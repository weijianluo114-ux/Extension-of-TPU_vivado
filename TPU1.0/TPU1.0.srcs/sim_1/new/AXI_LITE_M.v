`timescale 1ns / 1ps

module AXI_LITE_M #(
        // 用户可在此添加参数

        // 用户参数结束
        // 请勿修改此行之后的参数

        parameter C_M_START_DATA_VALUE         = 32'b1_00_00_00_00,  // 主机将从 C_M_START_DATA_VALUE 值开始生成数据
        parameter C_M_TARGET_SLAVE_BASE_ADDR   = 32'h00000000,       // 主机需要一个目标从机基地址。主机会在此参数指定的基地址上对从机发起读写事务。
        parameter integer C_M_AXI_ADDR_WIDTH   = 32,                 // M_AXI 地址总线宽度。主机生成的读写地址宽度由 C_M_AXI_ADDR_WIDTH 指定。
        parameter integer C_M_AXI_DATA_WIDTH   = 32,                 // M_AXI 数据总线宽度。主机发出写数据并接收读数据，数据总线宽度为 C_M_AXI_DATA_WIDTH
        parameter integer C_M_TRANSACTIONS_NUM = 18                  // 事务数量是主机在此示例内存测试中将执行的写和读事务数量。
    ) (
        // 用户可在此添加端口

        // 用户端口结束
        // 请勿修改此行之后的端口


        input  wire                              INIT_AXI_TXN,      // 启动 AXI 事务
        output reg                               ERROR,             // 检测到错误时置位
        output wire                              TXN_DONE,          // AXI 事务完成时置位
        input  wire                              M_AXI_ACLK,        // AXI 时钟信号
        input  wire                              M_AXI_ARESETN,     // AXI 低有效复位信号

        //写通道
        output wire [C_M_AXI_ADDR_WIDTH-1 : 0]   M_AXI_AWADDR,      // 主接口写地址通道端口。写地址（由主机发出）
        output wire [2 : 0]                      M_AXI_AWPROT,      // 写通道保护类型。此信号指示事务的特权和安全级别，以及事务是数据访问还是指令访问。
        output wire                              M_AXI_AWVALID,     // 写地址有效。
        input  wire                              M_AXI_AWREADY,     // 写地址就绪。

        output wire [C_M_AXI_DATA_WIDTH-1 : 0]   M_AXI_WDATA,       // 主接口写数据通道端口。写数据（由主机发出）
        output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,       // 写选通信号。
        output wire                              M_AXI_WVALID,      // 写有效。此信号指示有有效的写数据和选通信号。
        input  wire                              M_AXI_WREADY,      // 写就绪。此信号指示从机可以接收写数据。

        input  wire [1 : 0]                      M_AXI_BRESP,       // 主接口写响应通道端口。
        input  wire                              M_AXI_BVALID,      // 写响应有效。
        output wire                              M_AXI_BREADY,      // 响应就绪。此信号指示主机可以接收写响应。

        //读通道
        output wire [C_M_AXI_ADDR_WIDTH-1 : 0]   M_AXI_ARADDR,      // 主接口读地址通道端口。读地址（由主机发出）
        output wire [2 : 0]                      M_AXI_ARPROT,      // 保护类型。此信号指示事务的特权和安全级别，以及事务是数据访问还是指令访问。
        output wire                              M_AXI_ARVALID,     // 读地址有效。
        input  wire                              M_AXI_ARREADY,     // 读地址就绪。

        input  wire [C_M_AXI_DATA_WIDTH-1 : 0]   M_AXI_RDATA,       // 主接口读数据通道端口。读数据（由从机发出）
        input  wire [1 : 0]                      M_AXI_RRESP,       // 读响应。此信号指示读传输的状态。
        input  wire                              M_AXI_RVALID,      // 读有效。此信号指示通道正在发出所需的读数据。
        output wire                              M_AXI_RREADY       // 读就绪。此信号指示主机可以接收读数据和响应信息。
    );


/****************************************** axi内部函数 *****************************************/
  // clogb2 函数返回一个整数，其值为 log2 向上取整
  function integer clogb2(input integer bit_depth);
    begin
      for (clogb2 = 0; bit_depth > 0; clogb2 = clogb2 + 1) bit_depth = bit_depth >> 1;
    end
  endfunction


/****************************************** 用户参数 ********************************************/
    //以下是18个矩阵对应的需要发送的参数数据
        parameter reg_config_int4_16_16_16       = 32'b1_00_00_00_00,
                  reg_config_int4_32_16_8        = 32'b1_00_00_00_10,
                  reg_config_int4_8_16_32        = 32'b1_00_00_00_01,

                  reg_config_int8_16_16_16       = 32'b1_01_01_01_00,
                  reg_config_int8_32_16_8        = 32'b1_01_01_01_10,
                  reg_config_int8_8_16_32        = 32'b1_01_01_01_01,

                  reg_config_fp16_32_16_8        = 32'b0_10_10_10_00,
                  reg_config_fp16_16_16_16       = 32'b0_10_10_10_10,
                  reg_config_fp16_8_16_32        = 32'b0_10_10_10_01,

                  reg_config_fp32_16_16_16       = 32'b0_11_11_11_00,
                  reg_config_fp32_32_16_8        = 32'b0_11_11_11_10,
                  reg_config_fp32_8_16_32        = 32'b0_11_11_11_01,

                  reg_config_int4_int32_16_16_16 = 32'b1_11_00_00_00,
                  reg_config_int4_int32_32_16_8  = 32'b1_11_00_00_10,
                  reg_config_int4_int32_8_16_32  = 32'b1_11_00_00_01,

                  reg_config_int8_int32_16_16_16 = 32'b1_11_01_01_00,
                  reg_config_int8_int32_32_16_8  = 32'b1_11_01_01_10,
                  reg_config_int8_int32_8_16_32  = 32'b1_11_01_01_01;


/****************************************** axi内部参数 *****************************************/
	//-------------------------------------- 普通参数 ------------------------------------//
        // 示例状态机，用于初始化计数器、初始化写事务、初始化读事务以及将读数据与写入数据进行比较
        parameter [1:0] IDLE                            = 2'b00,  // 此状态在 INIT_AXI_TXN 由 0 跳变为 1 时启动 AXI4Lite 事务
                        INIT_WRITE_REG_CONFIGURE_TEST   = 2'b01,  // 此状态初始化写事务，写完成后状态机切换到 INIT_READ
                        INIT_READ                       = 2'b10,  // 此状态初始化读事务，读完成后状态机切换到 INIT_COMPARE
                        INIT_COMPARE                    = 2'b11;  // 此状态比较写入数据与读出数据

	//-------------------------------------- 本地参数 ------------------------------------//
        // TRANS_NUM_BITS 是写或读事务计数器的宽度
        localparam integer TRANS_NUM_BITS = clogb2(C_M_TRANSACTIONS_NUM - 1);


/****************************************** 用户信号 ********************************************/
	//-------------------------------------- 寄存器型 ------------------------------------//
        reg [4:0] MATRIX_reg_cnt;   //指示现在配置的数据集矩阵是哪一组

/****************************************** axi内部信号 *****************************************/
	//-------------------------------------- 寄存器型 ------------------------------------//
        reg [1:0] mst_exec_state;

        // AXI4LITE 信号
        reg                            axi_awvalid;        // 写地址有效
        reg [C_M_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;         // 写地址
        reg                            axi_wvalid;         // 写数据有效
        reg [C_M_AXI_DATA_WIDTH-1 : 0] axi_wdata;          // 写数据
        reg                            axi_bready;         // 写响应接收
        reg                            start_single_write; // 启动单次写事务脉冲
        reg                            write_issued;       // 单次写事务发出后保持到写完成
        reg [TRANS_NUM_BITS : 0]       write_index;        // 写事务计数器
        reg                            last_write;         // 写计数达到最后一次写事务时置位
        reg                            writes_done;        // 写事务完成标志。写事务数量由参数 C_M_TRANSACTIONS_NUM 指定

        reg                            axi_arvalid;        // 读地址有效
        reg [C_M_AXI_ADDR_WIDTH-1 : 0] axi_araddr;         // 读地址
        reg                            axi_rready;         // 读数据接收
        reg                            start_single_read;  // 启动单次读事务脉冲
        reg                            read_issued;        // 单次读事务发出后保持到读完成
        reg [TRANS_NUM_BITS : 0]       read_index;         // 读事务计数器
        reg                            last_read;          // 读计数达到最后一次读事务时置位
        reg                            reads_done;         // 读事务完成标志。读事务数量由参数 C_M_TRANSACTIONS_NUM 指定
        reg                            read_mismatch;      // 读数据与期望数据不匹配标志
        reg [C_M_AXI_DATA_WIDTH-1 : 0] expected_rdata;     // 期望读数据，用于与实际读数据比较
        
        reg                            compare_done;       // 比较完成标志
        reg                            error_reg;          // 错误寄存器，在写响应错误、读响应错误或数据不匹配时置位

        reg init_txn_ff;
        reg init_txn_ff2;
        reg init_txn_edge;

	//-------------------------------------- 网表型 ------------------------------------//
        wire init_txn_pulse;

        wire write_resp_error;        // 写响应错误标志
        wire read_resp_error;         // 读响应错误标志


/****************************************** 用户组合逻辑 ****************************************/


/****************************************** axi内部组合逻辑 *************************************/
  // I/O 连接赋值
  assign M_AXI_AWADDR   = C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;      // 将偏移地址加到从机基地址
  assign M_AXI_WDATA    = axi_wdata;     // AXI 4 写数据
  assign M_AXI_AWPROT   = 3'b000;
  assign M_AXI_AWVALID  = axi_awvalid;
  assign M_AXI_WVALID   = axi_wvalid;    // 写数据（W）
  assign M_AXI_WSTRB    = 4'b1111;       // 本例中所有字节选通都置位
  assign M_AXI_BREADY   = axi_bready;    // 写响应（B）

  assign M_AXI_ARADDR   = C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;  // 读地址（AR）
  assign M_AXI_ARVALID  = axi_arvalid;
  assign M_AXI_ARPROT   = 3'b001;
  assign M_AXI_RREADY   = axi_rready;    // 读和读响应（R）

  // 示例设计 I/O
  assign TXN_DONE       = compare_done;
  assign init_txn_pulse = (!init_txn_ff2) && init_txn_ff;


/****************************************** 用户时序逻辑 ****************************************/
    //矩阵参数状态机，用于控制写入的参数
    always @(posedge M_AXI_ACLK) begin
        if ((!M_AXI_ARESETN) || init_txn_pulse) begin
            axi_wdata <= reg_config_int4_16_16_16;
        end else begin
            case (write_index)      
                1:  axi_wdata <= reg_config_int4_16_16_16      ;
                2:  axi_wdata <= reg_config_int4_32_16_8       ;
                3:  axi_wdata <= reg_config_int4_8_16_32       ;
                4:  axi_wdata <= reg_config_int8_16_16_16      ;
                5:  axi_wdata <= reg_config_int8_32_16_8       ;
                6:  axi_wdata <= reg_config_int8_8_16_32       ;
                7:  axi_wdata <= reg_config_fp16_32_16_8       ;
                8:  axi_wdata <= reg_config_fp16_16_16_16      ;
                9:  axi_wdata <= reg_config_fp16_8_16_32       ;
                10: axi_wdata <= reg_config_fp32_16_16_16      ;
                11: axi_wdata <= reg_config_fp32_32_16_8       ;
                12: axi_wdata <= reg_config_fp32_8_16_32       ;
                13: axi_wdata <= reg_config_int4_int32_16_16_16;
                14: axi_wdata <= reg_config_int4_int32_32_16_8 ;
                15: axi_wdata <= reg_config_int4_int32_8_16_32 ;
                16: axi_wdata <= reg_config_int8_int32_16_16_16;
                17: axi_wdata <= reg_config_int8_int32_32_16_8 ;
                18: axi_wdata <= reg_config_int8_int32_8_16_32 ;

                default: axi_wdata <= reg_config_int4_16_16_16 ; 
            endcase
        end
    end


    // 实现主命令接口状态机
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 1'b0) begin
                // 复位条件
                // 所有信号在复位条件下赋默认值
                mst_exec_state     <= IDLE;
                start_single_write <= 1'b0;
                write_issued       <= 1'b0;
                start_single_read  <= 1'b0;
                read_issued        <= 1'b0;
                compare_done       <= 1'b0;
                ERROR              <= 1'b0;
            end else begin
            // 状态转移
                case (mst_exec_state)

                    IDLE:
                    // 此状态负责在 init_txn_pulse 置位时启动 AXI 事务
                    if (init_txn_pulse == 1'b1) begin
                        mst_exec_state <= INIT_WRITE_REG_CONFIGURE_TEST;
                        ERROR          <= 1'b0;
                        compare_done   <= 1'b0;
                    end else begin
                        mst_exec_state <= IDLE;
                    end

                    //此状态用来发送所有数据集的配置
                    INIT_WRITE_REG_CONFIGURE_TEST: begin
                        // 此状态负责发出 start_single_write 脉冲以启动写事务。
                        // 写事务会一直发出直到 last_write 信号置位。
                        // 写控制器
                        if (writes_done) begin
                            mst_exec_state <= INIT_COMPARE;  //
                        end else begin
                            mst_exec_state <= INIT_WRITE_REG_CONFIGURE_TEST;

                            if (~axi_awvalid && ~axi_wvalid && ~M_AXI_BVALID && ~last_write && ~start_single_write && ~write_issued) begin
                                start_single_write <= 1'b1;
                                write_issued       <= 1'b1;
                            end else if (axi_bready) begin
                                write_issued       <= 1'b0;
                            end else begin
                                start_single_write <= 1'b0;  // 取反以产生脉冲
                            end
                        end
                    end
                    

                    //跳过，暂时不需要读通道，直接写完成即可
                    INIT_READ:
                    // 此状态负责发出 start_single_read 脉冲以启动读事务。
                    // 读事务会一直发出直到 last_read 信号置位。
                    // 读控制器
                    if (reads_done) begin
                        mst_exec_state <= INIT_COMPARE;
                    end else begin
                        mst_exec_state <= INIT_READ;

                        if (~axi_arvalid && ~M_AXI_RVALID && ~last_read && ~start_single_read && ~read_issued) begin
                            start_single_read <= 1'b1;
                            read_issued       <= 1'b1;
                        end else if (axi_rready) begin
                            read_issued       <= 1'b0;
                        end else begin
                            start_single_read <= 1'b0;  // 取反以产生脉冲
                        end
                    end

                    INIT_COMPARE: begin
                    // 此状态负责比较写入数据与读出数据。如果没有错误标志，compare_done 置位表示成功。
                        ERROR          <= error_reg;
                        mst_exec_state <= IDLE;
                        compare_done   <= 1'b1;
                    end

                    default: begin
                        mst_exec_state <= IDLE;
                    end
                endcase
            end
        end  // MASTER_EXECUTION_PROC


/****************************************** axi内部时序逻辑 *************************************/ 
    //检测启动信号上升沿并启动AXI事务的脉冲的块
        always @(posedge M_AXI_ACLK) begin
            // 启动 AXI 事务延迟
            if (M_AXI_ARESETN == 0) begin
                init_txn_ff  <= 1'b0;
                init_txn_ff2 <= 1'b0;
            end else begin
                init_txn_ff  <= INIT_AXI_TXN;
                init_txn_ff2 <= init_txn_ff;
            end
        end




	//以下是axi的通道的控制信号
	//-------------------------------------- 写地址通道 --------------------------------------//
        // 写地址通道用于请求整个事务的地址和命令信息。仅需一次传输。

        // 注意：本例中 axi_awvalid/axi_wvalid 同时置位，然后各自独立去置零。
        // 这是一种较低性能但更简单的控制方案。

        // AXI VALID 信号必须在被对方接受前一直保持有效。

        // 当主机有 VALID 数据且从机也 READY 时，数据传输被从机接受。
        // 虽然主机可以通过不去置零 VALID 信号来连续发起多个请求，
        // 但本设计为简化起见会插入空闲周期。

        // 由于用户设计只发起一个未完成的事务，
        // 不会出现新请求与已接受请求在同一时钟周期冲突的情况。

        always @(posedge M_AXI_ACLK) begin
            // 仅在复位时需要去置零 VALID 信号，符合 AXI 规范
            // 可考虑反向后寄存低有效复位以提高最高频率
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                axi_awvalid <= 1'b0;
            end  // 用户逻辑发出新地址/数据命令时置位
            else begin
                if (start_single_write) begin
                    axi_awvalid <= 1'b1;
                end  // 从机发出 M_AXI_AWREADY 时地址被接受
                else if (M_AXI_AWREADY && axi_awvalid) begin
                    axi_awvalid <= 1'b0;
                end
            end
        end

        // 写地址
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                axi_awaddr <= 0;
            end  // 用户逻辑发出新写地址/写数据时
            else if (M_AXI_AWREADY && axi_awvalid) begin
                axi_awaddr <= 0;
                // axi_awaddr <= axi_awaddr + 32'h00000004;
            end
        end


	//-------------------------------------- 写数据通道 --------------------------------------//
        // 写数据通道用于传输实际数据。
        // 数据生成方式与本例相关，仅展示 WVALID/WREADY 握手

        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                axi_wvalid <= 1'b0;
            end  // 用户逻辑发出新地址/数据命令时置位
                else if (start_single_write) begin
                    axi_wvalid <= 1'b1;
                end  // 从机发出 M_AXI_WREADY 时数据被接受
                else if (M_AXI_WREADY && axi_wvalid) begin
                    axi_wvalid <= 1'b0;
            end
        end

        // 写数据生成单独进行控制
        // always @(posedge M_AXI_ACLK) begin
        //     if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
        //         axi_wdata <= C_M_START_DATA_VALUE;
        //     end  // 用户逻辑发出新写地址/写数据时
        //     else if (M_AXI_WREADY && axi_wvalid) begin
        //         axi_wdata <= ;
        //     end
        // end


	//-------------------------------------- 写响应 (B) 通道 ---------------------------------//                                                                                                                                                                                                          
        // 写响应通道用于反馈写操作已提交到存储器。
        // BREADY 会在数据和写地址都被从机接受后发出，
        // 可保证后续访问不会被重排序到其前面。

        // BRESP[1] 用于指示互连或从机的写突发错误。本例会捕获该错误。

        // 虽然规范未强制要求，但建议在主从复位延迟不同的情况下去置零 READY 信号。

        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                axi_bready <= 1'b0;
            end  // 主机用 axi_bready 接受/确认 bresp，当从机发出 M_AXI_BVALID 时
            else if (M_AXI_BVALID && ~axi_bready) begin
                axi_bready <= 1'b1;
            end  // 一个时钟周期后去置零
            else if (axi_bready) begin
                axi_bready <= 1'b0;
            end  // 保持原值
            else axi_bready <= axi_bready;
        end

        // 写错误标志
        assign write_resp_error = (axi_bready & M_AXI_BVALID & M_AXI_BRESP[1]);


	//-------------------------------------- 读地址通道 --------------------------------------//
        // start_single_read 触发新读事务。read_index 计数器用于跟踪已发起的读事务数量

        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
            read_index <= 0;
            end  // 用户逻辑发出新读地址时
            else if (start_single_read) begin
            read_index <= read_index + 1;
            end
        end

        // 有效读地址可用时置位 axi_arvalid。start_single_read 触发新读事务
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                axi_arvalid <= 1'b0;
            end  // 用户逻辑发出新读地址命令时置位
            else if (start_single_read) begin
                axi_arvalid <= 1'b1;
            end  // 从机发出 M_AXI_ARREADY 时地址被接受
            else if (M_AXI_ARREADY && axi_arvalid) begin
                axi_arvalid <= 1'b0;
            end
            // 保持原值
        end

        // 读地址
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                axi_araddr <= 0;
            end  // 用户逻辑发出新写地址/写数据时
            else if (M_AXI_ARREADY && axi_arvalid) begin
                axi_araddr <= axi_araddr + 32'h00000004;        //每次加4，是因为每个数据占4个字节
            end
        end


	//-------------------------------------- 读数据 (和响应) 通道 -----------------------------//                                                                                                                                                                                                                                                                              
        // 读数据通道返回读请求的结果
        // 主机在有有效读数据时通过置位 axi_rready 接收数据
        // 虽然规范未强制要求，但建议在主从复位延迟不同的情况下去置零 READY 信号。

        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
            axi_rready <= 1'b0;
            end  // 主机用 axi_rready 接受/确认 rdata/rresp，当从机发出 M_AXI_RVALID 时
            else if (M_AXI_RVALID && ~axi_rready) begin
            axi_rready <= 1'b1;
            end  // 一个时钟周期后去置零
            else if (axi_rready) begin
            axi_rready <= 1'b0;
            end
            // 保持原值
        end

        // 读错误标志
        assign read_resp_error = (axi_rready & M_AXI_RVALID & M_AXI_RRESP[1]);


    // 地址/数据激励
    // 本例的地址/数据对。读写值应一致。
    // 如需不同地址模式可自行修改。
    //-------------------------------------- 写有关信号控制通道 -------------------------------//                                                                                                                                                                                                                                                                              
        // start_single_write 触发新写事务
        // write_index 计数器用于跟踪已发起的写事务数量
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
                write_index <= 0;
            end  // 用户逻辑发出新写地址/写数据时
            else if (start_single_write) begin
                write_index <= write_index + 1;
            end
        end

        // 终端写计数
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) last_write <= 1'b0;

            // 最后一次写应与写地址就绪响应相关联
            else if ((write_index == C_M_TRANSACTIONS_NUM) && M_AXI_AWREADY) last_write <= 1'b1;
            else last_write <= last_write;
        end

        // 检查最后一次写完成
        // 此逻辑用于将最后一次写计数与最终写响应进行确认。演示如何确认写已提交。
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) writes_done <= 1'b0;

            // writes_done 应与 bready 响应相关联
            else if (last_write && M_AXI_BVALID && axi_bready) writes_done <= 1'b1;
            else writes_done <= writes_done;
        end


	//-------------------------------------- 读有关信号控制通道 -------------------------------//
        


        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) begin
            expected_rdata <= C_M_START_DATA_VALUE;
            end  // 用户逻辑发出新写地址/写数据时
            else if (M_AXI_RVALID && axi_rready) begin
            expected_rdata <= C_M_START_DATA_VALUE + read_index;
            end
        end

        // 终端读计数
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) last_read <= 1'b0;

            // 最后一次读应与读地址就绪响应相关联
            else if ((read_index == C_M_TRANSACTIONS_NUM) && (M_AXI_ARREADY)) last_read <= 1'b1;
            else last_read <= last_read;
        end

        //检查最后一次读完成。
        //此逻辑用于将最后一次读计数与最终读响应/数据进行确认。
        always @(posedge M_AXI_ACLK) begin
            if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) reads_done <= 1'b0;

            // reads_done 应与读就绪响应相关联
            else if (last_read && M_AXI_RVALID && axi_rready) reads_done <= 1'b1;
            else reads_done <= reads_done;
        end

        // 数据比较
            always @(posedge M_AXI_ACLK) begin
                if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) read_mismatch <= 1'b0;

                // 有效读数据时（axi_rready 置位）与期望数据比较
                else if ((M_AXI_RVALID && axi_rready) && (M_AXI_RDATA != expected_rdata)) read_mismatch <= 1'b1;
                else read_mismatch <= read_mismatch;
            end     


	//-------------------------------------- 错误信号 -------------------------------//
        // 寄存并保持所有数据不匹配或读写接口错误
            always @(posedge M_AXI_ACLK) begin
                if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1) 
                    error_reg <= 1'b0;
                // 捕获所有错误类型
                else if (read_mismatch || write_resp_error || read_resp_error) 
                    error_reg <= 1'b1;
                else error_reg <= error_reg;
            end

endmodule

