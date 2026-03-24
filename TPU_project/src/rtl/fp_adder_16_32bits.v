//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE     
// VSCODE plug-in version: Verilog-Hdl-Format-4.1.20260207
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            Please Write Company name
// All rights reserved     
// File name:              
// Last modified Date:     2026/03/22 15:37:39
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/22 15:37:39
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              fp_adder.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fp_adder.v
// Descriptions:           之前写的五级流水线浮点数加法器
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

`timescale 1ns / 1ps  //修改了reset negedge
module fp_adder_16_32bits #(  // 输入+三级流水（对阶 加减 规格化）+输出
    parameter MATRIX_PRECISION = 32,
    parameter FP_WIDTH         = 32,
    //parameter INPUT_WIDTH    = MATRIX_PRECISION == 16 ? 16 : 32, // 支持32位(FP32)或16位(FP16)
    parameter EXP_WIDTH        = FP_WIDTH == 32 ? 8 : 5,    // FP32:8位阶码, FP16:5位阶码
    parameter FRAC_WIDTH       = FP_WIDTH == 32 ? 23 : 10,  // FP32:23位尾数, FP16:10位尾数
    parameter MANT_WIDTH       = FRAC_WIDTH + 1,            // 包含隐含1的尾数宽度
    parameter BIAS             = FP_WIDTH == 32 ? 127 : 15  // FP32:偏移量127, FP16:偏移量15
) (
    input  wire                clk,                // 时钟信号
    input  wire                rst_n,              // 异步复位，低电平复位
    input  wire                read_en,            // 输入使能，高电平有效
    input  wire [        31:0] input_A,            // 输入A
    input  wire [        31:0] input_B,            // 输入B    特殊化处理(可以为16位)
    input  wire [         5:0] input_b_precision,  //输入B的精度(可为16或32)
    output reg  [FP_WIDTH-1:0] C,                  // 输出结果
    output reg                 indicate            // 计算完成指示信号s（高电平有效）
);

  /******************************* 参数 ***********************************/
  localparam QNAN = {1'b0, {31{1'b1}}};  //作为一个默认的QNaN输出


  /******************************* 网表信号 ***********************************/
  // 输入信号处理
  wire [31:0] half_to_float_b;
  wire [31:0] A;
  wire [31:0] B;

  //第一级流水线
  //将对指数和尾数是否均为0进行判断，即0
  wire is_zero_A_stage1;
  wire is_zero_B_stage1;
  wire is_zero_stage1;
  //判断指数位是否全1
  wire is_inf_A_stage1;  // 无穷处理 A/B是否为无穷大
  wire is_inf_B_stage1;  // 无穷处理 A/B是否为无穷大
  //对非规格数进行判断
  wire is_abnorm_A_stage1;  // 判断指数是否为0
  wire is_abnorm_B_stage1;  // 判断指数是否为0
  //对NaN的判断
  wire is_NaN_A_stage1;
  wire is_NaN_B_stage1;
  wire is_NaN_stage1;

  /******************************* reg信号 ***********************************/
  // Stage 1：输入分解寄存器
  reg en_stage1;  // 流水线使能信号
  //存储
  reg signA_stage1;  // A的符号位
  reg signB_stage1;  ///B的符号位
  reg [EXP_WIDTH-1:0] expA_stage1;  // A的指数
  reg [EXP_WIDTH-1:0] expB_stage1;  // B的指数
  reg [FRAC_WIDTH-1:0] fracA_stage1;  // A/B的尾数
  reg [FRAC_WIDTH-1:0] fracB_stage1;  // A/B的尾数
  //检测
  reg is_exp_one_A_stage1;  // 判断指数是否全1
  reg is_exp_one_B_stage1;  // 判断指数是否全1
  reg is_exp_zero_A_stage1;  // 判断指数是否全0
  reg is_exp_zero_B_stage1;  // 判断指数是否全0
  reg is_frac_zero_A_stage1;  // 判断A是否全0
  reg is_frac_zero_B_stage1;  // 判断B是否全0


  // Stage 2：对阶与尾数对齐
  reg en_stage2;
  //存储
  reg signA_stage2;
  reg signB_stage2;
  reg [EXP_WIDTH-1 : 0] exp_stage2;
  reg [MANT_WIDTH-1:0] mantA_stage2;  // 尾数扩展至24位
  reg [MANT_WIDTH-1:0] mantB_stage2;  // 尾数扩展至24位
  //传递
  reg is_inf_A_stage2;  // 无穷大传递信号
  reg is_inf_B_stage2;  // 无穷大传递信号
  reg is_abnorm_A_stage2;  // 非规格数传输信号
  reg is_abnorm_B_stage2;  // 非规格数传输信号
  reg is_zero_stage2;  // 判断是否为0
  reg [FP_WIDTH-1:0] zero_result_stage2;  //传递有一个数是0时的结果
  reg is_NaN_stage2;  // 判断是否为0

  // Stage 3：加减运算
  reg en_stage3;
  //存储
  reg result_sign_stage3;
  reg [EXP_WIDTH-1:0] exp_stage3;
  reg [MANT_WIDTH:0] sum_stage3;  //多一位保存可能的进位/借位
  //传递
  reg is_inf_stage3;  // 结果是否为无穷大
  reg is_nan_stage3;  // 结果是否为NaN（无穷相减的情况）
  reg is_abnorm_A_stage3;  //非规格数传递信号
  reg is_abnorm_B_stage3;  //非规格数传递信号
  reg is_zero_stage3;  // 判断是否为0
  reg [FP_WIDTH-1:0] zero_result_stage3;  //传递有一个数是0时的结果
  reg is_NaN_stage3;  // 判断是否为0

  // Stage 4：规格化
  reg en_stage4;
  //存储
  reg result_sign_stage4;
  reg [EXP_WIDTH-1:0] exp_stage4;  //指数位
  reg [MANT_WIDTH:0] norm_mantissa;  //规格化后隐含1的24位尾数，1不输出
  reg [$clog2(MANT_WIDTH+1)-1:0] shift_amount;  //记录左移位数（前导零计数的结果）
  //传递
  reg is_inf_stage4;
  reg is_abnorm_A_stage4;
  reg is_abnorm_B_stage4;
  reg is_zero_stage4;  // 判断是否为0
  reg [FP_WIDTH-1:0] zero_result_stage4;  //传递有一个数是0时的结果
  reg is_NaN_stage4;  // 判断是否为0

  // Stage 5：输出
  reg en_stage5;

  /******************************* 组合逻辑 ***********************************/
  assign A = input_A;
  assign B = (input_b_precision == 'd16) ? half_to_float_b : input_B;

  //第一级流水线
  //对0的判断
  assign is_zero_A_stage1 = is_exp_zero_A_stage1 && is_frac_zero_A_stage1;
  assign is_zero_B_stage1 = is_exp_zero_B_stage1 && is_frac_zero_B_stage1;
  assign is_zero_stage1 = is_zero_A_stage1 || is_zero_B_stage1;
  //对NaN的判断
  assign is_NaN_A_stage1 = is_exp_one_A_stage1 && !(is_frac_zero_A_stage1);
  assign is_NaN_B_stage1 = is_exp_one_B_stage1 && !(is_frac_zero_B_stage1);
  assign is_NaN_stage1 = is_NaN_A_stage1 || is_NaN_B_stage1;
  //对非规格数的判断
  assign is_abnorm_A_stage1 = is_exp_zero_B_stage1 && !(is_frac_zero_B_stage1);
  assign is_abnorm_B_stage1 = is_exp_zero_B_stage1 && !(is_frac_zero_B_stage1);
  //对无穷大的判断
  assign is_inf_A_stage1 = is_exp_one_A_stage1 && is_frac_zero_A_stage1;
  assign is_inf_B_stage1 = is_exp_one_B_stage1 && is_frac_zero_B_stage1;

  /******************************* 时序逻辑 ***********************************/
  //第一级流水线
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin  // 复位
      en_stage1    <= 1'b0;
      //分段存储
      signA_stage1 <= 0;
      signB_stage1 <= 0;
      expA_stage1  <= 0;
      expB_stage1  <= 0;
      fracA_stage1 <= 0;
      fracB_stage1 <= 0;
      //分段检测
      is_exp_one_A_stage1 <= 0;
      is_exp_one_B_stage1 <= 0;
      is_exp_zero_A_stage1 <= 1'b0;
      is_exp_zero_B_stage1 <= 1'b0;
      is_frac_zero_A_stage1 <= 1'b0;
      is_frac_zero_B_stage1 <= 1'b0;
    end else begin
      if (read_en) begin  // read_en有效，初始化
        // stage1有效跟踪
        en_stage1 <= 1'b1;

        //存储
        // 最高位为符号位
        signA_stage1 <= A[FP_WIDTH-1];
        signB_stage1 <= B[FP_WIDTH-1];
        // 符号后一位开始到尾数部分之前为阶码位
        expA_stage1 <= A[FP_WIDTH-2:FRAC_WIDTH];
        expB_stage1 <= B[FP_WIDTH-2:FRAC_WIDTH];
        // 最低FRAC_WIDTH位为尾数位
        fracA_stage1 <= A[FRAC_WIDTH-1:0];
        fracB_stage1 <= B[FRAC_WIDTH-1:0];

        //检测
        // 检测A和B的指数是否全1
        is_exp_one_A_stage1 <= A[FP_WIDTH-2:FRAC_WIDTH] == 8'hff ? 1'b1 : 1'b0;
        is_exp_one_B_stage1 <= B[FP_WIDTH-2:FRAC_WIDTH] == 8'hff ? 1'b1 : 1'b0;
        // 检测A和B的指数是全0
        is_exp_zero_A_stage1 <= A[FP_WIDTH-2:FRAC_WIDTH] == 8'b0 ? 1'b1 : 1'b0;
        is_exp_zero_B_stage1 <= B[FP_WIDTH-2:FRAC_WIDTH] == 8'b0 ? 1'b1 : 1'b0;
        //检测A和B尾数是否全0
        is_frac_zero_A_stage1 <= A[FRAC_WIDTH-1:0] == 23'b0 ? 1'b1 : 1'b0;
        is_frac_zero_B_stage1 <= B[FRAC_WIDTH-1:0] == 23'b0 ? 1'b1 : 1'b0;
      end else begin
        en_stage1 <= 1'b0;
      end
    end
  end

  //第二级流水线
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin  // 复位
      en_stage2    <= 1'b0;
      //存储
      signA_stage2 <= 0;
      signB_stage2 <= 0;
      exp_stage2   <= 0;
      mantA_stage2 <= 0;
      mantB_stage2 <= 0;
      //传递
      is_inf_A_stage2 <= 1'b0;
      is_inf_B_stage2 <= 1'b0;
      is_abnorm_A_stage2 <= 1'b0;
      is_abnorm_B_stage2 <= 1'b0;
      is_zero_stage2 <= 1'b0;
      is_NaN_stage2 <= 1'b0;
      zero_result_stage2 <= 'b0;
    end else if (en_stage1) begin  // Stage2继承Stage1符号结果
      //Stage2有效跟踪
      en_stage2 <= 1'b1;

      //存储传递
      signA_stage2 <= signA_stage1;
      signB_stage2 <= signB_stage1;
      is_inf_A_stage2 <= is_inf_A_stage1;
      is_inf_B_stage2 <= is_inf_B_stage1;
      is_abnorm_A_stage2 <= is_abnorm_A_stage1;
      is_abnorm_B_stage2 <= is_abnorm_B_stage1;
      is_zero_stage2 <= is_zero_stage1;
      is_NaN_stage2 <= is_NaN_stage1;

      //首先进行是否为NaN的判断
      if (is_NaN_stage1) begin  //为NaN则传递
        //若是则不进行其它操作
      end else if (is_zero_A_stage1) begin  //为0则传递
        zero_result_stage2 <= {signB_stage1, expB_stage1, fracB_stage1};
      end else if (is_zero_B_stage1) begin  //B为0则传递A
        zero_result_stage2 <= {signA_stage1, expA_stage1, fracA_stage1};
      end else begin
        //给出默认值，防止锁存
        zero_result_stage2 <= 'b0;

        //实现对齐
        //规格数对齐
        if (expA_stage1 >= expB_stage1) begin  // 比较阶码，决定右移对象
          exp_stage2 <= expA_stage1;  // 取较大者阶码作为对齐后的阶码
          //若A的阶码全0，意味着A为非规格数
          if (is_abnorm_A_stage1) begin
            mantA_stage2 <= {1'b0, fracA_stage1};  //则对实际的尾数进行0扩展
          end else begin  //若A阶码不全为0，则进行1扩展，即组装尾数，加上隐含的1（规格化数隐含位）
            mantA_stage2 <= {1'b1, fracA_stage1};
          end
          //若B的阶码全为0则说明其为非规格数，进行0扩展并移位
          if (is_abnorm_B_stage1) begin
            mantB_stage2 <= {1'b0, fracB_stage1} >> ((expA_stage1 ? expA_stage1 : 8'd1) - 8'd1);
          end else begin
            mantB_stage2 <= {1'b1, fracB_stage1} >> (expA_stage1 - expB_stage1); // 较小者尾数右移对齐
          end  //若B阶码不全为0，则进行1扩展并移位
        end else begin  // 同理，另一种情况
          exp_stage2 <= expB_stage1;
          //A的判断
          if (is_abnorm_A_stage1) begin
            mantA_stage2 <= {1'b0, fracA_stage1} >> ((expB_stage1 ? expB_stage1 : 8'd1) - 8'd1);
          end else begin
            mantA_stage2 <= {1'b1, fracA_stage1} >> (expB_stage1 - expA_stage1);
          end
          //B的判断
          if (is_abnorm_B_stage1) begin
            mantB_stage2 <= {1'b0, fracB_stage1};
          end else begin
            mantB_stage2 <= {1'b1, fracB_stage1};
          end
        end
      end
    end else begin
      en_stage2 <= 1'b0;
    end
  end


  //第三级流水线
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      en_stage3          <= 1'b0;
      //存储
      result_sign_stage3 <= 0;
      exp_stage3         <= 0;
      sum_stage3         <= 0;
      //传递
      is_inf_stage3      <= 1'b0;
      is_nan_stage3      <= 1'b0;
      is_abnorm_A_stage3 <= 1'b0;
      is_abnorm_B_stage3 <= 1'b0;
      is_zero_stage3     <= 1'b0;
      is_NaN_stage3      <= 1'b0;
      zero_result_stage3 <= 'b0;
    end else if (en_stage2) begin
      //Stage3有效跟踪
      en_stage3 <= 1'b1;

      //传递
      is_abnorm_A_stage3 <= is_abnorm_A_stage2;
      is_abnorm_B_stage3 <= is_abnorm_B_stage2;
      is_zero_stage3 <= is_zero_stage2;
      is_NaN_stage3 <= is_NaN_stage2;
      zero_result_stage3 <= zero_result_stage2;


      //首先进行是否为0的判断
      if (is_NaN_stage2) begin
        //若不是则进行其它操作
      end else if (is_zero_stage2) begin  //为0则传递
        //若不是则进行其它操作
      end else begin
        if (is_inf_A_stage2 || is_inf_B_stage2) begin
          // 两个都是无穷大 且符号相反
          if (is_inf_A_stage2 && is_inf_B_stage2 && (signA_stage2 != signB_stage2)) begin
            is_nan_stage3 <= 1'b1;  // 结果为NaN
            is_inf_stage3 <= 1'b0;  // 结果不为INF

          end else begin
            // 至少有一个是无穷大
            is_inf_stage3 <= 1'b1;
            is_nan_stage3 <= 1'b0;
            // 结果符号为无穷大的符号
            if (is_inf_A_stage2 && !is_inf_B_stage2) begin
              result_sign_stage3 <= signA_stage2;  //取A即可
            end else begin
              result_sign_stage3 <= signB_stage2;  // 因为两者符号相同或者只有B是无穷
            end
          end
          // 正常数值的处理（原代码逻辑）
        end else begin

          //传递对齐后的阶码
          exp_stage3 <= exp_stage2;
          is_inf_stage3 <= 1'b0;
          is_nan_stage3 <= 1'b0;

          //符号位相同，执行加法
          if (signA_stage2 == signB_stage2) begin
            sum_stage3         <= mantA_stage2 + mantB_stage2;  //尾数求和
            result_sign_stage3 <= signA_stage2;  //符号任取其一
            //符号位相异，执行减法
          end else begin
            if (mantA_stage2 >= mantB_stage2) begin  //大减小
              sum_stage3         <= mantA_stage2 - mantB_stage2;
              result_sign_stage3 <= signA_stage2;  //符号位取大
            end else begin  //同理，另一种情况
              sum_stage3         <= mantB_stage2 - mantA_stage2;
              result_sign_stage3 <= signB_stage2;
            end
          end
        end
      end
    end else begin
      en_stage3 <= 1'b0;
    end
  end


  //第四级流水线
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin  //复位
      en_stage4          <= 1'b0;
      //存储
      result_sign_stage4 <= 1'b0;
      exp_stage4         <= 'b0;
      norm_mantissa      <= 'b0;
      //传递
      is_inf_stage4      <= 1'b0;
      is_abnorm_A_stage4 <= 1'b0;
      is_abnorm_B_stage4 <= 1'b0;
      is_zero_stage4     <= 1'b0;
      is_NaN_stage4      <= 1'b0;
      zero_result_stage4 <= 'b0;
    end else if (en_stage3) begin  //传递
      //Stage4有效跟踪
      en_stage4          <= 1'b1;

      //传递
      result_sign_stage4 <= result_sign_stage3;
      is_abnorm_A_stage4 <= is_abnorm_A_stage3;
      is_abnorm_B_stage4 <= is_abnorm_B_stage3;
      is_zero_stage4     <= is_zero_stage3;
      is_NaN_stage4      <= is_NaN_stage3 || is_nan_stage3;  //传递
      zero_result_stage4 <= zero_result_stage3;


      //首先进行是否为0的判断
      if (is_NaN_stage3) begin
        //若不是则进行其它操作
      end else if (is_zero_stage3) begin  //0则传递
        //若不是则进行其它操作
      end else if (is_inf_stage3) begin
        is_inf_stage4 <= is_inf_stage3;
      end else begin  //若都不是则进行其它操作
        if (sum_stage3 == 0) begin  //特殊0处理，两个数绝对值相等当符号相反
          norm_mantissa <= 0;
          exp_stage4    <= 0;
        end else if (is_abnorm_A_stage3 && is_abnorm_B_stage3) begin  //非规格数处理
          norm_mantissa <= sum_stage3;
          if (sum_stage3[MANT_WIDTH-1] == 1'b1) begin //非规格数相加，因为超过了非规格数能表示的范围而进位，故阶码加1，即普通溢出
            exp_stage4 <= 1;
          end else begin  //既没有溢出，也不等于0，即没有进位
            exp_stage4 <= 0;
          end
        end else if (sum_stage3[MANT_WIDTH] == 1'b1) begin// 最高位溢出（进位产生1）,右移尾数
          // 溢出成为无穷大
          if (exp_stage3 == 8'd254) begin
            is_inf_stage4 <= 1'b1;
          end else begin
            norm_mantissa <= sum_stage3[MANT_WIDTH:1];
            exp_stage4    <= exp_stage3 + 1;    //指数+1
          end
          // 尾数规格化：使用分组优先级编码计算前导0的数量   
        end else begin
          // 分组优先级编码器实现 - 计算前导零
          // 根据MANT_WIDTH确定适当的分组方式

          // FP32: MANT_WIDTH = 24，分为3组，每组8位
          // FP16: MANT_WIDTH = 11，分为2组，第一组5位，第二组6位
          // 注意：以下代码处理了两种可能的宽度
          norm_mantissa <= sum_stage3[MANT_WIDTH:0] << (shift_amount);  // 指数大于移位数，则减去移位数，否则归零
          if (exp_stage3 > shift_amount) begin  //够移则仍然是规格数
            exp_stage4 <= exp_stage3 - shift_amount;
          end else begin  //不够移位则是非规格数
            exp_stage4 <= 0;
          end
        end
      end

    end else begin
      en_stage4 <= 1'b0;
    end
  end

  //第五级流水线
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      en_stage5 <= 1'b0;
      C         <= 0;
      indicate  <= 1'b0;
    end else if (en_stage4) begin
      en_stage5 <= 1'b1;
      indicate  <= 1'b1;  //输出有效跟踪
      // 最终结果：符号位、规格化后的阶码、规格化尾数的低FRAC_WIDTH位（去掉隐含1）
      if (is_NaN_stage4) begin
        C <= QNAN;
      end else if (is_zero_stage4) begin  //0则传递
        C <= zero_result_stage4;
      end else if (is_inf_stage4) begin
        C <= {result_sign_stage4, {EXP_WIDTH{1'b1}}, {FRAC_WIDTH{1'b0}}};  //对应的无穷大
      end else begin  //若都不是则进行其它操作
        C <= {result_sign_stage4, exp_stage4, norm_mantissa[22:0]};
      end
    end else begin
      en_stage5 <= 1'b0;
      indicate  <= 1'b0;
    end
  end

  always @(*) begin
    if (MANT_WIDTH > 16) begin
      // 处理FP32情况 - 24位尾数(包含隐含位)，分成3组
      if (sum_stage3[FRAC_WIDTH:FRAC_WIDTH-7] != 0) begin
        // 最高8位有1
        casez (sum_stage3[FRAC_WIDTH:FRAC_WIDTH-7])
          8'b1???????: shift_amount = 0;
          8'b01??????: shift_amount = 1;
          8'b001?????: shift_amount = 2;
          8'b0001????: shift_amount = 3;
          8'b00001???: shift_amount = 4;
          8'b000001??: shift_amount = 5;
          8'b0000001?: shift_amount = 6;
          8'b00000001: shift_amount = 7;
          default: shift_amount = 8;  // 不应该到达这里
        endcase
      end else if (sum_stage3[FRAC_WIDTH-8:FRAC_WIDTH-15] != 0) begin
        // 中间8位有1
        casez (sum_stage3[FRAC_WIDTH-8:FRAC_WIDTH-15])
          8'b1???????: shift_amount = 8;
          8'b01??????: shift_amount = 9;
          8'b001?????: shift_amount = 10;
          8'b0001????: shift_amount = 11;
          8'b00001???: shift_amount = 12;
          8'b000001??: shift_amount = 13;
          8'b0000001?: shift_amount = 14;
          8'b00000001: shift_amount = 15;
          default: shift_amount = 16;  // 不应该到达这里
        endcase
      end else begin
        // 最低8位(对于FP32，实际只需要处理到最低的8位)
        casez (sum_stage3[FRAC_WIDTH-16:FRAC_WIDTH-23])
          8'b1???????: shift_amount = 16;
          8'b01??????: shift_amount = 17;
          8'b001?????: shift_amount = 18;
          8'b0001????: shift_amount = 19;
          8'b00001???: shift_amount = 20;
          8'b000001??: shift_amount = 21;
          8'b0000001?: shift_amount = 22;
          8'b00000001: shift_amount = 23;
          default: shift_amount = 24;  // 全0情况
        endcase
      end
    end else begin
      // 处理FP16情况 - 11位尾数(包含隐含位)，分成2组
      if (sum_stage3[FRAC_WIDTH:FRAC_WIDTH-5] != 0) begin
        // 最高6位有1
        casez (sum_stage3[FRAC_WIDTH:FRAC_WIDTH-5])
          6'b1?????: shift_amount = 0;
          6'b01????: shift_amount = 1;
          6'b001???: shift_amount = 2;
          6'b0001??: shift_amount = 3;
          6'b00001?: shift_amount = 4;
          6'b000001: shift_amount = 5;
          default:   shift_amount = 6;  // 不应该到达这里
        endcase
      end else begin
        // 最低5位有1
        casez (sum_stage3[FRAC_WIDTH-6:0])
          5'b1????: shift_amount = 6'd6;
          5'b01???: shift_amount = 6'd7;
          5'b001??: shift_amount = 6'd8;
          5'b0001?: shift_amount = 6'd9;
          5'b00001: shift_amount = 6'd10;
          default:  shift_amount = 6'd11;  // 全0情况
        endcase
      end
    end
  end


  /******************************* 模块例化 ***********************************/
  // 输入信号预处理(fp16->fp32)
  fp16_to_fp32 h2f_b (
      .half_in  (input_B[15:0]),
      .float_out(half_to_float_b)
  );


endmodule
