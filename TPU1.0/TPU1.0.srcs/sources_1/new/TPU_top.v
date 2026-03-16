`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/07 12:37:47
// Design Name: 
// Module Name: TPU_top
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

`include "top_parameter.vh"

module TPU_top#(
    /*************************************** AXI_FULL参数 ******************************/
      // 用户在此处添加变量
		  parameter DDR3_DATA_BACK_BASE_ADDR	    = 32'h00000000,     // 写回数据时目标从机的基址
      // 用户的变量结束处
      // 不要修改这一行下面的参数

      parameter C_M_TARGET_SLAVE_BASE_ADDR	 = 32'h00000000,  // 目标从机的基址
      parameter integer C_M_AXI_BURST_LEN	   = 256,           // 突发长度。支持1，2，4，8，16，32，64，128，256的突发长度
      parameter integer C_M_AXI_ID_WIDTH  	 = 4,             // Thread ID Width（线程ID宽度）
      parameter integer C_M_AXI_ADDR_WIDTH	 = 29,            // 地址总线宽度
      parameter integer C_M_AXI_DATA_WIDTH	 = 128,           // 数据总线宽度

      parameter integer C_M_AXI_AWUSER_WIDTH = 0,             // 用户写地址总线的宽度
      parameter integer C_M_AXI_ARUSER_WIDTH = 0,             // 用户读地址总线的宽度
      parameter integer C_M_AXI_WUSER_WIDTH	 = 0,             // 用户写数据总线宽度
      parameter integer C_M_AXI_RUSER_WIDTH	 = 0,             // 用户读数据总线的宽度
      parameter integer C_M_AXI_BUSER_WIDTH	 = 0,             // 用户响应总线的宽度


    /*************************************** AXI_LITE参数 ******************************/
        // 用户可在此添加参数

        // 用户参数结束
        // 请勿修改此行之后的参数

        parameter integer C_S_AXI_DATA_WIDTH = 32,   // S_AXI 数据总线宽度
        parameter integer C_S_AXI_ADDR_WIDTH = 4     // S_AXI 地址总线宽度
	
    )(

    /*************************************** 用户 I/O口 ****************************/
      input clk,
      input rst_n,

      //该信号为测试用，可删除
      output tb_last_data_back, 
      output tb_write_flag,
      output [127:0] tb_AXI_wdata,

    /*************************************** AXI_FULL I/O口 ****************************/
      // 用户可以在这里添加端口

      //-------------------------- 输入信号 --------------------------//
      input [1:0]									axi_work_state,            //axi工作状态指示
      
      input                       AXI_FULL_test_effective,   //测试用的AXI_FULL启动信号
      //-------------------------- 输出信号 --------------------------//
      output 										  read_flag,		             //读有效
      output 										  write_flag,		             //写有效，该信号表示AXI在写数据
      output 									    ar_effective,	             //该信号用于指示读地址准备和读地址同时有效

      

    
      // 用户端口终止处

      // 不要修改这行以外的端口
      output  wire                                 READ_TXN_DONE, // 当传输完成时有效
      output  wire                                 WRITE_TXN_DONE,// 当传输完成时有效

      input   wire                                 M_AXI_ACLK,    // 全局时钟信号
      input   wire                                 M_AXI_ARESETN, // 全局复位信号。这个信号低电平有效

      //写地址通道
      output  wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_AWID,    // 主机接口写地址ID
      output  wire [C_M_AXI_ADDR_WIDTH-1 : 0]      M_AXI_AWADDR,  // 主机接口写地址
      output  wire [7 : 0]                         M_AXI_AWLEN,   // 突发传输长度。突发长度给出了一次突发中准确的传输事务个数
      output  wire [2 : 0]                         M_AXI_AWSIZE,  // 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
      output  wire [1 : 0]                         M_AXI_AWBURST, // 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
      output  wire                                 M_AXI_AWVALID,	// 写地址有效。这个信号指出这个写地址通道正在发送有效的写地址和写控制信息
      input   wire                                 M_AXI_AWREADY,	// 写地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号
          
      //写数据通道
      output  wire [C_M_AXI_DATA_WIDTH-1 : 0]      M_AXI_WDATA,	  // 主机接口写数据
      output  wire [C_M_AXI_DATA_WIDTH/8-1 : 0]    M_AXI_WSTRB,	  // Write strobes（写掩码）.这个信号指出哪一个字节通道有有效的数据。在写数据总线1比特的写掩码控制8比特的数据
      output  wire                                 M_AXI_WLAST,	  // 写last。这个信号指出在一次写突发传输的最后一位
      output  wire                                 M_AXI_WVALID,	// 写数据有效。这个信号指出有效的写数据和写掩码是可获得的
      input   wire                                 M_AXI_WREADY,	// 写数据准备。这个信号指出从机可以接收写数据

      //写响应 (B) 通道
      input   wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_BID,		  // 主机接口写响应ID
      input   wire [1 : 0] 						             M_AXI_BRESP,	  // 写响应。这个信号指出写事物的状态
      input   wire                                 M_AXI_BVALID,	// 写响应有效。这个信号指出写响应通道的写响应信号有效
      output  wire                                 M_AXI_BREADY,	// 写响应准备。这个信号指出主机可以接受一次写响应

      //读地址通道
      output  wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_ARID,	  // 主机读地址ID
      output  wire [C_M_AXI_ADDR_WIDTH-1 : 0]      M_AXI_ARADDR,	// 写地址。这个信号指出一次读突发传输事务的初始化地址
      output  wire [7 : 0]                         M_AXI_ARLEN,	  // 突发传输长度，突发长度给出了一次突发中准确的传输事务个数
      output  wire [2 : 0]                         M_AXI_ARSIZE,	// 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
      output  wire [1 : 0]                         M_AXI_ARBURST,	// 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
      output  wire                                 M_AXI_ARVALID, // 读地址有效。这个信号指出这个读地址通道正在发送有效的写地址和写控制信息
      input   wire                                 M_AXI_ARREADY, // 读地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号

          //读数据 (和响应) 通道
      input   wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_RID,		  //读ID标签。这个信号是从机生成的读数据信号组的身份标签
      input   wire [C_M_AXI_DATA_WIDTH-1 : 0]      M_AXI_RDATA,	  //主机读数据
      input   wire [1 : 0]                         M_AXI_RRESP,	  //读响应。这个信号指出读传输的状态（响应）
      input   wire                                 M_AXI_RLAST,	  //读last。这个信号指出一次读突发传输的最后一次传输
      input   wire                                 M_AXI_RVALID,	//读有效。这个信号指出这个通道正给出需要的读数据
      output  wire                                 M_AXI_RREADY,	//读准备。这个信号指出主机可以接收读数据和响应的信息


    /*************************************** AXI_LITE I/O口 ****************************/
        // 用户可在此添加端口
        //配置的寄存器的信息


        // 用户端口结束
        // 请勿修改此行之后的端口

        input  wire                                S_AXI_ACLK,    // 全局时钟信号
        input  wire                                S_AXI_ARESETN, // 全局复位信号，低有效

        //写通道
        input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_AWADDR,  // 写地址（由主机发出，被从机接收）
        input  wire                                S_AXI_AWVALID, // 写地址有效。该信号指示主机正在传递有效的写地址和控制信息。
        output wire                                S_AXI_AWREADY, // 写地址就绪。该信号指示从机已准备好接收地址及相关控制信号。
        input  wire [2 : 0]                        S_AXI_AWPROT,  // 写通道保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。

        input  wire [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_WDATA,   // 写数据（由主机发出，被从机接收） 
        input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,   // 写选通信号。该信号指示哪些字节通道包含有效数据。每8位数据总线对应一个写选通位。
        input  wire                                S_AXI_WVALID,  // 写有效。该信号指示有效的写数据和选通信号可用。
        output wire                                S_AXI_WREADY,  // 写就绪。该信号指示从机可以接收写数据。

        output wire [1 : 0]                        S_AXI_BRESP,   // 写响应。该信号指示写事务的状态。
        output wire                                S_AXI_BVALID,  // 写响应有效。该信号指示通道正在传递有效的写响应。
        input  wire                                S_AXI_BREADY,  // 响应就绪。该信号指示主机可以接收写响应。
        
        //读通道
        input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_ARADDR,  // 读地址（由主机发出，被从机接收）
        input  wire                                S_AXI_ARVALID, // 读地址有效。该信号指示通道正在传递有效的读地址和控制信息。
        output wire                                S_AXI_ARREADY, // 读地址就绪。该信号指示从机已准备好接收地址及相关控制信号。
        input  wire [2 : 0]                        S_AXI_ARPROT,  // 保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。

        output wire [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_RDATA,   // 读数据（由从机发出）
        output wire [1 : 0]                        S_AXI_RRESP,   // 读响应。该信号指示读传输的状态。
        output wire                                S_AXI_RVALID,  // 读有效。该信号指示通道正在传递所需的读数据。
        input  wire                                S_AXI_RREADY   // 读就绪。该信号指示主机可以接收读数据和响应信息。
	);


/******************************* 参数 ***********************************/
  //------------------------------- 普通参数 ---------------------------//


  //------------------------------- 本地参数 ---------------------------//
    //以下参数为AXI的工作状态
    localparam AXI_IDLE               = 2'b00,    //axi空闲态，目前未知其用处未知
               AXI_LOAD_DATA_TO_DDR3  = 2'b01,    //axi的读写操作状态，此时为从bram读取数据并载入数据至ddr3
               AXI_COMPUTE            = 2'b10;    //axi的计算操作状态，此时开始从ddr3中读取数据至TPU


/*************************************** 信号 ********************************/
  //-------------------------------- 寄存器型 --------------------------//


  //-------------------------------- 网表型 ----------------------------//
    //用于配置寄存器的信号，与mult_kernel相连
      wire [5:0] MATRIX_m;              //矩阵的维度

      wire [5:0] MATRIX_a_precision;    //矩阵精度
      wire [5:0] MATRIX_b_precision;
      wire [5:0] MATRIX_c_precision;
      wire       MATRIX_c_int_or_fp;    //判断矩阵C是否是整数


    wire reg_config_handshake;          //标志寄存器配置完毕的信号
    wire data_send_flag;                //标志正在发送数据
    wire reg_config_valid;              //标志从机读取配置完毕

    wire INIT_AXI_READ_TXN;             //用于启动AXI_FULL读的信号
    wire INIT_AXI_WRITE_TXN;            //用于启动AXI_FULL写的信号
    wire AXI_FULL_rstop;                //用于暂停AXI读事务的信号
    wire AXI_FULL_wstop;                //用于暂停AXI写事务的信号
  
    wire AXI_FULL_reffective;           //AXI_FULL_crtl控制AXI_FULL的读有效信号
    wire AXI_FULL_weffective;           //AXI_FULL_crtl控制AXI_FULL的写有效信号

    wire [1:0] MATRIX_state;            //该信号与TPU连接，用于判断当前发送矩阵种类（A(1)，B(2)还是C(3)）
    wire [6:0] MATRIX_cnt;              //该信号与TPU连接，用于判断当前是矩阵中的第几个128位数据 
    wire       AXI_data_send_handshake; //该信号与TPU连接，用于使能TPU的数据接收模块
    wire       data_send_last;          //该信号与TPU连接，用于指示当前为发送的最后一组128位数据
    wire       M_en;                    //该信号与TPU连接，用于指示有新的配置
    wire       AXI_data_send_ready;     //该信号与TPU连接，用于指示可接受新的数据
    wire       compute_en_posedge;      //compute_en上升沿信号  
    wire       compute_over;            //计算完成信号
    wire       last_compute;            //标志最后一次计算
    wire [5:0] MATRIX_D_data_back_cnt;  //读回矩阵D数据时用到的计数器


    wire [127:0] AXI_wdata;             //该信号为写回数据，与TPU连接
    wire [127:0] AXI_rdata;             //该信号为读出的数据，与AXI_FULL连接



/****************************************** 组合逻辑 ****************************************/
  //以下为测试用
    assign tb_AXI_wdata = AXI_wdata;

  //以下逻辑将AXI_FULL的启动信号以仲裁的方式连接到AXI_FULL
    assign INIT_AXI_READ_TXN  = (axi_work_state == AXI_COMPUTE) ? AXI_FULL_reffective : AXI_FULL_test_effective;
    assign INIT_AXI_WRITE_TXN = (axi_work_state == AXI_COMPUTE) ? AXI_FULL_weffective : AXI_FULL_test_effective;

  //以下逻辑将AXI_LITE_AWVALID的作为有新配置的标志
    assign M_en = S_AXI_AWVALID;

  //AXI读的数据
    assign AXI_rdata = M_AXI_RDATA;

  //以下为仿真信号的引出
    assign tb_write_flag = write_flag && (axi_work_state == AXI_COMPUTE);   //只有在计算态时write_flag才算标志回收数据

/*************************************** 模块例化 ****************************/

  //-------------------------------- AXI_FULL模块 --------------------------//
    AXI_FULL_M_CHINESE #(
        // 用户在此处添加变量
        .DDR3_DATA_BACK_BASE_ADDR    (DDR3_DATA_BACK_BASE_ADDR  ),  // 写回数据时目标从机的基址
        // 用户的变量结束处

        // 不要修改这一行下面的参数

        .C_M_TARGET_SLAVE_BASE_ADDR  (C_M_TARGET_SLAVE_BASE_ADDR),  // 目标从机的基址
        .C_M_AXI_BURST_LEN	         (C_M_AXI_BURST_LEN         ),  // 突发长度。支持1，2，4，8，16，32，64，128，256的突发长度
        .C_M_AXI_ID_WIDTH            (C_M_AXI_ID_WIDTH          ),  // Thread ID Width（线程ID宽度）
        .C_M_AXI_ADDR_WIDTH          (C_M_AXI_ADDR_WIDTH        ),  // 地址总线宽度
        .C_M_AXI_DATA_WIDTH          (C_M_AXI_DATA_WIDTH        )   // 数据总线宽度
    ) AXI_FULL_M_CHINESE (

      // 用户端口
        //-------------------------- 输入信号 --------------------------//
        .axi_work_state            (axi_work_state           ),	 //axi工作类型

        .AXI_FULL_rstop            (AXI_FULL_rstop           ),  //控制读暂停的信号
        .AXI_FULL_wstop            (AXI_FULL_wstop           ),  //控制写暂停的信号

        .AXI_wdata                 (AXI_wdata                ),  //由计算得到的写数据

        //-------------------------- 输出信号 --------------------------//
        .read_flag     (read_flag     ),		//读有效
        .write_flag    (write_flag    ),    //写有效
        .ar_effective  (ar_effective  ),


      //AXI_FULL I/O
          .INIT_AXI_READ_TXN  (INIT_AXI_READ_TXN ),  // 启动AXI读传输事务
          .INIT_AXI_WRITE_TXN (INIT_AXI_WRITE_TXN), // 启动AXI写传输事务
          .READ_TXN_DONE      (READ_TXN_DONE     ),  // 当读完成时有效
          .WRITE_TXN_DONE     (WRITE_TXN_DONE    ),  // 当写完成时有效

          .M_AXI_ACLK         (M_AXI_ACLK        ),  // 用户时钟信号，由ddr3控制
          .M_AXI_ARESETN      (M_AXI_ARESETN     ),  // 用户复位信号。这个信号低电平有效，由ddr3控制

          //----------------------- AXI4写通道 -------------------------------//
          //写地址通道
          .M_AXI_AWID    (M_AXI_AWID   ),  // 主机接口写地址ID
          .M_AXI_AWADDR  (M_AXI_AWADDR ),  // 主机接口写地址
          .M_AXI_AWLEN   (M_AXI_AWLEN  ),  // 突发传输长度。突发长度给出了一次突发中准确的传输事务个数
          .M_AXI_AWSIZE  (M_AXI_AWSIZE ),  // 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
          .M_AXI_AWBURST (M_AXI_AWBURST),  // 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
          .M_AXI_AWVALID (M_AXI_AWVALID),	 // 写地址有效。这个信号指出这个写地址通道正在发送有效的写地址和写控制信息
          .M_AXI_AWREADY (M_AXI_AWREADY),	 // 写地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号

          //写数据通道
          .M_AXI_WDATA   (M_AXI_WDATA ),   // 主机接口写数据
          .M_AXI_WSTRB   (M_AXI_WSTRB ),	 // Write strobes（写掩码）.这个信号指出哪一个字节通道有有效的数据。在写数据总线1比特的写掩码控制8比特的数据
          .M_AXI_WLAST   (M_AXI_WLAST ),	 // 写last。这个信号指出在一次写突发传输的最后一位
          .M_AXI_WVALID  (M_AXI_WVALID),	 // 写数据有效。这个信号指出有效的写数据和写掩码是可获得的
          .M_AXI_WREADY  (M_AXI_WREADY),   // 写数据准备。这个信号指出从机可以接收写数据

          //写响应 (B) 通道
          .M_AXI_BID     (M_AXI_BID   ),   // 主机接口写响应ID
          .M_AXI_BRESP   (M_AXI_BRESP ),   // 写响应。这个信号指出写事物的状态
          .M_AXI_BVALID  (M_AXI_BVALID),	 // 写响应有效。这个信号指出写响应通道的写响应信号有效
          .M_AXI_BREADY  (M_AXI_BREADY),	 // 写响应准备。这个信号指出主机可以接受一次写响应

          //----------------------- AXI4读通道 -------------------------------//
          //读地址通道
          .M_AXI_ARID    (M_AXI_ARID   ),  // 主机读地址ID
          .M_AXI_ARADDR  (M_AXI_ARADDR ),	 // 写地址。这个信号指出一次读突发传输事务的初始化地址
          .M_AXI_ARLEN   (M_AXI_ARLEN  ),	 // 突发传输长度，突发长度给出了一次突发中准确的传输事务个数
          .M_AXI_ARSIZE  (M_AXI_ARSIZE ),	 // 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
          .M_AXI_ARBURST (M_AXI_ARBURST),	 // 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
          .M_AXI_ARVALID (M_AXI_ARVALID),  // 读地址有效。这个信号指出这个读地址通道正在发送有效的写地址和写控制信息
          .M_AXI_ARREADY (M_AXI_ARREADY),  // 读地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号

          //读数据 (和响应) 通道
          .M_AXI_RID     (M_AXI_RID   ),	 //读ID标签。这个信号是从机生成的读数据信号组的身份标签
          .M_AXI_RDATA   (M_AXI_RDATA ),   //主机读数据
          .M_AXI_RRESP   (M_AXI_RRESP ),   //读响应。这个信号指出读传输的状态（响应）
          .M_AXI_RLAST   (M_AXI_RLAST ),	 //读last。这个信号指出一次读突发传输的最后一次传输
          .M_AXI_RVALID  (M_AXI_RVALID),	 //读有效。这个信号指出这个通道正给出需要的读数据
          .M_AXI_RREADY  (M_AXI_RREADY)	   //读准备。这个信号指出主机可以接收读数据和响应的信息
    );


  //-------------------------------- AXI_LITE模块 --------------------------//
    AXI_LITE_S #(
        // 用户参数

        //内部参数
          .C_S_AXI_DATA_WIDTH   (C_S_AXI_DATA_WIDTH),   // S_AXI 数据总线宽度
          .C_S_AXI_ADDR_WIDTH   (C_S_AXI_ADDR_WIDTH)    // S_AXI 地址总线宽度
    ) AXI_LITE_S (
        // 用户端口
          .MATRIX_m             (MATRIX_m          ),             //矩阵的维度

          .MATRIX_a_precision   (MATRIX_a_precision),   //矩阵精度
          .MATRIX_b_precision   (MATRIX_b_precision),
          .MATRIX_c_precision   (MATRIX_c_precision),
          .MATRIX_c_int_or_fp   (MATRIX_c_int_or_fp),   //判断矩阵C是否是整数

          //以下端口与AXI_FULL_crtl连接
          .reg_config_valid     (reg_config_valid    ),
          .reg_config_handshake (reg_config_handshake),
          .data_send_flag       (data_send_flag      ),

          .axi_work_state       (axi_work_state      ),
        
        //AXI_LITE I/O
          .S_AXI_ACLK    (S_AXI_ACLK   ),  //input  wire                                // 全局时钟信号
          .S_AXI_ARESETN (S_AXI_ARESETN),  //input  wire                                // 全局复位信号，低有效

          //写通道
          .S_AXI_AWADDR  (S_AXI_AWADDR ),  //input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]      // 写地址（由主机发出，被从机接收）
          .S_AXI_AWVALID (S_AXI_AWVALID),  //input  wire                                 // 写地址有效。该信号指示主机正在传递有效的写地址和控制信息。
          .S_AXI_AWREADY (S_AXI_AWREADY),  //output wire                                 // 写地址就绪。该信号指示从机已准备好接收地址及相关控制信号。
          .S_AXI_AWPROT  (S_AXI_AWPROT ),  //input  wire [2 : 0]                         // 写通道保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。

          .S_AXI_WDATA   (S_AXI_WDATA  ),  //input  wire [C_S_AXI_DATA_WIDTH-1 : 0]      // 写数据（由主机发出，被从机接收） 
          .S_AXI_WSTRB   (S_AXI_WSTRB  ),  //input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0]  // 写选通信号。该信号指示哪些字节通道包含有效数据。每8位数据总线对应一个写选通位。
          .S_AXI_WVALID  (S_AXI_WVALID ),  //input  wire                                 // 写有效。该信号指示有效的写数据和选通信号可用。
          .S_AXI_WREADY  (S_AXI_WREADY ),  //output wire                                 // 写就绪。该信号指示从机可以接收写数据。

          .S_AXI_BRESP   (S_AXI_BRESP  ),  //output wire [1 : 0]                         // 写响应。该信号指示写事务的状态。
          .S_AXI_BVALID  (S_AXI_BVALID ),  //output wire                                 // 写响应有效。该信号指示通道正在传递有效的写响应。
          .S_AXI_BREADY  (S_AXI_BREADY ),  //input  wire                                 // 响应就绪。该信号指示主机可以接收写响应。
          
          //读通道
          .S_AXI_ARADDR  (S_AXI_ARADDR ),  //input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]      // 读地址（由主机发出，被从机接收）
          .S_AXI_ARVALID (S_AXI_ARVALID),  //input  wire                                 // 读地址有效。该信号指示通道正在传递有效的读地址和控制信息。
          .S_AXI_ARREADY (S_AXI_ARREADY),  //output wire                                 // 读地址就绪。该信号指示从机已准备好接收地址及相关控制信号。
          .S_AXI_ARPROT  (S_AXI_ARPROT ),  //input  wire [2 : 0]                         // 保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。
          
          .S_AXI_RDATA   (S_AXI_RDATA  ),  //output wire [C_S_AXI_DATA_WIDTH-1 : 0]      // 读数据（由从机发出）
          .S_AXI_RRESP   (S_AXI_RRESP  ),  //output wire [1 : 0]                         // 读响应。该信号指示读传输的状态。
          .S_AXI_RVALID  (S_AXI_RVALID ),  //output wire                                 // 读有效。该信号指示通道正在传递所需的读数据。
          .S_AXI_RREADY  (S_AXI_RREADY )   //input  wire                                 // 读就绪。该信号指示主机可以接收读数据和响应信息。
    );


  //-------------------------------- AXI_FULL_crtl模块 -----------------------//
    AXI_FULL_crtl AXI_FULL_crtl(
          .clk                  (clk                 ),
          .rst_n                (rst_n               ),

          //该信号为测试用，可删除
          .tb_last_data_back    (tb_last_data_back   ), 

          .reg_config_valid     (reg_config_valid    ),       //表示可以读取此时的配置，此时为reg_ready与reg_valid握手
          .reg_config_handshake (reg_config_handshake),       //标志握手成功，该信号也连接至TPU
          .data_send_flag       (data_send_flag      ),       //标志正在发送数据

          .M_en                 (M_en                ),       //此为主机使能信号，这里使用AXI_M的awvalid作为连接，该信号也与TPU连接

          //以下为寄存器配置
          .MATRIX_m             (MATRIX_m            ),       //矩阵的维度
          .MATRIX_a_precision   (MATRIX_a_precision  ),       //矩阵精度
          .MATRIX_b_precision   (MATRIX_b_precision  ),
          .MATRIX_c_precision   (MATRIX_c_precision  ),

          .read_flag            (read_flag           ),       //读有效时拉高
          .write_flag           (write_flag          ),       //写有效时拉高

          .AXI_FULL_reffective  (AXI_FULL_reffective ),       //高电平时axi一直有效发送数据，下降沿时会完全将其终止，即让他跑完剩下的
          .AXI_FULL_weffective  (AXI_FULL_weffective ),       //高电平时axi一直有效，接收数据，下降沿时会完全将其终止，即让他跑完剩下的
          .AXI_FULL_rstop       (AXI_FULL_rstop      ),       //暂停AXI读的信号
          .AXI_FULL_wstop       (AXI_FULL_wstop      ),       //暂停AXI写的信号

          .READ_TXN_DONE        (READ_TXN_DONE       ),       //此信号表明AXI完成了一次大的读突发传输
          .WRITE_TXN_DONE       (WRITE_TXN_DONE      ),       //此信号表明AXI完成了一次大的写突发传输
          .AXI_work_state       (axi_work_state      ),       //测试口（留作测试及运算使用），AXI的工作状态

          //以下信号要与TPU模块连接
          .MATRIX_state            (MATRIX_state           ), //用于判断当前为哪一个矩阵
          .MATRIX_cnt              (MATRIX_cnt             ),
          .AXI_data_send_handshake (AXI_data_send_handshake),
          .data_send_last          (data_send_last         ), //当最后一组数据发送完之后拉高
          .AXI_data_send_ready     (AXI_data_send_ready    ), //由TPU_top来发送的信号
          .compute_en_posedge      (compute_en_posedge     ),//compute_en上升沿信号
          .compute_over            (compute_over           ), //计算完成信号
          .last_compute            (last_compute           ), //标志最后一次计算
          .MATRIX_D_data_back_cnt  (MATRIX_D_data_back_cnt )  //读回矩阵D数据时用到的计数器
      );



  //-------------------------------- TPU模块 -----------------------//
    TPU TPU(
      .clk                        (clk                    ),    //input wire         
      .rst_n                      (rst_n                  ),    //input wire         

      .write_flag                 (write_flag             ),    //写回有效                      //input wire         
      .read_flag                  (read_flag              ),    //读数据是有效的                //input wire         
      .AXI_rdata                  (AXI_rdata              ),    //AXI读出来的128位宽数据        //input wire [127:0] 
      .AXI_wdata                  (AXI_wdata              ),    //写回ddr3或总线的数据          //output reg [127:0] 

      //与AXI_FULL_crtl连接的端口，最后连接到RAM_BUF_TOP
      .MATRIX_state               (MATRIX_state           ),    //用于判断当前为哪一个矩阵       //input wire [1:0]   
      .MATRIX_cnt                 (MATRIX_cnt             ),    //input wire [6:0]   
      .MATRIX_D_data_back_cnt     (MATRIX_D_data_back_cnt ),    //读回矩阵D数据时用到的计数器    //input wire [5:0]   

      .compute_en_posedge         (compute_en_posedge     ),    //compute_en上升沿信号，接出去  //output wire        

      .AXI_data_send_handshake    (AXI_data_send_handshake),    //标志AXI_data_send_valid和AXI_data_send_ready握手成功    //input wire         
      .data_send_last             (data_send_last         ),    //当最后一组数据发送完之后拉高   //input wire         
      .reg_config_handshake       (reg_config_handshake   ),    //标志配置握手成功              //input wire         
      .M_en                       (M_en                   ),    //AXI_LITE_M_AWVALID拉高时拉高的信号，标志还有未完成的AXI_LITE事务（即未计算完成的矩阵）    //input wire         

      .AXI_data_send_ready        (AXI_data_send_ready    ),    //控制ready信号                //output reg         
      .compute_over               (compute_over           ),    //运算结束信号，只要拉高一个脉冲 //output wire        
      .last_compute               (last_compute           ),    //最后一次计算                 //output wire        
      .data_send_flag             (data_send_flag         ),    //该信号用来控制 //input wire         

      //以下为输入的参数
      .MATRIX_m                   (MATRIX_m               ),    //矩阵的维度     //input wire [5:0] 
      .MATRIX_a_precision         (MATRIX_a_precision     ),    //矩阵精度      //input wire [5:0] 
      .MATRIX_b_precision         (MATRIX_b_precision     ),    //input wire [5:0] 
      .MATRIX_c_precision         (MATRIX_c_precision     ),    //input wire [5:0] 
      .MATRIX_c_int_or_fp         (MATRIX_c_int_or_fp     )     //判断矩阵C是否是整数       //input wire       
    );


endmodule
