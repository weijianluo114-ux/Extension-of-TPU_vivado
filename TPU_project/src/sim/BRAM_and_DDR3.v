`timescale 1ns / 1ps

/*************************************** 头文件引用 **************************/
  `include "top_parameter.vh"

/*************************************** 主模块 ******************************/
  module BRAM_and_DDR3 (
	//-------------------------------------- 接口 ------------------------------------//
        input        clk,
        input        rst_n,

        output       init_calib_complete,       //ddr3初始化完成信号
        input  [1:0] axi_work_state,            //axi工作状态信号，由tb控制

        output       c0_ddr3_ui_clk,            //ddr3控制的时钟
        output       c0_ddr3_ui_clk_sync_rst_n, //ddr3控制的复位

	//-------------------------------------- AXI_FULL接口 ------------------------------------//
        // 用户信号

        // 写地址
        input  wire [ 3 : 0]                axi_awid,
        input  wire [`AXI_ADDR_WIDTH-1 : 0] axi_awaddr,
        input  wire [ 7 : 0]                axi_awlen,
        input  wire [ 2 : 0]                axi_awsize,
        input  wire [ 1 : 0]                axi_awburst,
        input  wire                         axi_awvalid,
        output wire                         axi_awready,
        // 写数据
        input  wire [`AXI_DATA_WIDTH-1 : 0] axi_wdata,
        input  wire [`AXI_STRB-1 : 0]       axi_wstrb,
        input  wire                         axi_wlast,
        input  wire                         axi_wvalid,
        output wire                         axi_wready,
        // 写响应
        output wire [ 3 : 0]                axi_bid,
        output wire [ 1 : 0]                axi_bresp,
        output wire                         axi_bvalid,
        input  wire                         axi_bready,
        // 读地址
        input  wire [ 3 : 0]                axi_arid,
        input  wire [`AXI_ADDR_WIDTH-1 : 0] axi_araddr,
        input  wire [ 7 : 0]                axi_arlen,
        input  wire [ 2 : 0]                axi_arsize,
        input  wire [ 1 : 0]                axi_arburst,
        input  wire                         axi_arvalid,
        output wire                         axi_arready,
        // 读数据
        output wire [ 3 : 0]                axi_rid,
        output wire [`AXI_DATA_WIDTH-1 : 0] axi_rdata,
        output wire [ 1 : 0]                axi_rresp,
        output wire                         axi_rlast,
        output wire                         axi_rvalid,
        input  wire                         axi_rready
  );


/*************************************** 参数 ********************************/
	//-------------------------------------- 普通参数 ------------------------------------//

	//-------------------------------------- 本地参数 ------------------------------------//
    localparam AXI_IDLE               = 2'b00,    //axi空闲态，目前未知其用处未知
               AXI_LOAD_DATA_TO_DDR3  = 2'b01,    //axi的读写操作状态，此时为从bram读取数据并载入数据至ddr3
               AXI_COMPUTE            = 2'b10;    //axi的计算操作状态，此时开始从ddr3中读取数据至TPU


/*************************************** 信号 ********************************/
  //-------------------------------- 测试模块的信号 --------------------------//

  //---------------------------- bram从机s_axi信号 --------------------------//
    wire                         s_aclk;       
    wire                         s_aresetn;    

    // 写地址通道
    wire [3 : 0]                 s_axi_awid;   
    wire [31 : 0]                s_axi_awaddr; 
    wire [7 : 0]                 s_axi_awlen;  
    wire [2 : 0]                 s_axi_awsize; 
    wire [1 : 0]                 s_axi_awburst;
    wire                         s_axi_awvalid;
    wire                         s_axi_awready;

    //写数据通
    wire [`AXI_DATA_WIDTH-1 : 0] s_axi_wdata; 
    wire [`AXI_STRB-1 : 0]       s_axi_wstrb; 
    wire                         s_axi_wlast; 
    wire                         s_axi_wvalid;
    wire                         s_axi_wready;
    //写响应 (B) 通
    wire [3 : 0]                 s_axi_bid;   
    wire [1 : 0]                 s_axi_bresp; 
    wire                         s_axi_bvalid;
    wire                         s_axi_bready;

    // 读地址通
    wire [3 : 0]                 s_axi_arid;   
    wire [31 : 0]                s_axi_araddr; 
    wire [7 : 0]                 s_axi_arlen;  
    wire [2 : 0]                 s_axi_arsize; 
    wire [1 : 0]                 s_axi_arburst;
    wire                         s_axi_arvalid;
    wire                         s_axi_arready;
    
    //读数据 (和响应) 通道
    wire [3 : 0]                 s_axi_rid;   
    wire [`AXI_DATA_WIDTH-1 : 0] s_axi_rdata; 
    wire [1 : 0]                 s_axi_rresp; 
    wire                         s_axi_rlast; 
    wire                         s_axi_rvalid;
    wire                         s_axi_rready;


  //---------------------------- ddr3从机s_axi信号 --------------------------//
    // 写地址通道
    wire [3:0]                  c0_ddr3_s_axi_awid;   
    wire [`AXI_ADDR_WIDTH-1:0]  c0_ddr3_s_axi_awaddr; 
    wire [7:0]                  c0_ddr3_s_axi_awlen;  
    wire [2:0]                  c0_ddr3_s_axi_awsize; 
    wire [1:0]                  c0_ddr3_s_axi_awburst;
    wire                        c0_ddr3_s_axi_awvalid;
    wire                        c0_ddr3_s_axi_awready;

    // 写数据通道
    wire [`AXI_DATA_WIDTH-1:0]  c0_ddr3_s_axi_wdata; 
    wire [`AXI_STRB-1:0]        c0_ddr3_s_axi_wstrb; 
    wire                        c0_ddr3_s_axi_wlast; 
    wire                        c0_ddr3_s_axi_wvalid;
    wire                        c0_ddr3_s_axi_wready;

    // 写响应通道
    wire [3:0]                  c0_ddr3_s_axi_bid;   
    wire [1:0]                  c0_ddr3_s_axi_bresp; 
    wire                        c0_ddr3_s_axi_bvalid;
    wire                        c0_ddr3_s_axi_bready;

    // 读地址通道
    wire [3:0]                  c0_ddr3_s_axi_arid;   
    wire [`AXI_ADDR_WIDTH-1:0]  c0_ddr3_s_axi_araddr; 
    wire [7:0]                  c0_ddr3_s_axi_arlen;  
    wire [2:0]                  c0_ddr3_s_axi_arsize; 
    wire [1:0]                  c0_ddr3_s_axi_arburst;
    wire                        c0_ddr3_s_axi_arvalid;
    wire                        c0_ddr3_s_axi_arready;

    // 读数据通道
    wire [3:0]                  c0_ddr3_s_axi_rid;   
    wire [`AXI_DATA_WIDTH-1:0]  c0_ddr3_s_axi_rdata; 
    wire [1:0]                  c0_ddr3_s_axi_rresp; 
    wire                        c0_ddr3_s_axi_rlast; 
    wire                        c0_ddr3_s_axi_rvalid;
    wire                        c0_ddr3_s_axi_rready;


  //------------------------------ ddr3仿真物理接口信号 --------------------------//
    wire          c0_init_calib_complete;      //ddr初始化完毕的信号

    // 地址/控制信号组
    wire [14:0]   c0_ddr3_addr;                // [14:0] 行/列地址，自动映射到DDR3芯片引脚
    wire [2: 0]   c0_ddr3_ba;                  // [2:0]  Bank地址，位宽由芯片Bank数决定（3位=8 Banks）
    wire          c0_ddr3_cas_n;               // CAS#（列地址选通，低有效）
    wire          c0_ddr3_ras_n;               // RAS#（行地址选通，低有效）
    wire          c0_ddr3_we_n;                // WE#（写使能，低有效）

    // 时钟/使能/片选
    wire [0: 0]   c0_ddr3_cke;                 // [0:0]  时钟使能信号，通常固定使能
    wire [0: 0]   c0_ddr3_ck_n;                // [0:0]  DDR3差分时钟负端，需连接芯片CK#引脚
    wire [0: 0]   c0_ddr3_ck_p;                // [0:0]  DDR3差分时钟正端，需连接芯片CK引脚
    wire [0: 0]   c0_ddr3_cs_n;                // [0:0]  片选信号（低有效），单Rank时通常固定为低

    // 数据/掩码/数据选通
    wire [1: 0]   c0_ddr3_dm;                  // [1:0]  数据掩码（写操作时屏蔽字节）
    wire [15:0]   c0_ddr3_dq;                  // [15:0] 双向数据总线，位宽需与芯片x8/x16配置匹配
    wire [1: 0]   c0_ddr3_dqs_n;               // [1:0]  差分数据选通负端，需约束与DQ的PCB时序关系
    wire [1: 0]   c0_ddr3_dqs_p;               // [1:0]  差分数据选通正端
            
    // 其他控制信号
    wire          c0_ddr3_reset_n;             // DDR3芯片复位（低有效），初始化后自动释放
    wire [0: 0]   c0_ddr3_odt;                 // [0:0]  片上终端电阻使能，由控制器自动管理


/*************************************** 组合逻辑 ****************************/
  //-------------------------------- 测试 --------------------------//

  //-------------------------------- 控制 --------------------------//
    assign c0_ddr3_ui_clk_sync_rst_n = ~c0_ddr3_ui_clk_sync_rst;


  //以下逻辑用于选择是否初始化ddr3，若初始化则把bram的存储数据存进ddr3（即把读部分信号连接至bram，
  //写部分信号连接至ddr3，实现从bram读，并把数据写入ddr3），否则将所有信号连接至ddr3，正常读写ddr3
  //-------------------------------- bram模块 --------------------------//
    assign s_aclk        = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_ui_clk         :0;       
    assign s_aresetn     = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_ui_clk_sync_rst_n:0;

    //axi写通道
    // 读地址通道
    assign s_axi_awid    = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_awid;   
    assign s_axi_awaddr  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_awaddr; 
    assign s_axi_awlen   = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_awlen;  
    assign s_axi_awsize  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_awsize; 
    assign s_axi_awburst = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_awburst;
    assign s_axi_awvalid = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_awvalid;

    // 写数据通道
    assign s_axi_wdata  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_wdata; 
    assign s_axi_wstrb  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_wstrb; 
    assign s_axi_wlast  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_wlast; 
    assign s_axi_wvalid = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_wvalid;

    // 写响应通道
    assign s_axi_bready = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_bready;

    //axi读通道
    // 读地址通道
    assign s_axi_arid    = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_arid      : 'b0;  // input    
    assign s_axi_araddr  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_araddr    : 'b0;  // input  
    assign s_axi_arlen   = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_arlen     : 'b0;  // input   
    assign s_axi_arsize  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_arsize    : 'b0;  // input  
    assign s_axi_arburst = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_arburst   : 'b0;  // input 
    assign s_axi_arvalid = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_arvalid   : 'b0;  // input


    //读数据 (和响应) 通道
    assign s_axi_rready  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_rready    : 'b0;  // input 


  //-------------------------------- ddr3模块 --------------------------//
    assign init_calib_complete   = c0_init_calib_complete;     //ddr3初始化完成信号

    // 写地址通道
    assign c0_ddr3_s_axi_awid    =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_awid    : 'b0;     // input  
    assign c0_ddr3_s_axi_awaddr  =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_awaddr  : 'b0;     // input 
    assign c0_ddr3_s_axi_awlen   =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_awlen   : 'b0;     // input 
    assign c0_ddr3_s_axi_awsize  =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_awsize  : 'b0;     // input 
    assign c0_ddr3_s_axi_awburst =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_awburst : 'b0;     // input 
    assign c0_ddr3_s_axi_awvalid =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_awvalid : 'b0;     // input 


    // 写数据通道
    assign c0_ddr3_s_axi_wdata   =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_wdata   : 'b0;     // input 
    assign c0_ddr3_s_axi_wstrb   =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_wstrb   : 'b0;     // input 
    assign c0_ddr3_s_axi_wlast   =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_wlast   : 'b0;     // input 
    assign c0_ddr3_s_axi_wvalid  =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_wvalid  : 'b0;     // input 



    assign c0_ddr3_s_axi_bready  =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? axi_bready  : 'b0;     // input 

    // 读地址通道
    assign c0_ddr3_s_axi_arid    = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_arid   ;      // input 
    assign c0_ddr3_s_axi_araddr  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_araddr ;      // input 
    assign c0_ddr3_s_axi_arlen   = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_arlen  ;      // input 
    assign c0_ddr3_s_axi_arsize  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_arsize ;      // input 
    assign c0_ddr3_s_axi_arburst = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_arburst;      // input 
    assign c0_ddr3_s_axi_arvalid = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_arvalid;      // input

    // 读数据通道  
    assign c0_ddr3_s_axi_rready  = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? 'b0 : axi_rready; // input 


  //-------------------------------- 共用的信号端口 --------------------------//
    // 由于axi的信号也会在写通道共享，故应该单独控制
    assign axi_awready           =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_s_axi_awready : s_axi_awready; // output

    // 写数据通道
    assign axi_wready            =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_s_axi_wready : s_axi_wready;   // output

    // 写响应通道
    assign axi_bid               =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_s_axi_bid    : s_axi_bid;      // output
    assign axi_bresp             =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_s_axi_bresp  : s_axi_bresp;    // output
    assign axi_bvalid            =  (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? c0_ddr3_s_axi_bvalid : s_axi_bvalid;   // output


    // 由于axi的信号会在读通道共享，故应该单独控制
    //读地址准备
    assign axi_arready           = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? s_axi_arready : c0_ddr3_s_axi_arready;  // output

    //读数据部分信号
    assign axi_rid               = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? s_axi_rid     : c0_ddr3_s_axi_rid   ;   // output   
    assign axi_rdata             = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? s_axi_rdata   : c0_ddr3_s_axi_rdata ;   // output 
    assign axi_rresp             = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? s_axi_rresp   : c0_ddr3_s_axi_rresp ;   // output 
    assign axi_rlast             = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? s_axi_rlast   : c0_ddr3_s_axi_rlast ;   // output 
    assign axi_rvalid            = (axi_work_state == AXI_LOAD_DATA_TO_DDR3) ? s_axi_rvalid  : c0_ddr3_s_axi_rvalid;   // output


/*************************************** 时序逻辑 ****************************/


/*************************************** 模块例化 ****************************/
  //-------------------------------- 存储数据集和发送数据bram模块 --------------------------//
    //该模块是用来初始化存储数据集的，用coe初始化数据集
    blk_mem_gen_0 blk_mem_gen_0 (
        .s_aclk              (clk          ),     // input wire s_aclk
        .s_aresetn           (s_aresetn||rst_n),     // input wire s_aresetn

        //----------------------- AXI4写通道 -------------------------------//
        // 写地址通道
        .s_axi_awid          (s_axi_awid      ),     // input wire [3 : 0] s_axi_awid
        .s_axi_awaddr        (s_axi_awaddr    ),     // input wire [31 : 0] s_axi_awaddr
        .s_axi_awlen         (s_axi_awlen     ),     // input wire [7 : 0] s_axi_awlen
        .s_axi_awsize        (s_axi_awsize    ),     // input wire [2 : 0] s_axi_awsize
        .s_axi_awburst       (s_axi_awburst   ),     // input wire [1 : 0] s_axi_awburst
        .s_axi_awvalid       (s_axi_awvalid   ),     // input wire s_axi_awvalid
        .s_axi_awready       (s_axi_awready   ),     // output wire s_axi_awready
        //写数据通道
        .s_axi_wdata         (s_axi_wdata     ),      // input wire [127 : 0] s_axi_wdata
        .s_axi_wstrb         (s_axi_wstrb     ),      // input wire [15 : 0] s_axi_wstrb
        .s_axi_wlast         (s_axi_wlast     ),      // input wire s_axi_wlast
        .s_axi_wvalid        (s_axi_wvalid    ),      // input wire s_axi_wvalid
        .s_axi_wready        (s_axi_wready    ),      // output wire s_axi_wready
        //写响应 (B) 通道
        .s_axi_bid           (s_axi_bid       ),      // output wire [3 : 0] s_axi_bid
        .s_axi_bresp         (s_axi_bresp     ),      // output wire [1 : 0] s_axi_bresp
        .s_axi_bvalid        (s_axi_bvalid    ),      // output wire s_axi_bvalid
        .s_axi_bready        (s_axi_bready    ),      // input wire s_axi_bready

        //----------------------- AXI4读通道 -------------------------------//
        // 读地址通道
        .s_axi_arid          (s_axi_arid      ),     // input wire [3 : 0] s_axi_arid
        .s_axi_araddr        (s_axi_araddr    ),     // input wire [31 : 0] s_axi_araddr
        .s_axi_arlen         (s_axi_arlen     ),     // input wire [7 : 0] s_axi_arlen
        .s_axi_arsize        (s_axi_arsize    ),     // input wire [2 : 0] s_axi_arsize
        .s_axi_arburst       (s_axi_arburst   ),     // input wire [1 : 0] s_axi_arburst
        .s_axi_arvalid       (s_axi_arvalid   ),     // input wire s_axi_arvalid
        .s_axi_arready       (s_axi_arready   ),     // output wire s_axi_arready

        //读数据 (和响应) 通道
        .s_axi_rid           (s_axi_rid       ),      // output wire [3 : 0] s_axi_rid
        .s_axi_rdata         (s_axi_rdata     ),      // output wire [127 : 0] s_axi_rdata
        .s_axi_rresp         (s_axi_rresp     ),      // output wire [1 : 0] s_axi_rresp
        .s_axi_rlast         (s_axi_rlast     ),      // output wire s_axi_rlast
        .s_axi_rvalid        (s_axi_rvalid    ),      // output wire s_axi_rvalid
        .s_axi_rready        (s_axi_rready    )       // input wire s_axi_rready
      );


  //-------------------------------- ddr3模块 --------------------------//
    //该ddr3是用来存储数据集的，包括ddr3物理仿真模型和mig控制模块
    //_______________________ ddr3控制器(mig) ____________________//
    ddr3_0 ddr3_controler (
      //----------------------- 初始化与状态监控 --------------------------//
      .c0_init_calib_complete (c0_init_calib_complete ),          // output [初始化完成标志] 高电平表示DDR3校准完成，用户逻辑需检测此信号后再操作

      //----------------------- 调试接口 --------------------------------//
      .dbg_clk                (                       ),          // output [调试时钟] 用于连接ILA或其他调试工具
      .dbg_bus                (dbg_bus                ),          // output [511:0][调试总线] 输出控制器内部状态信号（如校准阶段、时序参数）

      //----------------------- 系统时钟 ------------------------//
      .c0_sys_clk_i           (clk                    ),          // input  系统时钟

                                      
      //----------------------- DDR3物理接口信号 -------------------------//
      // 地址/控制信号组
      .c0_ddr3_addr           (c0_ddr3_addr           ),          // output [14:0] 行/列地址，自动映射到DDR3芯片引脚
      .c0_ddr3_ba             (c0_ddr3_ba             ),          // output [2:0]  Bank地址，位宽由芯片Bank数决定（3位=8 Banks）
      .c0_ddr3_cas_n          (c0_ddr3_cas_n          ),          // output        CAS#（列地址选通，低有效）
      .c0_ddr3_ras_n          (c0_ddr3_ras_n          ),          // output        RAS#（行地址选通，低有效）
      .c0_ddr3_we_n           (c0_ddr3_we_n           ),          // output        WE#（写使能，低有效）

      // 时钟/使能/片选
      .c0_ddr3_cke            (c0_ddr3_cke            ),          // output [0:0]  时钟使能信号，通常固定使能
      .c0_ddr3_ck_n           (c0_ddr3_ck_n           ),          // output [0:0]  DDR3差分时钟负端，需连接芯片CK#引脚
      .c0_ddr3_ck_p           (c0_ddr3_ck_p           ),          // output [0:0]  DDR3差分时钟正端，需连接芯片CK引脚
      .c0_ddr3_cs_n           (c0_ddr3_cs_n           ),          // output [0:0]  片选信号（低有效），单Rank时通常固定为低

      // 数据/掩码/数据选通
      .c0_ddr3_dm             (c0_ddr3_dm             ),          // output [1:0]  数据掩码（写操作时屏蔽字节）
      .c0_ddr3_dq             (c0_ddr3_dq             ),          // inout  [15:0] 双向数据总线，位宽需与芯片x8/x16配置匹配
      .c0_ddr3_dqs_n          (c0_ddr3_dqs_n          ),          // inout  [1:0]  差分数据选通负端，需约束与DQ的PCB时序关系
      .c0_ddr3_dqs_p          (c0_ddr3_dqs_p          ),          // inout  [1:0]  差分数据选通正端

      // 其他控制信号
      .c0_ddr3_odt            (c0_ddr3_odt            ),          // output [0:0]  片上终端电阻使能，由控制器自动管理
      .c0_ddr3_reset_n        (c0_ddr3_reset_n        ),          // output        DDR3芯片复位（低有效），初始化后自动释放

      //----------------------- 用户接口时钟与复位 ------------------------//
      .c0_ddr3_ui_clk         (c0_ddr3_ui_clk            ),          // output [用户接口时钟] AXI操作需同步到此时钟（如200MHz）
      .c0_ddr3_ui_clk_sync_rst(c0_ddr3_ui_clk_sync_rst   ),          // output [用户接口同步复位] 高电平时AXI总线不可操作
      .c0_ddr3_aresetn        (rst_n                     ),          // input  [异步复位] 低电平复位整个控制器，通常连接系统复位

      //----------------------- AXI4通道 -------------------------------//
      //----------------------- AXI4写通道 -------------------------------//
      // 写地址通道
      .c0_ddr3_s_axi_awid     (c0_ddr3_s_axi_awid     ),          // input  [3:0]  写事务ID，用于多主设备区分（未使用时置0）
      .c0_ddr3_s_axi_awaddr   (c0_ddr3_s_axi_awaddr   ),          // input  [28:0] 写地址（字节地址，需按数据宽度对齐，如64位对齐最低3位为0）
      .c0_ddr3_s_axi_awlen    (c0_ddr3_s_axi_awlen    ),          // input  [7:0]  突发长度（实际长度=awlen+1，最大支持255）
      .c0_ddr3_s_axi_awsize   (c0_ddr3_s_axi_awsize   ),          // input  [2:0]  每次传输字节数（如3'b011表示8字节，需与数据位宽匹配）
      .c0_ddr3_s_axi_awburst  (c0_ddr3_s_axi_awburst  ),          // input  [1:0]  突发类型：00-固定地址，01-递增，10-回环
      .c0_ddr3_s_axi_awvalid  (c0_ddr3_s_axi_awvalid  ),          // input        写地址有效，需与awready握手
      .c0_ddr3_s_axi_awready  (c0_ddr3_s_axi_awready  ),          // output       写地址就绪，由控制器驱动

      // 写数据通道
      .c0_ddr3_s_axi_wdata    (c0_ddr3_s_axi_wdata    ),          // input  [127:0] 写入数据，位宽需与IP核配置一致
      .c0_ddr3_s_axi_wstrb    (c0_ddr3_s_axi_wstrb    ),          // input  [15:0]  字节使能（1表示对应字节有效）
      .c0_ddr3_s_axi_wlast    (c0_ddr3_s_axi_wlast    ),          // input        突发传输最后一个数据标志
      .c0_ddr3_s_axi_wvalid   (c0_ddr3_s_axi_wvalid   ),          // input        写数据有效，需与wready握手
      .c0_ddr3_s_axi_wready   (c0_ddr3_s_axi_wready   ),          // output       写数据就绪，由控制器驱动

      // 写响应通道
      .c0_ddr3_s_axi_bid      (c0_ddr3_s_axi_bid      ),          // output [3:0] 写事务ID回传
      .c0_ddr3_s_axi_bresp    (c0_ddr3_s_axi_bresp    ),          // output [1:0] 写响应状态（00-成功，其他为错误码）
      .c0_ddr3_s_axi_bvalid   (c0_ddr3_s_axi_bvalid   ),          // output       写响应有效，需与bready握手
      .c0_ddr3_s_axi_bready   (c0_ddr3_s_axi_bready   ),          // input        写响应就绪，用户需接收响应

      //----------------------- AXI4读通道 -------------------------------//
      // 读地址通道
      .c0_ddr3_s_axi_arid     (c0_ddr3_s_axi_arid     ),           // input  [3:0]  读事务ID，用法同写通道
      .c0_ddr3_s_axi_araddr   (c0_ddr3_s_axi_araddr   ),           // input  [28:0] 读地址（对齐要求同写地址）
      .c0_ddr3_s_axi_arlen    (c0_ddr3_s_axi_arlen    ),           // input  [7:0]  突发长度
      .c0_ddr3_s_axi_arsize   (c0_ddr3_s_axi_arsize   ),           // input  [2:0]  传输字节数
      .c0_ddr3_s_axi_arburst  (c0_ddr3_s_axi_arburst  ),           // input  [1:0]  突发类型
      .c0_ddr3_s_axi_arvalid  (c0_ddr3_s_axi_arvalid  ),           // input        读地址有效
      .c0_ddr3_s_axi_arready  (c0_ddr3_s_axi_arready  ),           // output       读地址就绪

      // 读数据通道
      .c0_ddr3_s_axi_rid      (c0_ddr3_s_axi_rid      ),           // output [3:0] 读事务ID回传
      .c0_ddr3_s_axi_rdata    (c0_ddr3_s_axi_rdata    ),           // output [127:0]读出数据
      .c0_ddr3_s_axi_rresp    (c0_ddr3_s_axi_rresp    ),           // output [1:0] 读响应状态
      .c0_ddr3_s_axi_rlast    (c0_ddr3_s_axi_rlast    ),           // output       突发传输最后一个数据标志
      .c0_ddr3_s_axi_rvalid   (c0_ddr3_s_axi_rvalid   ),           // output       读数据有效
      .c0_ddr3_s_axi_rready   (c0_ddr3_s_axi_rready   ),           // input        读数据就绪，用户需接收数据

      //----------------------- 全局系统复位 -----------------------------//
      .sys_rst                (~rst_n                 )            // input  [系统复位] 高电平有效，初始化阶段需保持足够时间
    );

    //_______________________ ddr3物理仿真模型 ____________________//
    ddr3_model ddr3_model(
        .rst_n       (c0_ddr3_reset_n),
        .ck          (c0_ddr3_ck_p   ),
        .ck_n        (c0_ddr3_ck_n   ),
        .cke         (c0_ddr3_cke    ),
        .cs_n        (c0_ddr3_cs_n   ),
        .ras_n       (c0_ddr3_ras_n  ),
        .cas_n       (c0_ddr3_cas_n  ),
        .we_n        (c0_ddr3_we_n   ),
        .dm_tdqs     (c0_ddr3_dm     ),
        .ba          (c0_ddr3_ba     ),
        .addr        (c0_ddr3_addr   ),
        .dq          (c0_ddr3_dq     ),
        .dqs         (c0_ddr3_dqs_p  ),
        .dqs_n       (c0_ddr3_dqs_n  ),
        .tdqs_n      (               ),
        .odt         (c0_ddr3_odt    )
    );


  
endmodule
