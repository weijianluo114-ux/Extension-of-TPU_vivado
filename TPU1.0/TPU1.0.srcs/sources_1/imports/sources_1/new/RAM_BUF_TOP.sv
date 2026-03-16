`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/10 19:32:45
// Design Name: 
// Module Name: RAM_BUF_TOP
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


module RAM_BUF_TOP(
    input wire             clk,
    input wire             rst_n,

    input wire             RAM_switch,              //切换矩阵标志

    //与AXI_FULL_crtl连接的端口
        input wire         AXI_data_send_handshake, //标志AXI_data_send_valid和AXI_data_send_ready握手成功，开始发送数据
        input wire         data_send_last,          //当最后一组数据发送完之后拉高，发送完数据

        output wire        compute_en_posedge,      //compute_en上升沿信号，接出去


    //以下信号为与矩阵数据地址有关信号，由TPU给出
        input wire [1:0]   MATRIX_state,            //用于判断当前为哪一个矩阵
        input wire [6:0]   MATRIX_cnt,
        input wire [5:0]   MATRIX_D_data_back_cnt,  //读回矩阵D数据时用到的计数器
        input wire         read_flag,               //读数据是有效的
        input wire         write_flag,              //可以写数据，新增的
        input wire [127:0] AXI_rdata,               //AXI读出来的128位宽数据

        output reg [127:0] AXI_wdata,               //写回ddr3或总线的数据
    

    //以下信号连接至MATRIX_COMPUTE_KERNEL
        //读数据RAM使能
        input wire         Rd_AB_en,
        input wire         Rd_C_en,
        input wire         Rd_D_en,
        //读数据地址
        input wire [4:0]   Rd_A_addr,
        input wire [4:0]   Rd_B_addr,
        input wire [7:0]   Rd_C_addr,
        input wire [7:0]   Rd_D_addr,
        //读出的数据
        output reg [511:0] Rd_A_data,               //A的一行的元素，最多为512位
        output reg [511:0] Rd_B_data,               //B的一列的元素，最多为512位
        output reg [31:0]  Rd_C_data,               //C的一个元素，最多为32位

        input wire [31:0]  Rd_D_data,               //D的一个元素，为32位，由计算核心提供，是input

    //以下为输入的参数
        input wire [5:0]   MATRIX_m,                //矩阵的维度
        input wire [5:0]   MATRIX_a_precision,      //矩阵精度
        input wire [5:0]   MATRIX_b_precision,


        input compute_en,                           //计算使能信号
    //以下为计算时的参数
        input wire [5:0]   a_precision,             //矩阵精度
        input wire [5:0]   c_precision
    );


/****************************************** 参数 ********************************************/
  //------------------------------- 本地参数 ---------------------------//
    //表示现在是哪一个矩阵
    localparam MATRIX_A   = 2'd1,
               MATRIX_B   = 2'd2,
               MATRIX_C   = 2'd3;

    //精度
    localparam int4       = 'd4,
               int8       = 'd8,
               fp16       = 'd16,
               fp32_int32 = 'd32;


/****************************************** 网表型信号 ***************************************/
    //RAM的端口使能信号
    wire RAM_A_0_en;
    wire RAM_A_1_en;
    wire RAM_C_0_en;
    wire RAM_C_1_en;

    //RAM的读写使能信号（高为写，低为读）
    wire RAM_A_0_RW_en;
    wire RAM_A_1_RW_en;
    wire RAM_C_0_RW_en;
    wire RAM_C_1_RW_en;

    //RAM地址信号
    wire [4:0] RAM_A_0_addr;
    wire [4:0] RAM_A_1_addr;
    wire [5:0] RAM_C_0_addr;
    wire [5:0] RAM_C_1_addr;


    //RAM输出数据
    wire [511:0] RAM_A_0_dout;
    wire [511:0] RAM_A_1_dout;
    wire [127:0] RAM_C_0_dout;
    wire [127:0] RAM_C_1_dout;
    

/****************************************** 寄存器型信号 ************************************/
    //以下为替代RAM的B缓冲寄存器数组
    reg [511:0] RAM_B_0[32];
    reg [511:0] RAM_B_1[32];

    //以下为替代RAM的D缓冲寄存器数组
    reg [127:0] RAM_D_0[64];
    reg [127:0] RAM_D_1[64];

    reg RAM_switch_flag;                //切换矩阵的真正标志

    reg data_send_en;                   //标志处于发送状态

    //以下为AXI传输数据时控制的RAM地址
    reg [4:0] AXI_rdata_A_addr = 0;


    //RAM输入数据
    reg [511:0] RAM_A_din;
    reg [127:0] RAM_C_din;

    //用来临时存储A数据的寄存器
    reg [127:0] r_AXI_rdata[3];

    //用来中转的C地址，与Rd_C_addr不同
    reg [5:0]   RAM_Rd_C_addr;

    //以下为计算时的参数，在compute_en拉高时存下来只存一次
    reg [5:0]   compute_a_precision;
    reg [5:0]   compute_c_precision;

    reg r_compute_en;       //临时存储使能信号，以方便检测上升沿

    reg [4:0] r_Rd_A_addr;        //打一拍地址
    reg [7:0] r_Rd_C_addr;        //打一拍地址
    


/****************************************** 组合逻辑 ****************************************/
    //上升沿检测
    assign compute_en_posedge = compute_en && (~r_compute_en);

    //这里规定RAM_switch_flag为高电平时，AXI接RAM_0，kernel接RAM_1，低电平时则AXI接RAM_1，kernel接RAM_0

    //RAM_A端口连接
        //端口en连接，只有在发送，读数据有效拉高，且在A矩阵下才会使能
        assign RAM_A_0_en    = (RAM_switch_flag) ? (data_send_en && (MATRIX_state == MATRIX_A) && read_flag) : Rd_AB_en;       //低电平disen
        assign RAM_A_1_en    = (RAM_switch_flag) ? Rd_AB_en : (data_send_en && (MATRIX_state == MATRIX_A) && read_flag);

        //端口读写en连接
        assign RAM_A_0_RW_en = (RAM_switch_flag) ? data_send_en : (~Rd_AB_en);    //注意wea高为写，低为读
        assign RAM_A_1_RW_en = (RAM_switch_flag) ? (~Rd_AB_en) : data_send_en;

        //地址连接
        assign RAM_A_0_addr  = (RAM_switch_flag) ? AXI_rdata_A_addr : ((compute_a_precision == int4) ? Rd_A_addr[4:1] : Rd_A_addr);
        assign RAM_A_1_addr  = (RAM_switch_flag) ? ((compute_a_precision == int4) ? Rd_A_addr[4:1] : Rd_A_addr) : AXI_rdata_A_addr;

        //输出数据连接在下面
        

    //RAM_C端口连接
        //端口en连接
        assign RAM_C_0_en    = (RAM_switch_flag) ? (data_send_en && (MATRIX_state == MATRIX_C) && read_flag) : Rd_C_en;  //低电平disen
        assign RAM_C_1_en    = (RAM_switch_flag) ? Rd_C_en : (data_send_en && (MATRIX_state == MATRIX_C) && read_flag);

        //端口读写en连接
        assign RAM_C_0_RW_en = (RAM_switch_flag) ? data_send_en : (~Rd_C_en);    //注意wea高为写，低为读
        assign RAM_C_1_RW_en = (RAM_switch_flag) ? (~Rd_C_en) : data_send_en;

        //地址连接
        assign RAM_C_0_addr  = (RAM_switch_flag) ? MATRIX_cnt : RAM_Rd_C_addr;
        assign RAM_C_1_addr  = (RAM_switch_flag) ? RAM_Rd_C_addr : MATRIX_cnt;

        //输入数据连接
        assign RAM_C_din     = AXI_rdata;       //直接将AXI的数据给到C即可

        //输出数据在下面
        

    //RAM_D端口连接
        //输出数据连接
        // assign AXI_wdata     = (write_flag) ? ((RAM_switch_flag) ? RAM_D_0[MATRIX_D_data_back_cnt] : RAM_D_1[MATRIX_D_data_back_cnt]) : 128'b0;  //由外部的计数器控制取地址逻辑
        assign AXI_wdata     = (write_flag) ? ((RAM_switch_flag) ? RAM_D_0[MATRIX_D_data_back_cnt] : RAM_D_1[MATRIX_D_data_back_cnt]) : 128'b0;  //由外部的计数器控制取地址逻辑
        
        //输入数据连接在下面

        
    //-------------------------------- RAM_A相关信号 -----------------------//
        //RAM_A使能控制
        //使能已用data_send_en代替


        //RAM_A输入数据地址控制
            always @(*) begin
                if (MATRIX_state == MATRIX_A) begin
                    //A地址控制
                    case (MATRIX_a_precision)
                        //不同精度
                        int4: begin
                            AXI_rdata_A_addr <= MATRIX_cnt;
                        end 

                        int8: begin
                            AXI_rdata_A_addr <= MATRIX_cnt;
                        end

                        fp16: begin
                            AXI_rdata_A_addr <= MATRIX_cnt[6:1];
                        end

                        fp32_int32: begin
                            AXI_rdata_A_addr <= MATRIX_cnt[6:2];
                        end

                        default: AXI_rdata_A_addr <= 0;
                    endcase
                end else AXI_rdata_A_addr <= 0;
            end


        //RAM_A输入数据控制
            //这里只控制int4和int8的
            always @(*) begin
                if (MATRIX_state == MATRIX_A) begin
                    //A地址控制
                    case (MATRIX_a_precision)
                        //不同精度
                        int4: begin
                            RAM_A_din <= AXI_rdata;
                        end 

                        int8: begin
                            RAM_A_din <= AXI_rdata;
                        end

                        fp16: begin
                            RAM_A_din <= {r_AXI_rdata[0],AXI_rdata};
                        end

                        fp32_int32: begin
                            RAM_A_din <= {r_AXI_rdata[0],r_AXI_rdata[1],r_AXI_rdata[2],AXI_rdata};
                        end

                        default: RAM_A_din <= 0;
                    endcase
                end else RAM_A_din <= 0;
            end

        
        //RAM_A输出数据控制
            //这里控制int4和其它的
            always @(*) begin
                if (compute_a_precision == int4) begin
                    if (RAM_switch_flag) begin
                        if (r_Rd_A_addr[0]) begin
                            Rd_A_data <= RAM_A_1_dout[63:0];           //取低位
                        end else Rd_A_data <= RAM_A_1_dout[127:64];    //取高位
                    end else begin
                        if (r_Rd_A_addr[0]) begin
                            Rd_A_data <= RAM_A_0_dout[63:0];           //取低位
                        end else Rd_A_data <= RAM_A_0_dout[127:64];    //取高位
                    end
                end else begin
                    if (RAM_switch_flag) begin
                        Rd_A_data <= RAM_A_1_dout;
                    end else Rd_A_data <= RAM_A_0_dout;
                end  
            end


    //-------------------------------- RAM_C相关信号 -----------------------//
        //RAM_C输出地址控制直接使用
            always @(*) begin
                case (compute_c_precision)
                    //不同精度
                    int4: begin
                        RAM_Rd_C_addr <= Rd_C_addr[7:5];
                    end 

                    int8: begin
                        RAM_Rd_C_addr <= Rd_C_addr[7:4];
                    end

                    fp16: begin
                        RAM_Rd_C_addr <= Rd_C_addr[7:3];
                    end

                    fp32_int32: begin
                        RAM_Rd_C_addr <= Rd_C_addr[7:2];
                    end

                    default: RAM_Rd_C_addr <= 0;
                endcase
            end

        //RAM_C输出数据控制
            always @(*) begin
                case (compute_c_precision)
                    //不同精度
                    int4: begin
                        if (RAM_switch_flag) begin
                            Rd_C_data      <= RAM_C_1_dout[127-(r_Rd_C_addr[4:0]<<2)-:4];
                        end else Rd_C_data <= RAM_C_0_dout[127-(r_Rd_C_addr[4:0]<<2)-:4];
                    end 

                    int8: begin
                        if (RAM_switch_flag) begin
                            Rd_C_data      <= RAM_C_1_dout[127-(r_Rd_C_addr[3:0]<<3)-:8];
                        end else Rd_C_data <= RAM_C_0_dout[127-(r_Rd_C_addr[3:0]<<3)-:8];
                    end

                    fp16: begin
                        if (RAM_switch_flag) begin
                            Rd_C_data      <= RAM_C_1_dout[127-(r_Rd_C_addr[2:0]<<4)-:16];
                        end else Rd_C_data <= RAM_C_0_dout[127-(r_Rd_C_addr[2:0]<<4)-:16];
                    end

                    fp32_int32: begin
                        if (RAM_switch_flag) begin
                            Rd_C_data      <= RAM_C_1_dout[127-(r_Rd_C_addr[1:0]<<5)-:32];
                        end else Rd_C_data <= RAM_C_0_dout[127-(r_Rd_C_addr[1:0]<<5)-:32];
                    end

                    default: Rd_C_data <= 0;
                endcase
            end

            
/****************************************** 时序逻辑 ****************************************/
    //-------------------------------- RAM_A相关信号 -----------------------//
        //RAM_A临时输入数据控制，包含fp16和fp32_int32的
            always @(posedge clk) begin
                if (!rst_n) begin
                    r_AXI_rdata [0] <= 0;
                    r_AXI_rdata [1] <= 0;
                    r_AXI_rdata [2] <= 0;
                end else if (MATRIX_state == MATRIX_A)begin
                    case (MATRIX_a_precision)   
                        
                        fp16: begin
                            if (MATRIX_cnt[0] == 1'b0) begin
                                r_AXI_rdata[0]      <= AXI_rdata;
                            end else r_AXI_rdata[0] <= r_AXI_rdata[0];    
                        end 

                        fp32_int32: begin
                            case (MATRIX_cnt[1:0])
                                2'd0: begin
                                    r_AXI_rdata[0] <= AXI_rdata;
                                end

                                2'd1: begin
                                    r_AXI_rdata[1] <= AXI_rdata;
                                end

                                2'd2: begin
                                    r_AXI_rdata[2] <= AXI_rdata;
                                end

                                default: ;
                            endcase
                        end

                        default: begin
                            r_AXI_rdata [0] <= 0;
                            r_AXI_rdata [1] <= 0;
                            r_AXI_rdata [2] <= 0;
                        end
                    endcase
                end else begin
                    r_AXI_rdata [0] <= 0;
                    r_AXI_rdata [1] <= 0;
                    r_AXI_rdata [2] <= 0;
                end
            end
        

    //-------------------------------- RAM_B相关信号 -----------------------//
        //RAM_B读出的数据
            always @(posedge clk) begin
                if (!rst_n) begin
                    Rd_B_data <= 0;
                end else Rd_B_data <= (RAM_switch_flag) ? RAM_B_1[Rd_B_addr] : RAM_B_0[Rd_B_addr];
            end

        //RAM_B读入的数据
            //分为4种精度，3种维度，共12种情况
            integer i;
            always @(posedge clk) begin
                if (!rst_n) begin
                    for (i = 0; i<32; i++) begin
                        RAM_B_0[i] <= 512'b0;
                        RAM_B_1[i] <= 512'b0;
                    end
                    
                end else if ((MATRIX_state == MATRIX_B) && read_flag) begin
                    if (RAM_switch_flag) begin
                        case (MATRIX_b_precision)
                        //不同精度
                        //int4精度
                            int4: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<8; i++) begin
                                            RAM_B_0[i][(63-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(127-(i<<2)) -: 4];
                                            RAM_B_0[i][(59-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(95 -(i<<2)) -: 4];
                                            RAM_B_0[i][(55-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(63 -(i<<2)) -: 4];
                                            RAM_B_0[i][(51-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(31 -(i<<2)) -: 4];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<16; i++) begin
                                            RAM_B_0[i][(63-(MATRIX_cnt<<3)) -: 4] <= AXI_rdata[(127-(i<<2)) -: 4];
                                            RAM_B_0[i][(59-(MATRIX_cnt<<3)) -: 4] <= AXI_rdata[(63 -(i<<2)) -: 4];
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<32; i++) begin
                                            RAM_B_0[i][(63-(MATRIX_cnt<<2)) -: 4] <= AXI_rdata[(127-(i<<2)) -: 4];
                                        end
                                    end
                                    default: ;
                                endcase
                            end 

                        //int8精度
                            int8: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<8; i++) begin
                                            RAM_B_0[i][(127-(MATRIX_cnt<<4)) -: 8] <= AXI_rdata[(127-(i<<3)) -: 8];
                                            RAM_B_0[i][(119-(MATRIX_cnt<<4)) -: 8] <= AXI_rdata[(63 -(i<<3)) -: 8];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<16; i++) begin
                                            RAM_B_0[i][(127-(MATRIX_cnt<<3)) -: 8] <= AXI_rdata[(127-(i<<3)) -: 8];
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<16; i++) begin
                                            if (MATRIX_cnt[0]) begin
                                                RAM_B_0[i+16][(127-(MATRIX_cnt[6:1]<<3)) -: 8]   <= AXI_rdata[(127-(i<<3)) -: 8];
                                            end else RAM_B_0[i][(127-(MATRIX_cnt[6:1]<<3)) -: 8] <= AXI_rdata[(127-(i<<3)) -: 8];
                                        end
                                    end
                                    default: ;
                                endcase
                            end

                        //fp16精度
                            fp16: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<8; i++) begin
                                            RAM_B_0[i][(255-(MATRIX_cnt<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<8; i++) begin
                                            if (MATRIX_cnt[0]) begin
                                                RAM_B_0[i+8][(255-(MATRIX_cnt[6:1]<<4)) -: 16]    <= AXI_rdata[(127-(i<<4)) -: 16];
                                            end else RAM_B_0[i][(255-(MATRIX_cnt[6:1]<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<8; i++) begin
                                            case (MATRIX_cnt[1:0])
                                                2'b00: RAM_B_0[i][(255-(MATRIX_cnt[6:2]<<4)) -: 16]    <= AXI_rdata[(127-(i<<4)) -: 16];
                                                2'b01: RAM_B_0[i+8][(255-(MATRIX_cnt[6:2]<<4)) -: 16]  <= AXI_rdata[(127-(i<<4)) -: 16];
                                                2'b10: RAM_B_0[i+16][(255-(MATRIX_cnt[6:2]<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                                2'b11: RAM_B_0[i+24][(255-(MATRIX_cnt[6:2]<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                                default:; 
                                            endcase
                                        end
                                    end
                                    default: ;
                                endcase
                            end

                        //fp32_int4精度
                            fp32_int32: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<4; i++) begin
                                            if (MATRIX_cnt[0]) begin
                                                RAM_B_0[i+4][(511-(MATRIX_cnt[6:1]<<5)) -: 32]    <= AXI_rdata[(127-(i<<5)) -: 32];
                                            end else RAM_B_0[i][(511-(MATRIX_cnt[6:1]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<4; i++) begin
                                            case (MATRIX_cnt[1:0])
                                                2'b00: RAM_B_0[i][(511-(MATRIX_cnt[6:2]<<5)) -: 32]    <= AXI_rdata[(127-(i<<5)) -: 32];
                                                2'b01: RAM_B_0[i+4][(511-(MATRIX_cnt[6:2]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                2'b10: RAM_B_0[i+8][(511-(MATRIX_cnt[6:2]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                2'b11: RAM_B_0[i+12][(511-(MATRIX_cnt[6:2]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                default:; 
                                            endcase
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<4; i++) begin
                                            case (MATRIX_cnt[2:0])
                                                3'b000: RAM_B_0[i][(511-(MATRIX_cnt[6:3]<<5)) -: 32]    <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b001: RAM_B_0[i+4][(511-(MATRIX_cnt[6:3]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b010: RAM_B_0[i+8][(511-(MATRIX_cnt[6:3]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b011: RAM_B_0[i+12][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b100: RAM_B_0[i+16][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b101: RAM_B_0[i+20][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b110: RAM_B_0[i+24][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b111: RAM_B_0[i+28][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                default:; 
                                            endcase
                                        end
                                    end
                                    default: ;
                                endcase
                            end

                        default: ;
                        endcase    
                    end else begin
                        case (MATRIX_b_precision)
                        //不同精度

                        //int4精度
                            int4: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<8; i++) begin
                                            RAM_B_1[i][(63-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(127-(i<<2)) -: 4];
                                            RAM_B_1[i][(59-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(95 -(i<<2)) -: 4];
                                            RAM_B_1[i][(55-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(63 -(i<<2)) -: 4];
                                            RAM_B_1[i][(51-(MATRIX_cnt<<4)) -: 4] <= AXI_rdata[(31 -(i<<2)) -: 4];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<16; i++) begin
                                            RAM_B_1[i][(63-(MATRIX_cnt<<3)) -: 4] <= AXI_rdata[(127-(i<<2)) -: 4];
                                            RAM_B_1[i][(59-(MATRIX_cnt<<3)) -: 4] <= AXI_rdata[(63 -(i<<2)) -: 4];
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<32; i++) begin
                                            RAM_B_1[i][(63-(MATRIX_cnt<<2)) -: 4] <= AXI_rdata[(127-(i<<2)) -: 4];
                                        end
                                    end
                                    default: ;
                                endcase
                            end 

                        //int8精度
                            int8: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<8; i++) begin
                                            RAM_B_1[i][(127-(MATRIX_cnt<<4)) -: 8] <= AXI_rdata[(127-(i<<3)) -: 8];
                                            RAM_B_1[i][(119-(MATRIX_cnt<<4)) -: 8] <= AXI_rdata[(63 -(i<<3)) -: 8];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<16; i++) begin
                                            RAM_B_1[i][(127-(MATRIX_cnt<<3)) -: 8] <= AXI_rdata[(127-(i<<3)) -: 8];
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<16; i++) begin
                                            if (MATRIX_cnt[0]) begin
                                                RAM_B_1[i+16][(127-(MATRIX_cnt[6:1]<<3)) -: 8]   <= AXI_rdata[(127-(i<<3)) -: 8];
                                            end else RAM_B_1[i][(127-(MATRIX_cnt[6:1]<<3)) -: 8] <= AXI_rdata[(127-(i<<3)) -: 8];
                                        end
                                    end
                                    default: ;
                                endcase
                            end

                        //fp16精度
                            fp16: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<8; i++) begin
                                            RAM_B_1[i][(255-(MATRIX_cnt<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<8; i++) begin
                                            if (MATRIX_cnt[0]) begin
                                                RAM_B_1[i+8][(255-(MATRIX_cnt[6:1]<<4)) -: 16]    <= AXI_rdata[(127-(i<<4)) -: 16];
                                            end else RAM_B_1[i][(255-(MATRIX_cnt[6:1]<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<8; i++) begin
                                            case (MATRIX_cnt[1:0])
                                                2'b00: RAM_B_1[i][(255-(MATRIX_cnt[6:2]<<4)) -: 16]    <= AXI_rdata[(127-(i<<4)) -: 16];
                                                2'b01: RAM_B_1[i+8][(255-(MATRIX_cnt[6:2]<<4)) -: 16]  <= AXI_rdata[(127-(i<<4)) -: 16];
                                                2'b10: RAM_B_1[i+16][(255-(MATRIX_cnt[6:2]<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                                2'b11: RAM_B_1[i+24][(255-(MATRIX_cnt[6:2]<<4)) -: 16] <= AXI_rdata[(127-(i<<4)) -: 16];
                                                default:; 
                                            endcase
                                        end
                                    end
                                    default: ;
                                endcase
                            end

                        //fp32_int4精度
                            fp32_int32: begin
                                case (MATRIX_m)
                                    'd32: begin
                                        for (i = 0; i<4; i++) begin
                                            if (MATRIX_cnt[0]) begin
                                                RAM_B_1[i+4][(511-(MATRIX_cnt[6:1]<<5)) -: 32]    <= AXI_rdata[(127-(i<<5)) -: 32];
                                            end else RAM_B_1[i][(511-(MATRIX_cnt[6:1]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                        end
                                    end

                                    'd16: begin
                                        for (i = 0; i<4; i++) begin
                                            case (MATRIX_cnt[1:0])
                                                2'b00: RAM_B_1[i][(511-(MATRIX_cnt[6:2]<<5)) -: 32]    <= AXI_rdata[(127-(i<<5)) -: 32];
                                                2'b01: RAM_B_1[i+4][(511-(MATRIX_cnt[6:2]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                2'b10: RAM_B_1[i+8][(511-(MATRIX_cnt[6:2]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                2'b11: RAM_B_1[i+12][(511-(MATRIX_cnt[6:2]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                default:; 
                                            endcase
                                        end
                                    end 

                                    'd8: begin
                                        for (i = 0; i<4; i++) begin
                                            case (MATRIX_cnt[2:0])
                                                3'b000: RAM_B_1[i][(511-(MATRIX_cnt[6:3]<<5)) -: 32]    <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b001: RAM_B_1[i+4][(511-(MATRIX_cnt[6:3]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b010: RAM_B_1[i+8][(511-(MATRIX_cnt[6:3]<<5)) -: 32]  <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b011: RAM_B_1[i+12][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b100: RAM_B_1[i+16][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b101: RAM_B_1[i+20][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b110: RAM_B_1[i+24][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                3'b111: RAM_B_1[i+28][(511-(MATRIX_cnt[6:3]<<5)) -: 32] <= AXI_rdata[(127-(i<<5)) -: 32];
                                                default:; 
                                            endcase
                                        end
                                    end
                                    default: ;
                                endcase
                            end

                            default: ;
                            endcase
                    end
                end
            end


    //-------------------------------- RAM_D相关信号 -----------------------//
        //RAM_D读入的数据，由计算核心来控制使能读入
            always @(posedge clk) begin
                if (!rst_n) begin
                    for (i = 0; i<64; i++) begin
                        RAM_D_0[i] <= 128'b0;
                        RAM_D_1[i] <= 128'b0;
                    end
                end else if (Rd_D_en) begin
                    if (RAM_switch_flag) begin
                        RAM_D_1[Rd_D_addr[7:2]][(127-(Rd_D_addr[1:0]<<5)) -: 32]      <= Rd_D_data;
                    end else RAM_D_0[Rd_D_addr[7:2]][(127-(Rd_D_addr[1:0]<<5)) -: 32] <= Rd_D_data;
                end
            end


    //data_send_en控制逻辑
        always @(posedge clk) begin
            if (!rst_n) begin
                data_send_en      <= 1'b0;
            end else if (data_send_last) begin     //结束发送
                data_send_en      <= 1'b0;  
            end else if (AXI_data_send_handshake) begin     //开始发送
                data_send_en      <= 1'b1;  
            end else data_send_en <= data_send_en;
        end


    //RAM_switch_flag逻辑
        always @(posedge clk) begin
            if (!rst_n) begin
                RAM_switch_flag      <= 1'b0;
            end else if (RAM_switch) begin
                RAM_switch_flag      <= (~RAM_switch_flag);  //取反即可
            end else RAM_switch_flag <= RAM_switch_flag;
        end


    //存储r_compute_en信号
        always @(posedge clk) begin
            r_compute_en <= compute_en;
        end


    //参数存储逻辑
        always @(posedge clk) begin
            if (compute_en_posedge) begin
                compute_a_precision <= a_precision;     
                compute_c_precision <= c_precision;
            end
        end


    //将Rd_A_addr打一拍
        always @(posedge clk) begin
            r_Rd_A_addr <= Rd_A_addr;
        end

    //将Rd_A_addr打一拍
        always @(posedge clk) begin
            r_Rd_C_addr <= Rd_C_addr;
        end

        
/****************************************** 模块例化 ****************************************/
    //以下为双缓冲模块的RAM_A及RAM_C
        RAM_A RAM_A_0 (
            .clka  (clk          ),    // input wire clka
            .ena   (RAM_A_0_en   ),    // input wire ena
            .wea   (RAM_A_0_RW_en),    // input wire [0 : 0] wea
            .addra (RAM_A_0_addr ),    // input wire [4 : 0] addra
            .dina  (RAM_A_din    ),    // input wire [511 : 0] dina
            .douta (RAM_A_0_dout )     // output wire [511 : 0] douta
        );

        RAM_A RAM_A_1 (
            .clka  (clk          ),     // input wire clka
            .ena   (RAM_A_1_en   ),     // input wire ena
            .wea   (RAM_A_1_RW_en),     // input wire [0 : 0] wea
            .addra (RAM_A_1_addr ),     // input wire [4 : 0] addra
            .dina  (RAM_A_din    ),     // input wire [511 : 0] dina
            .douta (RAM_A_1_dout )      // output wire [511 : 0] douta
        );

        RAM_C RAM_C_0 (
            .clka  (clk          ),     // input wire clka
            .ena   (RAM_C_0_en   ),     // input wire ena
            .wea   (RAM_C_0_RW_en),     // input wire [0 : 0] wea
            .addra (RAM_C_0_addr ),     // input wire [5 : 0] addra
            .dina  (RAM_C_din    ),     // input wire [127 : 0] dina
            .douta (RAM_C_0_dout )      // output wire [127 : 0] douta
        );

        RAM_C RAM_C_1 (
            .clka  (clk          ),     // input wire clka
            .ena   (RAM_C_1_en   ),     // input wire ena
            .wea   (RAM_C_1_RW_en),     // input wire [0 : 0] wea
            .addra (RAM_C_1_addr ),     // input wire [5 : 0] addra
            .dina  (RAM_C_din    ),     // input wire [127 : 0] dina
            .douta (RAM_C_1_dout )      // output wire [127 : 0] douta
        );


endmodule
