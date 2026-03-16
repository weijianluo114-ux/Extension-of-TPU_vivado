`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/07 12:43:06
// Design Name: 
// Module Name: AXI_LITE_S
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


`timescale 1 ns / 1 ps

module AXI_LITE_S #(
        // 用户可在此添加参数

        // 用户参数结束
        // 请勿修改此行之后的参数

        parameter integer C_S_AXI_DATA_WIDTH = 32,   // S_AXI 数据总线宽度
        parameter integer C_S_AXI_ADDR_WIDTH = 4     // S_AXI 地址总线宽度
    ) (
        // 用户可在此添加端口
        //配置的寄存器的信息
        output reg [5:0] MATRIX_m,                  //矩阵的维度

        output reg [5:0] MATRIX_a_precision,        //矩阵精度
        output reg [5:0] MATRIX_b_precision,
        output reg [5:0] MATRIX_c_precision,
        output reg       MATRIX_c_int_or_fp,        //判断矩阵C是否是整数

        output reg       reg_config_valid,
        input wire       reg_config_handshake,      //标志寄存器配置握手成功
        input wire       data_send_flag,

        input wire [1:0] axi_work_state,            //AXI工作状态
        
        // 用户端口结束
        // 请勿修改此行之后的端口

        input  wire                                S_AXI_ACLK,    // 全局时钟信号
        input  wire                                S_AXI_ARESETN, // 全局复位信号，低有效

        //写通道
        input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_AWADDR,  // 写地址（由主机发出，被从机接收）
        input  wire [2 : 0]                        S_AXI_AWPROT,  // 写通道保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。
        input  wire                                S_AXI_AWVALID, // 写地址有效。该信号指示主机正在传递有效的写地址和控制信息。
        output wire                                S_AXI_AWREADY, // 写地址就绪。该信号指示从机已准备好接收地址及相关控制信号。

        input  wire [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_WDATA,   // 写数据（由主机发出，被从机接收） 
        input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,   // 写选通信号。该信号指示哪些字节通道包含有效数据。每8位数据总线对应一个写选通位。
        input  wire                                S_AXI_WVALID,  // 写有效。该信号指示有效的写数据和选通信号可用。
        output wire                                S_AXI_WREADY,  // 写就绪。该信号指示从机可以接收写数据。

        output wire [1 : 0]                        S_AXI_BRESP,   // 写响应。该信号指示写事务的状态。
        output wire                                S_AXI_BVALID,  // 写响应有效。该信号指示通道正在传递有效的写响应。
        input  wire                                S_AXI_BREADY,  // 响应就绪。该信号指示主机可以接收写响应。
        
        //读通道
        input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_ARADDR,  // 读地址（由主机发出，被从机接收）
        input  wire [2 : 0]                        S_AXI_ARPROT,  // 保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。
        input  wire                                S_AXI_ARVALID, // 读地址有效。该信号指示通道正在传递有效的读地址和控制信息。
        output wire                                S_AXI_ARREADY, // 读地址就绪。该信号指示从机已准备好接收地址及相关控制信号。

        output wire [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_RDATA,   // 读数据（由从机发出）
        output wire [1 : 0]                        S_AXI_RRESP,   // 读响应。该信号指示读传输的状态。
        output wire                                S_AXI_RVALID,  // 读有效。该信号指示通道正在传递所需的读数据。
        input  wire                                S_AXI_RREADY   // 读就绪。该信号指示主机可以接收读数据和响应信息。
    );


/****************************************** 用户参数 ********************************************/


/****************************************** axi内部参数 *****************************************/
  //-------------------------------------- 普通参数 ------------------------------------//


  //-------------------------------------- 本地参数 ------------------------------------//
    // 示例专用设计信号
    // 用于寻址32位/64位C_S_AXI_DATA_WIDTH的本地参数
    // ADDR_LSB用于寻址32/64位寄存器/存储器
    // 32位时ADDR_LSB=2（n到2）
    // 64位时ADDR_LSB=3（n到3）
    localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH / 32) + 1;
    localparam integer OPT_MEM_ADDR_BITS = 1;

    //axi_work_state的状态
    localparam [1:0] AXI_IDLE               = 2'b00,    //axi空闲态，目前未知其用处未知
             	 	 AXI_LOAD_DATA_TO_DDR3  = 2'b01,    //axi的读写操作状态，此时为从bram读取数据并载入数据至ddr3
             	     AXI_COMPUTE            = 2'b10;    //axi的计算操作状态，此时开始从ddr3中读取数据至TPU


/****************************************** 用户信号 ********************************************/
  //-------------------------------------- 寄存器型 ------------------------------------//


  //-------------------------------------- 网表型 ------------------------------------//
    wire write_done;                //标志着主机写寄存器完成


/****************************************** axi内部信号 *****************************************/
  //-------------------------------------- 寄存器型 ------------------------------------//
    // AXI4LITE 信号
    reg [C_S_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;
    reg                            axi_awready;
    reg                            axi_wready;
    reg [1 : 0]                    axi_bresp;
    reg                            axi_bvalid;
    reg [C_S_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
    reg                            axi_arready;
    reg [C_S_AXI_DATA_WIDTH-1 : 0] axi_rdata;
    reg [1 : 0]                    axi_rresp;
    reg                            axi_rvalid;


    //----------------------------------------------
    //-- 用户逻辑寄存器空间示例的信号
    //------------------------------------------------
    //-- 从机寄存器数量为4
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg0;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg1;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg2;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg3;
    reg [C_S_AXI_DATA_WIDTH-1:0] reg_data_out;
    reg                          aw_en;
   
    integer byte_index;

  //-------------------------------------- 网表型 ------------------------------------//
    wire slv_reg_rden;
    wire slv_reg_wren;


/****************************************** 用户组合逻辑 ****************************************/
    assign write_done = S_AXI_BREADY && S_AXI_BVALID;                       //标志读事务完成


/****************************************** axi内部组合逻辑 *************************************/
  // I/O 连接赋值
  assign S_AXI_AWREADY = axi_awready;
  assign S_AXI_WREADY  = axi_wready;
  assign S_AXI_BRESP   = axi_bresp;
  assign S_AXI_BVALID  = axi_bvalid;
  assign S_AXI_ARREADY = axi_arready;
  assign S_AXI_RDATA   = axi_rdata;
  assign S_AXI_RRESP   = axi_rresp;
  assign S_AXI_RVALID  = axi_rvalid;
  // 实现 axi_awready 生成
  // 当 S_AXI_AWVALID 和 S_AXI_WVALID 都为高时，axi_awready 在一个 S_AXI_ACLK 时钟周期内被置高。
  // 当复位为低时，axi_awready 取消置高。


  // 当 axi_awready、S_AXI_WVALID、axi_wready 和 S_AXI_WVALID 都为高时，写数据被接收并写入存储器映射寄存器。
  assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

  // 实现存储器映射寄存器选择和读逻辑生成
  // 当有有效地址且从机准备好接收读地址时，从机寄存器读使能被置高。
  assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;


/****************************************** 用户时序逻辑 ****************************************/


  //-------------------------------------- 配置参数解码部分 --------------------------------------//
    //标志配置完毕的信号
    always @(posedge S_AXI_ACLK) begin
        if(!S_AXI_ARESETN) begin
            reg_config_valid <= 1'b0;
        end else if (reg_config_handshake) begin
            reg_config_valid <= 1'b0;
        end else if (write_done) begin
            reg_config_valid <= 1'b1;
        end else reg_config_valid <= reg_config_valid;
    end

    //判断矩阵维度，利用第一个寄存器的前2位
        always @(posedge S_AXI_ACLK) begin                                        
            if(!S_AXI_ARESETN) begin
                MATRIX_m = 6'd16;
            end else if (reg_config_valid) begin
                case (slv_reg0[1:0])
                    //第一个维度
                    2'b00: begin
                        MATRIX_m <= 6'd16;
                    end
                    //第2个维度
                    2'b01: begin
                        MATRIX_m <= 6'd8;
                    end
                    //第3个维度
                    2'b10: begin
                        MATRIX_m <= 6'd32;
                    end
                    //默认维度
                    default: begin
                        MATRIX_m <= 6'd16;
                    end 
                endcase
            end else begin      //默认位16，16，16
                MATRIX_m <= MATRIX_m;
            end                                    
        end 


    //判断ABC三个矩阵的精度
        //矩阵A
        always @(posedge S_AXI_ACLK)begin
            if(!S_AXI_ARESETN) begin
                MATRIX_a_precision <= 6'd4;
            end else if (reg_config_valid) begin
                case (slv_reg0[3:2])
                    2'b00:   MATRIX_a_precision <= 6'd4;  //int4
                    2'b01:   MATRIX_a_precision <= 6'd8;  //int8
                    2'b10:   MATRIX_a_precision <= 6'd16; //fp16
                    2'b11:   MATRIX_a_precision <= 6'd32; //fp32
                    default: MATRIX_a_precision <= 6'd4;  //默认int4
                endcase
            end else begin      
                MATRIX_a_precision <= MATRIX_a_precision;
            end
        end

        //矩阵B
        always @(posedge S_AXI_ACLK)begin
            if(!S_AXI_ARESETN) begin
                MATRIX_b_precision <= 6'd4;
            end else if (reg_config_valid) begin
                case (slv_reg0[5:4])
                    2'b00:   MATRIX_b_precision <= 6'd4;  //int4 
                    2'b01:   MATRIX_b_precision <= 6'd8;  //int8
                    2'b10:   MATRIX_b_precision <= 6'd16; //fp16
                    2'b11:   MATRIX_b_precision <= 6'd32; //fp32
                    default: MATRIX_b_precision <= 6'd4;  //默认int4
                endcase
            end else begin      
                MATRIX_b_precision <= MATRIX_b_precision;
            end
        end

        //矩阵C
        always @(posedge S_AXI_ACLK)begin
            if(!S_AXI_ARESETN) begin
                MATRIX_c_precision <= 6'd4;
            end else if (reg_config_valid) begin
                case (slv_reg0[7:6])
                    2'b00:   MATRIX_c_precision <= 6'd4;  //int4
                    2'b01:   MATRIX_c_precision <= 6'd8;  //int8
                    2'b10:   MATRIX_c_precision <= 6'd16; //fp16
                    2'b11:   MATRIX_c_precision <= 6'd32; //32
                    default: MATRIX_c_precision <= 6'd4;  //默认int4
                endcase
            end else begin      
                MATRIX_c_precision <= MATRIX_c_precision;
            end
        end


    //判断矩阵C是否是整数，默认是整数
        always @(posedge S_AXI_ACLK) begin
            if(!S_AXI_ARESETN) begin
                MATRIX_c_int_or_fp          <= 1'b1;
            end else if (reg_config_valid) begin
                if (slv_reg0[8]) begin
                    MATRIX_c_int_or_fp      <= 1'b1;
                end else MATRIX_c_int_or_fp <= 1'b0;
            end else MATRIX_c_int_or_fp     <= MATRIX_c_int_or_fp;
        end


/****************************************** axi内部时序逻辑 *************************************/
  // 实现存储器映射寄存器选择和写逻辑生成
  // 写选通用于在写入时选择从机寄存器的字节使能。
  // 这些寄存器在复位（低有效）时清零。
  // 当有有效地址和数据，并且从机准备好接收写地址和写数据时，从机寄存器写使能被置高。
    always @(posedge S_AXI_ACLK) begin
        if (S_AXI_ARESETN == 1'b0) begin
        slv_reg0 <= 0;
        slv_reg1 <= 0;
        slv_reg2 <= 0;
        slv_reg3 <= 0;
        end else begin
        if (slv_reg_wren) begin
            case (axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB])

            2'h0: begin
                for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1) begin
                    if (S_AXI_WSTRB[byte_index] == 1) begin
                        // 按照写选通信号使能相应字节
                        // 从机寄存器0
                        slv_reg0[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
                    end
                end
            end

            2'h1: begin
                for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1) begin
                    if (S_AXI_WSTRB[byte_index] == 1) begin
                        // 按照写选通信号使能相应字节
                        // 从机寄存器1
                        slv_reg1[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
                    end
                end
            end

            2'h2: begin
                for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1) begin
                    if (S_AXI_WSTRB[byte_index] == 1) begin
                        // 按照写选通信号使能相应字节
                        // 从机寄存器2
                        slv_reg2[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
                    end
                end
            end

            2'h3: begin
                for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH / 8) - 1; byte_index = byte_index + 1) begin
                    if (S_AXI_WSTRB[byte_index] == 1) begin
                    // 按照写选通信号使能相应字节
                    // 从机寄存器3
                        slv_reg3[(byte_index*8)+:8] <= S_AXI_WDATA[(byte_index*8)+:8];
                    end
                end
            end

            default: begin
                slv_reg0 <= slv_reg0;
                slv_reg1 <= slv_reg1;
                slv_reg2 <= slv_reg2;
                slv_reg3 <= slv_reg3;
            end
            endcase
        end
        end
    end


    always @(*) begin
        // 读寄存器的地址译码
        case (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB])
        2'h0    : reg_data_out <= slv_reg0;
        2'h1    : reg_data_out <= slv_reg1;
        2'h2    : reg_data_out <= slv_reg2;
        2'h3    : reg_data_out <= slv_reg3;
        default : reg_data_out <= 0;
        endcase
    end


  //-------------------------------------- 写地址通道 --------------------------------------//
    //通过单独调整aw_en，来指示目前计算正在进行，无法接收下一次的配置
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
                aw_en           <= 1'b1;
            end else begin
                if ((~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) || (data_send_flag)) begin
                    // 当写地址和写数据总线上都有有效数据时，从机准备好接收写地址
                    // 本设计不允许有未完成的事务
                    aw_en       <= 1'b0;
                end else if (~data_send_flag) begin
                    aw_en       <= 1'b1;
                end else begin
                    aw_en       <= aw_en;
                end
            end
        end

    //写地址控制
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
                axi_awready <= 1'b0;
            end else begin
                if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en && (axi_work_state == AXI_COMPUTE)) begin
                    // 当写地址和写数据总线上都有有效数据时，从机准备好接收写地址
                    // 本设计不允许有未完成的事务
                    axi_awready <= 1'b1;
                end else if (write_done) begin
                    axi_awready <= 1'b0;
                end else begin
                    axi_awready <= 1'b0;        //目的是生成一段脉冲
                end
            end
        end

    // 实现 axi_awaddr 锁存
    // 该过程用于在 S_AXI_AWVALID 和 S_AXI_WVALID 都有效时锁存地址
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
                axi_awaddr <= 0;
            end else begin
                if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
                    // 写地址锁存
                    axi_awaddr <= S_AXI_AWADDR;
                end
            end
        end


  //-------------------------------------- 写数据通道 --------------------------------------//
    // 当 S_AXI_AWVALID 和 S_AXI_WVALID 都为高时，axi_wready 在一个 S_AXI_ACLK 时钟周期内被置高。
    // 当复位为低时，axi_wready 取消置高。
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
            axi_wready <= 1'b0;
            end else begin
            if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en && (axi_work_state == AXI_COMPUTE)) begin
                // 当写地址和写数据总线上都有有效数据时，从机准备好接收写数据
                // 本设计不允许有未完成的事务
                axi_wready <= 1'b1;
            end else begin
                axi_wready <= 1'b0;
            end
            end
        end

  
  //-------------------------------------- 写响应 (B) 通道 ---------------------------------//                                                                                                                                                                                                          
    // 当 axi_wready、S_AXI_WVALID、axi_wready 和 S_AXI_WVALID 都为高时，从机会置高写响应和响应有效信号。
    // 这表示地址已被接收，并指示写事务的状态。
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
                axi_bvalid <= 0;
                axi_bresp  <= 2'b0;
            end else begin
                if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID) begin
                    // 表示有一个有效的写响应可用
                    axi_bvalid <= 1'b1;
                    axi_bresp  <= 2'b0;  // “OKAY”响应 
                end                      // 以后可处理错误响应
                else begin
                    if (S_AXI_BREADY && axi_bvalid) // 检查bready在bvalid为高时是否被置高（有可能bready一直为高）
                    begin
                        axi_bvalid <= 1'b0;
                    end
                end
            end
        end


  //-------------------------------------- 读地址通道 --------------------------------------//
    // 实现 axi_arready 生成
    // 当 S_AXI_ARVALID 为高时，axi_arready 在一个 S_AXI_ACLK 时钟周期内被置高。
    // 当复位（低有效）时，axi_awready 取消置高。
    // 当 S_AXI_ARVALID 为高时，读地址也会被锁存。axi_araddr 在复位时被清零。
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
            axi_arready <= 1'b0;
            axi_araddr  <= 32'b0;
            end else begin
            if (~axi_arready && S_AXI_ARVALID) begin
                // 表示从机已接收有效的读地址
                axi_arready <= 1'b1;
                // 读地址锁存
                axi_araddr  <= S_AXI_ARADDR;
            end else begin
                axi_arready <= 1'b0;
            end
            end
        end

    // 实现 axi_arvalid 生成
        // 当 S_AXI_ARVALID 和 axi_arready 都为高时，axi_rvalid 在一个 S_AXI_ACLK 时钟周期内被置高。
        // 此时从机寄存器数据可通过 axi_rdata 总线输出。
        // axi_rvalid 的置高表示总线上有有效的读数据，axi_rresp 指示读事务的状态。
        // 复位（低有效）时，axi_rvalid 取消置高，axi_rresp 和 axi_rdata 清零。
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
            axi_rvalid <= 0;
            axi_rresp  <= 0;
            end else begin
            if (axi_arready && S_AXI_ARVALID && ~axi_rvalid) begin
                // 读数据总线上有有效数据
                axi_rvalid <= 1'b1;
                axi_rresp  <= 2'b0;  // “OKAY”响应
            end else if (axi_rvalid && S_AXI_RREADY) begin
                // 主机已接收读数据
                axi_rvalid <= 1'b0;
            end
            end
        end

  
  //-------------------------------------- 读数据 (和响应) 通道 -----------------------------//                                                                                                                                                                                                                                                                              
    // 输出寄存器或存储器读数据
        always @(posedge S_AXI_ACLK) begin
            if (S_AXI_ARESETN == 1'b0) begin
            axi_rdata <= 0;
            end else begin
            // 当有有效的读地址（S_AXI_ARVALID）且从机已接收读地址（axi_arready）时，输出读数据
            if (slv_reg_rden) begin
                axi_rdata <= reg_data_out;  // 寄存器读数据
            end
            end
        end


endmodule
