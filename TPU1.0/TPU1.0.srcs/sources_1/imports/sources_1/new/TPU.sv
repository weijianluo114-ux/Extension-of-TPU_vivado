`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/10 20:27:33
// Design Name: 
// Module Name: TPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TPU(
    input wire         clk,
    input wire         rst_n,

    input wire         write_flag,                 //写回有效
    input wire         read_flag,                  //读数据是有效的
    input wire [127:0] AXI_rdata,                  //AXI读出来的128位宽数据
    output reg [127:0] AXI_wdata,                  //写回ddr3或总线的数据



    //与AXI_FULL_crtl连接的端口，最后连接到RAM_BUF_TOP
        input wire [1:0]   MATRIX_state,           //用于判断当前为哪一个矩阵
        input wire [6:0]   MATRIX_cnt,
        input wire [5:0]   MATRIX_D_data_back_cnt, //读回矩阵D数据时用到的计数器

        output wire        compute_en_posedge,     //compute_en上升沿信号，接出去

    input wire         AXI_data_send_handshake,    //标志AXI_data_send_valid和AXI_data_send_ready握手成功
    input wire         data_send_last,             //当最后一组数据发送完之后拉高
    input wire         reg_config_handshake,       //标志配置握手成功
    input wire         M_en,                       //AXI_LITE_M_AWVALID拉高时拉高的信号，标志还有未完成的AXI_LITE事务（即未计算完成的矩阵）

    output reg         AXI_data_send_ready,        //控制ready信号

    output wire        compute_over,               //运算结束信号，只要拉高一个脉冲

    output reg         last_compute,               //最后一次计算                

    input wire         data_send_flag,             //该信号用来控制

    //以下为输入的参数
        input wire [5:0] MATRIX_m,                 //矩阵的维度
        input wire [5:0] MATRIX_a_precision,       //矩阵精度
        input wire [5:0] MATRIX_b_precision,
        input wire [5:0] MATRIX_c_precision,
        input wire       MATRIX_c_int_or_fp        //判断矩阵C是否是整数
    );


/****************************************** 参数 ********************************************/
  //------------------------------- 普通参数 ---------------------------//


  //------------------------------- 本地参数 ---------------------------//
    //配置参数状态机参数
      localparam REG_IDLE              = 2'd0,
                 REG_CONFIG            = 2'd1,
                 REG_WAIT_COMPUTE_OVER = 2'd2,
                 REG_OVER              = 2'd3;
                   

/****************************************** 网表型信号 ***************************************/
    wire reg_config_complete;    //配置完成后拉高的信号，开始配置时拉低（由data_send_flag来决定）

    wire RAM_switch;             //标志接线要切换的时刻，与RAM_BUF_TOP连接

    //以下信号为MATRIX_COMPUTE_KERNEL与RAM_BUF_TOP模块的连接信号
    wire         Rd_AB_en; 
    wire         Rd_C_en;  
    wire         Rd_D_en;  
    wire [4:0]   Rd_A_addr;
    wire [4:0]   Rd_B_addr;
    wire [7:0]   Rd_C_addr;
    wire [7:0]   Rd_D_addr;
    wire [511:0] Rd_A_data;
    wire [511:0] Rd_B_data;
    wire [31:0]  Rd_C_data;
    wire [31:0]  Rd_D_data;

    


/****************************************** 寄存器型信号 ************************************/
    reg       weather_first;              //用于判断是否为第一个计算的矩阵

    reg       compute_en;        //告诉核心可以开始计算

    reg [1:0] reg_config_state;    //配置参数状态机状态
    reg [1:0] r_reg_config_state;  //用于检测状态变换



    reg data_send_complete;      //发完数据后拉高的信号，发送时拉低
    reg reg_config_compute_over; //只有在计算的时候才会拉低的一个信号

    reg wait_en;                 //与M_en配合使用，给REG_WAIT_COMPUTE_OVER提供参考

    

    reg [5:0] r_m;                //矩阵的维度
    reg [5:0] r_a_precision;      //矩阵精度
    reg [5:0] r_b_precision;
    reg [5:0] r_c_precision;
    reg       r_c_int_or_fp;      //判断矩阵C是否是整数

    //以下为缓冲用的配置及给出的配置
    reg [5:0] m;                  //矩阵的维度
    reg [5:0] a_precision;        //矩阵精度
    reg [5:0] b_precision;
    reg [5:0] c_precision;
    reg       c_int_or_fp;        //判断矩阵C是否是整数


/****************************************** 组合逻辑 ****************************************/
    //以下为配置完成信号
    assign reg_config_complete = data_send_flag;

    //表示要切换RAM的连接了，最后一次是状态的切换的时候要拉高一下，因为最后一次只有回传数据，没有发送数据
    assign RAM_switch = ((reg_config_state == REG_CONFIG) && (data_send_complete && reg_config_complete)) || (r_reg_config_state == REG_WAIT_COMPUTE_OVER && reg_config_state == REG_OVER);

    // assign m           =   
    // assign a_precision =  
    // assign b_precision =  
    // assign c_precision =  
    // assign c_int_or_fp =  

/****************************************** 时序逻辑 ****************************************/
    //配置参数及计算使能状态机
        always @(posedge clk) begin
            if (!rst_n) begin                 //复位
                weather_first     <= 1'b1;     //判断是否为第一次计算
                compute_en         <= 1'b0;     //计算使能复位
                reg_config_state   <= REG_IDLE;
            end else begin
                //判断此时的发送状态
                case (reg_config_state)

                //空闲态
                REG_IDLE: begin
                    compute_en                <= 1'b0;       //空闲态下不使能
                    weather_first             <= 1'b1;       //空闲态下为第一次计算
                    if (reg_config_handshake) begin          //等待开始信号（这里以reg_config_handshake作为启动，因为该信号拉高一定表明有数据要传输）
                        reg_config_state      <= REG_CONFIG;
                    end else begin 
                        reg_config_state      <= REG_IDLE;
                    end
                end

                //等待数据发送完成，并发送可开始计算信号等待下一次的配置握手
                REG_CONFIG: begin
                    //往后的发送
                    if (data_send_complete && reg_config_compute_over) begin
                        compute_en                <= 1'b1;
                        reg_config_state          <= REG_WAIT_COMPUTE_OVER;
                    end else reg_config_state     <= REG_CONFIG;
                end

                //等待计算完成态
                REG_WAIT_COMPUTE_OVER: begin
                    if (compute_en) begin
                        weather_first    <= 1'b0;            //说明已经计算了第一次
                    end
                    // if (AXI_data_send_handshake) begin
                    //     weather_first    <= 1'b0;            //说明已经计算了第一次
                    // end

                    //在等待计算完成的中途，数据和配置都完成了
                    if (compute_over) begin
                        if (wait_en) begin
                            reg_config_state  <= REG_CONFIG;
                        end else begin
                            reg_config_state <= REG_OVER;
                        end 
                        //标志最后一次计算
                        

                        compute_en            <= 1'b0;
                    end else reg_config_state <= REG_WAIT_COMPUTE_OVER;
                end

                //等待计算结束态
                REG_OVER: begin
                    if (compute_over) begin
                        reg_config_state      <= REG_IDLE;
                        compute_en            <= 1'b0;           //计算完成后不使能
                    end else if (data_send_complete && reg_config_compute_over) begin
                        compute_en            <= 1'b1;
                    end else reg_config_state <= REG_OVER;
                end

                default: begin 
                    reg_config_state    <= REG_IDLE;                   //默认处于空闲态
                end
                endcase
            end
        end


    //last_compute控制
        always @(posedge clk) begin
            if ((!rst_n) || (reg_config_state == REG_IDLE)) begin                 //复位
                last_compute <= 1'b0;
            end else if (compute_en_posedge) begin
                if (wait_en) begin
                    last_compute      <= 1'b0;
                end else last_compute <= 1'b1;
            end else last_compute     <= last_compute;
        end



    //data_send_complete控制
        always @(posedge clk) begin
            if ((!rst_n) || (reg_config_state == REG_IDLE)) begin                 //复位
                data_send_complete      <= 1'b0;
            end else if (RAM_switch) begin
                data_send_complete      <= 1'b0;
            end else if (data_send_last) begin
                data_send_complete      <= 1'b1;
            end else data_send_complete <= data_send_complete;
        end


    // //AXI_data_send_ready控制
    //     always @(posedge clk) begin
    //         if ((!rst_n) || (reg_config_state == REG_IDLE)) begin                 //复位
    //             AXI_data_send_ready <= 1'b1;
    //         end else if (AXI_data_send_handshake) begin
    //             if (weather_first) begin
    //                 AXI_data_send_ready      <= 1'b1;
    //             end else AXI_data_send_ready <= 1'b0;
    //         end else AXI_data_send_ready     <= 1'b1;
    //     end

    //AXI_data_send_ready控制
        always @(posedge clk) begin
            if ((!rst_n) || (reg_config_state == REG_IDLE)) begin                 //复位
                AXI_data_send_ready <= 1'b1;
            end else if (AXI_data_send_handshake) begin
                if (weather_first) begin
                    AXI_data_send_ready      <= 1'b1;
                end else AXI_data_send_ready <= 1'b0;
            end else if (compute_over) begin
                AXI_data_send_ready     <= 1'b1;
            end else AXI_data_send_ready     <= AXI_data_send_ready;
        end


    //reg_config_compute_over控制
        always @(posedge clk) begin
            if (!rst_n) begin                 //复位
                reg_config_compute_over      <= 1'b0;
            end else if (RAM_switch) begin
                reg_config_compute_over      <= 1'b0;
            end else if (reg_config_complete) begin
                reg_config_compute_over      <= 1'b1;
            end else reg_config_compute_over <= reg_config_compute_over;
        end


    //wait_en控制
        always @(posedge clk) begin
            if ((!rst_n) || (reg_config_state == REG_IDLE)) begin    //复位或空闲态时为0
                wait_en      <= 1'b0;
            end else if ((reg_config_state == REG_CONFIG) && (data_send_complete && reg_config_complete)) begin
                wait_en      <= M_en;
            end else if (compute_over) begin
                wait_en      <= 1'b0;
            end else wait_en <= wait_en;
        end


    //参数配置
        //r_参数在reg_config_handshake之后接收
        always @(posedge clk) begin
            if (reg_config_handshake || compute_en_posedge) begin
                r_m           <= MATRIX_m          ;          
                r_a_precision <= MATRIX_a_precision;
                r_b_precision <= MATRIX_b_precision;
                r_c_precision <= MATRIX_c_precision;
                r_c_int_or_fp <= MATRIX_c_int_or_fp;
            end
        end

        //给进的参数
        always @(posedge clk) begin
            m           <= (~compute_en && AXI_data_send_handshake) ? r_m           : MATRIX_m          ;                        
            a_precision <= (~compute_en && AXI_data_send_handshake) ? r_a_precision : MATRIX_a_precision;
            b_precision <= (~compute_en && AXI_data_send_handshake) ? r_b_precision : MATRIX_b_precision;
            c_precision <= (~compute_en && AXI_data_send_handshake) ? r_c_precision : MATRIX_c_precision;
            c_int_or_fp <= (~compute_en && AXI_data_send_handshake) ? r_c_int_or_fp : MATRIX_c_int_or_fp;
        end


    //
    always @(posedge clk) begin
        r_reg_config_state <= reg_config_state;
    end
/****************************************** 模块例化 ****************************************/
    //RAM_BUF_TOP模块
        RAM_BUF_TOP RAM_BUF_TOP(
            .clk                     (clk                    ),      //input wire
            .rst_n                   (rst_n                  ),      //input wire

            .RAM_switch              (RAM_switch             ),      //input wire    //切换矩阵标志
        //与AXI_FULL_crtl连接的端口
            .AXI_data_send_handshake (AXI_data_send_handshake),      //标志AXI_data_send_valid和AXI_data_send_ready握手成功，开始发送数据 //input wire
            .data_send_last          (data_send_last         ),      //当最后一组数据发送完之后拉高，发送完数据                            //input wire

            .compute_en_posedge      (compute_en_posedge     ),      //compute_en上升沿信号，接出去

        //以下信号为与矩阵数据地址有关信号，由TPU给出
             .MATRIX_state           (MATRIX_state           ),      //用于判断当前为哪一个矩阵    input wire [1:0]  
             .MATRIX_cnt             (MATRIX_cnt             ),      //input wire [6:0]  
             .MATRIX_D_data_back_cnt (MATRIX_D_data_back_cnt ),      //读回矩阵D数据时用到的计数器
             .read_flag              (read_flag              ),      //读数据是有效的             input wire        
             .write_flag             (write_flag             ),      //写的数据是有效的
             .AXI_rdata              (AXI_rdata              ),      //AXI读出来的128位宽数据     input wire [127:0]
             .AXI_wdata              (AXI_wdata              ),      //写回ddr3或总线的数据       input wire [127:0]
            

        //以下信号连接至MATRIX_COMPUTE_KERNEL
            //读数据RAM使能
            .Rd_AB_en                (Rd_AB_en               ),     //input wire         
            .Rd_C_en                 (Rd_C_en                ),     //input wire
            .Rd_D_en                 (Rd_D_en                ),     //input wire
            //读数据地址
            .Rd_A_addr               (Rd_A_addr              ),     //input wire [4:0]   
            .Rd_B_addr               (Rd_B_addr              ),     //input wire [4:0]   
            .Rd_C_addr               (Rd_C_addr              ),     //input wire [7:0]   
            .Rd_D_addr               (Rd_D_addr              ),     //input wire [7:0]   
            //读出的数据
            .Rd_A_data               (Rd_A_data              ),     //A的一行的元素，最多为512位 //output reg [511:0] 
            .Rd_B_data               (Rd_B_data              ),     //B的一列的元素，最多为512位 //output reg [511:0] 
            .Rd_C_data               (Rd_C_data              ),     //C的一个元素，最多为32位    //output reg [31:0]  
            .Rd_D_data               (Rd_D_data              ),     //D的一个元素，为32位        //output reg [31:0]  

        //以下为输入数据的参数
            .MATRIX_m                (MATRIX_m               ),     //矩阵的维度     //input wire [5:0]   
            .MATRIX_a_precision      (MATRIX_a_precision     ),     //矩阵精度       //input wire [5:0]   
            .MATRIX_b_precision      (MATRIX_b_precision     ),     //input wire [5:0]   

            .compute_en              (compute_en             ),     //计算使能信号
        //以下为计算时的参数
            .a_precision             (a_precision            ),     //矩阵精度       //input wire [5:0]   
            .c_precision             (c_precision            )      //input wire [5:0]
        );


    //矩阵计算核心单元
        MATRIX_COMPUTE_KERNEL MATRIX_COMPUTE_KERNEL(
            .clk                (clk               ),     // 系统时钟            //input  
            .rst_n              (rst_n             ),     // 复位信号，低电平有效 //input  
            //计算使能及结束
            .compute_en         (compute_en        ),     //input  
            .compute_over       (compute_over      ),     //output reg 
            //以下为输入数据的参数
            .MATRIX_m           (m                 ),     //input  [5:0]
            .MATRIX_a_precision (a_precision       ),     //input  [5:0]
            .MATRIX_b_precision (b_precision       ),                 
            .MATRIX_c_precision (c_precision       ),                  
            .MATRIX_c_int_or_fp (c_int_or_fp       ),     //input  
            //读数据地址
            .Rd_A_addr          (Rd_A_addr         ),              //output [4:0]           
            .Rd_B_addr          (Rd_B_addr         ),              //output [4:0] 
            .Rd_C_addr          (Rd_C_addr         ),              //output [7:0] 
            .Rd_D_addr          (Rd_D_addr         ),               //output [7:0]      
            //读数据地址
            .Rd_A_data          (Rd_A_data         ),     //input  wire [511:0]   
            .Rd_B_data          (Rd_B_data         ),     //input  wire [511:0]   
            .Rd_C_data          (Rd_C_data         ),     //input  wire [31 :0]   
            .Rd_D_data          (Rd_D_data         ),     //output wire [31 :0]               
            //读数据RAM使能
            .Rd_AB_en           (Rd_AB_en          ),               // output 
            .Rd_C_en            (Rd_C_en           ),               // output 
            .Rd_D_en            (Rd_D_en           )                // output 
            

        );
endmodule
