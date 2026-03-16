// 矩阵乘法顶层模块
// 功能：集成存储器和计算核，完成矩阵乘法运算
module MATRIX_COMPUTE_KERNEL (
      input  clk,                   // 系统时钟
      input  rst_n,                 // 复位信号，低电平有效

      input      compute_en,
      output reg compute_over,

      //以下为输入数据的参数
      input  [5:0] MATRIX_m,
      input  [5:0] MATRIX_a_precision,
                   MATRIX_b_precision,
                   MATRIX_c_precision, 
      input        MATRIX_c_int_or_fp,

      //读数据地址
      input  wire [511:0]   Rd_A_data,
      input  wire [511:0]   Rd_B_data,
      input  wire [31 :0]   Rd_C_data,
      output wire [31 :0]   Rd_D_data,            

      //读数据RAM使能
      output Rd_AB_en,
      output Rd_C_en,
      output Rd_D_en,

      //读数据地址
      output [4:0] Rd_A_addr,             
      output [4:0] Rd_B_addr,
      output [7:0] Rd_C_addr,
      output [7:0] Rd_D_addr

  );

/****************************************** 参数 ********************************************/
  //------------------------------- 本地参数 ---------------------------//
    localparam K           = 16;              //K为定值16

    //不变本地参数
    localparam IDLE          = 3'b000,
               HAND_SHAKE    = 3'b001,
               COMPUTE_START = 3'b011,
               COMPUTE_END   = 3'b010,
               COMPUTE_OVER  = 3'b110;


/*************************寄存器型**************************/
  reg        Start;
  reg        r_compute_en = 1'b0;             //计算使能
  reg [31:0] r_matrix_complete_num = 32'd0;    //完成计算的矩阵组数

  reg [5:0] r_MATRIX_m;
  reg [5:0] r_MATRIX_k;
  reg [5:0] r_MATRIX_n;

  reg [5:0] r_MATRIX_a_precision;
  reg [5:0] r_MATRIX_b_precision;
  reg [5:0] r_MATRIX_c_precision;

  reg       r_MATRIX_c_int_or_fp;

  //状态机参数
  reg [2:0] cur_state, nxt_state;

/*************************网表型**************************/
  wire r_cycle_complete;    //AB矩阵完成一组数据读取之后的标志信号
  wire C_cnt_complete;      //C矩阵完成一组数据读取之后的标志信号
  wire r_compute_end;       //全部的矩阵计算完成后拉高的信号


  // 存储接口信号定义
  reg signed [31:0]    A_value[16];  // A矩阵列数据总线（16路）
  reg signed [31:0]    B_value[16];  // B矩阵行数据总线（16路）
  reg signed [31:0]    C_value;



/************************时序逻辑*************************/

  //状态机逻辑
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      cur_state <= IDLE;
    end
    else begin
      cur_state <= nxt_state;
    end
  end

  reg former_compute_en;

  always @(posedge clk) begin
    former_compute_en <= compute_en;
  end

  //状态机次态逻辑
  always @(*) begin
    nxt_state <= cur_state;
    case(cur_state)
    IDLE:
      if(compute_en & ~former_compute_en) begin
        nxt_state <= HAND_SHAKE;
      end
      else begin
        nxt_state <= IDLE;
      end
    HAND_SHAKE:
      nxt_state <= COMPUTE_START;
    COMPUTE_START:
      if(r_compute_end) begin
        nxt_state <= COMPUTE_END;
      end
      else begin
        nxt_state <= COMPUTE_START;
      end
    COMPUTE_END:
      if(Rd_D_en)begin
        nxt_state <= COMPUTE_END;
      end
      else begin
        nxt_state <= COMPUTE_OVER;
      end
    COMPUTE_OVER:
      nxt_state <= IDLE;
    default:
      nxt_state <= IDLE;
    endcase
  end

  // // AXI握手协议与寄存器配置
  // always @(posedge clk or negedge rst_n) begin
  //   if (!rst_n) begin
  //     Start <= 1'b0;
  //     r_compute_en         <= 1'b0;
  //     r_MATRIX_m           <= 'd0;
  //     r_MATRIX_k           <= 'd0;
  //     r_MATRIX_n           <= 'd0;
  //     r_MATRIX_a_precision <= 'd0;
  //     r_MATRIX_b_precision <= 'd0;
  //     r_MATRIX_c_precision <= 'd0;
  //     r_MATRIX_c_int_or_fp <= 1'b0;
  //     compute_over <= 1'b0;
  //   end
  //   else if (cur_state == IDLE) begin
  //     Start                <= 1'b0;
  //     r_compute_en         <= 1'b0;
  //     r_MATRIX_m           <= 'd0;
  //     r_MATRIX_k           <= 'd0;
  //     r_MATRIX_n           <= 'd0;
  //     r_MATRIX_a_precision <= 'd0;
  //     r_MATRIX_b_precision <= 'd0;
  //     r_MATRIX_c_precision <= 'd0;
  //     r_MATRIX_c_int_or_fp <= 1'b0;
  //     compute_over <= 1'b0;
  //   end
  //   else if(cur_state == HAND_SHAKE) begin
  //     Start <= 1'b1;
  //     r_MATRIX_m <= MATRIX_m;
  //     r_MATRIX_k <= 'd16;
  //     if (MATRIX_m == 'd32)      r_MATRIX_n <= 'd8;
  //     else if (MATRIX_m == 'd16) r_MATRIX_n <= 'd16;
  //     else                       r_MATRIX_n <= 'd32;
  //     r_MATRIX_a_precision <= MATRIX_a_precision;
  //     r_MATRIX_b_precision <= MATRIX_b_precision;
  //     r_MATRIX_c_precision <= MATRIX_c_precision;
  //     r_MATRIX_c_int_or_fp <= MATRIX_c_int_or_fp;
  //     compute_over <= 1'b0;
  //   end
  //   else if(cur_state == COMPUTE_START) begin
  //     r_compute_en <= 1'b1;
  //   end
  //   else if(cur_state == COMPUTE_END) begin
  //     r_compute_en <= 1'b0;
  //   end
  //   else if(cur_state == COMPUTE_OVER) begin
  //     compute_over <= 1'b1;
  //   end
  //   else begin
  //     Start <= Start;
  //     r_compute_en         <= r_compute_en;
  //     r_MATRIX_m           <= r_MATRIX_m;
  //     r_MATRIX_k           <= r_MATRIX_k;
  //     r_MATRIX_n           <= r_MATRIX_n;
  //     r_MATRIX_a_precision <= r_MATRIX_a_precision;
  //     r_MATRIX_b_precision <= r_MATRIX_b_precision;
  //     r_MATRIX_c_precision <= r_MATRIX_c_precision;
  //     r_MATRIX_c_int_or_fp <= r_MATRIX_c_int_or_fp;
  //     compute_over <= compute_over;
  //   end
  // end

  // AXI握手协议与寄存器配置
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      Start <= 1'b0;
      r_compute_en         <= 1'b0;
      r_MATRIX_m           <= 'd0;
      r_MATRIX_k           <= 'd0;
      r_MATRIX_n           <= 'd0;
      r_MATRIX_a_precision <= 'd0;
      r_MATRIX_b_precision <= 'd0;
      r_MATRIX_c_precision <= 'd0;
      r_MATRIX_c_int_or_fp <= 1'b0;
      compute_over <= 1'b0;
    end
    else if (cur_state == IDLE) begin
      Start                <= 1'b0;
      r_compute_en         <= 1'b0;
      
      if(compute_en & ~former_compute_en) begin
        r_MATRIX_m <= MATRIX_m;
        r_MATRIX_k <= 'd16;
        if (MATRIX_m == 'd32)      r_MATRIX_n <= 'd8;
        else if (MATRIX_m == 'd16) r_MATRIX_n <= 'd16;
        else                       r_MATRIX_n <= 'd32;
        r_MATRIX_a_precision <= MATRIX_a_precision;
        r_MATRIX_b_precision <= MATRIX_b_precision;
        r_MATRIX_c_precision <= MATRIX_c_precision;
        r_MATRIX_c_int_or_fp <= MATRIX_c_int_or_fp;
        compute_over <= 1'b0;
      end
      else begin
        r_MATRIX_m           <= 'd0;
        r_MATRIX_k           <= 'd0;
        r_MATRIX_n           <= 'd0;
        r_MATRIX_a_precision <= 'd0;
        r_MATRIX_b_precision <= 'd0;
        r_MATRIX_c_precision <= 'd0;
        r_MATRIX_c_int_or_fp <= 1'b0;
        compute_over <= 1'b0;
      end
    end
    else if(cur_state == HAND_SHAKE) begin
      Start <= 1'b1;
      compute_over <= 1'b0;
    end
    else if(cur_state == COMPUTE_START) begin
      r_compute_en <= 1'b1;
    end
    else if(cur_state == COMPUTE_END) begin
      r_compute_en <= 1'b0;
    end
    else if(cur_state == COMPUTE_OVER) begin
      compute_over <= 1'b1;
    end
    else begin
      Start <= Start;
      r_compute_en         <= r_compute_en;
      r_MATRIX_m           <= r_MATRIX_m;
      r_MATRIX_k           <= r_MATRIX_k;
      r_MATRIX_n           <= r_MATRIX_n;
      r_MATRIX_a_precision <= r_MATRIX_a_precision;
      r_MATRIX_b_precision <= r_MATRIX_b_precision;
      r_MATRIX_c_precision <= r_MATRIX_c_precision;
      r_MATRIX_c_int_or_fp <= r_MATRIX_c_int_or_fp;
      compute_over <= compute_over;
    end
  end


/************************组合逻辑*************************/

  assign r_compute_end = r_cycle_complete;

  //######################################################
  // 第一级流水线数据预处理
  //######################################################

  always @(posedge clk) begin
    for(int i = 0; i < K; i++) begin
      case(r_MATRIX_a_precision)
      'd4:  A_value[i] <= (Rd_A_data >> (4  * (K - i - 1))) & ((1 << 4 ) - 1);
      'd8:  A_value[i] <= (Rd_A_data >> (8  * (K - i - 1))) & ((1 << 8 ) - 1);
      'd16: A_value[i] <= (Rd_A_data >> (16 * (K - i - 1))) & ((1 << 16) - 1);
      'd32: A_value[i] <= (Rd_A_data >> (32 * (K - i - 1))) & ((1 << 32) - 1);
      endcase
    end
  end

  always @(posedge clk) begin
    for(int i = 0; i < K; i++) begin
      case(r_MATRIX_b_precision)
      'd4:  B_value[i] <= (Rd_B_data >> (4  * (K - i - 1))) & ((1 << 4 ) - 1);
      'd8:  B_value[i] <= (Rd_B_data >> (8  * (K - i - 1))) & ((1 << 8 ) - 1);
      'd16: B_value[i] <= (Rd_B_data >> (16 * (K - i - 1))) & ((1 << 16) - 1);
      'd32: B_value[i] <= (Rd_B_data >> (32 * (K - i - 1))) & ((1 << 32) - 1);
      endcase
    end
  end

  always @(posedge clk) begin
    C_value <= Rd_C_data;
  end



/*************************例化**************************/

    matmult_kernel matmult_kernel_inst(
        // 时钟和控制
        .clk   (clk  ),
        .Start (Start),
        .rst_n (rst_n),

        .MATRIX_m(r_MATRIX_m),
        .MATRIX_k(r_MATRIX_k),
        .MATRIX_n(r_MATRIX_n),

        .MATRIX_a_precision(r_MATRIX_a_precision),
        .MATRIX_b_precision(r_MATRIX_b_precision),
        .MATRIX_c_precision(r_MATRIX_c_precision),

        .MATRIX_c_int_or_fp(r_MATRIX_c_int_or_fp),

        // A矩阵输入（16个元素）
        .A  (A_value),

        // B矩阵输入（16个元素）  
        .B  (B_value),

        // C矩阵输入（1个元素）
        .C  (C_value),

        // 计算结果输出
        .D  (Rd_D_data),

        // 存储器控制信号
        .Rd_AB_en        (Rd_AB_en        ),
        .Rd_C_en         (Rd_C_en         ),
        .Rd_A_addr       (Rd_A_addr       ),
        .Rd_B_addr       (Rd_B_addr       ),
        .Rd_C_addr       (Rd_C_addr       ),
        .Wr_en           (Rd_D_en         ),
        .Wr_addr         (Rd_D_addr       ),
        .r_cycle_complete(r_cycle_complete),
        .compute_en      (r_compute_en    ),
        .compute_over    (compute_over    ),
        .C_cnt_complete  (C_cnt_complete  )
    );

endmodule