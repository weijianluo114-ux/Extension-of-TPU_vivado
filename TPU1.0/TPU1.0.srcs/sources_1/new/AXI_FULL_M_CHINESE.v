`timescale 1ns / 1ps
////////////////////////////////////创建文件信息/////////////////////////////////////
	// Company: 
	// Engineer: 
	// 
	// Create Date: 2025/03/04 22:26:32
	// Design Name: 
	// Module Name: AXI_FULL_M_CHINESE
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

module AXI_FULL_M_CHINESE #
	(
		// 用户在此处添加变量
		parameter DDR3_DATA_BACK_BASE_ADDR	    = 32'h10000000,     // 写回数据时目标从机的基址

		// 用户的变量结束处
		// 不要修改这一行下面的参数

		parameter C_M_TARGET_SLAVE_BASE_ADDR	= 32'h00000000,     // 目标从机的基址
		parameter integer C_M_AXI_BURST_LEN	    = 4,                // 突发长度。支持1，2，4，8，16，32，64，128，256的突发长度
		parameter integer C_M_AXI_ID_WIDTH  	= 4,                // Thread ID Width（线程ID宽度）
		parameter integer C_M_AXI_ADDR_WIDTH	= 29,               // 地址总线宽度
		parameter integer C_M_AXI_DATA_WIDTH	= 128,              // 数据总线宽度
		
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,                // 用户写地址总线的宽度
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,                // 用户读地址总线的宽度
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,                // 用户写数据总线宽度
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,                // 用户读数据总线的宽度
		parameter integer C_M_AXI_BUSER_WIDTH	= 0                 // 用户响应总线的宽度
	)
	(
		// 用户可以在这里添加端口

		//-------------------------- 输入信号 --------------------------//
		input [1:0]									 axi_work_state, 			//axi工作状态指示

		input 										 AXI_FULL_rstop,			//暂停读
		input 										 AXI_FULL_wstop,			//暂停写

		input [127:0]								 AXI_wdata,					//由计算得到的写数据	

		//-------------------------- 输出信号 --------------------------//
		output 										 read_flag,		   //读有效
		output 										 write_flag,	   //写有效

		output 									     ar_effective,	   //该信号用于指示读地址准备和读地址同时有效

		// 用户端口终止处

		// 不要修改这行以外的端口
		input   wire                                 INIT_AXI_READ_TXN, // 启动AXI传输事务
		input   wire                                 INIT_AXI_WRITE_TXN,// 启动AXI写传输事务

		output  wire                                 READ_TXN_DONE, 	// 当传输完成时有效
		output  wire                                 WRITE_TXN_DONE,	// 当传输完成时有效

		input   wire                                 M_AXI_ACLK,    	// 全局时钟信号
		input   wire                                 M_AXI_ARESETN, 	// 全局复位信号。这个信号低电平有效

	    //写地址通道
		output  wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_AWID,    	// 主机接口写地址ID
		output  wire [C_M_AXI_ADDR_WIDTH-1 : 0]      M_AXI_AWADDR,  	// 主机接口写地址
		output  wire [7 : 0]                         M_AXI_AWLEN,   	// 突发传输长度。突发长度给出了一次突发中准确的传输事务个数
		output  wire [2 : 0]                         M_AXI_AWSIZE,  	// 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
		output  wire [1 : 0]                         M_AXI_AWBURST, 	// 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
		output  wire                                 M_AXI_AWLOCK,  	// LOCK模式。提供关于原子（atomic）特性传输的额外的信息
		output  wire [3 : 0]                         M_AXI_AWCACHE, 	// Memory类型。这个信号指出传输事务应该要在系统里面如何进行进程
		output  wire [2 : 0]                         M_AXI_AWPROT,  	// Protection类型。这个信号指出这次传输的特权和安全级别，以及该事务是否是数据访问还是指令访问。
		output  wire [3 : 0]                         M_AXI_AWQOS,   	// 服务质量，这个东西在每一次写事物的时候发送
		output  wire [C_M_AXI_AWUSER_WIDTH-1 : 0]    M_AXI_AWUSER,		// 可选，写地址通道用户自定义的信号
		output  wire                                 M_AXI_AWVALID,		// 写地址有效。这个信号指出这个写地址通道正在发送有效的写地址和写控制信息
		input   wire                                 M_AXI_AWREADY,		// 写地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号
        
	    //写数据通道
		output  wire [C_M_AXI_DATA_WIDTH-1 : 0]      M_AXI_WDATA,		// 主机接口写数据
		output  wire [C_M_AXI_DATA_WIDTH/8-1 : 0]    M_AXI_WSTRB,		// Write strobes（写掩码）.这个信号指出哪一个字节通道有有效的数据。在写数据总线1比特的写掩码控制8比特的数据
		output  wire                                 M_AXI_WLAST,		// 写last。这个信号指出在一次写突发传输的最后一位
		output  wire [C_M_AXI_WUSER_WIDTH-1 : 0]     M_AXI_WUSER,		// 可选。写数据通道中用户自定义的信号
		output  wire                                 M_AXI_WVALID,		// 写数据有效。这个信号指出有效的写数据和写掩码是可获得的
		input   wire                                 M_AXI_WREADY,		// 写数据准备。这个信号指出从机可以接收写数据

        //写响应 (B) 通道
		input   wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_BID,			// 主机接口写响应ID
		input   wire [1 : 0] 						 M_AXI_BRESP,		// 写响应。这个信号指出写事物的状态
		input   wire [C_M_AXI_BUSER_WIDTH-1 : 0]     M_AXI_BUSER,		// 可选。写响应通道里的用户自定义信号
		input   wire                                 M_AXI_BVALID,		// 写响应有效。这个信号指出写响应通道的写响应信号有效
		output  wire                                 M_AXI_BREADY,		// 写响应准备。这个信号指出主机可以接受一次写响应

        //读地址通道
		output  wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_ARID,		// 主机读地址ID
		output  wire [C_M_AXI_ADDR_WIDTH-1 : 0]      M_AXI_ARADDR,		// 写地址。这个信号指出一次读突发传输事务的初始化地址
		output  wire [7 : 0]                         M_AXI_ARLEN,		// 突发传输长度，突发长度给出了一次突发中准确的传输事务个数
		output  wire [2 : 0]                         M_AXI_ARSIZE,		// 突发传输大小。这个信号指出突发传输中每一个传输的字节大小
		output  wire [1 : 0]                         M_AXI_ARBURST,		// 突发传输种类。突发传输种类和大小信息，确定计算突发传输内每个传输的地址的方法。
		output  wire                                 M_AXI_ARLOCK,		// LOCK模式。提供关于原子（atomic）特性传输的额外的信息
		output  wire [3 : 0]                         M_AXI_ARCACHE,		// Memory类型。这个信号指出传输事务应该要在系统里面如何进行进程
		output  wire [2 : 0]                         M_AXI_ARPROT,  	// Protection类型。这个信号指出这次传输的特权和安全级别，以及该事务是否是
		output  wire [3 : 0]                         M_AXI_ARQOS,   	// 服务质量，这个东西在每一次写事物的时候发送
		output  wire [C_M_AXI_ARUSER_WIDTH-1 : 0]    M_AXI_ARUSER,  	// 可选，读地址通道用户自定义的信号
		output  wire                                 M_AXI_ARVALID, 	// 读地址有效。这个信号指出这个读地址通道正在发送有效的写地址和写控制信息
		input   wire                                 M_AXI_ARREADY, 	// 读地址准备。这个信号指出从机已经准备好接受地址和相关的控制信号

        //读数据 (和响应) 通道
		input   wire [C_M_AXI_ID_WIDTH-1 : 0]        M_AXI_RID,			//读ID标签。这个信号是从机生成的读数据信号组的身份标签
		input   wire [C_M_AXI_DATA_WIDTH-1 : 0]      M_AXI_RDATA,		//主机读数据
		input   wire [1 : 0]                         M_AXI_RRESP,		//读响应。这个信号指出读传输的状态（响应）
		input   wire                                 M_AXI_RLAST,		//读last。这个信号指出一次读突发传输的最后一次传输
		input   wire [C_M_AXI_RUSER_WIDTH-1 : 0]     M_AXI_RUSER,		//可选。读地址通道用户自选的信号
		input   wire                                 M_AXI_RVALID,		//读有效。这个信号指出这个通道正给出需要的读数据
		output  wire                                 M_AXI_RREADY		//读准备。这个信号指出主机可以接收读数据和响应的信息
	);


/****************************************** axi内部函数 *****************************************/
	 // 函数clogb2返回一个整数，该整数具有log以2为底的上限的值。实现方法是将一个二进制数一直右移，
	 // 然后看这个数是否到0，没到0就继续右移，直至将所有的1移出，得到这个数是其非0位数                 
	//   function integer clogb2 (input integer bit_depth);              
	//   begin                                                           
	//     for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	//       bit_depth = bit_depth >> 1;                                 
	//     end                                                           
	//   endfunction      

	//chat改过的函数，可以减少warnings
	function integer clogb2 (input integer bit_depth);              
	integer tmp;
	begin                                                           
		tmp = bit_depth;
		for (clogb2 = 0; tmp > 0; clogb2 = clogb2 + 1) tmp = tmp >> 1;                                             
	end                                                             
	endfunction
                                               

/****************************************** 用户参数 ********************************************/
	//-------------------------------------- 普通参数 ------------------------------------//


	//-------------------------------------- 本地参数 ------------------------------------//
	  localparam [1:0] AXI_IDLE               = 2'b00,    //axi空闲态，目前未知其用处未知
             	 	   AXI_LOAD_DATA_TO_DDR3  = 2'b01,    //axi的读写操作状态，此时为从bram读取数据并载入数据至ddr3
             	       AXI_COMPUTE            = 2'b10;    //axi的计算操作状态，此时开始从ddr3中读取数据至TPU


/****************************************** axi内部参数 *****************************************/
	//-------------------------------------- 普通参数 ------------------------------------//
		

	//-------------------------------------- 本地参数 ------------------------------------//
		// 读和写状态机的状态
		// 用于初始化计数器、初始化写事务、初始化读事务，并将读取的数据与写入的数据进行比较的状态机示例。
		//读状态机状态
		localparam [1:0] READ_IDLE            = 2'b00, // 当 INIT_AXI_READ_TXN 从 0 变为 1 时，此状态开始 AXI4Lite 事务，并将状态机状态更改为 INIT_WRITE
						 READ_DATA_TODDR_INIT = 2'b01, // 此状态为初始化读bram至ddr3操作，操作完成后，状态机状态更改为READ_INIT_DONE
						 READ_COMPUTE_DATA	  = 2'b10, // 此状态为初始化读ddr3数据操作，操作完成后，状态机状态更改为READ_INIT_DONE
						 READ_INIT_DONE       = 2'b11; // 此状态为结束态
		//写状态机状态				
		localparam [1:0] WRITE_IDLE        	  = 2'b00, // 当 INIT_AXI_WRITE_TXN 从 0 变为 1 时，此状态开始 AXI4Lite 事务，并将状态机状态更改为 WRITE_DDR3_INIT
						 WRITE_DDR3_INIT  	  = 2'b01, // 此状态初始化写操作，写操作完成后，状态机状态更改为WRITE_INIT_DONE
						 WRITE_DATA_BACK      = 2'b10, // 此状态为写结果数据回到DDR3中
						 WRITE_INIT_DONE   	  = 2'b11; // 此状态为结束态

		//axi内部本地参数
		// C_TRANSACTIONS_NUM是写或读事务数的索引计数器的宽度
		localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);

		// 事务的突发长度是以 C_M_AXI_DATA_WIDTH（数据宽度）为单位的。非 2 的幂次的突发长度最终会导致跨越 4KB 地址边界的突发传输。
		localparam integer C_MASTER_LENGTH	= 12;

		// 突发传输的总数是主长度除以突发长度和突发大小								
		localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);

		//每次突发传输应该自加的字节数数量位宽，供地址使用
		localparam BURST_SIZE_BYTES_WIDTH = clogb2((C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8)-1);


/****************************************** 用户信号 ********************************************/
	//-------------------------------------- 寄存器型 ------------------------------------//
	//用户添加的信号
	reg [1:0]   axi_araddr_state = 0;	 //指示axi_addr应不应该更新为0

	reg 	    axi_b_complete;

	reg 	    axi_arvalid_state = 0;

	reg [1:0]   r_axi_work_state;		 //用来记录上一个时刻的axi_work_state	

	//-------------------------------------- 网表型 ------------------------------------//
	wire 		axi_work_state_switch;	 //该信号用来指示axi_work_state从AXI_LOAD_DATA_TO_DDR3转变到axi_work_state


/****************************************** axi内部信号 *****************************************/
	//-------------------------------------- 寄存器型 ------------------------------------//

		// 工程的读写状态机信号
		reg [1:0] mst_exec_read_state;			//控制读的状态机的状态信号
		reg [1:0] mst_exec_write_state;			//控制写的状态机的状态信号

		// AXI4LITE 信号
		// AXI4 内部暂时信号
		reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
		reg  							axi_awvalid;
		reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
		reg  							axi_wlast;
		reg  							axi_wvalid;
		reg  							axi_bready;
		reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
		reg  							axi_arvalid;
		reg  							axi_rready;

		reg [C_TRANSACTIONS_NUM   : 0] 	write_index;	//write beat count in a burst
		reg [C_TRANSACTIONS_NUM   : 0] 	read_index;		//read beat count in a burst
		
		// 突发计数器用于跟踪进行数据传输所需的突发次数，每次突发传输的长度为 C_M_AXI_BURST_LEN，总共需要传输 2^C_MASTER_LENGTH 字节的数据。
		reg [C_NO_BURSTS_REQ      : 0] 	write_burst_counter;
		reg [C_NO_BURSTS_REQ      : 0] 	read_burst_counter;

		reg  							start_single_burst_write;
		reg  							start_single_burst_read;

		//写完成和读完成信号
		reg  							writes_done;
		reg  							reads_done;


		reg  							read_done;
		reg  							write_done;			

		reg  							burst_write_active;
		reg  							burst_read_active;

		reg  							init_txn_read_ff;
		reg  							init_txn_read_ff2;

		reg  							init_txn_write_ff;
		reg  							init_txn_write_ff2;

	//-------------------------------------- 网表型 ------------------------------------//
		wire [BURST_SIZE_BYTES_WIDTH:0] burst_size_bytes;	//用字节表示的突发长度 //size of C_M_AXI_BURST_LEN length burst in bytes

		//接口响应错误标志
		wire  							write_resp_error;
		wire  							read_resp_error;

		wire  							wnext;					//wvalid和wready同时有效时拉高
		wire  							rnext;					//rvalid和rready同时有效时拉高
		wire  							init_txn_read_pulse;
		wire                            init_txn_write_pulse;

		wire 							AXI_FULL_crtl_axi_rready;	//该信号具有读暂停功能
		wire 							AXI_FULL_crtl_axi_wvalid;	//该信号具有写暂停功能


/****************************************** 用户组合逻辑 ****************************************/
	// 用户的组合逻辑
	assign read_flag    = rnext;
	assign write_flag   = wnext;

	assign ar_effective = M_AXI_ARVALID && M_AXI_ARREADY;		//该信号指示读地址有效和准备均拉高

	//以下逻辑实现外部控制暂停rready的暂停
	// assign AXI_FULL_crtl_axi_rready = (axi_rready) && (~AXI_FULL_rstop);
	assign rnext = M_AXI_RVALID && axi_rready;    // 通道有效且准备就绪时产生前向移动信号

	//允许读写时拉高的信号
	assign AXI_FULL_crtl_axi_wvalid = (axi_wvalid) && (~AXI_FULL_wstop);
	assign wnext = M_AXI_WREADY && AXI_FULL_crtl_axi_wvalid;	//ready和valid同时有效且不暂停时拉高

	//以下逻辑用来指示axi_work_state从AXI_LOAD_DATA_TO_DDR3转变到axi_work_state
	assign axi_work_state_switch = (r_axi_work_state == AXI_LOAD_DATA_TO_DDR3) && (axi_work_state == AXI_COMPUTE);


/****************************************** axi内部组合逻辑 *************************************/
	// 内部信号 不要更改
	//写地址 (AW)
	assign M_AXI_AWID	 = 'b0;		//写ID
	//巧妙地控制基址实现读回数据，并存入正确的地方
	assign M_AXI_AWADDR	 = C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;	//The AXI address is a concatenation of the target base address + active offset range
	assign M_AXI_AWLEN	 = C_M_AXI_BURST_LEN - 1;				//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_AWSIZE	 = clogb2((C_M_AXI_DATA_WIDTH/8)-1);	//Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
	assign M_AXI_AWBURST = 2'b01;								//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_AWLOCK	 = 1'b0;
	assign M_AXI_AWCACHE = 4'b0010;								//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_AWPROT	 = 3'h0;
	assign M_AXI_AWQOS	 = 4'h0;
	assign M_AXI_AWUSER	 = 'b1;
	assign M_AXI_AWVALID = axi_awvalid;
	
	//写数据(W)，若当前处于计算态使写数据由计算核心给出
	assign M_AXI_WDATA	 = (axi_work_state == AXI_COMPUTE) ? AXI_wdata : axi_wdata;	//这里由于需要测试故将这个信号直接连接至读信号


	assign M_AXI_WSTRB	 = {(C_M_AXI_DATA_WIDTH/8){1'b1}};
	assign M_AXI_WLAST	 = axi_wlast;
	assign M_AXI_WUSER	 = 'b0;
	assign M_AXI_WVALID	 = axi_wvalid;

	//写响应 (B)
	assign M_AXI_BREADY	 = axi_bready;

	//读地址 (AR)
	assign M_AXI_ARID	 = 'b0;
	assign M_AXI_ARADDR	 = C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	assign M_AXI_ARLEN	 = C_M_AXI_BURST_LEN - 1;				//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_ARSIZE	 = clogb2((C_M_AXI_DATA_WIDTH/8)-1);	//Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
	assign M_AXI_ARBURST = 2'b01;								//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_ARLOCK	 = 1'b0;
	assign M_AXI_ARCACHE = 4'b0010;								//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_ARPROT	 = 3'h0;
	assign M_AXI_ARQOS	 = 4'h0;
	assign M_AXI_ARUSER	 = 'b1;
	assign M_AXI_ARVALID = axi_arvalid;
	
	//读数据和读响应 (R)
	assign M_AXI_RREADY	= axi_rready;

	//Example design I/O
	assign READ_TXN_DONE	= read_done;
	assign WRITE_TXN_DONE	= write_done;

	//突发大小(以字节为单位)
	assign burst_size_bytes	= C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8;	//长度*每一次传输的比特数/8得到总的字节数
	assign init_txn_read_pulse	= (!init_txn_read_ff2)  && init_txn_read_ff;			//检测读启动信号的上升沿
	assign init_txn_write_pulse	= (!init_txn_write_ff2) && init_txn_write_ff;			//检测写启动信号的上升沿

	                                   
	
	//标志读和写的错误的信号
	assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1]; 
	assign read_resp_error  = axi_rready & M_AXI_RVALID & M_AXI_RRESP[1];  //如果M_AXI_RRESP是2'b10就说明出问题了，即error


/****************************************** 用户时序逻辑 ****************************************/
	//自己编写的控制状态机
	//--------------------------------- 实现主命令读接口状态机 --------------------------------//                                                                                                                                                                                                          
	  always @ ( posedge M_AXI_ACLK) begin                                                                                                     
	    if (M_AXI_ARESETN == 1'b0 ) begin			// 复位状态下所有信号均被赋予默认值                                                                                                                                                                                       
	        mst_exec_read_state      <= READ_IDLE;	//控制读状态为空闲态
	        start_single_burst_read  <= 1'b0;		//读操作初始化
	        read_done                <= 1'b0;       //读结束为0                                                                  
	    end else begin                                                                                                                                                                              
	        case (mst_exec_read_state)                                                                               

			  //读空闲态                                                                                                  
	          READ_IDLE: begin                                                                                                    
				read_done           <= 1'b0;		//读结束保持为0
	            if ( init_txn_read_pulse == 1'b1) begin	//检测启动脉冲  

					case (axi_work_state)

						// axi空闲态
						AXI_IDLE: begin
							mst_exec_read_state      <= READ_IDLE;
						end

						//axi开始载入ddr3数据态
						AXI_LOAD_DATA_TO_DDR3: begin
							mst_exec_read_state      <= READ_DATA_TODDR_INIT;
						end

						//axi开始输出计算数据态
						AXI_COMPUTE: begin
							mst_exec_read_state      <= READ_COMPUTE_DATA;		//将axi状态转至读ddr3数据态
						end

						default: mst_exec_read_state <= READ_IDLE;
					endcase
	            end else mst_exec_read_state         <= READ_IDLE;  
			  end                                                                                                                                                                                                                              

			  //读bram数据初始化态	                                                                                              
	          READ_DATA_TODDR_INIT: begin
				// 该状态负责产生start_single_read脉冲以发起读事务。
				// 读事务将持续发出，直到burst_read_active信号置位。
				// 读控制器                                                                              
	            if (reads_done) begin						//判断是否读完                                                                                         
	                mst_exec_read_state <= READ_INIT_DONE;                                                             
	            end else begin                              //没有读完则继续读                                                           
	                mst_exec_read_state <= READ_DATA_TODDR_INIT;                                                               
	                                                                                                            
	                if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read && ~burst_write_active)	begin	//若此时没有任何其他的读数据请求，则开始一次新的读                         
	                	start_single_burst_read <= 1'b1;                                                        
	                end else start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
	            end
			  end                                                                                       

			  //读数据到TPU状态
			  READ_COMPUTE_DATA: begin
				// 该状态负责产生start_single_read脉冲以发起读事务。
				// 读事务将持续发出，直到burst_read_active信号置位。
				// 读控制器                                                                              
	            if (reads_done) begin						  //判断是否读完                                                                                         
	                mst_exec_read_state <= READ_INIT_DONE;                                                             
	            end else begin                                //没有读完则继续读                                                           
	                mst_exec_read_state <= READ_COMPUTE_DATA;                                                               
	                                                                                                            
	                if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read && ~AXI_FULL_rstop)	begin	//若此时没有任何其他的读数据请求，则开始一次新的读                         
	                	start_single_burst_read <= 1'b1;                                                        
	                end else start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
	            end
			  end

	          //读结束态                                                                                                  
	          READ_INIT_DONE: begin                                                                                                                                                                    
	              mst_exec_read_state 		<= READ_IDLE;		//回到空闲态	                                                               
	              read_done           		<= 1'b1;            //指示读完成                                                               
	          end

			  //默认处于空闲态                                                                                                                                                                                        
	          default: mst_exec_read_state  <= READ_IDLE;                                                                                                                                                         
	        endcase                                                                                             
	      end                                                                                                   
	  end 


	//--------------------------------- 实现主命令写接口状态机 --------------------------------//                                                                                                                                                                                                          
	  always @ ( posedge M_AXI_ACLK) begin                                                                                                                                                                              
	    if (M_AXI_ARESETN == 1'b0 ) begin 				//复位状态下所有信号均被赋予默认值                                                                            
	        mst_exec_write_state     <= WRITE_IDLE;		//控制状态
	        start_single_burst_write <= 1'b0;			//写操作初始化                                                                   
	        write_done               <= 1'b0;   		//写结束为0                                                                       
	    end else begin                                                                                                                                                                              
	        case (mst_exec_write_state)                                                                               

			  //写空闲态                                                                                                  
	          WRITE_IDLE: begin                                                                                                    
				write_done          <= 1'b0;   	   //写结束
	            if ( init_txn_write_pulse == 1'b1) begin //检测启动脉冲                                                     

					case (axi_work_state)

						// axi空闲态
						AXI_IDLE: begin
							mst_exec_write_state <= WRITE_IDLE;
						end

						//axi开始载入数据态
						AXI_LOAD_DATA_TO_DDR3: begin
							mst_exec_write_state <= WRITE_DDR3_INIT;
						end

						//axi开始输出计算数据态
						AXI_COMPUTE: begin
							mst_exec_write_state      <= WRITE_DATA_BACK;		//将axi状态转至读ddr3数据态
						end

						default: mst_exec_write_state  <= WRITE_IDLE;
					endcase  
	            end                                                                                           
	            else mst_exec_write_state  <= WRITE_IDLE;  
			  end                                                          
                                                                                           
	          //写ddr3数据初始化态                                                                                                  
	          WRITE_DDR3_INIT: begin
				// 该状态负责产生start_single_write脉冲以发起写事务。
				// 写事务将持续发出，直到burst_write_active信号置位。
				// 写控制器                                                                             
	            if (writes_done) begin                                                                                         
	                mst_exec_write_state <= WRITE_INIT_DONE;                                                              
	            end else begin                                                                                         
	                mst_exec_write_state  <= WRITE_DDR3_INIT;                                                              
	                //注意这里由于要使写数据比读数据慢一拍故要等待读开始拉高                                                                                           
	                if (~axi_awvalid && ~start_single_burst_write && ~burst_write_active && start_single_burst_read) begin 	                                                                                    
	                    start_single_burst_write <= 1'b1;                                                       
	                end else start_single_burst_write <= 1'b0; // 置低以产生脉冲                          
	            end
			  end

			  //写结果数据回DDR3或总线状态
			  WRITE_DATA_BACK: begin 
			    if (writes_done) begin                                                                                         
			  		mst_exec_write_state <= WRITE_INIT_DONE;                                                              
			  	end else begin                                                                                         
			  		mst_exec_write_state  <= WRITE_DATA_BACK;                                                              
			  		//注意这里由于要使写数据比读数据慢一拍故要等待读开始拉高                                                                                           
			  		if (~axi_awvalid && ~start_single_burst_write && ~burst_write_active && (~AXI_FULL_wstop)) begin 	                                                                                    
			  			start_single_burst_write <= 1'b1;                                                       
			  		end else start_single_burst_write <= 1'b0; // 置低以产生脉冲                          
			  	end 
			  end                                                                                          

			  //写结束态	                                                                                                
	          WRITE_INIT_DONE: begin                                                                                                                                                                   
	              mst_exec_write_state		  <= WRITE_IDLE;                                                               
	              write_done          		  <= 1'b1;                                                                         
	          end  

			  //默认处于空闲态                                                                                           
	          default : mst_exec_write_state  <= WRITE_IDLE;                                                                                                                                            
	        endcase                                                                                             
	      end                                                                                                   
	  end


	//记录上一次的状态
		always @(posedge M_AXI_ACLK) begin                                        
			r_axi_work_state <= axi_work_state;									
		end 


	//检测b是否完成
		always @(posedge M_AXI_ACLK) begin
			if (axi_bready && M_AXI_BVALID) begin
				axi_b_complete <= 1; 
			end else if (start_single_burst_read) begin
				axi_b_complete <= 0; 
			end else axi_b_complete <= axi_b_complete;
		end


/****************************************** axi内部时序逻辑 *************************************/
	//检测读启动信号上升沿的块
	  always @(posedge M_AXI_ACLK) begin                                                                        
	    // Initiates AXI transaction delay启动AXI事务延迟，为了检测上升沿    
	    if (M_AXI_ARESETN == 0 )                                                   
	      begin                                                                    
	        init_txn_read_ff <= 1'b0;                                                   
	        init_txn_read_ff2 <= 1'b0;                                                   
	      end                                                                               
	    else                                                                       
	      begin  
	        init_txn_read_ff <= INIT_AXI_READ_TXN;
	        init_txn_read_ff2 <= init_txn_read_ff;                                                                 
	      end                                                                      
	  end     

	//检测读启动信号上升沿的块
	  always @(posedge M_AXI_ACLK) begin                                                                        
	    // Initiates AXI transaction delay启动AXI事务延迟，为了检测上升沿    
	    if (M_AXI_ARESETN == 0 )                                                   
	      begin                                                                    
	        init_txn_write_ff <= 1'b0;                                                   
	        init_txn_write_ff2 <= 1'b0;                                                   
	      end                                                                               
	    else                                                                       
	      begin  
	        init_txn_write_ff <= INIT_AXI_WRITE_TXN;
	        init_txn_write_ff2 <= init_txn_write_ff;                                                                 
	      end                                                                      
	  end

	
	//以下是axi的5个通道的控制信号
	//-------------------------------------- 写地址通道 --------------------------------------//                                                                                                                                                                                                          
		// 写地址通道的作用是为整个事务请求地址和命令信息。这是一拍（single beat）传输的信息。
		// 每当一个地址事务被接受，地址就会按 burst_size_byte 的字节数递增，以指向下一个地址。

		//axi_awvalid控制
			always @(posedge M_AXI_ACLK) begin                                                                																
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1 ) begin
					if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
						axi_awvalid <= axi_awvalid;
					end else axi_awvalid <= 1'b0;
				end

				//一旦有效信号被拉高，这个信号就不能被拉低，这个信号必须等到传输任务被接受才能拉低                         
				else if (M_AXI_AWREADY && axi_awvalid || AXI_FULL_wstop) begin		//写地址准备信号和写有效信号同时为高                                                            
					axi_awvalid <= 1'b0;                                           
				end
				else if (~axi_awvalid && start_single_burst_write) begin
					 axi_awvalid <= 1'b1;                                           
				end else axi_awvalid <= axi_awvalid;                                      
			end                                                                
																																	
		// 当 AWREADY 信号有效后出现的新地址，标志着前序地址已被成功接收。
		//axi_awaddr控制
			always @(posedge M_AXI_ACLK) begin                                                                
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1) begin                    
					//这里要注意在状态转换的时候将地址变为0一下
					if ((axi_work_state == AXI_LOAD_DATA_TO_DDR3) || (axi_work_state == AXI_COMPUTE)) begin		//在计算态下，地址不要在启动时拉低
						axi_awaddr <= axi_awaddr;
					end else axi_awaddr <= 'b0;
				end    
				else if (axi_work_state_switch) begin
					axi_awaddr <= 'b0;
				end else if (M_AXI_AWREADY && axi_awvalid) begin                                                            
					axi_awaddr <= axi_awaddr + burst_size_bytes;	//每一次地址+传输所需要的字节数                   
				end else axi_awaddr <= axi_awaddr;                                        
			end                                                                


	//-------------------------------------- 写数据通道 --------------------------------------//                                                                                                                                                                                                          
		//写数据通道会持续尝试通过接口推送写数据。
		//从设备和AXI互联结构的设置（例如是否启用了FIFO）会决定能够接受多少数据。
		//注意：写数据通道与写地址通道之间没有显式的时序关系。
		//写数据通道有自己独立的节流标志，与AW（写地址）通道是分开的。
		//通道之间的同步必须由用户自行决定。
		//最简单但性能最低的方法是：每次只发起一次写地址和一次数据突发传输。
		//在本示例中，通过使用相同的地址增量和突发长度使两个通道保持同步。
		//AW（写地址）通道和W（写数据）通道的事务数量由用户逻辑中的阈值计数器来跟踪，以确保它们之间不会相差太多。
		//只有当写数据通道的 valid 和 ready 同时为高时，写通道才会前进。

		//axi_wvalid控制
			always @(posedge M_AXI_ACLK)                                                      
			begin                                                                             
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1 ) begin
					if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
						axi_wvalid <= axi_wvalid;
					end else axi_wvalid <= 1'b0;                                                         
				end else if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
					if (M_AXI_AWVALID && M_AXI_WREADY) begin
						axi_wvalid <= 1'b1;
					end else if (wnext && axi_wlast) axi_wvalid <= 1'b0;
					else axi_wvalid <= axi_wvalid; 
				end else if (~axi_wvalid && start_single_burst_write) begin                                                                         
					axi_wvalid <= 1'b1;                                                         
				end else if (wnext && axi_wlast)                                                    
					axi_wvalid <= 1'b0;
				else axi_wvalid <= axi_wvalid;                                                     
			end                                                                               
																																				
		//axi_wlast控制
			always @(posedge M_AXI_ACLK)                                                      
			begin                                                                             
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1 )                                                        
				begin                                                                         
					axi_wlast <= 1'b0;                                                          
				end                                                                           
				// 当写索引计数达到倒数第二个值时，拉高 axi_wlast 信号，以便与最后一个写数据同步。
				// 当 write_index 为 b1111 时，拉高 axi_wlast。
				// 否则，如果 (&(write_index[C_TRANSACTIONS_NUM-1:1]) && ~write_index[0] && wnext) 
				else if (((write_index == C_M_AXI_BURST_LEN-2 && C_M_AXI_BURST_LEN >= 2) && wnext) || (C_M_AXI_BURST_LEN == 1 ))
				begin                                                                         
					axi_wlast <= 1'b1;                                                          
				end                                                                           
				// 当最后一个写数据被从设备接受并且有有效响应时，拉低 axi_wlast 信号。                        
				else if (wnext)                                                                 
				axi_wlast <= 1'b0;                                                            
				else if (axi_wlast && C_M_AXI_BURST_LEN == 1)                                   
				axi_wlast <= 1'b0;                                                            
				else                                                                            
				axi_wlast <= axi_wlast;                                                       
			end                                                                               
																							
		/* 突发长度计数器。使用额外的计数器寄存器位来指示终止计数，以减少解码逻辑 */                                                                                  
		//write_index控制
			always @(posedge M_AXI_ACLK)                                                      
			begin                                                                             
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1 || start_single_burst_write == 1'b1)    
				begin                                                                         
					write_index <= 0;                                                           
				end                                                                           
				else if (wnext && (write_index != C_M_AXI_BURST_LEN-1))                         
				begin                                                                         
					write_index <= write_index + 1;                                             
				end                                                                           
				else                                                                            
				write_index <= write_index;                                                   
			end                                                                               
																																													
		// 要发出什么数据由自己定                                                                    
		//axi_wdata控制
			always @(posedge M_AXI_ACLK) begin                                                                             
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1)                                                         
					axi_wdata <= 'b0;                                                             
				else if (wnext && axi_wlast)                                                  
					axi_wdata <= 'b0;

				//单独控制将数据写入ddr3
				else if (axi_work_state <= AXI_LOAD_DATA_TO_DDR3) begin
					axi_wdata <= M_AXI_RDATA;
				end 
				else                                                                            
					axi_wdata <= axi_wdata;                                                       
			end                                                                             


	//-------------------------------------- 写响应 (B) 通道 ---------------------------------//                                                                                                                                                                                                          
		//写响应通道用于反馈写操作已完成，并将数据放到内存。当所有写数据和写地址都已到达并被从设备接受时，BREADY 信号会激活。
		//写事务的发起（即未完成写地址的数量）由写地址传输（AW）开始，由 BREADY/BRESP 信号完成。
		//尽管拉低 BREADY 最终会限制 AWREADY 信号（写地址握手），但最好不要用这种方式来节流整个写数据通道。
		//BRESP 的第1位（bit[1]）用于指示整个写突发过程中来自互联结构或从设备的错误。本示例会将该错误信号记录到 ERROR 输出端口中。

		//axi_bready控制
			always @(posedge M_AXI_ACLK)                                     
			begin                                                                 
				if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1 )                                            
				begin
					if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
						axi_bready <= axi_bready;                                             
					end else axi_bready <= 1'b0;                                             
				end                                                               
				// accept/acknowledge bresp with axi_bready by the master           
				// when M_AXI_BVALID is asserted by slave                           
				else if (M_AXI_RLAST)	//从机给了有效信号，且上一个时钟没有给准备信号                               
				begin                                                             
					axi_bready <= 1'b1;                                             
				end                                                                                                  
				else if (axi_bready && M_AXI_BVALID)                                                
				begin                                                             
					axi_bready <= 1'b0;                                             
				end                                                               
				// 保留先前的值                                        
				else axi_bready <= axi_bready;                                         
			end                                                                   


	//-------------------------------------- 读地址通道 --------------------------------------//                                                                                                                                                                                                          
		//读地址通道（AR）与写地址通道功能类似——用于提供突发传输所需的传输限定信息。
		//在本示例中，读地址的递增方式与写地址通道相同。

		//axi_arvalid控制
			always @(posedge M_AXI_ACLK) begin                                                             
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1 ) begin                                                          
					axi_arvalid <= 1'b0;                                         
				end else if (~axi_arvalid && start_single_burst_read) begin // 如果前一个时钟读地址无效，开始下一个读事务
					if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
						if (axi_arvalid_state == 1'b0) begin
							axi_arvalid_state <= 1'b1;
							axi_arvalid       <= 1'b1;
						end else begin
							if (axi_b_complete) begin
								axi_arvalid   <= 1'b1;
							end else axi_arvalid   <= 1'b0;
						end 
					end else axi_arvalid      <= 1'b1;                                         
				end else if (M_AXI_ARREADY && axi_arvalid || (~AXI_FULL_rstop)) begin    //握手拉低不用管
					axi_arvalid <= 1'b0;                                         
				end else axi_arvalid <= axi_arvalid;                                    
			end                                                                
																																			
		// 当 ARREADY 信号有效后出现的新地址，标志着前序地址已被成功接收。 
		//axi_araddr控制
			always @(posedge M_AXI_ACLK)                                       
			begin                                                              
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1) begin
					
					if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
						axi_araddr <= axi_araddr;
					end 
					else if (axi_work_state == AXI_COMPUTE) begin

						if (axi_araddr_state == 0) begin
							axi_araddr       <= 0;
							axi_araddr_state <= 1;
						end  
						else axi_araddr <= axi_araddr;

					end
					else axi_araddr <= 'b0;                                                         
				end                                                            
				else if (M_AXI_ARREADY && axi_arvalid)                           
				begin
					if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin
						axi_araddr      <= axi_araddr + burst_size_bytes;	//每一次地址+传输所需要的字节数                 
					end
					if (axi_work_state == AXI_COMPUTE) begin
						axi_araddr      <= axi_araddr + burst_size_bytes;	//每一次地址+传输所需要的字节数                 
					end 
					else axi_araddr     <= axi_araddr + burst_size_bytes;	//每一次地址+传输所需要的字节数                                                           
				end                                                            
				else                                                             
				axi_araddr <= axi_araddr;                                      
			end                                                                


	//-------------------------------------- 读数据 (和响应) 通道 -----------------------------//                                                                                                                                                                                                                                                                              
		// 突发长度计数器。使用额外的计数器寄存器位来指示终止计数，以减少解码逻辑                                
		//read_index控制
			always @(posedge M_AXI_ACLK)                                          
			begin                                                                 
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1 || start_single_burst_read)                  
				begin                                                             
					read_index <= 0;                                                
				end                                                               
				else if (rnext && (read_index != C_M_AXI_BURST_LEN-1))              
				begin                                                             
					read_index <= read_index + 1;                                   
				end                                                               
				else                                                                
				read_index <= read_index;                                         
			end                                                                   
																				
		//本通道用于传输读取请求的结果数据，当前示例设计中的数据校验模块始终可以接收数据，因此无需通过RREADY信号进行流控                                                                    
		//axi_rready控制
			always @(posedge M_AXI_ACLK)                                          
			begin                                                                 
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1 )                  
				begin                                                             
					axi_rready <= 1'b0;                                             
				end                                                                
				// 当从设备拉高M_AXI_RVALID或读地址已经准备好时，主设备通过拉高 axi_rready 来接受/确认接收到的 rdata 和 rresp。                        
				else if (M_AXI_RVALID || ar_effective) begin                                      
					if (M_AXI_RLAST && axi_rready || AXI_FULL_rstop) begin                                  
						axi_rready <= 1'b0;                  
					end                                    
					else if (axi_work_state == AXI_LOAD_DATA_TO_DDR3) begin	//单独操控处于写入ddr3数据的状态
						axi_rready <= 1'b1; 
					end else begin                                 
						axi_rready <= 1'b1;                 
					end                                   
				end                                        
				// 保留前一个值                 
			end                                                                                                             

                                                                                     
	//-------------------------------------- 写有关信号控制通道 -------------------------------//                                                                                                                                                                                                                                                                              
		// write_burst_counter计数器功能：跟踪主设备已发起的突发传输次数与需要发起的突发传输总数的对比
		//write_burst_counter控制
		always @(posedge M_AXI_ACLK)                                                                              
		begin                                                                                                     
			if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1 )                                                                                 
			begin                                                                                                 
				write_burst_counter <= 'b0;                                                                         
			end                                                                                                   
			else if (M_AXI_AWREADY && axi_awvalid)                                                                  
			begin                                                                                                 
				if (write_burst_counter[C_NO_BURSTS_REQ] == 1'b0)                                                   
				begin                                                                                             
					write_burst_counter <= write_burst_counter + 1'b1;                                              
					//write_burst_counter[C_NO_BURSTS_REQ] <= 1'b1;                                                 
				end                                                                                               
			end                                                                                                   
			else                                                                                                    
			write_burst_counter <= write_burst_counter;                                                           
		end                                                                                                       

		//下面的always块是读写有效信号控制逻辑以及读写结束标志逻辑                                                                                                         
		// burst_write_active 信号在启动 start_single_burst_write 时，表示开始了一个突发写操作。
		// 当突发写操作被从设备接受时，burst_write_active 信号保持有效。                       
		//burst_write_active控制
			always @(posedge M_AXI_ACLK)                                                                              
			begin
				case (axi_work_state)

					//加数据至dd3中的态需要单独处理
					AXI_LOAD_DATA_TO_DDR3:begin
						if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1)                                                                                 
							burst_write_active <= 1'b0;                                                                                                                                                                                
						//当burst_write_active发起时burst_write_active信号拉高                        
						else if (start_single_burst_write)                                                                      
							burst_write_active <= 1'b1;                                                                           
						else if (M_AXI_BVALID && axi_bready)                                                                    
							burst_write_active <= 0;
					end

					//默认下正常axi处理 
					default:begin
						if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1)                                                                                 
							burst_write_active <= 1'b0;                                                                                                                                                                                
						//当burst_write_active发起时burst_write_active信号拉高                        
						else if (start_single_burst_write)                                                                      
							burst_write_active <= 1'b1;                                                                           
						else if (M_AXI_BVALID && axi_bready)                                                                    
							burst_write_active <= 0;
					end 
				endcase                                                                                                     
				                                                                              
			end                                                                                                       

		// 检查最后一次写的完成                                                                                                                                                                          
		// This logic is to qualify the last write count with the final write response. This demonstrates how to confirm that a write has been committed.                                                                                                                                                                                              
		//writes_done控制
		always @(posedge M_AXI_ACLK)                                                                              
		begin                                                                                                     
			if (M_AXI_ARESETN == 0 || init_txn_write_pulse == 1'b1)                                                                                 
				writes_done <= 1'b0;                                                                                                                                                                                       
			// writes_done 应该与 bready 响应相关联
			// 如果 (M_AXI_BVALID && axi_bready && (write_burst_counter == {(C_NO_BURSTS_REQ-1){1}}) && axi_wlast)
			else if (M_AXI_BVALID && (write_burst_counter[C_NO_BURSTS_REQ]) && axi_bready)                          
				writes_done <= 1'b1;                                                                                  
			else                                                                                                    
				writes_done <= writes_done;                                                                           
			end                                                                                                     
				   

	//-------------------------------------- 读有关信号控制通道 -------------------------------//                                                                                                                                                                                                                                                                              
		// Read_burst_counter计数器跟踪启动的突发事务的数量与主服务器需要启动的突发事务的数量                                   
		//read_burst_counter控制
			always @(posedge M_AXI_ACLK)                                                                              
			begin                                                                                                     
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1)                                                                                 
				begin                                                                                                 
					read_burst_counter <= 'b0;                                                                          
				end                                                                                                   
				else if (M_AXI_ARREADY && axi_arvalid)                                                                  
				begin                                                                                                 
					if (read_burst_counter[C_NO_BURSTS_REQ] == 1'b0)                                                    
					begin                                                                                             
						read_burst_counter <= read_burst_counter + 1'b1;                                                
						//read_burst_counter[C_NO_BURSTS_REQ] <= 1'b1;                                                  
					end                                                                                               
				end                                                                                                   
				else                                                                                                    
				read_burst_counter <= read_burst_counter;                                                             
			end                                                                                                                                                                                      
																														
																													
		// burst_read_active 信号在启动 start_single_burst_read 时，表示开始了一个突发读操作。
		// 当突发读操作被主设备接受时，start_single_burst_read 信号保持有效。                       
		//burst_read_active控制
			always @(posedge M_AXI_ACLK)                                                                              
			begin                                                                                                     
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1)                                                                                 
					burst_read_active <= 1'b0;                                                                            	                                                                                                            
				//The burst_write_active is asserted when a write burst transaction is initiated                        
				else if (start_single_burst_read)                                                                       
					burst_read_active <= 1'b1;                                                                            
				else if (M_AXI_RVALID && axi_rready && M_AXI_RLAST)                                                     
					burst_read_active <= 0;                                                                               
			end                                                                                                     


		// 检查最后一次读完成                                                                                                                                                                           
		//reads_done控制
			always @(posedge M_AXI_ACLK)                                                                              
			begin                                                                                                     
				if (M_AXI_ARESETN == 0 || init_txn_read_pulse == 1'b1)                                                                                 
					reads_done <= 1'b0;                                                                                   	                                                                                                            
				// reads_done应该与一个已完成的响应（rready response）相关联                                            
				// else if (M_AXI_BVALID && axi_bready && (write_burst_counter == {(C_NO_BURSTS_REQ-1){1}}) && axi_wlast)
				else if (M_AXI_RVALID && axi_rready && (read_index == C_M_AXI_BURST_LEN-1) && (read_burst_counter[C_NO_BURSTS_REQ]))
					reads_done <= 1'b1;                                                                                   
				else if (reads_done == 1'b1) begin
					reads_done  <= 1'b0;
				end else reads_done <= reads_done;                                                                             
			end                                                                                                     

endmodule

