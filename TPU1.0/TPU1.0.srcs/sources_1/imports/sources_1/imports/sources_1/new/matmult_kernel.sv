// 矩阵乘法核模块
// 采用流水线结构实现16个元素的点积运算
module matmult_kernel #(

    //以下参数不变
    parameter C_TOTAL = 256,
    parameter D_TOTAL = 256
  )(
      // 基础控制信号
      input clk,   // 时钟信号
      input Start, // 开始计算信号
      input rst_n,
      
      input [5:0] MATRIX_m,
                  MATRIX_k,
                  MATRIX_n,

      input [5:0] MATRIX_a_precision,
                  MATRIX_b_precision,
                  MATRIX_c_precision,

      input       MATRIX_c_int_or_fp,

      // 输入向量A和B（各16个元素）
      input signed [31:0] A[16],
      // 向量B 
      input signed [31:0] B[16],
      // 元素C
      input signed [31:0] C,    //输入的元素C

      input compute_en,                         //计算使能信号

      input compute_over,                       //计算结束

      // 输出和存储器接口信号
      output reg        Rd_AB_en,Rd_C_en,Wr_en, // 读/写使能

      output     [31:0] Rd_A_addr,              // A向量读取地址
      output     [31:0] Rd_B_addr,              // B向量读取地址
      output reg [31:0] Rd_C_addr = 0,          // C向量读取地址
      output reg [31:0] Wr_addr = 0,            // 结果写入地址
      output     [31:0] D,                      // 计算结果


      output r_cycle_complete,                  // cycle_cnt到达255时拉高
      output C_cnt_complete                     // C矩阵完成一组读取后拉高
  );

/***************************寄存器型************************/

  // 流水线寄存器（树形结构实现并行归约）
  reg [31:0] reg_state_1[16];    // 第1级：16个并行乘法结果
  reg [31:0] reg_state_2[8];     // 第2级：8个加法结果（两两相加）
  reg [31:0] reg_state_3[4];     // 第3级：4个加法结果
  reg [31:0] reg_state_4[2];     // 第4级：2个加法结果
  reg [31:0] reg_state_5;        // 第5级：乘法的最终结果
  reg [31:0] reg_state_6;        // 第6级：最终求和结果


  reg [31:0] fp_reg_state_1[16];  // 第1级：16个并行乘法结果
  reg [31:0] fp_reg_state_2[8];   // 第2级：8个加法结果（两两相加）
  reg [31:0] fp_reg_state_3[4];   // 第3级：4个加法结果
  reg [31:0] fp_reg_state_4[2];   // 第4级：2个加法结果
  reg [31:0] fp_reg_state_5;      // 第5级：乘法的最终结果
  reg [31:0] fp_reg_state_6;      // 第6级：最终求和结果

  reg signed [31:0] fp_A[16];     //存放浮点数的寄存器组
  reg signed [31:0] fp_B[16];
  reg signed [31:0] fp_C;

  reg mix;                        //是否为混合精度

  reg signed [31:0] r_A[16];      //补高位后的A矩阵元素
  reg signed [31:0] r_B[16];      //补高位后的B矩阵元素
  reg signed [31:0] r_C;          //补高位后的C矩阵元素
  reg [4:0] r_A_row_cnt = 0;      //A矩阵读行数据的计数器
  reg [4:0] r_B_col_cnt = 0;      //B矩阵读列数据的计数器

  reg r_C_addr_state = 1;         //C矩阵计数器状态
  reg r_D_addr_state = 1;         //D矩阵计数器状态

  //A、B部位操作时需要的位移
  reg [5:0] shift_A;
  reg [5:0] shift_B;

  //判断是否是浮点数
  reg if_A_fp;
  reg if_B_fp;
  reg if_C_fp;

  reg fp_en;

  // 用于储存A、B、C精度的寄存器
  reg [5:0] r_MATRIX_a_precision;
  reg [5:0] r_MATRIX_b_precision;
  reg [5:0] r_MATRIX_c_precision;

  reg A_process_input_valid;
  reg B_process_input_valid;
  reg C_process_input_valid;

  reg [5:0] MATRIX_c_start_cycle_cnt;
  reg [5:0] MATRIX_d_start_cycle_cnt;


/***************************网表型*************************/
  wire AB_row_col_cnt_complete;

  // wire matrix_mult_fp_en;  //矩阵乘法时FPU使能信号
  // wire matrix_add_fp_en;   //矩阵加法时FPU使能信号
  

  //混合精度时，用于存储由整数转换而来的32位浮点数
  wire signed [31:0] fp_A_processed[16];
  wire signed [31:0] fp_B_processed[16];
  wire signed [31:0] fp_C_processed;

  wire [31:0] fp_state_1[16];     // 第1级：16个并行乘法结果
  wire [31:0] fp_state_2[8];      // 第2级：8个加法结果（两两相加）
  wire [31:0] fp_state_3[4];      // 第3级：4个加法结果
  wire [31:0] fp_state_4[2];      // 第4级：2个加法结果
  wire [31:0] fp_state_5;         // 第5级：乘法的最终结果
  wire [31:0] fp_state_6;         // 第6级：最终求和结果

  wire A_process_valid[16];       // A、B、C转换完成标志位(int->float)
  wire B_process_valid[16];
  wire C_process_valid;


/***************************时序逻辑************************/

  //----------------------AB矩阵控制逻辑-------------------//
    // A,B矩阵读地址使能生成逻辑
    always @(posedge clk) begin
      if (Start || compute_en) begin
        Rd_AB_en <= 1;  // 使能读取
      end else begin
        Rd_AB_en <= 0;
      end
    end

    // B矩阵列控制逻辑
    always @(posedge clk) begin
      if (compute_en) begin
        if (r_B_col_cnt == MATRIX_n - 1) begin
          r_B_col_cnt <= 0;
        end else begin
          r_B_col_cnt <= r_B_col_cnt+1;
        end
      end else r_B_col_cnt <= 0;
    end

    // A矩阵行控制逻辑
    always @(posedge clk) begin
      if (compute_en) begin
        if (AB_row_col_cnt_complete) begin
          r_A_row_cnt <= 0;
        end else if (r_B_col_cnt == MATRIX_n - 1) begin
          r_A_row_cnt <= r_A_row_cnt + 1;
        end
      end else r_A_row_cnt <= 0;
    end 

  //----------------------C矩阵控制逻辑-------------------//
  // C矩阵控制逻辑
    always @(posedge clk) begin
      if (!rst_n) begin
        r_C_addr_state <= 1;
      end else if (compute_over) begin
        r_C_addr_state <= 1;
      end else if (compute_en) begin
        if (r_C_addr_state) begin
          if (Rd_C_addr == MATRIX_c_start_cycle_cnt-1) begin
            Rd_C_addr <= 0;
            r_C_addr_state <= 0;
          end else begin
            Rd_C_addr <= Rd_C_addr+1;
          end
        end else begin
          if (Rd_C_addr == C_TOTAL-1) begin
            Rd_C_addr <= 0;
          end else begin
            Rd_C_addr <= Rd_C_addr+1;
          end
        end
      end else if(Rd_C_addr >= C_TOTAL-MATRIX_c_start_cycle_cnt-1) begin
          if (Rd_C_addr == C_TOTAL-1) begin
            Rd_C_addr <= 0;
          end else begin
            Rd_C_addr <= Rd_C_addr+1;
          end
      end
    end

    // C矩阵地址使能控制逻辑
    always @(posedge clk) begin
      if (compute_en) begin
        if (r_C_addr_state) begin
          Rd_C_en <= 0;
          if (Rd_C_addr == MATRIX_c_start_cycle_cnt-1) begin
            Rd_C_en <= 1;  
          end
        end
        else begin
          Rd_C_en <= Rd_C_en;
        end 
      end /*else if(Rd_C_addr >= C_TOTAL-MATRIX_c_start_cycle_cnt-1) begin
          if (Rd_C_addr == C_TOTAL-1) begin
            Rd_C_en   <= 0;  // 关闭使能
          end else begin
            Rd_C_en   <= 1;  // 继续使能写入
          end
      end*/
      else if (!(Start || compute_en)) begin
        Rd_C_en <= 0;
      end
      else begin
        Rd_C_en <= Rd_C_en;
      end
    end

  always @(posedge clk) begin
    r_MATRIX_a_precision <= MATRIX_a_precision;
    r_MATRIX_b_precision <= MATRIX_b_precision;
    r_MATRIX_c_precision <= MATRIX_c_precision;
  end

  // fpu数据赋值
  always @(posedge clk) begin
    if (!rst_n) begin
        for(int i = 0; i < 16; i++) begin
          fp_A[i] = 'd0;
          fp_B[i] = 'd0;
        end
        fp_C <= 'd0;
    end
    else if (fp_en) begin
      if (mix) begin
        for(int i = 0; i < 16; i++) begin
          if (A_process_valid[i]) fp_A[i] <= fp_A_processed[i];
          if (B_process_valid[i]) fp_B[i] <= fp_B_processed[i];
        end
        if (C_process_valid) fp_C <= fp_C_processed;
      end
      else begin
        fp_A <= A;
        fp_B <= B;
        fp_C <= C;
      end
    end
    else begin
      fp_A <= fp_A;
      fp_B <= fp_B;
      fp_C <= fp_C;
    end
  end

  //shift_A、shift_B计算
  //always @(*) begin
  //  shift_A = ('d32 - MATRIX_a_precisionr
  //  shift_B = ('d32 - r_MATRIX_b_precision);
  //end

  // A矩阵元素补码补高位操作(补位成32位)
  always @(posedge clk) begin
    for(int i = 0; i < 16; i++) begin
      if(!rst_n) begin
        r_A[i] <= 'd0;
        A_process_input_valid <= 0;
      end
      else if (Rd_AB_en) begin
        A_process_input_valid <= 1;
        case(r_MATRIX_a_precision)
          'd4:     r_A[i] <= (A[i] << 28) >>> 28;
          'd8:     r_A[i] <= (A[i] << 24) >>> 24;
          'd16:    r_A[i] <= (A[i] << 16) >>> 16;
          'd32:    r_A[i] <= A[i];
          default: r_A[i] <= A[i];
        endcase
      end
      else begin
        r_A[i] <= r_A[i];
        A_process_input_valid <= 0;
      end
    end
  end

  // B矩阵元素补码补高位操作(补位成32位)
  always @(posedge clk) begin
    for(int i = 0; i < 16; i++) begin
      if(!rst_n) begin
        r_B[i] <= 'd0;
        B_process_input_valid <= 0;
      end
      else if (Rd_AB_en) begin
        B_process_input_valid <= 1;
        case(r_MATRIX_b_precision)
          'd4:     r_B[i] <= (B[i] << 28) >>> 28;
          'd8:     r_B[i] <= (B[i] << 24) >>> 24;
          'd16:    r_B[i] <= (B[i] << 16) >>> 16;
          'd32:    r_B[i] <= B[i];
          default: r_B[i] <= B[i];
        endcase
      end
      else begin
        r_B[i] <= r_B[i];
        B_process_input_valid <= 0;
      end
    end
  end

  // C矩阵元素补码补高位操作(补位成32位)
  always @(posedge clk) begin
      if(!rst_n) begin
        r_C <= 'd0;
        C_process_input_valid <= 0;
      end
      else if (Rd_C_en) begin
        C_process_input_valid <= 1;
        case(r_MATRIX_c_precision)
          'd4:     r_C <= (C << 28) >>> 28;
          'd8:     r_C <= (C << 24) >>> 24;
          'd16:    r_C <= (C << 16) >>> 16;
          'd32:    r_C <= C;
          default: r_C <= C;
        endcase
      end
      else begin
        r_C <= r_C;
        C_process_input_valid <= 0;
      end
  end

  // always @(posedge clk) begin
  //   if (!rst_n) begin
  //     r_C <= 32'd0;
  //   end
  //   else if (r_MATRIX_c_precision == 'd4) begin
  //     r_C <= (C << 28) >>> 28;
  //   end
  //   else if (r_MATRIX_c_precision == 'd8) begin
  //     r_C <= (C << 24) >>> 24;
  //   end
  //   else if (r_MATRIX_c_precision == 32 && MATRIX_c_int_or_fp) begin
  //     r_C <= C;
  //   end
  //   else begin
  //     r_C <= r_C;
  //   end
  // end

  //----------------------C矩阵控制逻辑-------------------//
  // D矩阵写控制逻辑
  always @(posedge clk) begin
      if (!rst_n) begin
        r_D_addr_state <= 1;
      end else if (compute_over) begin
        r_D_addr_state <= 1;
      end else if (compute_en) begin
      if (r_D_addr_state) begin
        Wr_en <= 0;
        if (Wr_addr == MATRIX_d_start_cycle_cnt-1) begin
          Wr_addr <= 0;
          r_D_addr_state <= 0;
          Wr_en <= 1;
        end else begin
          Wr_addr <= Wr_addr+1;
        end
      end else begin
        Wr_en   <= 1;  // 使能写入
        if (Wr_addr == D_TOTAL-1) begin
          Wr_addr <= 0;
        end else begin
          Wr_addr <= Wr_addr+1;
        end
      end
    end else if(Wr_addr >= D_TOTAL-MATRIX_d_start_cycle_cnt-1) begin
        if (Wr_addr == D_TOTAL-1) begin
          Wr_en   <= 0;  // 关闭使能
          Wr_addr <= 0;
        end else begin
          Wr_en   <= 1;  // 继续使能写入
          Wr_addr <= Wr_addr+1;
        end
    end
  end

  // 判断是否有浮点数
  always @(posedge clk) begin
    if(r_MATRIX_a_precision == 'd16 || r_MATRIX_a_precision == 'd32) begin
      if_A_fp <= 1'b1;
    end
    else begin
      if_A_fp <= 1'b0;
    end
    if(r_MATRIX_b_precision == 'd16 || r_MATRIX_b_precision == 'd32) begin
      if_B_fp <= 1'b1;
    end
    else begin
      if_B_fp <= 1'b0;
    end
    if(r_MATRIX_c_precision == 'd16 || (r_MATRIX_c_precision == 'd32 && !MATRIX_c_int_or_fp)) begin
      if_C_fp <= 1'b1;
    end
    else begin
      if_C_fp <= 1'b0;
    end
  end

  // 判断是否为混合精度
  always @(posedge clk) begin
    if(if_A_fp == if_B_fp && if_B_fp == if_C_fp) begin
      mix <= 1'b0;
    end
    else begin
      mix <= 1'b1;
    end
  end

 always @(posedge clk) begin
    if(if_A_fp || if_B_fp || if_C_fp) begin
      MATRIX_c_start_cycle_cnt <= 29;
    end
    else begin
      MATRIX_c_start_cycle_cnt <= 5;
    end
  end

  always @(posedge clk) begin
    if (mix) begin
      MATRIX_d_start_cycle_cnt <= 44;
    end
    else if (!mix & if_A_fp) begin
      MATRIX_d_start_cycle_cnt <= 38;
    end
    else begin
      MATRIX_d_start_cycle_cnt <= 9;
    end
  end

  always @(posedge clk) begin
    if(if_A_fp || if_B_fp || if_C_fp) begin
      fp_en <= 1'b1;
    end
    else begin
      fp_en <= 1'b0;
    end
  end

/***************************组合逻辑************************/
  // 输出最终结果
  assign D = (fp_en) ? fp_reg_state_6 : reg_state_6;
  assign r_cycle_complete = AB_row_col_cnt_complete;
  assign AB_row_col_cnt_complete = (r_A_row_cnt == MATRIX_m - 1) && (r_B_col_cnt == MATRIX_n - 1);
  assign C_cnt_complete = (Rd_C_addr == C_TOTAL-1);

  assign Rd_A_addr = r_A_row_cnt;   //AB矩阵行列寻址控制
  assign Rd_B_addr = r_B_col_cnt; 


  // fpu使能控制
  // assign matrix_mult_fp_en = (if_A_fp || if_B_fp) ? 1 : 0;
  // assign matrix_add_fp_en = (matrix_mult_fp_en || if_C_fp) ? 1 : 0;

  //确定C、D矩阵开始读数据时机
  //assign MATRIX_c_start_cycle_cnt = (if_A_fp || if_B_fp || if_C_fp) ? 28 : 5;
  //assign MATRIX_d_start_cycle_cnt = 43; //(if_A_fp || if_B_fp || if_C_fp) ? 37 : 9;



/*************************** 流水线计算逻辑 ************************/
  // 第1级：并行乘法运算（A_i * B_i）
    always @(posedge clk) begin
      if(!(fp_en)) begin
        for(int i = 0; i < 16; i++) begin
          reg_state_1[i] <= r_A[i] * r_B[i];
        end
      end
    end


  // 第2级：第一次归约（8个加法器）
    always @(posedge clk) begin
      if(!(fp_en)) begin
        for(int i = 0; i < 8; i++) begin
          reg_state_2[i] <= reg_state_1[2 * i] + reg_state_1[2 * i + 1];
        end
      end
    end


  // 第3级：第二次归约（4个加法器）
    always @(posedge clk) begin
      if(!(fp_en)) begin
        for(int i = 0; i < 4; i++) begin
          reg_state_3[i] <= reg_state_2[2 * i] + reg_state_2[2 * i + 1];
        end
      end
    end


  // 第4级：第三次归约（2个加法器）
    always @(posedge clk) begin
      if(!(fp_en)) begin
        reg_state_4[0] <= reg_state_3[0] + reg_state_3[1];
        reg_state_4[1] <= reg_state_3[2] + reg_state_3[3];
      end
    end


  // 第5级：行列乘法的最终求和
    always @(posedge clk) begin
      if(!(fp_en)) begin
        reg_state_5 <= reg_state_4[0] + reg_state_4[1];
      end
    end


  // 第6级：最终求和
    always @(posedge clk) begin
      if(!(fp_en)) begin
        reg_state_6 <= reg_state_5 + r_C;
      end
    end

/*************************** 浮点数计算流水线 ************************/
    always @(posedge clk) begin
      fp_reg_state_1 <= fp_state_1;
    end

    always @(posedge clk) begin
      fp_reg_state_2 <= fp_state_2;
    end

    always @(posedge clk) begin
      fp_reg_state_3 <= fp_state_3;
    end

    always @(posedge clk) begin
      fp_reg_state_4 <= fp_state_4;
    end

    always @(posedge clk) begin
      fp_reg_state_5 <= fp_state_5;
    end

    always @(posedge clk) begin
      fp_reg_state_6 <= fp_state_6;
    end

/*************************** 模块例化 ************************/
    // 第1级流水线
      genvar i;
      generate
        for(i = 0; i < 16; i = i + 1) begin : fpu_mult_stage_1
          fpu_mult fpu_mult_stage_1_inst (
            .clk               (clk                 ),      
            .en                (fp_en               ),     
            .rst_n             (rst_n               ),
            .round_cfg         (1'b1                ),
            .input_a           (fp_A[i]             ),
            .input_b           (fp_B[i]             ),
            .input_a_precision (r_MATRIX_a_precision),
            .input_b_precision (r_MATRIX_b_precision),
            .float_c           (fp_state_1[i]       )
          );
        end
      endgenerate


    //第2级流水线

      generate
        for(i = 0; i < 8; i = i + 1) begin : fpu_add_stage_2
          fp_adder fpu_add_stage_2_inst (  
            .clk               (clk                  ),      
            .rst_n             (rst_n                ),     
            .read_en           (fp_en                ),
            .input_A           (fp_reg_state_1[2*i]  ),
            .input_B           (fp_reg_state_1[2*i+1]),
            .input_b_precision ('d32                 ),
            .C                 (fp_state_2[i]        )
          );
        end
      endgenerate


    //第3级流水线
      generate
        for(i = 0; i < 4; i = i + 1) begin : fpu_add_stage_3
          fp_adder fpu_add_stage_3_inst (
            .clk               (clk                  ),      
            .rst_n             (rst_n                ),     
            .read_en           (fp_en                ),
            .input_A           (fp_reg_state_2[2*i]  ),
            .input_B           (fp_reg_state_2[2*i+1]),
            .input_b_precision ('d32                 ),
            .C                 (fp_state_3[i]        )
          );
        end
      endgenerate


    //第4级流水线
      generate
        for(i = 0; i < 2; i = i + 1) begin : fpu_add_stage_4
          fp_adder fpu_add_stage_4_inst (
            .clk               (clk                  ),      
            .rst_n             (rst_n                ),     
            .read_en           (fp_en                ),
            .input_A           (fp_reg_state_3[2*i]  ),
            .input_B           (fp_reg_state_3[2*i+1]),
            .input_b_precision ('d32                 ),
            .C                 (fp_state_4[i]        )
          );
        end
      endgenerate


    //第5级流水线
      fp_adder fpu_add_stage_5_inst (
        .clk               (clk              ),      
        .rst_n             (rst_n            ),     
        .read_en           (fp_en            ),
        .input_A           (fp_reg_state_4[0]),
        .input_B           (fp_reg_state_4[1]),
        .input_b_precision ('d32             ),
        .C                 (fp_state_5       )
      );


    //第6级流水线
      fp_adder fpu_add_stage_6_inst (
        .clk               (clk                                  ),      
        .rst_n             (rst_n                                ),     
        .read_en           (fp_en                                ),
        .input_A           (fp_reg_state_5                       ),
        .input_B           (fp_C                                 ),         // 此位输入可为16位
        .input_b_precision (if_C_fp ? r_MATRIX_c_precision : 'd32),
        .C                 (fp_state_6                           )
      );


  /*************************** 整数转浮点数 ***************************/
    //A
    generate
        for(i = 0; i < 16; i = i + 1) begin : A_int2fp
            int2float int2float_A (
                .clk(clk),
                .rst_n(rst_n),
                .mode(!if_A_fp),
                .in_valid(mix & A_process_input_valid),
                .int_in(r_A[i]),
                .out_valid(A_process_valid[i]),
                .float_out(fp_A_processed[i])
            );
        end
    endgenerate 
    
    //B
    generate
        for(i = 0; i < 16; i = i + 1) begin : B_int2fp
            int2float int2float_B (
                .clk(clk),
                .rst_n(rst_n),
                .mode(!if_B_fp),
                .in_valid(mix & B_process_input_valid),
                .int_in(r_B[i]),
                .out_valid(B_process_valid[i]),
                .float_out(fp_B_processed[i])
            );
        end
    endgenerate

    //C
    int2float int2float_C0 (
      .clk(clk),
      .rst_n(rst_n),
      .mode(!if_C_fp),
      .in_valid(mix & C_process_input_valid),
      .int_in(r_C),
      .out_valid(C_process_valid),
      .float_out(fp_C_processed)
    );

endmodule


  // /*************************** 整数转浮点数 ************************/
  //   //A
  //   generate
  //       for(i = 0; i < 16; i = i + 1) begin : A_fp2int
  //           int2float int2float_A (
  //               .int_in(A[i]),
  //               .input_precision(r_MATRIX_a_precision),
  //               .float_out(fp_A_processed[i])
  //           );
  //       end
  //   endgenerate 
    
  //   //B
  //   generate
  //       for(i = 0; i < 16; i = i + 1) begin : B_fp2int
  //           int2float int2float_B (
  //               .int_in(B[i]),
  //               .input_precision(r_MATRIX_a_precision),
  //               .float_out(fp_B_processed[i])
  //           );
  //       end
  //   endgenerate

  //   //C
  //   int2float int2float_C0 (
  //     .int_in(C),
  //     .input_precision(r_MATRIX_c_precision),
  //     .float_out(fp_C_processed)
  //   );