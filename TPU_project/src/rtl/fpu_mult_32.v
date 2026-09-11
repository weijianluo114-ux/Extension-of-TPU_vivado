`timescale 1ns / 1ps
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE
// VSCODE plug-in version: Verilog-Hdl-Format-4.3.20260413
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            Please Write Company name
// All rights reserved
// File name:
// Last modified Date:     2026/09/07
// Last Version:           V2.0
// Descriptions:           重写版浮点乘法器（参考 fp_adder_16_32bits.v 的流水线写法）
//
//----------------------------------------------------------------------------------------
// Created by:             Agent（DeepSeek Harness）
// Created date:           2026/09/07
// Version:                V2.0
// TEXT NAME:              fpu_mult_32.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fpu_mult_32.v
// Descriptions:
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

// ============================================================================
// 浮点乘法器模块（重写版，3 级流水）
// ----------------------------------------------------------------------------
// 流水线结构（参考 fp_adder_16_32bits.v 的写法：每级一个 always 块 + en_stageN 有效跟踪）：
//   Stage0（时序）：fp16->fp32 扩展锁存（与原 fpu_mult 一致，保持 4 拍总延迟）
//   Stage1（时序）：符号/指数/尾数分解 + 特殊值检测 + subnormal 归一化
//   Stage2（组合+时序）：24x24 尾数相乘 + 指数相加 + 规格化 + RNE 舍入 + 上溢/下溢判定
//   Stage3（时序）：结果组装输出 + mult_valid（与 float_c 同步，en 后第 4 拍有效）
//
// 本模块内部固定按 FP32 实现（E=8, F=23, BIAS=127）。
// FP16 输入在输入端经 fp16_to_fp32 扩展后参与乘法。
//
// 旧版 7 个问题全部修复：
//   [1] Inf x 非零有限 -> +-Inf（旧版走正常路径，1.0 x Inf 甚至得 0）
//   [2] subnormal 输入 -> 前导零计数归一化后参与乘法（旧版加隐藏位 1 且乘积被清零）
//   [3] NaN 输入 -> 传播 QNaN（旧版当 normal 处理）
//   [4] RNE 舍入位修正：guard=bit22, round=bit21, sticky=bit20:0, lsb=bit23（旧版右移一位）
//   [5] round-up 尾数溢出 -> 重新规格化（mant 全 1 加 1 溢出时指数 +1）
//   [6] 上溢边界：舍入重规格化之后指数 >= 255 才判 Inf（旧版舍入前判定，边界过度饱和）
//   [7] 下溢 subnormal 输出：余数比较法做 RNE，可正确舍入到最小 normal（旧版直接截断）
// ============================================================================
module fpu_mult_32 #(
    // FP_WIDTH 参数保留仅为接口兼容；内部固定按 FP32 实现
    parameter FP_WIDTH   = 32,
    parameter EXP_WIDTH  = FP_WIDTH == 32 ? 8 : 5,
    parameter MANT_WIDTH = FP_WIDTH == 32 ? 23 : 10,
    parameter BIAS       = FP_WIDTH == 32 ? 127 : 15
) (
    input                     clk,                // 时钟信号
    input                     en,                 // 使能信号
    input                     rst_n,              // 低电平有效异步复位
    input                     round_cfg,          // 舍入模式配置（1=RNE 舍入，0=截断）
    input      [        31:0] input_a,            // 输入浮点数 A
    input      [        31:0] input_b,            // 输入浮点数 B
    input      [         5:0] input_a_precision,  // A 精度（16=FP16 输入，走 fp16_to_fp32）
    input      [         5:0] input_b_precision,  // B 精度
    output reg [FP_WIDTH-1:0] float_c,            // 输出浮点数 C（结果）
    output reg [         1:0] overflow,           // 00-正常，01-上溢/特殊，10-下溢到 0
    output reg                mult_valid,         // 乘法结果有效（与 float_c 同步）
    // 每个流水线阶段的使能信号，用于仿真观察
    output reg                en_stage1,
    output reg                en_stage2,
    output reg                en_stage3
);

    /******************************* 参数 ***********************************/
    localparam E_W   = 8;      // FP32 指数位宽
    localparam F_W   = 23;     // FP32 尾数（小数域）位宽
    localparam LBIAS = 127;    // FP32 指数偏置
    // 标准 quiet NaN：0x7FC00000
    localparam [31:0] QNAN = {1'b0, {E_W{1'b1}}, 1'b1, {(F_W-1){1'b0}}};

    /******************************* 网表信号（组合） ***********************************/
    // 输入精度统一（fp16 -> fp32，组合选择后经 Stage0 锁存）
    wire [31:0] half_to_float_a;
    wire [31:0] half_to_float_b;
    wire [31:0] float_a_pre;
    wire [31:0] float_b_pre;

    // 输入分解（组合）
    wire        sign_a;
    wire        sign_b;
    wire [E_W-1:0] exp_a;
    wire [E_W-1:0] exp_b;
    wire [F_W-1:0] frac_a;
    wire [F_W-1:0] frac_b;

    // 特殊值检测（组合）
    wire is_exp_one_a,  is_exp_one_b;
    wire is_exp_zero_a, is_exp_zero_b;
    wire is_frac_zero_a,is_frac_zero_b;
    wire is_NaN_a,  is_NaN_b;      // 指数全 1 且尾数非 0
    wire is_inf_a,  is_inf_b;      // 指数全 1 且尾数全 0
    wire is_zero_a, is_zero_b;     // 指数全 0 且尾数全 0
    wire is_abnorm_a,is_abnorm_b;  // 指数全 0 且尾数非 0（subnormal）

    // subnormal 归一化（组合）
    reg  [4:0] lzc_a, lzc_b;       // frac 的前导零个数（subnormal 时 0..22）
    wire [F_W-1:0] frac_norm_a;    // frac << lzc，leading 1 移到 bit22
    wire [F_W-1:0] frac_norm_b;
    wire [23:0]   man_a_w;         // 归一化尾数 {1'b1, 23 位小数}
    wire [23:0]   man_b_w;
    wire signed [9:0] biased_exp_a_w;  // 有符号"偏置指数"：normal=exp，subnormal=-lzc
    wire signed [9:0] biased_exp_b_w;

    /******************************* reg 信号（按 stage 分区） ***********************************/
    // ---- Stage0：输入精度统一锁存（与原 fpu_mult 一致） ----
    reg                en_stage0;
    reg [31:0]         float_a;
    reg [31:0]         float_b;

    // ---- Stage1：输入分解锁存 ----
    reg                s1, s2;                     // 符号
    reg signed [ 9:0] biased_exp_a, biased_exp_b;  // 有符号偏置指数
    reg [23:0]         man_a, man_b;               // 归一化尾数（含隐藏位 1）
    reg                is_NaN_A_stage1, is_NaN_B_stage1;
    reg                is_inf_A_stage1, is_inf_B_stage1;
    reg                is_zero_A_stage1,is_zero_B_stage1;

    // ---- Stage2：乘法结果锁存 ----
    reg [31:0]         result_stage2;
    reg [ 1:0]         overflow_stage2;

    // ---- Stage3：输出锁存 ----

    /******************************* 组合逻辑 ***********************************/
    // 输入精度统一（组合）
    assign float_a_pre = (input_a_precision == 'd16) ? half_to_float_a : input_a;
    assign float_b_pre = (input_b_precision == 'd16) ? half_to_float_b : input_b;

    // 输入分解
    assign sign_a = float_a[FP_WIDTH-1];
    assign sign_b = float_b[FP_WIDTH-1];
    assign exp_a  = float_a[FP_WIDTH-2:F_W];
    assign exp_b  = float_b[FP_WIDTH-2:F_W];
    assign frac_a = float_a[F_W-1:0];
    assign frac_b = float_b[F_W-1:0];

    // 特殊值检测（与 fp_adder_16_32bits.v 相同写法）
    assign is_exp_one_a  = (exp_a == {E_W{1'b1}});
    assign is_exp_one_b  = (exp_b == {E_W{1'b1}});
    assign is_exp_zero_a = (exp_a == {E_W{1'b0}});
    assign is_exp_zero_b = (exp_b == {E_W{1'b0}});
    assign is_frac_zero_a = (frac_a == {F_W{1'b0}});
    assign is_frac_zero_b = (frac_b == {F_W{1'b0}});
    assign is_NaN_a   = is_exp_one_a  && !is_frac_zero_a;
    assign is_NaN_b   = is_exp_one_b  && !is_frac_zero_b;
    assign is_inf_a   = is_exp_one_a  && is_frac_zero_a;
    assign is_inf_b   = is_exp_one_b  && is_frac_zero_b;
    assign is_zero_a  = is_exp_zero_a && is_frac_zero_a;
    assign is_zero_b  = is_exp_zero_b && is_frac_zero_b;
    assign is_abnorm_a = is_exp_zero_a && !is_frac_zero_a;
    assign is_abnorm_b = is_exp_zero_b && !is_frac_zero_b;

    // subnormal 前导零计数（23 位，层次化分组优先编码：8+8+7，关键路径 2 级）
    // 与 fp_adder_16_32bits.v 的 shift_amount 写法一致
    always @(*) begin
        // ---- A 操作数 ----
        if (frac_a[22:15] != 8'b0) begin
            casez (frac_a[22:15])
                8'b1???????: lzc_a = 5'd0;
                8'b01??????: lzc_a = 5'd1;
                8'b001?????: lzc_a = 5'd2;
                8'b0001????: lzc_a = 5'd3;
                8'b00001???: lzc_a = 5'd4;
                8'b000001??: lzc_a = 5'd5;
                8'b0000001?: lzc_a = 5'd6;
                8'b00000001: lzc_a = 5'd7;
                default:     lzc_a = 5'd8;
            endcase
        end else if (frac_a[14:7] != 8'b0) begin
            casez (frac_a[14:7])
                8'b1???????: lzc_a = 5'd8;
                8'b01??????: lzc_a = 5'd9;
                8'b001?????: lzc_a = 5'd10;
                8'b0001????: lzc_a = 5'd11;
                8'b00001???: lzc_a = 5'd12;
                8'b000001??: lzc_a = 5'd13;
                8'b0000001?: lzc_a = 5'd14;
                8'b00000001: lzc_a = 5'd15;
                default:     lzc_a = 5'd16;
            endcase
        end else begin
            casez (frac_a[6:0])
                7'b1??????: lzc_a = 5'd16;
                7'b01?????: lzc_a = 5'd17;
                7'b001????: lzc_a = 5'd18;
                7'b0001???: lzc_a = 5'd19;
                7'b00001??: lzc_a = 5'd20;
                7'b000001?: lzc_a = 5'd21;
                7'b0000001: lzc_a = 5'd22;
                default:    lzc_a = 5'd23;
            endcase
        end

        // ---- B 操作数 ----
        if (frac_b[22:15] != 8'b0) begin
            casez (frac_b[22:15])
                8'b1???????: lzc_b = 5'd0;
                8'b01??????: lzc_b = 5'd1;
                8'b001?????: lzc_b = 5'd2;
                8'b0001????: lzc_b = 5'd3;
                8'b00001???: lzc_b = 5'd4;
                8'b000001??: lzc_b = 5'd5;
                8'b0000001?: lzc_b = 5'd6;
                8'b00000001: lzc_b = 5'd7;
                default:     lzc_b = 5'd8;
            endcase
        end else if (frac_b[14:7] != 8'b0) begin
            casez (frac_b[14:7])
                8'b1???????: lzc_b = 5'd8;
                8'b01??????: lzc_b = 5'd9;
                8'b001?????: lzc_b = 5'd10;
                8'b0001????: lzc_b = 5'd11;
                8'b00001???: lzc_b = 5'd12;
                8'b000001??: lzc_b = 5'd13;
                8'b0000001?: lzc_b = 5'd14;
                8'b00000001: lzc_b = 5'd15;
                default:     lzc_b = 5'd16;
            endcase
        end else begin
            casez (frac_b[6:0])
                7'b1??????: lzc_b = 5'd16;
                7'b01?????: lzc_b = 5'd17;
                7'b001????: lzc_b = 5'd18;
                7'b0001???: lzc_b = 5'd19;
                7'b00001??: lzc_b = 5'd20;
                7'b000001?: lzc_b = 5'd21;
                7'b0000001: lzc_b = 5'd22;
                default:    lzc_b = 5'd23;
            endcase
        end
    end

    // subnormal 归一化尾数与等效偏置指数
    // subnormal 值 = 0.f x 2^-126；f<<lzc 把 leading 1 移到 bit22，
    // 值 = 1.xxx x 2^(-127-lzc)，故等效偏置指数 = (-127-lzc)+127 = -lzc
    assign frac_norm_a = frac_a << lzc_a;
    assign frac_norm_b = frac_b << lzc_b;
    assign man_a_w = is_abnorm_a ? {1'b1, frac_norm_a[21:0], 1'b0}
                                 : {1'b1, frac_a};
    assign man_b_w = is_abnorm_b ? {1'b1, frac_norm_b[21:0], 1'b0}
                                 : {1'b1, frac_b};
    assign biased_exp_a_w = is_abnorm_a ? (-$signed({5'b0, lzc_a}))
                                        : $signed({2'b0, exp_a});
    assign biased_exp_b_w = is_abnorm_b ? (-$signed({5'b0, lzc_b}))
                                        : $signed({2'b0, exp_b});

    // ---- Stage2 组合：尾数乘法 + 规格化 + 舍入 + 上溢/下溢判定 ----
    reg [31:0] final_result_comb;
    reg [ 1:0] overflow_comb;

    reg        nan_in, inf_zero, inf_out, zero_out, sign_out;
    reg [47:0] prod48;
    reg [47:0] mul48;
    reg        n;                 // 乘积归一化移位标志
    integer    prod_exp;          // 有符号偏置指数（ba+bb-BIAS）
    integer    biased_exp_int;    // 舍入重规格化后的偏置指数
    integer    shift_int;         // 下溢右移位数
    reg [22:0] mant23;
    reg        g, r, s, round_up, carry;
    reg [24:0] result24;   // 25 位：bit24 为舍入进位
    reg [22:0] mant_post;
    reg [47:0] q_sub, rem_sub, half_sub;
    reg        round_up_sub;
    reg [23:0] mant_sub24;
    reg        sub_carry;

    always @(*) begin
        // ---- 特殊值短路（IEEE 754） ----
        nan_in   = is_NaN_A_stage1 || is_NaN_B_stage1;
        inf_zero = (is_inf_A_stage1 && is_zero_B_stage1) ||
                   (is_zero_A_stage1 && is_inf_B_stage1);   // Inf x 0 -> NaN
        inf_out  = (is_inf_A_stage1 || is_inf_B_stage1) && !inf_zero && !nan_in;
        zero_out = (is_zero_A_stage1 || is_zero_B_stage1) && !inf_zero && !nan_in && !inf_out;
        sign_out = s1 ^ s2;

        // ---- 正常乘法路径（特殊值时也计算，最终被 mux 掉） ----
        prod48 = man_a * man_b;                 // 24x24 = 48 位
        n      = prod48[47];                    // 乘积 >= 2 时最高位为 1
        mul48  = n ? (prod48 >> 1) : prod48;    // 归一化到 [2^46, 2^47)，bit46=1
        prod_exp = $signed(biased_exp_a) + $signed(biased_exp_b) - LBIAS;
        biased_exp_int = prod_exp + n;

        // ---- RNE 舍入（round to nearest even） ----
        // mul48 = 1.m x 2^46，取 [45:23] 为 23 位小数；
        // guard=mul48[22], round=mul48[21], sticky=|mul48[20:0], lsb=mant23[0]
        mant23 = mul48[45:23];
        g = mul48[22];
        r = mul48[21];
        s = |mul48[20:0];
        round_up = round_cfg && g && (mant23[0] || r || s);
        // 24 位尾数（含隐含 1）加舍入进位，扩为 25 位以保留进位位 bit24
        result24 = {1'b0, {1'b1, mant23}} + {24'b0, round_up};
        carry    = result24[24];                // 尾数舍入溢出（1.111..1 + 1 -> 10.000..0）
        mant_post = carry ? 23'b0 : result24[22:0];
        biased_exp_int = biased_exp_int + carry; // 舍入进位重新规格化：指数 +1

        // ---- 下溢路径（biased_exp_int <= 0） ----
        // 精确值 = mul48 x 2^(biased_exp_int-127-46)
        //        = mul48 x 2^(biased_exp_int-173)
        // subnormal 尾数 = round(mul48 / 2^shift)，shift = 24 - biased_exp_int
        shift_int = 24 - biased_exp_int;        // >= 24（下溢时）
        if (shift_int > 47) begin
            // 全部移出：精确值 < 0.5 ulp(subnormal)，RNE 舍入到 0
            q_sub    = 48'd0;
            rem_sub  = mul48;
            half_sub = 48'h800000000000;
        end else begin
            q_sub    = mul48 >> shift_int;
            rem_sub  = mul48 & ((48'd1 << shift_int) - 1'b1);
            half_sub = 48'd1 << (shift_int - 1);
        end
        // RNE：余数 > 一半 -> 进 1；余数 == 一半 -> 看 q 最低位（tie to even）
        round_up_sub = (rem_sub > half_sub) || ((rem_sub == half_sub) && q_sub[0]);
        mant_sub24 = {1'b0, q_sub[22:0]} + {23'b0, round_up_sub};
        sub_carry  = mant_sub24[23];            // 舍入到 2^23 -> 最小 normal

        // ---- 结果 mux（优先级：NaN > Inf > Zero > 上溢 > normal > subnormal） ----
        if (nan_in || inf_zero) begin
            final_result_comb = QNAN;
            overflow_comb     = 2'b01;
        end else if (inf_out) begin
            final_result_comb = {sign_out, {E_W{1'b1}}, {F_W{1'b0}}};
            overflow_comb     = 2'b01;
        end else if (zero_out) begin
            final_result_comb = {sign_out, {E_W{1'b0}}, {F_W{1'b0}}};
            overflow_comb     = 2'b00;
        end else if (biased_exp_int >= 255) begin
            final_result_comb = {sign_out, {E_W{1'b1}}, {F_W{1'b0}}};   // 上溢 -> Inf
            overflow_comb     = 2'b01;
        end else if (biased_exp_int >= 1) begin
            final_result_comb = {sign_out, biased_exp_int[E_W-1:0], mant_post};
            overflow_comb     = 2'b00;
        end else begin
            if (sub_carry) begin
                // subnormal 舍入进位到最小 normal：1.0 x 2^-126
                final_result_comb = {sign_out, {{(E_W-1){1'b0}}, 1'b1}, {F_W{1'b0}}};
                overflow_comb     = 2'b00;
            end else begin
                final_result_comb = {sign_out, {E_W{1'b0}}, mant_sub24[F_W-1:0]};
                overflow_comb     = (mant_sub24 == 24'b0) ? 2'b10 : 2'b00;
            end
        end
    end

    /******************************* 时序逻辑（每级一个 always，参考 fp_adder_16_32bits） ***********************************/
    // ---- Stage0：fp16->fp32 扩展锁存（延迟 1 拍，与原 fpu_mult 对齐） ----
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en_stage0 <= 1'b0;
            float_a   <= 32'd0;
            float_b   <= 32'd0;
        end else if (en) begin
            en_stage0 <= 1'b1;
            float_a   <= float_a_pre;
            float_b   <= float_b_pre;
        end else begin
            en_stage0 <= 1'b0;
        end
    end

    // ---- Stage1：输入分解与特殊值锁存 ----
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en_stage1 <= 1'b0;
            s1 <= 1'b0; s2 <= 1'b0;
            biased_exp_a <= 10'sd0; biased_exp_b <= 10'sd0;
            man_a <= 24'd0; man_b <= 24'd0;
            is_NaN_A_stage1  <= 1'b0; is_NaN_B_stage1  <= 1'b0;
            is_inf_A_stage1  <= 1'b0; is_inf_B_stage1  <= 1'b0;
            is_zero_A_stage1 <= 1'b0; is_zero_B_stage1 <= 1'b0;
        end else if (en_stage0) begin
            en_stage1 <= 1'b1;
            s1 <= sign_a;
            s2 <= sign_b;
            biased_exp_a <= biased_exp_a_w;
            biased_exp_b <= biased_exp_b_w;
            man_a <= man_a_w;
            man_b <= man_b_w;
            is_NaN_A_stage1  <= is_NaN_a;
            is_NaN_B_stage1  <= is_NaN_b;
            is_inf_A_stage1  <= is_inf_a;
            is_inf_B_stage1  <= is_inf_b;
            is_zero_A_stage1 <= is_zero_a;
            is_zero_B_stage1 <= is_zero_b;
        end else begin
            en_stage1 <= 1'b0;
        end
    end

    // ---- Stage2：乘法结果锁存 ----
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en_stage2    <= 1'b0;
            result_stage2  <= 32'd0;
            overflow_stage2 <= 2'b0;
        end else if (en_stage1) begin
            en_stage2    <= 1'b1;
            result_stage2  <= final_result_comb;
            overflow_stage2 <= overflow_comb;
        end else begin
            en_stage2 <= 1'b0;
        end
    end

    // ---- Stage3：输出锁存（mult_valid 与 float_c 同步，en 后第 3 拍有效） ----
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en_stage3 <= 1'b0;
            float_c     <= {FP_WIDTH{1'b0}};
            overflow    <= 2'b0;
            mult_valid  <= 1'b0;
        end else if (en_stage2) begin
            en_stage3 <= 1'b1;
            float_c     <= result_stage2;
            overflow    <= overflow_stage2;
            mult_valid  <= 1'b1;
        end else begin
            en_stage3 <= 1'b0;
            mult_valid  <= 1'b0;
        end
    end

    /******************************* 模块例化 ***********************************/
    fp16_to_fp32 h2f_a (
        .half_in  (input_a[15:0]),
        .float_out(half_to_float_a)
    );

    fp16_to_fp32 h2f_b (
        .half_in  (input_b[15:0]),
        .float_out(half_to_float_b)
    );

endmodule
