`timescale 1ns / 1ps

module test_start(
    input  wire clk,
    input  wire rst_n,
    input  wire start_test,

    output wire the_last_matrix
    );

/********************************* 参数 ***********************************/
  //------------------------------- 普通参数 ---------------------------//
    //AXI_LITE的参数
    parameter AXI_DATA_WIDTH      = 32;
    parameter AXI_LITE_ADDR_WIDTH =  4;

  //------------------------------- 本地参数 ---------------------------//


/********************************* 信号 ***********************************/
  //------------------------------- 寄存器型 ---------------------------//


  //------------------------------- 网表型 ---------------------------//
        //该信号为测试用，可删除
        wire tb_last_data_back;
        wire tb_write_flag;
        wire [127:0] tb_AXI_wdata;

        wire AXI_LITE_M_start;  //AXI_LITE_M用于接收总tb模块给出的开始测试信号的信号

    //AXI_LITE_M_crtl_test模块和AXI_LITE_M模块的连接
        wire axi_lite_effective;
        wire axi_lite_txn_done;
        wire axi_lite_error;


    //以下信号用于连接AXI_LITE_M模块以及TPU_crtl_tb模块中的axi_lite_s部分
        wire [AXI_LITE_ADDR_WIDTH-1 : 0]     axi_lite_awaddr;        
        wire [2 : 0]                         axi_lite_awprot;        
        wire                                 axi_lite_awvalid;       
        wire                                 axi_lite_awready;

        wire [AXI_DATA_WIDTH-1 : 0]          axi_lite_wdata;         
        wire [(AXI_DATA_WIDTH/8)-1 : 0]      axi_lite_wstrb;         
        wire                                 axi_lite_wvalid;        
        wire                                 axi_lite_wready;         

        wire [1 : 0]                         axi_lite_bresp;        
        wire                                 axi_lite_bvalid;        
        wire                                 axi_lite_bready;        

        wire [AXI_LITE_ADDR_WIDTH-1 : 0]     axi_lite_araddr;        
        wire [2 : 0]                         axi_lite_arprot;        
        wire                                 axi_lite_arvalid;        
        wire                                 axi_lite_arready;       
 
        wire [AXI_DATA_WIDTH-1 : 0]          axi_lite_rdata;        
        wire [1 : 0]                         axi_lite_rresp;        
        wire                                 axi_lite_rvalid;        
        wire                                 axi_lite_rready;        
    

/******************************** 组合逻辑 ********************************/
    //将总tb的开始测试信号与AXI_LITE_M相连
        assign AXI_LITE_M_start = start_test;


/********************************* 模块例化 ****************************/
    //-------------------------------------- TPU_crtl_tb模块 ------------------------------------//
        TPU_crtl_tb #(
        /*************************************** AXI_LITE参数 ****************************/
            .C_S_AXI_DATA_WIDTH   (AXI_DATA_WIDTH     ),   // S_AXI 数据总线宽度
            .C_S_AXI_ADDR_WIDTH   (AXI_LITE_ADDR_WIDTH)    // S_AXI 地址总线宽度，只需要2，因为只要1个寄存器，32bit，4个字节，需要2位宽的字节地址    
        ) TPU_crtl_tb (
        /*************************************** I/O口 **************************/
            .clk                  (clk                ),
            .rst_n                (rst_n              ),
            .the_last_matrix      (the_last_matrix    ),    //标志最后一个矩阵的传输完毕，由AXI_FULL_crtl_test发出

            .start_test           (start_test         ),        

            //该信号为测试用，可删除
            .tb_last_data_back    (tb_last_data_back  ),
            .tb_write_flag        (tb_write_flag      ),
            .tb_AXI_wdata         (tb_AXI_wdata       ),
        /*************************************** AXI_LITE I/O口 **************************/
            // 用户可在此添加端口

            // 用户端口结束

            //写通道
            .S_AXI_AWADDR  (axi_lite_awaddr ),  //input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]      // 写地址（由主机发出，被从机接收）
            .S_AXI_AWVALID (axi_lite_awvalid),  //input  wire                                 // 写地址有效。该信号指示主机正在传递有效的写地址和控制信息。
            .S_AXI_AWREADY (axi_lite_awready),  //output wire                                 // 写地址就绪。该信号指示从机已准备好接收地址及相关控制信号。
            .S_AXI_AWPROT  (axi_lite_awprot ),  //input  wire [2 : 0]                         // 写通道保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。

            .S_AXI_WDATA   (axi_lite_wdata  ),  //input  wire [C_S_AXI_DATA_WIDTH-1 : 0]      // 写数据（由主机发出，被从机接收） 
            .S_AXI_WSTRB   (axi_lite_wstrb  ),  //input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0]  // 写选通信号。该信号指示哪些字节通道包含有效数据。每8位数据总线对应一个写选通位。
            .S_AXI_WVALID  (axi_lite_wvalid ),  //input  wire                                 // 写有效。该信号指示有效的写数据和选通信号可用。
            .S_AXI_WREADY  (axi_lite_wready ),  //output wire                                 // 写就绪。该信号指示从机可以接收写数据。

            .S_AXI_BRESP   (axi_lite_bresp  ),  //output wire [1 : 0]                         // 写响应。该信号指示写事务的状态。
            .S_AXI_BVALID  (axi_lite_bvalid ),  //output wire                                 // 写响应有效。该信号指示通道正在传递有效的写响应。
            .S_AXI_BREADY  (axi_lite_bready ),  //input  wire                                 // 响应就绪。该信号指示主机可以接收写响应。
            
            //读通道
            .S_AXI_ARADDR  (axi_lite_araddr ),  //input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]      // 读地址（由主机发出，被从机接收）
            .S_AXI_ARVALID (axi_lite_arvalid),  //input  wire                                 // 读地址有效。该信号指示通道正在传递有效的读地址和控制信息。
            .S_AXI_ARREADY (axi_lite_arready),  //output wire                                 // 读地址就绪。该信号指示从机已准备好接收地址及相关控制信号。
            .S_AXI_ARPROT  (axi_lite_arprot ),  //input  wire [2 : 0]                         // 保护类型。该信号指示事务的特权和安全级别，以及该事务是数据访问还是指令访问。
            
            .S_AXI_RDATA   (axi_lite_rdata  ),  //output wire [C_S_AXI_DATA_WIDTH-1 : 0]      // 读数据（由从机发出）
            .S_AXI_RRESP   (axi_lite_rresp  ),  //output wire [1 : 0]                         // 读响应。该信号指示读传输的状态。
            .S_AXI_RVALID  (axi_lite_rvalid ),  //output wire                                 // 读有效。该信号指示通道正在传递所需的读数据。
            .S_AXI_RREADY  (axi_lite_rready )   //input  wire                                 // 读就绪。该信号指示主机可以接收读数据和响应信息。

        );


    //-------------------------------------- AXI_LITE_M模块 ------------------------------------//
        AXI_LITE_M #(
        /*************************************** 参数 ****************************/
            // 用户可在此添加参数

            // 用户参数结束
            // 请勿修改此行之后的参数

            .C_M_START_DATA_VALUE       (32'b1_01_01_01_01),  // 主机将从 C_M_START_DATA_VALUE 值开始生成数据
            .C_M_TARGET_SLAVE_BASE_ADDR (32'h00000000     ),  // 主机需要一个目标从机基地址。主机会在此参数指定的基地址上对从机发起读写事务。
            .C_M_AXI_ADDR_WIDTH         (32               ),  // M_AXI 地址总线宽度。主机生成的读写地址宽度由 C_M_AXI_ADDR_WIDTH 指定。
            .C_M_AXI_DATA_WIDTH         (AXI_DATA_WIDTH   ),  // M_AXI 数据总线宽度。主机发出写数据并接收读数据，数据总线宽度为 C_M_AXI_DATA_WIDTH
            .C_M_TRANSACTIONS_NUM       (18                )   // 事务数量是主机在此示例内存测试中将执行的写和读事务数量。
        ) AXI_LITE_M (
        /*************************************** IO口 ****************************/
            // 用户可在此添加端口

            // 用户端口结束
            // 请勿修改此行之后的端口

            .INIT_AXI_TXN       (AXI_LITE_M_start  ),      // 启动 AXI_LITE 事务
            .ERROR              (axi_lite_error    ),      // 检测到错误时置位，暂时不用
            .TXN_DONE           (axi_lite_txn_done ),      // AXI_LITE 事务完成时置位
            .M_AXI_ACLK         (clk               ),      // AXI_LITE 时钟信号
            .M_AXI_ARESETN      (rst_n             ),      // AXI_LITE 低有效复位信号

            //写通道
            .M_AXI_AWADDR       (axi_lite_awaddr ),      // 主接口写地址通道端口。写地址（由主机发出）
            .M_AXI_AWPROT       (axi_lite_awprot ),      // 写通道保护类型。此信号指示事务的特权和安全级别，以及事务是数据访问还是指令访问。
            .M_AXI_AWVALID      (axi_lite_awvalid),      // 写地址有效。
            .M_AXI_AWREADY      (axi_lite_awready),      // 写地址就绪。

            .M_AXI_WDATA        (axi_lite_wdata  ),       // 主接口写数据通道端口。写数据（由主机发出）
            .M_AXI_WSTRB        (axi_lite_wstrb  ),       // 写选通信号。
            .M_AXI_WVALID       (axi_lite_wvalid ),      // 写有效。此信号指示有有效的写数据和选通信号。
            .M_AXI_WREADY       (axi_lite_wready ),      // 写就绪。此信号指示从机可以接收写数据。

            .M_AXI_BRESP        (axi_lite_bresp  ),       // 主接口写响应通道端口。
            .M_AXI_BVALID       (axi_lite_bvalid ),      // 写响应有效。
            .M_AXI_BREADY       (axi_lite_bready ),      // 响应就绪。此信号指示主机可以接收写响应。

            //读通道
            .M_AXI_ARADDR       (axi_lite_araddr ),      // 主接口读地址通道端口。读地址（由主机发出）
            .M_AXI_ARPROT       (axi_lite_arprot ),      // 保护类型。此信号指示事务的特权和安全级别，以及事务是数据访问还是指令访问。
            .M_AXI_ARVALID      (axi_lite_arvalid),     // 读地址有效。
            .M_AXI_ARREADY      (axi_lite_arready),     // 读地址就绪。

            .M_AXI_RDATA        (axi_lite_rdata  ),       // 主接口读数据通道端口。读数据（由从机发出）
            .M_AXI_RRESP        (axi_lite_rresp  ),       // 读响应。此信号指示读传输的状态。
            .M_AXI_RVALID       (axi_lite_rvalid ),      // 读有效。此信号指示通道正在发出所需的读数据。
            .M_AXI_RREADY       (axi_lite_rready )       // 读就绪。此信号指示主机可以接收读数据和响应信息。
        );


    //-------------------------------------- 写回数据测试模块 ------------------------------------//
    data_back_tb data_back_tb(
    .clk               (clk              ),   //input 
    .rst_n             (rst_n            ),   //input 

    .tb_write_flag     (tb_write_flag    ),   //input 
    .tb_last_data_back (tb_last_data_back),   //input 

    .tb_AXI_wdata      (tb_AXI_wdata     )    //input [127:0] 
    );
endmodule
