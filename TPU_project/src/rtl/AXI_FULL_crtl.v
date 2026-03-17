`timescale 1ns / 1ps

module AXI_FULL_crtl(
        input clk,
        input rst_n,

        //该信号为测试用，可删除
        output tb_last_data_back,                   

        input  wire reg_config_valid,             //表示可以读取此时的配置，此时为reg_ready与reg_valid握手
        output wire reg_config_handshake,         //标志握手成功，该信号也连接至TPU
        output reg  data_send_flag,               //标志正在发送数据

        input  wire M_en,                         //此为主机使能信号，这里使用AXI_M的awvalid作为连接

        input  wire compute_en_posedge,           //compute_en上升沿信号
        input  wire compute_over,                 //该信号为计算结束态
        input  wire last_compute,                 //该信号标志最后一次计算

        //以下为寄存器配置
        input wire [5:0] MATRIX_m,                //矩阵的维度
        input wire [5:0] MATRIX_a_precision,      //矩阵精度
        input wire [5:0] MATRIX_b_precision,
        input wire [5:0] MATRIX_c_precision,

        input wire       read_flag,               //读有效时拉高
        input wire       write_flag,              //写有效时拉高

        output reg       AXI_FULL_reffective,     //高电平时axi一直有效发送数据，下降沿时会完全将其终止，即让他跑完剩下的
        output reg       AXI_FULL_weffective,     //高电平时axi一直有效接收数据，下降沿时会完全将其终止，即让他跑完剩下的
        output reg       AXI_FULL_rstop,          //读停止态
        output reg       AXI_FULL_wstop,          //写停止态

        output reg [1:0] MATRIX_state,            //用于判断当前为哪一个矩阵
        output wire[6:0] MATRIX_cnt,
        output wire      AXI_data_send_handshake, //标志AXI_data_send_valid和AXI_data_send_ready握手成功
        output wire      data_send_last,          //当最后一组数据发送完之后拉高

        output wire [5:0]MATRIX_D_data_back_cnt,  //读回矩阵D数据时用到的计数器

        input wire       READ_TXN_DONE,           //此信号表明AXI完成了一次大的读突发传输
        input wire       WRITE_TXN_DONE,          //此信号表明AXI完成了一次大的写突发传输
        input wire [1:0] AXI_work_state,          //测试口（留作测试及运算使用），AXI的工作状态

        input wire       AXI_data_send_ready      //TPU_top控制的准备信号，连接至TPU_top
    );


/******************************* 参数 ***********************************/
  //------------------------------- 普通参数 ---------------------------//


  //------------------------------- 本地参数 ---------------------------//
    //以下参数为AXI的工作状态
    localparam AXI_IDLE               = 2'b00,    //axi空闲态，目前未知其用处未知
               AXI_LOAD_DATA_TO_DDR3  = 2'b01,    //axi的读写操作状态，此时为从bram读取数据并载入数据至ddr3
               AXI_COMPUTE            = 2'b10;    //axi的计算操作状态，此时开始从ddr3中读取数据至TPU

    //以下为发送控制状态机参数
    localparam SEND_IDLE              = 2'd0,     //空闲态
               SEND_CONTINUE          = 2'd1,
               SEND_AXI_OVER          = 2'd2;

    //以下为发回数据控制状态机参数
    localparam DATA_BACK_IDLE              = 2'd0,     //空闲态
               DATA_BACK_CONTINUE          = 2'd1,
               DATA_BACK_AXI_OVER          = 2'd2;    

    localparam MATRIX_IDLE            = 2'd0,
               MATRIX_A               = 2'd1,
               MATRIX_B               = 2'd2,
               MATRIX_C               = 2'd3;           


/******************************* 网表型 ***********************************/
    wire      last_data_back;       //当最后一个写回数据发送时拉高

    wire      reg_config_cnt_flag;  //标志计数器最大值要切换


/******************************* 寄存器型 ***********************************/
    reg       reg_config_ready;     //由该模块控制寄存器ready（最绝妙的地方）

    reg [1:0] data_send_state;      //发送数据状态
    reg [1:0] data_back_state;      //发回数据状态

    reg [5:0] MATRIX_data_back_cnt; //此计数器用于计数传回的D矩阵数据，最大为64

    reg [6:0] MATRIX_AXI_cnt;       //此计数器用于计数，以达到判断当前处于哪个矩阵的目的，最大为128
    reg [7:0] MATRIX_AXI_A_cnt_MAX;
    reg [7:0] MATRIX_AXI_B_cnt_MAX;
    reg [7:0] MATRIX_AXI_C_cnt_MAX;

    reg       AXI_data_send_valid;  //内部控制valid


/******************************* 组合逻辑 ********************************/
    //以下为测试用
        assign tb_last_data_back = last_data_back;

    //判断reg_config即寄存器配置是否握手成功
        assign reg_config_handshake    = reg_config_valid && reg_config_ready;

    //判断发数据是否握手成功
        assign AXI_data_send_handshake = (AXI_data_send_ready && AXI_data_send_valid);

    //当最后一组数据发送时拉高的标志信号
        assign data_send_last          = (MATRIX_state == MATRIX_C) && (MATRIX_AXI_cnt == MATRIX_AXI_C_cnt_MAX-1);    

    //当最后一组写回数据发回时拉高的标志信号
        assign last_data_back          = (MATRIX_D_data_back_cnt == 63); 

    //将计数器连接到外面去，以供TPU使用
        assign MATRIX_cnt              = MATRIX_AXI_cnt;
        assign MATRIX_D_data_back_cnt  = MATRIX_data_back_cnt;

        assign reg_config_cnt_flag     = (MATRIX_state == MATRIX_A);


/******************************* 时序逻辑 ********************************/
    //-------------------------------- 发送数据控制状态机 --------------------------//
        always @(posedge clk) begin
            if (!rst_n) begin   //复位
                AXI_FULL_rstop   <= 1'b0;                           //默认处于暂停状态
                data_send_state <= SEND_IDLE;
            end else if (AXI_work_state == AXI_COMPUTE) begin      //明确此时处于计算态
                //以下逻辑保证AXI_FULL能持续工作
                if (READ_TXN_DONE) begin
                    AXI_FULL_reffective      <= 1'b0;
                end else if (data_send_state == SEND_CONTINUE) begin
                    AXI_FULL_reffective      <= 1'b1;
                end else AXI_FULL_reffective <= 1'b0;

                //判断此时的发送状态
                case (data_send_state)

                //空闲态
                SEND_IDLE: begin
                    AXI_FULL_rstop <= 1'b0;                         //空闲态下无需暂停

                    if (reg_config_handshake) begin                //等待开始信号（这里以reg_config_handshake作为启动，因为该信号拉高一定表明有数据要传输）
                        data_send_state      <= SEND_CONTINUE;
                        AXI_FULL_reffective   <= 1'b1;              //开始发送数据
                    end else begin 
                        data_send_state      <= SEND_IDLE;
                        AXI_FULL_reffective   <= 1'b0;              //不发送，停下AXI事务
                    end
                end

                //此状态为发送状态下，发送完后会判断下一次是否需要继续发送数据
                SEND_CONTINUE: begin
                    if (data_send_last) begin
                        AXI_FULL_rstop <= 1'b1;                     //发完一组后先暂停，等待下一次发送
                        if (M_en) begin                             //关键，用于判断下一次是否要继续发送数据
                            data_send_state     <= SEND_CONTINUE; 
                        end else begin
                            data_send_state     <= SEND_AXI_OVER;
                            AXI_FULL_reffective <= 1'b0;            //终止发送
                        end
                    end else if (AXI_data_send_handshake) begin
                        AXI_FULL_rstop          <= 1'b0;            //下一次发送握手成功后暂停结束，继续发送
                    end else data_send_state    <= SEND_CONTINUE;
                end

                //此状态用于等待AXI_FULL事务完全完成
                SEND_AXI_OVER: begin
                    AXI_FULL_rstop <= 1'b0;                         //该状态下等待AXI事务的完成

                    if (READ_TXN_DONE) begin
                        data_send_state        <= SEND_IDLE;
                    end
                end

                default: begin 
                    data_send_state    <= SEND_IDLE;                //默认处于空闲态
                end
                endcase
            end
        end


    //-------------------------------- 写回数据控制状态机 --------------------------//
        always @(posedge clk) begin
            if (!rst_n) begin   //复位
                AXI_FULL_wstop   <= 1'b0;                          //默认处于暂停状态
                data_back_state  <= DATA_BACK_IDLE;
            end else if (AXI_work_state == AXI_COMPUTE) begin      //明确此时处于计算态
                //以下逻辑保证AXI_FULL能持续工作
                if (WRITE_TXN_DONE) begin
                    AXI_FULL_weffective      <= 1'b0;
                end else if (data_back_state == DATA_BACK_CONTINUE) begin
                    AXI_FULL_weffective      <= 1'b1;
                end else AXI_FULL_weffective <= 1'b0;

                //判断此时的发送状态
                case (data_back_state)

                //空闲态
                DATA_BACK_IDLE: begin
                    AXI_FULL_wstop <= 1'b0;                         //空闲态下无需暂停

                    if (compute_en_posedge) begin                   //等待开始信号，开始计算时说明上一次计算完成，可以发回数据了
                        data_back_state      <= DATA_BACK_CONTINUE;
                        AXI_FULL_weffective  <= 1'b1;               //开始发送数据
                        AXI_FULL_wstop       <= 1'b1;               //第一次计算开始的时候要暂停，因为还没有数据算完
                    end else begin 
                        data_back_state      <= DATA_BACK_IDLE;
                        AXI_FULL_weffective  <= 1'b0;               //不发送，停下AXI事务
                    end
                end

                //此状态为持续写回数据态，等待计算完成即可
                DATA_BACK_CONTINUE: begin
                    if (compute_over) begin
                        AXI_FULL_wstop       <= 1'b1;               //需要暂停，判断还需不需要写

                        //在一次计算完成后判断是否是最后一次计算
                        if (last_compute) begin
                            data_back_state  <= DATA_BACK_AXI_OVER;
                        end else data_back_state <= DATA_BACK_CONTINUE;
                    end else if (last_data_back) begin
                        AXI_FULL_wstop       <= 1'b1;              //最后一次发送时，需要暂停
                    end else if (compute_en_posedge) begin
                        AXI_FULL_wstop       <= 1'b0;              //不暂停，继续写
                    end else begin
                        data_back_state <= DATA_BACK_CONTINUE;
                    end 
                end

                //此状态用于等待AXI_FULL剩余写事务完全完成
                DATA_BACK_AXI_OVER: begin
                    AXI_FULL_wstop       <= 1'b0;                    //该状态下等待AXI事务的完成
                    AXI_FULL_weffective  <= 1'b0;                    //停止发送数据

                    if (WRITE_TXN_DONE) begin
                        data_back_state  <= DATA_BACK_IDLE;
                    end
                end

                default: begin 
                    data_back_state      <= DATA_BACK_IDLE;          //默认处于空闲态
                end
                endcase
            end
        end
                                       

    //对AXI_data_in_valid的控制
        always @(posedge clk) begin                                                                             
            if (!rst_n) 
                AXI_data_send_valid <= 1'b0;                                                         
            else if (reg_config_handshake)
                AXI_data_send_valid <= 1'b1;                             
            else if (AXI_data_send_handshake)                                                    
                AXI_data_send_valid <= 1'b0;
            else AXI_data_send_valid <= AXI_data_send_valid;                                                     
        end  


    //-------------------------------------- data_send_flag信号 --------------------------------------//
        always @(posedge clk) begin
            if (!rst_n) begin     //在空闲态下置0
                data_send_flag           <= 1'b0;
            end else begin
                if (((~reg_config_valid) && reg_config_ready) || (data_send_state == SEND_AXI_OVER)) begin      //在等待AXI结束时置0
                    data_send_flag       <= 1'b0;
                end else if (reg_config_handshake) begin            //握手完成之后发送数据
                    data_send_flag       <= 1'b1;
                end else if (data_send_state == SEND_IDLE)begin
                    data_send_flag       <= 1'b0;
                end else data_send_flag  <= data_send_flag;
            end
        end


    //解码配置，提供矩阵元素数量计数器最大值
        //对A矩阵
            always @(posedge clk) begin                                        
                if(!rst_n)                               
                    MATRIX_AXI_A_cnt_MAX <= 0;                                            
                else if (reg_config_cnt_flag) begin
                    case (MATRIX_m)
                        8:  MATRIX_AXI_A_cnt_MAX <= (MATRIX_a_precision);
                        16: MATRIX_AXI_A_cnt_MAX <= (MATRIX_a_precision << 1);
                        32: MATRIX_AXI_A_cnt_MAX <= (MATRIX_a_precision << 2);
                        default: MATRIX_AXI_A_cnt_MAX <= 0;
                    endcase
                end else MATRIX_AXI_A_cnt_MAX <= MATRIX_AXI_A_cnt_MAX;                               
            end

        //对B矩阵
            always @(posedge clk) begin                                        
                if(!rst_n)                               
                    MATRIX_AXI_B_cnt_MAX <= 0;                                            
                else if (reg_config_cnt_flag) begin
                    case (MATRIX_m)
                        8:  MATRIX_AXI_B_cnt_MAX <= (MATRIX_b_precision << 2);
                        16: MATRIX_AXI_B_cnt_MAX <= (MATRIX_b_precision << 1);
                        32: MATRIX_AXI_B_cnt_MAX <= (MATRIX_b_precision);
                        default: MATRIX_AXI_B_cnt_MAX <= 0;
                    endcase
                end else MATRIX_AXI_B_cnt_MAX <= MATRIX_AXI_B_cnt_MAX;                               
            end

        //对C矩阵
            always @(posedge clk) begin                                        
                if(!rst_n)                               
                    MATRIX_AXI_C_cnt_MAX <= 0;                                            
                else if (reg_config_cnt_flag) begin
                    MATRIX_AXI_C_cnt_MAX <= (MATRIX_c_precision << 1);
                end else MATRIX_AXI_C_cnt_MAX <= MATRIX_AXI_C_cnt_MAX;                               
            end                                          
 

    //矩阵计数器状态机
        always @(posedge clk) begin
            if (!rst_n) begin   //复位
                MATRIX_state <= MATRIX_IDLE;
            end else begin
                case (MATRIX_state)

                //空闲态，等待数据发送握手信号
                MATRIX_IDLE: begin
                    if (AXI_data_send_handshake) begin 
                        MATRIX_state      <= MATRIX_A;      //开始A矩阵的发送
                    end else MATRIX_state <= MATRIX_IDLE;
                end

                MATRIX_A: begin
                    if (MATRIX_AXI_cnt == (MATRIX_AXI_A_cnt_MAX-1) && read_flag) begin
                        MATRIX_state      <= MATRIX_B;
                    end else MATRIX_state <= MATRIX_state;
                end

                MATRIX_B: begin
                    if (MATRIX_AXI_cnt == (MATRIX_AXI_B_cnt_MAX-1) && read_flag) begin
                        MATRIX_state      <= MATRIX_C;
                    end else MATRIX_state <= MATRIX_state;
                end

                MATRIX_C: begin
                    if (MATRIX_AXI_cnt == (MATRIX_AXI_C_cnt_MAX-1) && read_flag) begin
                        MATRIX_state      <= MATRIX_IDLE;
                    end else MATRIX_state <= MATRIX_state;
                end

                default: MATRIX_state     <= MATRIX_IDLE;                   //默认处于空闲态
                endcase
            end
        end


    //矩阵计数器
        always @(posedge clk) begin
            if (!rst_n) begin   //复位
                MATRIX_AXI_cnt <= 0;
            end else begin
                case (MATRIX_state)

                MATRIX_A: begin
                    if (read_flag) begin
                        if (MATRIX_AXI_cnt == (MATRIX_AXI_A_cnt_MAX-1)) begin
                            MATRIX_AXI_cnt <= 0;
                        end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt+1;
                    end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt;

                    // if (MATRIX_AXI_cnt == (MATRIX_AXI_A_cnt_MAX-1)) begin
                    //     MATRIX_AXI_cnt <= 0;
                    // end else if (read_flag) begin
                    //     MATRIX_AXI_cnt <= MATRIX_AXI_cnt+1;
                    // end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt;
                end

                MATRIX_B: begin
                    if (read_flag) begin
                        if (MATRIX_AXI_cnt == (MATRIX_AXI_B_cnt_MAX-1)) begin
                            MATRIX_AXI_cnt <= 0;
                        end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt+1;
                    end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt;

                    // if (MATRIX_AXI_cnt == (MATRIX_AXI_B_cnt_MAX-1)) begin
                    //     MATRIX_AXI_cnt <= 0;
                    // end else if (read_flag) begin
                    //     MATRIX_AXI_cnt <= MATRIX_AXI_cnt+1;
                    // end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt;
                end
                
                MATRIX_C: begin
                    if (read_flag) begin
                        if (MATRIX_AXI_cnt == (MATRIX_AXI_C_cnt_MAX-1)) begin
                            MATRIX_AXI_cnt <= 0;
                        end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt+1;
                    end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt;

                    // if (MATRIX_AXI_cnt == (MATRIX_AXI_C_cnt_MAX-1)) begin
                    //     MATRIX_AXI_cnt <= 0;
                    // end else if (read_flag) begin
                    //     MATRIX_AXI_cnt <= MATRIX_AXI_cnt+1;
                    // end else MATRIX_AXI_cnt <= MATRIX_AXI_cnt;
                end

                default: MATRIX_AXI_cnt    <= 0;                   //默认处于空闲态
                endcase
            end
        end


    //传回的矩阵D中元素个数计数器
        always @(posedge clk) begin
            if (!rst_n) begin   //复位
                MATRIX_data_back_cnt <= 0;
            end else if (MATRIX_data_back_cnt == 63) begin
                MATRIX_data_back_cnt <= 0;
            end else if (write_flag && (AXI_work_state == AXI_COMPUTE)) begin
                MATRIX_data_back_cnt <= MATRIX_data_back_cnt+1;
            end else MATRIX_data_back_cnt <= MATRIX_data_back_cnt;
        end


    //reg_config_ready的控制
        always @(posedge clk) begin                                                                             
            if (!rst_n) 
                reg_config_ready <= 1'b1;                                                         
            else if (data_send_last)
                reg_config_ready <= 1'b1;                             
            else if (reg_config_handshake)                                                    
                reg_config_ready <= 1'b0;
            else reg_config_ready <= reg_config_ready;                                                     
        end 

    // //reg_config_ready的控制
    //     always @(posedge clk) begin                                                                             
    //         if (!rst_n) 
    //             reg_config_ready <= 1'b1;                                                         
    //         else if (data_send_last)
    //             reg_config_ready <= 1'b1;                             
    //         else if (reg_config_handshake)                                                    
    //             reg_config_ready <= 1'b0;
    //         else reg_config_ready <= reg_config_ready;                                                     
    //     end 



endmodule
