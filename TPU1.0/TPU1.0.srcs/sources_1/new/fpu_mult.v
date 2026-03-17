// 浮点乘法器模块
// 支持IEEE 754格式浮点数乘法运算，包含对特殊情况如0×INF的处理
module fpu_mult #(
    //parameter INPUT_WIDTH  = MATRIX_PRECISION == 16 ? 16 : 32,   // 浮点数总位宽，默认32位（单精度）
    parameter FP_WIDTH = 32,
    parameter EXP_WIDTH = FP_WIDTH == 32 ? 8 : 5,  // 指数位宽，单精度8位，半精度5位
    parameter MANT_WIDTH   = FP_WIDTH == 32 ? 23 : 10,           // 尾数位宽，单精度23位，半精度10位
    parameter BIAS = FP_WIDTH == 32 ? 127 : 15  // 指数偏置，单精度127，半精度15
) (
    input clk,  // 时钟信号
    input en,  // 使能信号
    input rst_n,  // 低电平有效复位信号
    input round_cfg,  // 舍入模式配置（1为舍入，0为截断）
    input [31:0] input_a,  // 输入浮点数A
    input [31:0] input_b,  // 输入浮点数B
    input [5:0] input_a_precision,
    input [5:0] input_b_precision,
    output reg [FP_WIDTH-1:0] float_c,  // 输出浮点数C（结果）
    output reg [1:0] overflow,  // 溢出标志：00-正常，01-上溢，10-下溢，11-其他
    output reg mult_valid,  // 乘法结果有效信号
    // 新增：每个流水线阶段的使能信号，用于仿真观察
    output reg en_stage1,  // 第一阶段使能信号
    output reg en_stage2,  // 第二阶段使能信号
    output reg en_stage3  // 第三阶段（输出）使能信号
);

  // ---------- 输入信号处理 ----------
  wire [31:0] half_to_float_a;
  wire [31:0] half_to_float_b;

  reg  [31:0] float_a;
  reg  [31:0] float_b;
  // ---------- 内部寄存器定义 ----------
  // 第一级流水线寄存器
  reg s1, s2;  // 输入操作数的符号位
  reg [EXP_WIDTH-1:0] exp1, exp2;  // 输入操作数的指数部分
  reg [MANT_WIDTH+1:0] man1, man2;  // 输入操作数的尾数部分（包含隐藏位）

  // 临时计算变量
  integer signed_exp;  // 带符号指数值，用于下溢检测
  integer shift_amt;  // 非规格化数需要右移的位数
  reg     n;  // 归一化标志
  reg [EXP_WIDTH+1:0] temp1, temp2, temp3;  // 指数计算的临时变量
  reg [2*(MANT_WIDTH+1)-1:0] mul_out_p;  // 尾数乘法的结果

  // 第一级流水线结果（组合逻辑输出）
  wire one_s_out;  // 第一级输出的符号位
  reg [EXP_WIDTH+1:0] one_e_out;  // 第一级输出的指数值
  reg [2*(MANT_WIDTH+1)-1:0] one_m_out;  // 第一级输出的尾数乘积

  // 第一级流水线输出寄存
  reg one_s_reg;  // 第一级输出符号位寄存
  reg [EXP_WIDTH+1:0] one_e_reg;  // 第一级输出指数值寄存
  reg [2*(MANT_WIDTH+1)-1:0] one_m_reg;  // 第一级输出尾数乘积寄存

  // 第二级流水线结果（组合逻辑输出）
  reg [1:0] two_f_out;  // 特殊标志：00-正常，01-溢出，10-下溢，11-特殊值
  reg [EXP_WIDTH-1:0] two_e_out;  // 第二级输出指数
  reg [MANT_WIDTH-1:0] two_m_out;  // 第二级输出尾数

  // 第二级流水线输出寄存
  reg two_s_reg;  // 第二级输出符号位寄存
  reg [1:0] two_f_reg;  // 第二级输出特殊标志寄存
  reg [EXP_WIDTH-1:0] two_e_reg;  // 第二级输出指数寄存
  reg [MANT_WIDTH-1:0] two_m_reg;  // 第二级输出尾数寄存

  // 有效信号控制
  reg r_mult_valid;  // 内部乘法有效信号
  reg [2:0] valid_pipeline;  // 有效信号流水线传递

  // ---------- 特殊情况处理信号 ----------
  // 新增：用于0×INF=NaN特殊情况的处理
  wire is_zero_times_inf;  // 检测是否为0×INF的情况
  reg zero_times_inf_stage1;  // 第一级流水线传递0×INF标志
  reg zero_times_inf_stage2;  // 第二级流水线传递0×INF标志

  // ---------- 流水线控制逻辑 ----------
  // 3位移位寄存器实现valid信号的流水线延迟
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) valid_pipeline <= 3'b000;  // 复位时清零
    else if (!en) valid_pipeline <= 3'b000;  // 禁用时清零
    else valid_pipeline <= {valid_pipeline[1:0], en};  // 移位传递有效信号
  end

  // 由流水线第二级的有效信号生成内部乘法有效信号
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) r_mult_valid <= 1'b0;
    else r_mult_valid <= valid_pipeline[1];  // 第二级流水线有效信号
  end

  // 输出乘法有效信号延迟一个周期，与结果同步
  always @(posedge clk) mult_valid <= r_mult_valid;

  // ---------- 每个阶段的使能信号 ----------
  // 为仿真观察流水线状态而添加
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      en_stage1 <= 1'b0;
      en_stage2 <= 1'b0;
      en_stage3 <= 1'b0;
    end else begin
      en_stage1 <= en;  // 第一阶段直接受全局使能控制
      en_stage2 <= valid_pipeline[0];  // 第二阶段由第一个有效信号控制
      en_stage3 <= valid_pipeline[1];  // 第三阶段由第二个有效信号控制
    end
  end

  // ---------- 特殊值检测 ----------
  // 检测输入是否为零值（指数和尾数都为0）
  wire is_a_zero = (float_a[FP_WIDTH-2:MANT_WIDTH] == 0) && (float_a[MANT_WIDTH-1:0] == 0);
  wire is_b_zero = (float_b[FP_WIDTH-2:MANT_WIDTH] == 0) && (float_b[MANT_WIDTH-1:0] == 0);

  // 检测输入是否为无穷大（指数全1，尾数全0）
  wire is_a_inf = (float_a[FP_WIDTH-2:MANT_WIDTH] == {EXP_WIDTH{1'b1}}) && (float_a[MANT_WIDTH-1:0] == 0);
  wire is_b_inf = (float_b[FP_WIDTH-2:MANT_WIDTH] == {EXP_WIDTH{1'b1}}) && (float_b[MANT_WIDTH-1:0] == 0);

  // 新增：检测是否为0×INF的特殊情况（根据IEEE 754标准需要返回NaN）
  assign is_zero_times_inf = (is_a_zero && is_b_inf) || (is_a_inf && is_b_zero);

  // 输入数据预处理(fp16->fp32)
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      float_a <= 'd0;
      float_b <= 'd0;
    end else if (en) begin
      if (input_a_precision == 'd16) begin
        float_a <= half_to_float_a;
      end else begin
        float_a <= input_a;
      end
      if (input_b_precision == 'd16) begin
        float_b <= half_to_float_b;
      end else begin
        float_b <= input_b;
      end
    end else begin
      float_a <= float_a;
      float_b <= float_b;
    end
  end
  //assign float_a = (input_a_precision == 'd16) ? half_to_float_a : input_a;
  //assign float_b = (input_b_precision == 'd16) ? half_to_float_b : input_b;

  // ---------- 第一级流水线：提取输入值、计算指数和尾数乘法 ----------
  // 提取第一个操作数的符号、指数和尾数，并传递特殊情况标志
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // 复位初始化
      s1 <= 1'b0;  // 符号位清零
      exp1 <= 'b0;  // 指数清零
      man1 <= {1'b1, {(MANT_WIDTH + 1) {1'b0}}};  // 尾数设为1.0（隐藏位为1）
      zero_times_inf_stage1 <= 1'b0;  // 特殊情况标志清零
    end else if (en) begin
      // 正常操作
      s1 <= float_a[FP_WIDTH-1];  // 提取符号位
      exp1 <= is_a_zero ? 'b0 : float_a[FP_WIDTH-2:MANT_WIDTH]; // 若为零则指数清零，否则保留原值
      man1 <= is_a_zero ? 'b0 : {2'b01, float_a[MANT_WIDTH-1:0]}; // 若为零则尾数清零，否则添加隐藏位1
      zero_times_inf_stage1 <= is_zero_times_inf;  // 传递0×INF特殊情况标志
    end
  end

  // 提取第二个操作数的符号、指数和尾数
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // 复位初始化
      s2   <= 1'b0;  // 符号位清零
      exp2 <= 'b0;  // 指数清零
      man2 <= {1'b1, {(MANT_WIDTH + 1) {1'b0}}};  // 尾数设为1.0（隐藏位为1）
    end else if (en) begin
      // 正常操作
      s2 <= float_b[FP_WIDTH-1];  // 提取符号位
      exp2 <= is_b_zero ? 'b0 : float_b[FP_WIDTH-2:MANT_WIDTH]; // 若为零则指数清零，否则保留原值
      man2 <= is_b_zero ? 'b0 : {2'b01, float_b[MANT_WIDTH-1:0]}; // 若为零则尾数清零，否则添加隐藏位1
    end
  end

  // 计算结果符号位（两个操作数符号位异或）
  assign one_s_out = s1 ^ s2;

  // 计算结果指数（两个操作数指数相加并减去偏置值）
  always @(*) begin
    temp1 = {2'b0, exp1} - BIAS;  // 将A的指数转为无偏
    temp2 = {2'b0, exp2} - BIAS;  // 将B的指数转为无偏
    one_e_out = temp1 + temp2 + BIAS;  // 两指数相加再加偏置
  end

  // 计算尾数乘积
  //always @(*) begin
  //    if (exp1 == 'b0 || exp2 == 'b0)
  //        one_m_out = 'b0; // 若任一操作数为零，结果尾数为零
  //    else
  //        one_m_out = man1 * man2; // 正常尾数乘法
  //end

  // 第一级流水线输出寄存
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // 复位初始化
      one_s_reg <= 1'b0;
      one_e_reg <= 'b0;
      one_m_reg <= 'b0;
      zero_times_inf_stage2 <= 1'b0;
    end else if (valid_pipeline[0]) begin  // 使用valid_pipeline[0]控制第二阶段
      // 正常传递到下一级
      one_s_reg <= one_s_out;
      one_e_reg <= one_e_out;
      if (exp1 == 'b0 || exp2 == 'b0) begin
        one_m_reg <= 'b0;
      end else begin
        one_m_reg <= man1 * man2;
      end
      //one_m_reg <= one_m_out;
      zero_times_inf_stage2 <= zero_times_inf_stage1;  // 特殊情况标志传递到第二级
    end
  end

  // ---------- 第二级流水线：尾数规格化、舍入和溢出处理 ----------
  always @(*) begin
    if (one_m_reg == 0 && !zero_times_inf_stage2) begin
      // 结果为零且不是0×INF的情况
      n         = 1'b0;  // 无需归一化
      mul_out_p = 0;  // 尾数乘积为零
      two_m_out = 0;  // 输出尾数为零
      two_f_out = 2'b00;  // 正常标志
      two_e_out = 0;  // 零值的指数为零
    end else if (zero_times_inf_stage2) begin
      // 处理0×INF情况，根据IEEE 754标准返回NaN
      n         = 1'b0;  // 无需归一化
      mul_out_p = 0;  // 尾数乘积不重要
      two_m_out = {1'b1, {(MANT_WIDTH - 1) {1'b0}}};  // NaN的尾数：首位为1，其余为0
      two_f_out = 2'b11;  // 特殊值标志，用于NaN
      two_e_out = {EXP_WIDTH{1'b1}};  // NaN的指数全1
    end else begin
      // 正常非零结果处理
      // 归一化移位：检查乘法结果最高位是否为1
      n = one_m_reg[2*(MANT_WIDTH+1)-1];  // 乘法结果的最高位
      // 如果最高位为1，需要右移一位保持格式为1.xxx
      mul_out_p = n ? (one_m_reg >> 1) : one_m_reg;

      // 尾数舍入处理
      if (round_cfg) begin
        // 舍入模式：判断是否需要向上舍入
        // 检查舍弃位的最高位(G)及其他更低位(R|S)
        if (mul_out_p[MANT_WIDTH] && (mul_out_p[MANT_WIDTH-1] || |mul_out_p[MANT_WIDTH-2:0]))
          two_m_out = mul_out_p[2*(MANT_WIDTH+1)-3:MANT_WIDTH] + 1;  // 向上舍入
        else two_m_out = mul_out_p[2*(MANT_WIDTH+1)-3:MANT_WIDTH];  // 截断
      end else begin
        // 截断模式：直接取高位
        two_m_out = mul_out_p[2*(MANT_WIDTH+1)-3:MANT_WIDTH];
      end

      // 指数调整和溢出检测
      temp3 = one_e_reg + n;  // 若归一化需要右移，指数加1
      // 将temp3视为有符号整数，便于下溢检测
      signed_exp = $signed(temp3);

      if (signed_exp >= $signed({1'b0, {EXP_WIDTH{1'b1}}})) begin
        // 上溢情况：指数超过最大值，返回无穷大
        two_f_out = 2'b01;  // 上溢标志
        two_e_out = {EXP_WIDTH{1'b1}};  // 无穷大的指数全1
      end else if (signed_exp >= 1) begin
        // 正常范围：指数在有效范围内
        two_f_out = 2'b00;  // 正常标志
        two_e_out = temp3[EXP_WIDTH-1:0];  // 取指数的低位
      end else begin
        // 下溢处理：尝试非规格化表示
        shift_amt = 1 - signed_exp;  // 需要右移的位数
        if (shift_amt <= MANT_WIDTH) begin
          // 可以用非规格化数表示
          two_f_out = 2'b11;  // 非规格化标志
          two_e_out = 0;  // 非规格化数的指数为0
          // 右移尾数，保留粘滞位
          two_m_out = mul_out_p >> shift_amt;
        end else begin
          // 真下溢：无法用非规格化数表示，返回零
          two_f_out = 2'b10;  // 下溢标志
          two_e_out = 0;  // 零的指数为0
          two_m_out = 0;  // 零的尾数为0
        end
      end
    end
  end

  // 第二级流水线输出寄存
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // 复位初始化
      two_s_reg <= 1'b0;
      two_e_reg <= 'b0;
      two_m_reg <= 'b0;
      two_f_reg <= 2'b00;
    end else if (valid_pipeline[1]) begin  // 使用valid_pipeline[1]控制第三阶段
      // 正常传递到输出阶段
      two_s_reg <= one_s_reg;
      two_e_reg <= two_e_out;
      two_m_reg <= two_m_out;
      two_f_reg <= two_f_out;
    end
  end

  // ---------- 输出逻辑：组装最终输出 ----------
  always @(*) begin
    if (two_f_reg == 2'b11 && two_e_reg == {EXP_WIDTH{1'b1}}) begin
      // NaN输出：处理0×INF的情况
      // NaN表示：符号位任意（这里用0），指数全1，尾数非零
      float_c  = {1'b0, {EXP_WIDTH{1'b1}}, two_m_reg};
      overflow = 2'b01;  // 指示特殊情况
    end else begin
      // 其他情况的处理
      case (two_f_reg)
        2'b01: begin
          // 溢出 -> 输出无穷大
          float_c  = {two_s_reg, {EXP_WIDTH{1'b1}}, {MANT_WIDTH{1'b0}}};
          overflow = 2'b01;  // 上溢标志
        end
        2'b10: begin
          // 真下溢 -> 输出零
          float_c  = {two_s_reg, {EXP_WIDTH{1'b0}}, {MANT_WIDTH{1'b0}}};
          overflow = 2'b10;  // 下溢标志
        end
        2'b11: begin
          // 非规格化数（subnormal）
          float_c  = {two_s_reg, {EXP_WIDTH{1'b0}}, two_m_reg};
          overflow = 2'b00;  // 正常标志
        end
        default: begin
          // 正常规格化数（normal）
          float_c  = {two_s_reg, two_e_reg, two_m_reg};
          overflow = 2'b00;  // 正常标志
        end
      endcase
    end
  end

  //模块例化

  fp16_to_fp32 h2f_a (
      .half_in  (input_a[15:0]),
      .float_out(half_to_float_a)
  );

  fp16_to_fp32 h2f_b (
      .half_in  (input_b[15:0]),
      .float_out(half_to_float_b)
  );





endmodule
