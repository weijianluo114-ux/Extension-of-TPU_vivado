`timescale 1ns / 1ps
///////////////////////////////////创建文件信息////////////////////////////////////
  // Company: 
  // Engineer: 
  // 
  // Create Date: 2025/03/12 13:12:07
  // Design Name: 
  // Module Name: bram_axi_tb
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

/******************************** 头文件引用 ************************/
  `include "top_parameter.vh"

module AXI_FULL_crtl_test (
    input wire  clk,
    input wire  rst_n,

    input wire  AXI_FULL_start,

    output wire the_last_matrix,     //标志着最后一个矩阵从ddr3读出来

    output reg       AXI_FULL_test_effective,            
    input wire       READ_TXN_DONE,            
    input wire       WRITE_TXN_DONE,           
    input wire       init_calib_complete,
    output reg [1:0] axi_work_state,           

    input wire [`AXI_ADDR_WIDTH-1:0] axi_ar_addr_temp,    //暂存的读地址
    input wire [`AXI_DATA_WIDTH-1:0] test_r_data,         //测试用
    input wire [`AXI_DATA_WIDTH-1:0] test_w_data,  
    input wire                       read_flag,           //标志axi正在读的信号         
    input wire                       write_flag,          //标志axi正在写的信号         
    input wire                       ar_effective             

    );

/******************************* 函数 ************************************/
	 // 函数clogb2返回一个整数，该整数具有log以2为底的上限的值。实现方法是将一个二进制数一直右移，
	 // 然后看这个数是否到0，没到0就继续右移，直至将所有的1移出，得到这个数是其非0位数                 
	  function integer clogb2 (input integer bit_depth);              
	  begin                                                           
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	      bit_depth = bit_depth >> 1;                                 
	    end                                                           
	  endfunction


/******************************* 参数 ***********************************/
  //------------------------------- 普通参数 ---------------------------//
    parameter TOTAL_DATA_NUM_CNT_WIDTH = clogb2(`TOTAL_DATA_NUM-1);
    parameter AXI_BURST_SIZE_BYTE = 64;            //一次突发传输的字节数

  //------------------------------- 本地参数 ---------------------------//
    localparam CLOCK_PERIOD           = 5;         //200MHz的时钟周期

    localparam TEST_IDLE              = 3'b000,    //空闲态
               TEST_LOAD_DATA_TO_DDR3 = 3'b001,    //装载数据态
               TEST_COMPUTE           = 3'b010,
               TEST_DATA_DONE         = 3'b011;    //计算态

    localparam AXI_IDLE               = 2'b00,    //axi空闲态，目前未知其用处未知
               AXI_LOAD_DATA_TO_DDR3  = 2'b01,    //axi的读写操作状态，此时为从bram读取数据并载入数据至ddr3
               AXI_COMPUTE            = 2'b10;    //axi的计算操作状态，此时开始从ddr3中读取数据至TPU

    localparam INT4_NUM = `AXI_DATA_WIDTH/`INT4,  //各种精度下，128位数据位宽能存储的数据个数
               INT8_NUM = `AXI_DATA_WIDTH/`INT8,
               FP16_NUM = `AXI_DATA_WIDTH/`FP16,
               FP32_NUM = `AXI_DATA_WIDTH/`FP32;

    localparam INT4_16_16_16       = 1 ,           //不同矩阵状态
               INT4_32_16_8        = 2 ,                   
               INT4_8_16_32        = 3 ,
               INT8_16_16_16       = 4 ,
               INT8_32_16_8        = 5 ,
               INT8_8_16_32        = 6 ,
               FP16_16_16_16       = 7 ,
               FP16_32_16_8        = 8 ,
               FP16_8_16_32        = 9 ,
               FP32_16_16_16       = 10,
               FP32_32_16_8        = 11,
               FP32_8_16_32        = 12,
               INT4_16_16_16_INT32 = 13,
               INT4_32_16_8_INT32  = 14,
               INT4_8_16_32_INT32  = 15,
               INT8_16_16_16_INT32 = 16,
               INT8_32_16_8_INT32  = 17,
               INT8_8_16_32_INT32  = 18,
               STOP                = 19;

    localparam INT4_16_16_16_BASE_ADDR       = 29'd0 ,           //不同矩阵的基址
               INT4_32_16_8_BASE_ADDR        = 29'd384,                   
               INT4_8_16_32_BASE_ADDR        = 29'd832,
               INT8_16_16_16_BASE_ADDR       = 29'd1280 ,
               INT8_32_16_8_BASE_ADDR        = 29'd2048 ,
               INT8_8_16_32_BASE_ADDR        = 29'd2944 ,
               FP16_16_16_16_BASE_ADDR       = 29'd3840 ,
               FP16_32_16_8_BASE_ADDR        = 29'd5376 ,
               FP16_8_16_32_BASE_ADDR        = 29'd7168 ,
               FP32_16_16_16_BASE_ADDR       = 29'd8960,
               FP32_32_16_8_BASE_ADDR        = 29'd12032,
               FP32_8_16_32_BASE_ADDR        = 29'd15616,
               INT4_16_16_16_INT32_BASE_ADDR = 29'd19200,
               INT4_32_16_8_INT32_BASE_ADDR  = 29'd20480,
               INT4_8_16_32_INT32_BASE_ADDR  = 29'd21824,
               INT8_16_16_16_INT32_BASE_ADDR = 29'd23168,
               INT8_32_16_8_INT32_BASE_ADDR  = 29'd24704,
               INT8_8_16_32_INT32_BASE_ADDR  = 29'd26368;
         

/******************************* 信号 ***********************************/
  //------------------------------- 寄存器型 ---------------------------//
                                  
    reg [2:0]                           test_state;                //测试状态机信号

    reg [4:0]                           ddr_matrix_state = 0;      //从ddr3中读取数据时矩阵的状态
    reg [4:0]                           r_ddr_matrix_state = 0;    //记录上一次的矩阵状态

    reg [4:0]                           bram_matrix_state = 0;     //从bram中读取数据时矩阵的状态

    
    reg [TOTAL_DATA_NUM_CNT_WIDTH-1:0]  read_bram_data_num_cnt;    //计数从bram中读取的数据量，以128位计为一个数据
    reg [TOTAL_DATA_NUM_CNT_WIDTH-1:0]  read_ddr3_data_num_cnt;    //计数从ddr3中读取的数据量，以128位计为一个数据

    reg                                 read_ddr3_data_num_cnt_en; //计数器使能 

    reg                                 r_read_all_bram_data = 0;  //维持读完bram信号为高电平

    reg [`AXI_ADDR_WIDTH-1:0]           axi_ar_base_addr = 0;          //每个矩阵的基址


  //测试信号

  //------------------------------- 网表型 ---------------------------//
    wire [`AXI_DATA_WIDTH-1:0] r_test_r_data;         //记录上一个时刻读的数据        
    wire [`AXI_DATA_WIDTH-1:0] r_test_w_data;         //记录上一个时刻读的数据        
    wire               ddr_matrix_state_change;       //指示矩阵状态改变

    //测试信号
    wire [`INT4-1:0]   r_data_vector_int4 [INT4_NUM-1:0];  
    wire [`INT8-1:0]   r_data_vector_int8 [INT8_NUM-1:0];
    wire [`FP16-1:0]   r_data_vector_fp16 [FP16_NUM-1:0];
    wire [`FP32-1:0]   r_data_vector_fp32 [FP32_NUM-1:0];
    wire [`INT4-1:0]   w_data_vector_int4 [INT4_NUM-1:0];  
    wire [`INT8-1:0]   w_data_vector_int8 [INT8_NUM-1:0];
    wire [`FP16-1:0]   w_data_vector_fp16 [FP16_NUM-1:0];
    wire [`FP32-1:0]   w_data_vector_fp32 [FP32_NUM-1:0];

    wire               read_all_bram_data;    //指示读完所有bram中的数据
    wire               read_all_ddr3_data;    //指示读完所有ddr3中的数据


/******************************* 时序逻辑 ********************************/
  //-------------------------------- 状态机FSM --------------------------//
    always @(posedge clk) begin
      if (!rst_n) begin   //复位
        test_state     <= TEST_IDLE;
        AXI_FULL_test_effective  <= 0;
        axi_work_state <= AXI_IDLE; 
      end else begin
        case (test_state)

          //空闲态，用来等待计算开始信号
          TEST_IDLE: begin
            if (AXI_FULL_start) begin                     //等待开始信号
                test_state <= TEST_LOAD_DATA_TO_DDR3; 
            end else test_state <= TEST_IDLE;
          end

          //载入数据态，用来将bram里面的coe数据文件写入ddr3，做一个类似于总线存储至ddr3的操作
          TEST_LOAD_DATA_TO_DDR3: begin
            if (init_calib_complete) begin
                if (r_read_all_bram_data) begin                     //注意axi协议不允许中途突然间暂停，否则会出错
                    if (WRITE_TXN_DONE) begin
                      test_state        <= TEST_COMPUTE;            //指示读完则将状态转至计算态
                      //恢复初态
                      AXI_FULL_test_effective     <= 0;  
                    end else begin               
                      AXI_FULL_test_effective     <= 1;             //继续拉高直至读完
                      axi_work_state    <= TEST_LOAD_DATA_TO_DDR3;
                    end
                    // axi_work_state    <= AXI_IDLE;
                end else if (READ_TXN_DONE && ~read_all_bram_data) begin
                    AXI_FULL_test_effective     <= 0;
                    axi_work_state    <= AXI_LOAD_DATA_TO_DDR3;     //告诉axi接口开始将bram的数据载入至ddr3
                end else begin
                    AXI_FULL_test_effective  <= 1;                  //axi读取数据至DDR3有效信号，启动axi
                    axi_work_state <= AXI_LOAD_DATA_TO_DDR3;        //告诉axi接口开始将bram的数据载入至ddr3
                    test_state     <= TEST_LOAD_DATA_TO_DDR3;
                end    
            end else test_state <= TEST_LOAD_DATA_TO_DDR3;
             
          end

          //开始计算状态
          TEST_COMPUTE: begin
            if (READ_TXN_DONE && ~read_all_ddr3_data) begin
              AXI_FULL_test_effective  <= 0;                        //启动axi，开始从ddr3中读取数据  
              axi_work_state           <= AXI_COMPUTE;              //保持axi为可使用状态
            end 
            
            else if (read_all_ddr3_data) begin                      //注意axi协议不允许中途突然间暂停，否则会出错
              test_state        <= TEST_IDLE;                       //指示读完则将状态转至计算态
              //恢复初态
              AXI_FULL_test_effective <= 0;
            end 
            
            else begin
                AXI_FULL_test_effective <= 1;                      //axi有效信号，启动axi
                axi_work_state <= AXI_COMPUTE;                     //告诉axi接口开始将bram的数据载入至ddr3
                test_state     <= TEST_COMPUTE;
            end 
          end

          default: begin 
            AXI_FULL_test_effective <= 0;                           //启动axi，开始从ddr3中读取数据  
            test_state    <= TEST_IDLE;                             //默认处于空闲态
          end
        endcase
      end
    end


  //-------------------------------- 从ddr3中读取矩阵数据处于各种矩阵的状态 ------------------//
    //读出每一个矩阵的基址
    always @(posedge clk) begin
        if (!rst_n) begin
            axi_ar_base_addr <= 0;
        end else if (ddr_matrix_state_change) begin
            if (ddr_matrix_state == INT4_16_16_16) begin
                axi_ar_base_addr <= 0;    
            end 
            else if ((ddr_matrix_state > 0) && (ddr_matrix_state <= INT8_8_16_32_INT32)) begin
                axi_ar_base_addr <= axi_ar_addr_temp;
            end
            else axi_ar_base_addr <= axi_ar_base_addr;
        end
        else axi_ar_base_addr <= axi_ar_base_addr;
    end

    //记录上一个周期的矩阵状态以达到知道矩阵变化的目的
        always @(posedge clk) begin
            r_ddr_matrix_state <= ddr_matrix_state;
        end

    //当数据计数器达到某一个矩阵的起始值的时候切换矩阵的状态
    always @(*) begin
        case (ddr_matrix_state)
            0: begin
                if ((read_ddr3_data_num_cnt >= 0) && (read_ddr3_data_num_cnt_en)) begin
                    ddr_matrix_state <= INT4_16_16_16;
                end
            end
            INT4_16_16_16: begin
                if (read_ddr3_data_num_cnt >= 24) begin
                    ddr_matrix_state <= INT4_32_16_8;
                end
            end       
            INT4_32_16_8: begin
                if (read_ddr3_data_num_cnt >= 52) begin
                    ddr_matrix_state <= INT4_8_16_32;
                end
            end        
            INT4_8_16_32: begin
                if (read_ddr3_data_num_cnt >= 80) begin
                    ddr_matrix_state <= INT8_16_16_16;
                end
            end        
            INT8_16_16_16: begin
                if (read_ddr3_data_num_cnt >= 128) begin
                    ddr_matrix_state <= INT8_32_16_8;
                end
            end       
            INT8_32_16_8: begin
                if (read_ddr3_data_num_cnt >= 184) begin
                    ddr_matrix_state <= INT8_8_16_32;
                end
            end        
            INT8_8_16_32: begin
                if (read_ddr3_data_num_cnt >= 240) begin
                    ddr_matrix_state <= FP16_16_16_16;
                end
            end        
            FP16_16_16_16: begin
                if (read_ddr3_data_num_cnt >= 336) begin
                    ddr_matrix_state <= FP16_32_16_8;
                end
            end       
            FP16_32_16_8: begin
                if (read_ddr3_data_num_cnt >= 448) begin
                    ddr_matrix_state <= FP16_8_16_32;
                end
            end        
            FP16_8_16_32: begin
                if (read_ddr3_data_num_cnt >= 560) begin
                    ddr_matrix_state <= FP32_16_16_16;
                end
            end        
            FP32_16_16_16: begin
                if (read_ddr3_data_num_cnt >= 752) begin
                    ddr_matrix_state <= FP32_32_16_8;
                end
            end       
            FP32_32_16_8: begin
                if (read_ddr3_data_num_cnt >= 976) begin
                    ddr_matrix_state <= FP32_8_16_32;
                end
            end        
            FP32_8_16_32: begin
                if (read_ddr3_data_num_cnt >= 1200) begin
                    ddr_matrix_state <= INT4_16_16_16_INT32;
                end
            end        
            INT4_16_16_16_INT32: begin
                if (read_ddr3_data_num_cnt >= 1280) begin
                    ddr_matrix_state <= INT4_32_16_8_INT32;
                end
            end 
            INT4_32_16_8_INT32: begin
                if (read_ddr3_data_num_cnt >= 1364) begin
                    ddr_matrix_state <= INT4_8_16_32_INT32;
                end
            end  
            INT4_8_16_32_INT32: begin
                if (read_ddr3_data_num_cnt >= 1448) begin
                    ddr_matrix_state <= INT8_16_16_16_INT32;
                end
            end  
            INT8_16_16_16_INT32: begin
                if (read_ddr3_data_num_cnt >= 1544) begin
                    ddr_matrix_state <= INT8_32_16_8_INT32;
                end
            end 
            INT8_32_16_8_INT32: begin
                if (read_ddr3_data_num_cnt >= 1648) begin
                    ddr_matrix_state <= INT8_8_16_32_INT32;
                end
            end  
            INT8_8_16_32_INT32: begin
                if (read_ddr3_data_num_cnt == 0) begin
                     ddr_matrix_state <= STOP;
                end
            end
            STOP:    ddr_matrix_state <= STOP;   
            default: ddr_matrix_state <= STOP;
        endcase
    end

     
  //-------------------------------- 从bram中读取矩阵数据处于各种矩阵的状态 ------------------//
 
    //当数据计数器达到某一个矩阵的起始值的时候切换矩阵的状态
        always @(*) begin
            case (bram_matrix_state)
                0: begin
                    if ((read_bram_data_num_cnt >= 0) && (read_flag)) begin
                        bram_matrix_state <= INT4_16_16_16;
                    end
                end
                INT4_16_16_16: begin
                    if (read_bram_data_num_cnt >= 24) begin
                        bram_matrix_state <= INT4_32_16_8;
                    end
                end       
                INT4_32_16_8: begin
                    if (read_bram_data_num_cnt >= 52) begin
                        bram_matrix_state <= INT4_8_16_32;
                    end
                end        
                INT4_8_16_32: begin
                    if (read_bram_data_num_cnt >= 80) begin
                        bram_matrix_state <= INT8_16_16_16;
                    end
                end        
                INT8_16_16_16: begin
                    if (read_bram_data_num_cnt >= 128) begin
                        bram_matrix_state <= INT8_32_16_8;
                    end
                end       
                INT8_32_16_8: begin
                    if (read_bram_data_num_cnt >= 184) begin
                        bram_matrix_state <= INT8_8_16_32;
                    end
                end        
                INT8_8_16_32: begin
                    if (read_bram_data_num_cnt >= 240) begin
                        bram_matrix_state <= FP16_16_16_16;
                    end
                end        
                FP16_16_16_16: begin
                    if (read_bram_data_num_cnt >= 336) begin
                        bram_matrix_state <= FP16_32_16_8;
                    end
                end       
                FP16_32_16_8: begin
                    if (read_bram_data_num_cnt >= 448) begin
                        bram_matrix_state <= FP16_8_16_32;
                    end
                end        
                FP16_8_16_32: begin
                    if (read_bram_data_num_cnt >= 560) begin
                        bram_matrix_state <= FP32_16_16_16;
                    end
                end        
                FP32_16_16_16: begin
                    if (read_bram_data_num_cnt >= 752) begin
                        bram_matrix_state <= FP32_32_16_8;
                    end
                end       
                FP32_32_16_8: begin
                    if (read_bram_data_num_cnt >= 976) begin
                        bram_matrix_state <= FP32_8_16_32;
                    end
                end        
                FP32_8_16_32: begin
                    if (read_bram_data_num_cnt >= 1200) begin
                        bram_matrix_state <= INT4_16_16_16_INT32;
                    end
                end        
                INT4_16_16_16_INT32: begin
                    if (read_bram_data_num_cnt >= 1280) begin
                        bram_matrix_state <= INT4_32_16_8_INT32;
                    end
                end 
                INT4_32_16_8_INT32: begin
                    if (read_bram_data_num_cnt >= 1364) begin
                        bram_matrix_state <= INT4_8_16_32_INT32;
                    end
                end  
                INT4_8_16_32_INT32: begin
                    if (read_bram_data_num_cnt >= 1448) begin
                        bram_matrix_state <= INT8_16_16_16_INT32;
                    end
                end  
                INT8_16_16_16_INT32: begin
                    if (read_bram_data_num_cnt >= 1544) begin
                        bram_matrix_state <= INT8_32_16_8_INT32;
                    end
                end 
                INT8_32_16_8_INT32: begin
                    if (read_bram_data_num_cnt >= 1648) begin
                        bram_matrix_state <= INT8_8_16_32_INT32;
                    end
                end  
                INT8_8_16_32_INT32: begin
                    if (read_bram_data_num_cnt == 0) begin
                        bram_matrix_state <= STOP;
                    end
                end 
                STOP:    bram_matrix_state <= STOP;  
                default: bram_matrix_state <= STOP;
            endcase
        end


  //-------------------------------- bram读数据量计数器 ------------------//
    always @(posedge clk) begin
      if (!rst_n) begin
        read_bram_data_num_cnt <= 'b0;
      end else if (read_all_bram_data) begin
        read_bram_data_num_cnt <= 'b0;
      end else if (read_flag && (test_state == TEST_LOAD_DATA_TO_DDR3) && (~r_read_all_bram_data)) begin
        read_bram_data_num_cnt <= read_bram_data_num_cnt+1;
      end else begin
        read_bram_data_num_cnt <= read_bram_data_num_cnt;
      end
    end


  //-------------------------------- ddr3读数据量计数器 ------------------//
    //计数器使能控制
    always @(posedge clk) begin
      if (!rst_n) begin
        read_ddr3_data_num_cnt_en     <=  1'b0;
      end 
      else if (test_state == TEST_COMPUTE) begin
        if (read_all_ddr3_data) begin
            read_ddr3_data_num_cnt_en <=  1'b0;
        end 
        else read_ddr3_data_num_cnt_en <= 1'b1;    
      end 
      else read_ddr3_data_num_cnt_en <= 1'b0;
    end

    always @(posedge clk) begin
      if (!rst_n) begin
        read_ddr3_data_num_cnt    <=  'b0;
      end else if (read_all_ddr3_data) begin
        read_ddr3_data_num_cnt    <= 'b0;
      end else if (read_flag && read_ddr3_data_num_cnt_en) begin
        read_ddr3_data_num_cnt <= read_ddr3_data_num_cnt+1;
      end else begin
        read_ddr3_data_num_cnt <= read_ddr3_data_num_cnt;
      end
    end
     

    always @(posedge clk) begin
      if (read_all_bram_data) begin
        r_read_all_bram_data <= 1;
      end else r_read_all_bram_data <= r_read_all_bram_data;
    end


/******************************* 组合逻辑 ********************************/
  //以下为测试逻辑，即将读取的数据分成n个128/n位数据，128/n为精度
    genvar i;
    generate
        for (i = 0; i<INT4_NUM; i = i+1) begin
            assign r_data_vector_int4[i] = r_test_r_data[`INT4*(i+1)-1 -: `INT4];
            assign w_data_vector_int4[i] = r_test_w_data[`INT4*(i+1)-1 -: `INT4];
        end
    endgenerate

    generate
        for (i = 0; i<INT8_NUM; i = i+1) begin
            assign r_data_vector_int8[i] = r_test_r_data[`INT8*(i+1)-1 -: `INT8];
            assign w_data_vector_int8[i] = r_test_w_data[`INT8*(i+1)-1 -: `INT8];
        end
    endgenerate

    generate
        for (i = 0; i<FP16_NUM; i = i+1) begin
            assign r_data_vector_fp16[i] = r_test_r_data[`FP16*(i+1)-1 -: `FP16];
            assign w_data_vector_fp16[i] = r_test_w_data[`FP16*(i+1)-1 -: `FP16];
        end
    endgenerate

    generate
        for (i = 0; i<FP32_NUM; i = i+1) begin
            assign r_data_vector_fp32[i] = r_test_r_data[`FP32*(i+1)-1 -: `FP32];
            assign w_data_vector_fp32[i] = r_test_w_data[`FP32*(i+1)-1 -: `FP32];
        end
    endgenerate



  //检测bram读数据量计数器是否达到最大值
  assign read_all_bram_data      = (read_bram_data_num_cnt == (`TOTAL_DATA_NUM-1));    //指示读完所有bram中的数据
  //检测ddr3读数据量计数器是否达到最大值
  assign read_all_ddr3_data      = (read_ddr3_data_num_cnt == (`TOTAL_DATA_NUM-1));    //指示读完所有bram中的数据

  //将正确的data输出出来，其余全部置0
  assign r_test_r_data           = (read_flag) ? test_r_data : 'b0;

  assign r_test_w_data           = (write_flag) ? test_w_data : 'b0;

  //以下逻辑是为了检测矩阵变化
  assign ddr_matrix_state_change = (r_ddr_matrix_state != ddr_matrix_state);

  //标志最后一个矩阵从ddr3中读出
  assign the_last_matrix         = ddr_matrix_state == INT8_8_16_32_INT32;


/******************************* 模块例化 ********************************/

endmodule

