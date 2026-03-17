`timescale 1ns / 1ps
`include "top_parameter.vh"

module TPU_crtl_tb#(
    /*************************************** AXI_LITE参数 ****************************/
        parameter integer C_S_AXI_DATA_WIDTH = 32,   // S_AXI 数据总线宽度
        parameter integer C_S_AXI_ADDR_WIDTH = 4     // S_AXI 地址总线宽度

    )(
    /*************************************** I/O口 **************************/
        input  wire clk,
        input  wire rst_n,

        //该信号为测试用，可删除
        output tb_last_data_back,
        output tb_write_flag,
        output [127:0] tb_AXI_wdata,

        input  wire start_test,

        output wire the_last_matrix,

    /*************************************** AXI_LITE I/O口 **************************/

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


/******************************* 参数 ***********************************/
  //------------------------------- 普通参数 ---------------------------//


  //------------------------------- 本地参数 ---------------------------//
    localparam DDR3_DATA_BACK_BASE_ADDR   = 32'h10000000;         //注意该地址为接收的数据存放的地方，由上位机给出，这里测试就给出了DDR3的中间地址
    localparam C_M_TARGET_SLAVE_BASE_ADDR = 32'h00000000; 
    localparam C_M_AXI_BURST_LEN          = `AXI_BURST_LEN; 
    localparam C_M_AXI_ID_WIDTH           = 4; 
    localparam C_M_AXI_ADDR_WIDTH         = `AXI_ADDR_WIDTH; 
    localparam C_M_AXI_DATA_WIDTH         = `AXI_DATA_WIDTH; 


/******************************* 信号 ***********************************/
  //------------------------------- 寄存器型 ---------------------------//


  //------------------------------- 网表型 ---------------------------//
    //以下信号用来连接BRAM_and_DDR3模块和TPU_top中的AXI_FULL模块
        wire [C_M_AXI_ID_WIDTH-1 : 0]     axi_full_awid;
        wire [C_M_AXI_ADDR_WIDTH-1 : 0]   axi_full_awaddr;
        wire [7 : 0]                      axi_full_awlen;
        wire [2 : 0]                      axi_full_awsize;
        wire [1 : 0]                      axi_full_awburst;
        wire                              axi_full_awvalid;
        wire                              axi_full_awready;

        wire [C_M_AXI_DATA_WIDTH-1 : 0]   axi_full_wdata;
        wire [C_M_AXI_DATA_WIDTH/8-1 : 0] axi_full_wstrb;
        wire                              axi_full_wlast;
        wire                              axi_full_wvalid;
        wire                              axi_full_wready;

        wire [C_M_AXI_ID_WIDTH-1 : 0]     axi_full_bid;
        wire [1 : 0] 				      axi_full_bresp;
        wire                              axi_full_bvalid;
        wire                              axi_full_bready;

        wire [C_M_AXI_ID_WIDTH-1 : 0]     axi_full_arid;
        wire [C_M_AXI_ADDR_WIDTH-1 : 0]   axi_full_araddr;
        wire [7 : 0]                      axi_full_arlen;
        wire [2 : 0]                      axi_full_arsize;
        wire [1 : 0]                      axi_full_arburst;
        wire                              axi_full_arvalid;
        wire                              axi_full_arready;        

        wire [C_M_AXI_ID_WIDTH-1 : 0]     axi_full_rid;
        wire [C_M_AXI_DATA_WIDTH-1 : 0]   axi_full_rdata;
        wire [1 : 0]                      axi_full_rresp;
        wire                              axi_full_rlast;
        wire                              axi_full_rvalid;
        wire                              axi_full_rready;

        //bram_and_ddr3模块信号
        //ddr3控制AXI4的信号
        wire c0_ddr3_ui_clk;
        wire c0_ddr3_ui_clk_sync_rst_n;

    //以下信号连接BRAM_and_DDR3模块和AXI_FULL_crtl_test模块
        wire init_calib_complete;


    //以下信号连接TPU_top模块中的AXI_FUll模块和AXI_FULL_crtl_test模块
        wire AXI_FULL_test_effective;        //启动AIX的信号
        wire READ_TXN_DONE;        //标志AXI读写完成
        wire WRITE_TXN_DONE;     

        wire [1:0]                 axi_work_state;

        wire read_flag; 
        wire write_flag; 
        wire ar_effective; 

        wire [`AXI_DATA_WIDTH-1:0] test_r_data;     
        wire [`AXI_DATA_WIDTH-1:0] test_w_data;     
        wire [`AXI_ADDR_WIDTH-1:0] axi_ar_addr_temp;


/******************************* 组合逻辑 ***********************************/
    //以下逻辑用于连接TPU_top模块中的AXI_FUll模块和AXI_FULL_crtl_test模块
    assign test_r_data      = axi_full_rdata;     //将读数据取出来看看是否正确  
    assign test_w_data      = axi_full_wdata;     //将读数据取出来看看是否正确  
    assign axi_ar_addr_temp = axi_full_araddr; 

    //以下位测试的代码
    assign AXI_FULL_start   = start_test;


/*************************************** 模块例化 ****************************/
    //-------------------------------------- TPU_top模块 ------------------------------------//
        TPU_top #(
        /*************************************** AXI_FULL参数 ****************************/
            // 用户在此处添加变量
            .DDR3_DATA_BACK_BASE_ADDR    (DDR3_DATA_BACK_BASE_ADDR  ),  // 写回数据时目标从机的基址
            // 用户的变量结束处

            // 不要修改这一行下面的参数

            .C_M_TARGET_SLAVE_BASE_ADDR  (C_M_TARGET_SLAVE_BASE_ADDR),  // 目标从机的基址
            .C_M_AXI_BURST_LEN	         (C_M_AXI_BURST_LEN         ),  // 突发长度。支持1，2，4，8，16，32，64，128，256的突发长度
            .C_M_AXI_ID_WIDTH            (C_M_AXI_ID_WIDTH          ),  // Thread ID Width（线程ID宽度）
            .C_M_AXI_ADDR_WIDTH          (C_M_AXI_ADDR_WIDTH        ),  // 地址总线宽度
            .C_M_AXI_DATA_WIDTH          (C_M_AXI_DATA_WIDTH        ),  // 数据总线宽度

            //用户使用的参数
            .C_M_AXI_AWUSER_WIDTH        (0                         ),  // 用户写地址总线的宽度
            .C_M_AXI_ARUSER_WIDTH        (0                         ),  // 用户读地址总线的宽度
            .C_M_AXI_WUSER_WIDTH         (0                         ),  // 用户写数据总线宽度
            .C_M_AXI_RUSER_WIDTH         (0                         ),  // 用户读数据总线的宽度
            .C_M_AXI_BUSER_WIDTH         (0                         ),  // 用户响应总线的宽度


        /*************************************** AXI_LITE参数 ****************************/
            .C_S_AXI_DATA_WIDTH   (C_S_AXI_DATA_WIDTH),   // S_AXI 数据总线宽度
            .C_S_AXI_ADDR_WIDTH   (C_S_AXI_ADDR_WIDTH)    // S_AXI 地址总线宽度，只需要2，因为只要1个寄存器，32bit，4个字节，需要2位宽的字节地址
        

        ) TPU_top (
        /*************************************** 用户 I/O口 ****************************/
            .clk        (clk    ),
            .rst_n      (rst_n  ),

            //该信号为测试用，可删除
            .tb_last_data_back             (tb_last_data_back        ),
            .tb_write_flag                 (tb_write_flag            ),
            .tb_AXI_wdata                  (tb_AXI_wdata             ),


        /*************************************** AXI_FULL I/O口 **************************/
            // 用户可以在这里添加端口
                //-------------------------- 输入信号 --------------------------//
                .axi_work_state            (axi_work_state           ),	 //axi工作类型

                .AXI_FULL_test_effective   (AXI_FULL_test_effective  ),  // 启动AXI测试传输事务，用于传输BRAM中的数据到DDR3
                //-------------------------- 输出信号 --------------------------//
                .read_flag     (read_flag     ),		//读有效
                .write_flag    (write_flag    ),		//写有效
                .ar_effective  (ar_effective  ),



                // 用户端口终止处

                // 不要修改这行以外的端口

                .READ_TXN_DONE (READ_TXN_DONE ),  // 当读完成时有效
                .WRITE_TXN_DONE(WRITE_TXN_DONE),  // 当写完成时有效

                .M_AXI_ACLK    (c0_ddr3_ui_clk           ),  // 用户时钟信号，由ddr3控制
                .M_AXI_ARESETN (c0_ddr3_ui_clk_sync_rst_n),  // 用户复位信号。这个信号低电平有效，由ddr3控制

                //----------------------- AXI4写通道 -------------------------------//
                //写地址通道
                .M_AXI_AWID    (axi_full_awid   ),  // 主机接口写地址ID
                .M_AXI_AWADDR  (axi_full_awaddr ),  // 主机接口写地址
                .M_AXI_AWLEN   (axi_full_awlen  ),  // 突发传输长度。突发长度给出了一次突发中准确的传输事务个数
                .M_AXI_AWSIZE  (axi_full_awsize ),  // 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
                .M_AXI_AWBURST (axi_full_awburst),  // 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
                .M_AXI_AWVALID (axi_full_awvalid),	 // 写地址有效。这个信号指出这个写地址通道正在发送有效的写地址和写控制信息
                .M_AXI_AWREADY (axi_full_awready),	 // 写地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号

                //写数据通道
                .M_AXI_WDATA   (axi_full_wdata ),   // 主机接口写数据
                .M_AXI_WSTRB   (axi_full_wstrb ),	 // Write strobes（写掩码）.这个信号指出哪一个字节通道有有效的数据。在写数据总线1比特的写掩码控制8比特的数据
                .M_AXI_WLAST   (axi_full_wlast ),	 // 写last。这个信号指出在一次写突发传输的最后一位
                .M_AXI_WVALID  (axi_full_wvalid),	 // 写数据有效。这个信号指出有效的写数据和写掩码是可获得的
                .M_AXI_WREADY  (axi_full_wready),   // 写数据准备。这个信号指出从机可以接收写数据

                //写响应 (B) 通道
                .M_AXI_BID     (axi_full_bid   ),   // 主机接口写响应ID
                .M_AXI_BRESP   (axi_full_bresp ),   // 写响应。这个信号指出写事物的状态
                .M_AXI_BVALID  (axi_full_bvalid),	 // 写响应有效。这个信号指出写响应通道的写响应信号有效
                .M_AXI_BREADY  (axi_full_bready),	 // 写响应准备。这个信号指出主机可以接受一次写响应

                //----------------------- AXI4读通道 -------------------------------//
                //读地址通道
                .M_AXI_ARID    (axi_full_arid   ),  // 主机读地址ID
                .M_AXI_ARADDR  (axi_full_araddr ),	 // 写地址。这个信号指出一次读突发传输事务的初始化地址
                .M_AXI_ARLEN   (axi_full_arlen  ),	 // 突发传输长度，突发长度给出了一次突发中准确的传输事务个数
                .M_AXI_ARSIZE  (axi_full_arsize ),	 // 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
                .M_AXI_ARBURST (axi_full_arburst),	 // 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
                .M_AXI_ARVALID (axi_full_arvalid),  // 读地址有效。这个信号指出这个读地址通道正在发送有效的写地址和写控制信息
                .M_AXI_ARREADY (axi_full_arready),  // 读地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号

                //读数据 (和响应) 通道
                .M_AXI_RID     (axi_full_rid    ),	 //读ID标签。这个信号是从机生成的读数据信号组的身份标签
                .M_AXI_RDATA   (axi_full_rdata  ),   //主机读数据
                .M_AXI_RRESP   (axi_full_rresp  ),   //读响应。这个信号指出读传输的状态（响应）
                .M_AXI_RLAST   (axi_full_rlast  ),	 //读last。这个信号指出一次读突发传输的最后一次传输
                .M_AXI_RVALID  (axi_full_rvalid ),	 //读有效。这个信号指出这个通道正给出需要的读数据
                .M_AXI_RREADY  (axi_full_rready ),	 //读准备。这个信号指出主机可以接收读数据和响应的信息


        /*************************************** AXI_LITE_S I/O口 **************************/
            // 用户可在此添加端口
            
            // 用户端口结束
            // 请勿修改此行之后的端口

            .S_AXI_ACLK    (clk          ),  //input  wire                                // 全局时钟信号
            .S_AXI_ARESETN (rst_n        ),  //input  wire                                // 全局复位信号，低有效

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


    //-------------------------------------- BRAM_and_DDR3模块 ------------------------------------//
        BRAM_and_DDR3 BRAM_and_DDR3(
        //-------------------------------------- 接口 ------------------------------------//
            .clk                        (clk                      ),
            .rst_n                      (rst_n                    ),

            .c0_ddr3_ui_clk             (c0_ddr3_ui_clk           ),
            .c0_ddr3_ui_clk_sync_rst_n  (c0_ddr3_ui_clk_sync_rst_n),

            .init_calib_complete        (init_calib_complete      ),    //ddr3初始化完成信号
            .axi_work_state             (axi_work_state           ),    //axi工作状态信号，由tb控制
        
        
        //-------------------------------------- AXI_FULL接口 ------------------------------------//
            .axi_awid    (axi_full_awid   ),
            .axi_awaddr  (axi_full_awaddr ),
            .axi_awlen   (axi_full_awlen  ),
            .axi_awsize  (axi_full_awsize ),
            .axi_awburst (axi_full_awburst),
            .axi_awvalid (axi_full_awvalid),
            .axi_awready (axi_full_awready),

            .axi_wdata   (axi_full_wdata  ),
            .axi_wstrb   (axi_full_wstrb  ),
            .axi_wlast   (axi_full_wlast  ),
            .axi_wvalid  (axi_full_wvalid ),
            .axi_wready  (axi_full_wready ),

            .axi_bid     (axi_full_bid    ),
            .axi_bresp   (axi_full_bresp  ),
            .axi_bvalid  (axi_full_bvalid ),
            .axi_bready  (axi_full_bready ),

            .axi_arid    (axi_full_arid   ),
            .axi_araddr  (axi_full_araddr ),
            .axi_arlen   (axi_full_arlen  ),
            .axi_arsize  (axi_full_arsize ),
            .axi_arburst (axi_full_arburst),
            .axi_arvalid (axi_full_arvalid),
            .axi_arready (axi_full_arready),

            .axi_rid     (axi_full_rid    ),
            .axi_rdata   (axi_full_rdata  ),
            .axi_rresp   (axi_full_rresp  ),
            .axi_rlast   (axi_full_rlast  ),
            .axi_rvalid  (axi_full_rvalid ),
            .axi_rready  (axi_full_rready )
        );


    //-------------------------------------- AXI_FULL_crtl_test模块 ------------------------------------//
        AXI_FULL_crtl_test AXI_FULL_crtl_test (
            .clk                      (clk                      ),
            .rst_n                    (rst_n                    ),

            .AXI_FULL_start           (AXI_FULL_start           ),  //指示AXI的测试状态机可以开始工作       //注意！！！！！！！！！该信号要由AXI_LITE来控制
            .the_last_matrix          (the_last_matrix          ),  //指示最后一个矩阵读完  
            // 主机的接口
            .AXI_FULL_test_effective  (AXI_FULL_test_effective  ),  //主机开始读取数据
            .READ_TXN_DONE            (READ_TXN_DONE            ),  //axi完成信号
            .WRITE_TXN_DONE           (WRITE_TXN_DONE           ),  //axi完成信号

            .init_calib_complete      (init_calib_complete      ),  //ddr3初始化完成信号

            .axi_work_state           (axi_work_state           ),  //axi工作状态

            .axi_ar_addr_temp         (axi_ar_addr_temp         ),

            // 测试用的输出接口
            .test_r_data              (test_r_data              ),
            .test_w_data              (test_w_data              ),
            .read_flag                (read_flag                ),  //标志axi正在读的信号
            .write_flag               (write_flag               ),  //标志axi正在写的信号
            .ar_effective             (ar_effective             )
        );


endmodule
