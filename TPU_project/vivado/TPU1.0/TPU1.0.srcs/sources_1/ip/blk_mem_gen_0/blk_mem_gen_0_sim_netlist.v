// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Mar 17 16:58:37 2026
// Host        : Simple running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               E:/electronic2/project/verilog_pro/TPU_vivado/TPU1.0/TPU1.0.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcvu9p-flga2104-2L-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF AXI_SLAVE_S_AXI:AXILite_SLAVE_S_AXI, ASSOCIATED_RESET s_aresetn, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input s_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWID" *) (* x_interface_parameter = "XIL_INTERFACENAME AXI_SLAVE_S_AXI, DATA_WIDTH 128, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 4, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.000, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [3:0]s_axi_awid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWADDR" *) input [31:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWLEN" *) input [7:0]s_axi_awlen;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWSIZE" *) input [2:0]s_axi_awsize;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWBURST" *) input [1:0]s_axi_awburst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI WDATA" *) input [127:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI WSTRB" *) input [15:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI WLAST" *) input s_axi_wlast;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI BID" *) output [3:0]s_axi_bid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARID" *) input [3:0]s_axi_arid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARADDR" *) input [31:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARLEN" *) input [7:0]s_axi_arlen;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARSIZE" *) input [2:0]s_axi_arsize;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARBURST" *) input [1:0]s_axi_arburst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI RID" *) output [3:0]s_axi_rid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI RDATA" *) output [127:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI RLAST" *) output s_axi_rlast;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXI_SLAVE_S_AXI RREADY" *) input s_axi_rready;

  wire s_aclk;
  wire s_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [127:0]s_axi_rdata;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [127:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [15:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [127:0]NLW_U0_douta_UNCONNECTED;
  wire [127:0]NLW_U0_doutb_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "8" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     31.967058 mW" *) 
  (* C_FAMILY = "virtexuplus" *) 
  (* C_HAS_AXI_ID = "1" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "1" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1752" *) 
  (* C_READ_DEPTH_B = "1752" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "128" *) 
  (* C_READ_WIDTH_B = "128" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "16" *) 
  (* C_WEB_WIDTH = "16" *) 
  (* C_WRITE_DEPTH_A = "1752" *) 
  (* C_WRITE_DEPTH_B = "1752" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "128" *) 
  (* C_WRITE_WIDTH_B = "128" *) 
  (* C_XDEVICEFAMILY = "virtexuplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_2 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(1'b0),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[127:0]),
        .doutb(NLW_U0_doutb_UNCONNECTED[127:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arid(s_axi_arid),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awid(s_axi_awid),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(s_axi_bid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(s_axi_rid),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .web({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_axi_read_fsm" *) 
module blk_mem_gen_0_blk_mem_axi_read_fsm
   (\gaxi_full_sm.r_valid_r_reg_0 ,
    SR,
    s_axi_arready,
    s_axi_rlast,
    \FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ,
    s_axi_arlen_0_sp_1,
    D,
    s_axi_arvalid_0,
    \s_axi_arlen[7] ,
    \gaxi_full_sm.arlen_cntr_reg[4] ,
    \s_axi_arid[3] ,
    E,
    \gaxi_full_sm.outstanding_read_r_reg_0 ,
    \s_axi_araddr[14] ,
    ADDRBWRADDR,
    \gaxi_full_sm.r_valid_r_reg_1 ,
    s_axi_arvalid_1,
    s_axi_arvalid_2,
    \s_axi_arburst[1] ,
    s_aclk,
    s_aresetn,
    s_axi_rready,
    s_axi_arvalid,
    s_axi_arlen,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[3] ,
    s_axi_araddr,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[2] ,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1] ,
    \gaxi_full_sm.arlen_cntr_reg[6] ,
    Q,
    \gaxi_full_sm.arlen_cntr_reg[5] ,
    \gaxi_full_sm.arlen_cntr_reg[5]_0 ,
    \gaxi_full_sm.arlen_cntr_reg[3] ,
    \gaxi_full_sm.arlen_cntr_reg[4]_0 ,
    \gaxi_full_sm.arlen_cntr_reg[7] ,
    \gaxi_full_sm.arlen_cntr_reg[7]_0 ,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0] ,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] ,
    s_axi_arsize,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4]_0 ,
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0]_0 ,
    s_axi_arid,
    \grid.S_AXI_RID_reg[3] ,
    addr_cnt_enb_r,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    incr_en_r,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ,
    s_axi_arburst);
  output \gaxi_full_sm.r_valid_r_reg_0 ;
  output [0:0]SR;
  output s_axi_arready;
  output s_axi_rlast;
  output [0:0]\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ;
  output s_axi_arlen_0_sp_1;
  output [4:0]D;
  output s_axi_arvalid_0;
  output [7:0]\s_axi_arlen[7] ;
  output \gaxi_full_sm.arlen_cntr_reg[4] ;
  output [3:0]\s_axi_arid[3] ;
  output [0:0]E;
  output \gaxi_full_sm.outstanding_read_r_reg_0 ;
  output [10:0]\s_axi_araddr[14] ;
  output [10:0]ADDRBWRADDR;
  output [0:0]\gaxi_full_sm.r_valid_r_reg_1 ;
  output [0:0]s_axi_arvalid_1;
  output s_axi_arvalid_2;
  output [0:0]\s_axi_arburst[1] ;
  input s_aclk;
  input s_aresetn;
  input s_axi_rready;
  input s_axi_arvalid;
  input [7:0]s_axi_arlen;
  input \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[3] ;
  input [14:0]s_axi_araddr;
  input \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[2] ;
  input \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1] ;
  input \gaxi_full_sm.arlen_cntr_reg[6] ;
  input [7:0]Q;
  input \gaxi_full_sm.arlen_cntr_reg[5] ;
  input \gaxi_full_sm.arlen_cntr_reg[5]_0 ;
  input \gaxi_full_sm.arlen_cntr_reg[3] ;
  input \gaxi_full_sm.arlen_cntr_reg[4]_0 ;
  input \gaxi_full_sm.arlen_cntr_reg[7] ;
  input \gaxi_full_sm.arlen_cntr_reg[7]_0 ;
  input [0:0]\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0] ;
  input [4:0]\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] ;
  input [2:0]s_axi_arsize;
  input \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4]_0 ;
  input \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0]_0 ;
  input [3:0]s_axi_arid;
  input [3:0]\grid.S_AXI_RID_reg[3] ;
  input [8:0]addr_cnt_enb_r;
  input [4:0]\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [10:0]\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input incr_en_r;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ;
  input [1:0]s_axi_arburst;

  wire [10:0]ADDRBWRADDR;
  wire [4:0]D;
  wire [4:0]\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [10:0]\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ;
  wire [0:0]E;
  wire \FSM_sequential_gaxi_full_sm.present_state[1]_i_2__0_n_0 ;
  wire [0:0]\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ;
  wire [7:0]Q;
  wire [0:0]SR;
  wire [8:0]addr_cnt_enb_r;
  wire ar_ready_c;
  wire \gaxi_full_sm.S_AXI_RLAST_i_3_n_0 ;
  wire \gaxi_full_sm.ar_ready_r_i_2_n_0 ;
  wire \gaxi_full_sm.ar_ready_r_i_3_n_0 ;
  wire \gaxi_full_sm.ar_ready_r_i_4_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[2]_i_2_n_0 ;
  wire \gaxi_full_sm.arlen_cntr_reg[3] ;
  wire \gaxi_full_sm.arlen_cntr_reg[4] ;
  wire \gaxi_full_sm.arlen_cntr_reg[4]_0 ;
  wire \gaxi_full_sm.arlen_cntr_reg[5] ;
  wire \gaxi_full_sm.arlen_cntr_reg[5]_0 ;
  wire \gaxi_full_sm.arlen_cntr_reg[6] ;
  wire \gaxi_full_sm.arlen_cntr_reg[7] ;
  wire \gaxi_full_sm.arlen_cntr_reg[7]_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_4_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_5_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[0]_i_2_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_2_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_3_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_4_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_4_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_5_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_2_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_3_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_4_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_6_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_7_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_8_n_0 ;
  wire [0:0]\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0]_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[2] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[3] ;
  wire [4:0]\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4]_0 ;
  wire \gaxi_full_sm.outstanding_read_r_i_1_n_0 ;
  wire \gaxi_full_sm.outstanding_read_r_reg_0 ;
  wire \gaxi_full_sm.r_valid_r_i_2_n_0 ;
  wire \gaxi_full_sm.r_valid_r_reg_0 ;
  wire [0:0]\gaxi_full_sm.r_valid_r_reg_1 ;
  wire [3:0]\grid.S_AXI_RID_reg[3] ;
  wire incr_en_r;
  wire [1:0]next_state;
  wire outstanding_read_r;
  wire p_1_out;
  wire [1:0]present_state;
  wire r_last_c;
  wire r_valid_c;
  wire s_aclk;
  wire s_aresetn;
  wire [14:0]s_axi_araddr;
  wire [10:0]\s_axi_araddr[14] ;
  wire [1:0]s_axi_arburst;
  wire [0:0]\s_axi_arburst[1] ;
  wire [3:0]s_axi_arid;
  wire [3:0]\s_axi_arid[3] ;
  wire [7:0]s_axi_arlen;
  wire [7:0]\s_axi_arlen[7] ;
  wire s_axi_arlen_0_sn_1;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire s_axi_arvalid_0;
  wire [0:0]s_axi_arvalid_1;
  wire s_axi_arvalid_2;
  wire s_axi_rlast;
  wire s_axi_rready;

  assign s_axi_arlen_0_sp_1 = s_axi_arlen_0_sn_1;
  LUT6 #(
    .INIT(64'hEA45EF40EF40EF40)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_13 
       (.I0(addr_cnt_enb_r[8]),
        .I1(s_axi_araddr[14]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [10]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ),
        .I5(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [9]),
        .O(ADDRBWRADDR[10]));
  LUT5 #(
    .INIT(32'hEA45EF40)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_14 
       (.I0(addr_cnt_enb_r[8]),
        .I1(s_axi_araddr[13]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [9]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ),
        .O(ADDRBWRADDR[9]));
  LUT5 #(
    .INIT(32'hEA45EF40)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_15 
       (.I0(addr_cnt_enb_r[8]),
        .I1(s_axi_araddr[12]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [8]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ),
        .O(ADDRBWRADDR[8]));
  LUT6 #(
    .INIT(64'hEA45EF40EF40EF40)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_16 
       (.I0(addr_cnt_enb_r[8]),
        .I1(s_axi_araddr[11]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [7]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ),
        .I5(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [6]),
        .O(ADDRBWRADDR[7]));
  LUT5 #(
    .INIT(32'hEA45EF40)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_17 
       (.I0(addr_cnt_enb_r[8]),
        .I1(s_axi_araddr[10]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [6]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ),
        .O(ADDRBWRADDR[6]));
  LUT6 #(
    .INIT(64'hEFEAEFEF40454040)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_18 
       (.I0(addr_cnt_enb_r[8]),
        .I1(s_axi_araddr[9]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [4]),
        .I5(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [5]),
        .O(ADDRBWRADDR[5]));
  LUT5 #(
    .INIT(32'hEF40EA45)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_19 
       (.I0(addr_cnt_enb_r[7]),
        .I1(s_axi_araddr[8]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [4]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ),
        .O(ADDRBWRADDR[4]));
  LUT5 #(
    .INIT(32'hEF40EA45)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_20 
       (.I0(addr_cnt_enb_r[6]),
        .I1(s_axi_araddr[7]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [3]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .O(ADDRBWRADDR[3]));
  LUT5 #(
    .INIT(32'hEF40EA45)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_21 
       (.I0(addr_cnt_enb_r[5]),
        .I1(s_axi_araddr[6]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [2]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .O(ADDRBWRADDR[2]));
  LUT5 #(
    .INIT(32'hEF40EA45)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_22 
       (.I0(addr_cnt_enb_r[4]),
        .I1(s_axi_araddr[5]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [1]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .O(ADDRBWRADDR[1]));
  LUT6 #(
    .INIT(64'hEA45EF40EF40EF40)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_23 
       (.I0(addr_cnt_enb_r[3]),
        .I1(s_axi_araddr[4]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [0]),
        .I4(incr_en_r),
        .I5(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [4]),
        .O(ADDRBWRADDR[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h4500FFFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27 
       (.I0(outstanding_read_r),
        .I1(s_axi_rready),
        .I2(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I3(present_state[1]),
        .I4(present_state[0]),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ));
  LUT6 #(
    .INIT(64'hF3F3F30353535353)) 
    \FSM_sequential_gaxi_full_sm.present_state[0]_i_1__0 
       (.I0(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .I1(\gaxi_full_sm.ar_ready_r_i_3_n_0 ),
        .I2(present_state[0]),
        .I3(outstanding_read_r),
        .I4(\gaxi_full_sm.ar_ready_r_i_2_n_0 ),
        .I5(present_state[1]),
        .O(next_state[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFF51404040)) 
    \FSM_sequential_gaxi_full_sm.present_state[1]_i_1__0 
       (.I0(present_state[1]),
        .I1(present_state[0]),
        .I2(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .I3(s_axi_arvalid),
        .I4(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .I5(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2__0_n_0 ),
        .O(next_state[1]));
  LUT6 #(
    .INIT(64'hFD00FD00F8000800)) 
    \FSM_sequential_gaxi_full_sm.present_state[1]_i_2__0 
       (.I0(s_axi_arvalid),
        .I1(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .I4(outstanding_read_r),
        .I5(\gaxi_full_sm.ar_ready_r_i_2_n_0 ),
        .O(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2__0_n_0 ));
  (* FSM_ENCODED_STATES = "wait_rdaddr:00,os_rd:11,rd_mem:01,reg_rdaddr:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gaxi_full_sm.present_state_reg[0] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(next_state[0]),
        .Q(present_state[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "wait_rdaddr:00,os_rd:11,rd_mem:01,reg_rdaddr:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gaxi_full_sm.present_state_reg[1] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(next_state[1]),
        .Q(present_state[1]),
        .R(SR));
  LUT2 #(
    .INIT(4'hB)) 
    \gaxi_full_sm.S_AXI_RLAST_i_1 
       (.I0(s_axi_rready),
        .I1(\gaxi_full_sm.r_valid_r_reg_0 ),
        .O(p_1_out));
  LUT6 #(
    .INIT(64'h5F5F5F5F4F004000)) 
    \gaxi_full_sm.S_AXI_RLAST_i_2 
       (.I0(\gaxi_full_sm.ar_ready_r_i_2_n_0 ),
        .I1(outstanding_read_r),
        .I2(present_state[1]),
        .I3(present_state[0]),
        .I4(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .I5(\gaxi_full_sm.S_AXI_RLAST_i_3_n_0 ),
        .O(r_last_c));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \gaxi_full_sm.S_AXI_RLAST_i_3 
       (.I0(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .I1(present_state[0]),
        .I2(s_axi_arvalid),
        .O(\gaxi_full_sm.S_AXI_RLAST_i_3_n_0 ));
  FDRE \gaxi_full_sm.S_AXI_RLAST_reg 
       (.C(s_aclk),
        .CE(p_1_out),
        .D(r_last_c),
        .Q(s_axi_rlast),
        .R(SR));
  LUT6 #(
    .INIT(64'h57FF570002FF0200)) 
    \gaxi_full_sm.ar_ready_r_i_1 
       (.I0(present_state[1]),
        .I1(\gaxi_full_sm.ar_ready_r_i_2_n_0 ),
        .I2(outstanding_read_r),
        .I3(present_state[0]),
        .I4(\gaxi_full_sm.ar_ready_r_i_3_n_0 ),
        .I5(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .O(ar_ready_c));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \gaxi_full_sm.ar_ready_r_i_2 
       (.I0(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I1(s_axi_rready),
        .O(\gaxi_full_sm.ar_ready_r_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h8C8FAF8F)) 
    \gaxi_full_sm.ar_ready_r_i_3 
       (.I0(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .I1(s_axi_rready),
        .I2(s_axi_arvalid),
        .I3(present_state[1]),
        .I4(\gaxi_full_sm.r_valid_r_reg_0 ),
        .O(\gaxi_full_sm.ar_ready_r_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    \gaxi_full_sm.ar_ready_r_i_4 
       (.I0(s_axi_rready),
        .I1(\gaxi_full_sm.arlen_cntr_reg[4] ),
        .I2(Q[6]),
        .I3(Q[7]),
        .O(\gaxi_full_sm.ar_ready_r_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.ar_ready_r_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(ar_ready_c),
        .Q(s_axi_arready),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h22627767)) 
    \gaxi_full_sm.arlen_cntr[0]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I1(s_axi_arlen[0]),
        .I2(s_axi_arvalid),
        .I3(present_state[0]),
        .I4(Q[0]),
        .O(\s_axi_arlen[7] [0]));
  LUT6 #(
    .INIT(64'hB4B7B484B484B4B7)) 
    \gaxi_full_sm.arlen_cntr[1]_i_1 
       (.I0(s_axi_arlen[0]),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_arlen[1]),
        .I3(s_axi_arvalid_0),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(\s_axi_arlen[7] [1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hA9FFA900)) 
    \gaxi_full_sm.arlen_cntr[2]_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(s_axi_arlen[0]),
        .I2(s_axi_arlen[1]),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I4(\gaxi_full_sm.arlen_cntr[2]_i_2_n_0 ),
        .O(\s_axi_arlen[7] [2]));
  LUT6 #(
    .INIT(64'hFB08FB08FB0808FB)) 
    \gaxi_full_sm.arlen_cntr[2]_i_2 
       (.I0(s_axi_arlen[2]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(\gaxi_full_sm.arlen_cntr[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7848787B787B7848)) 
    \gaxi_full_sm.arlen_cntr[3]_i_1 
       (.I0(s_axi_arlen_0_sn_1),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_arlen[3]),
        .I3(s_axi_arvalid_0),
        .I4(Q[3]),
        .I5(\gaxi_full_sm.arlen_cntr_reg[3] ),
        .O(\s_axi_arlen[7] [3]));
  LUT6 #(
    .INIT(64'hBF40BF4FBF40B040)) 
    \gaxi_full_sm.arlen_cntr[4]_i_1 
       (.I0(s_axi_arlen[3]),
        .I1(s_axi_arlen_0_sn_1),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I3(s_axi_arlen[4]),
        .I4(s_axi_arvalid_0),
        .I5(\gaxi_full_sm.arlen_cntr_reg[4]_0 ),
        .O(\s_axi_arlen[7] [4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \gaxi_full_sm.arlen_cntr[4]_i_2 
       (.I0(s_axi_arlen[0]),
        .I1(s_axi_arlen[1]),
        .I2(s_axi_arlen[2]),
        .O(s_axi_arlen_0_sn_1));
  LUT6 #(
    .INIT(64'h7848787B787B7848)) 
    \gaxi_full_sm.arlen_cntr[5]_i_1 
       (.I0(\gaxi_full_sm.arlen_cntr_reg[5] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_arlen[5]),
        .I3(s_axi_arvalid_0),
        .I4(Q[5]),
        .I5(\gaxi_full_sm.arlen_cntr_reg[5]_0 ),
        .O(\s_axi_arlen[7] [5]));
  LUT6 #(
    .INIT(64'h7848787B787B7848)) 
    \gaxi_full_sm.arlen_cntr[6]_i_1 
       (.I0(\gaxi_full_sm.arlen_cntr_reg[6] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_arlen[6]),
        .I3(s_axi_arvalid_0),
        .I4(Q[6]),
        .I5(\gaxi_full_sm.arlen_cntr_reg[4] ),
        .O(\s_axi_arlen[7] [6]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \gaxi_full_sm.arlen_cntr[6]_i_3 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[3]),
        .I5(Q[5]),
        .O(\gaxi_full_sm.arlen_cntr_reg[4] ));
  LUT6 #(
    .INIT(64'hFFFF0FDFFFFF00D0)) 
    \gaxi_full_sm.arlen_cntr[7]_i_1 
       (.I0(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I1(s_axi_rready),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .I4(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .I5(s_axi_arvalid),
        .O(\gaxi_full_sm.r_valid_r_reg_1 ));
  LUT6 #(
    .INIT(64'hB080B0B3B0B3B080)) 
    \gaxi_full_sm.arlen_cntr[7]_i_2 
       (.I0(\gaxi_full_sm.arlen_cntr_reg[7] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_arlen[7]),
        .I3(s_axi_arvalid_0),
        .I4(Q[7]),
        .I5(\gaxi_full_sm.arlen_cntr_reg[7]_0 ),
        .O(\s_axi_arlen[7] [7]));
  LUT1 #(
    .INIT(2'h1)) 
    \gaxi_full_sm.aw_ready_r_i_1 
       (.I0(s_aresetn),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h0000F088)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[14]_i_2 
       (.I0(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .I1(s_axi_arvalid),
        .I2(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .I3(present_state[0]),
        .I4(present_state[1]),
        .O(s_axi_arvalid_2));
  LUT6 #(
    .INIT(64'h2020300020200000)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[14]_i_3 
       (.I0(outstanding_read_r),
        .I1(\gaxi_full_sm.ar_ready_r_i_2_n_0 ),
        .I2(present_state[1]),
        .I3(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .I4(present_state[0]),
        .I5(s_axi_arvalid),
        .O(\gaxi_full_sm.outstanding_read_r_reg_0 ));
  LUT6 #(
    .INIT(64'hFFF4FFFCFFFFFFFF)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_1 
       (.I0(present_state[1]),
        .I1(\gaxi_full_sm.S_AXI_RLAST_i_3_n_0 ),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_4_n_0 ),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_5_n_0 ),
        .I4(\gaxi_full_sm.ar_ready_r_i_2_n_0 ),
        .I5(s_aresetn),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ));
  LUT5 #(
    .INIT(32'h00000020)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_2 
       (.I0(s_axi_arburst[1]),
        .I1(s_axi_arburst[0]),
        .I2(s_axi_arvalid),
        .I3(present_state[0]),
        .I4(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .O(\s_axi_arburst[1] ));
  LUT6 #(
    .INIT(64'h0004000000000000)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_4 
       (.I0(present_state[1]),
        .I1(present_state[0]),
        .I2(Q[7]),
        .I3(Q[6]),
        .I4(\gaxi_full_sm.arlen_cntr_reg[4] ),
        .I5(s_axi_rready),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hD0000000)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_5 
       (.I0(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I1(s_axi_rready),
        .I2(outstanding_read_r),
        .I3(present_state[1]),
        .I4(present_state[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[10]_i_1 
       (.I0(s_axi_araddr[10]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[6]),
        .O(\s_axi_araddr[14] [6]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[11]_i_1 
       (.I0(s_axi_araddr[11]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[7]),
        .O(\s_axi_araddr[14] [7]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[12]_i_1 
       (.I0(s_axi_araddr[12]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[8]),
        .O(\s_axi_araddr[14] [8]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[13]_i_1 
       (.I0(s_axi_araddr[13]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[9]),
        .O(\s_axi_araddr[14] [9]));
  LUT6 #(
    .INIT(64'h03AA00AA03AA03AA)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[14]_i_1 
       (.I0(s_axi_arvalid),
        .I1(\gaxi_full_sm.ar_ready_r_i_4_n_0 ),
        .I2(present_state[1]),
        .I3(present_state[0]),
        .I4(s_axi_rready),
        .I5(\gaxi_full_sm.r_valid_r_reg_0 ),
        .O(s_axi_arvalid_1));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[14]_i_2 
       (.I0(s_axi_araddr[14]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[10]),
        .O(\s_axi_araddr[14] [10]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[4]_i_1 
       (.I0(s_axi_araddr[4]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[0]),
        .O(\s_axi_araddr[14] [0]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[5]_i_1 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[1]),
        .O(\s_axi_araddr[14] [1]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[6]_i_1 
       (.I0(s_axi_araddr[6]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[2]),
        .O(\s_axi_araddr[14] [2]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[7]_i_1 
       (.I0(s_axi_araddr[7]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[3]),
        .O(\s_axi_araddr[14] [3]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[8]_i_1 
       (.I0(s_axi_araddr[8]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[4]),
        .O(\s_axi_araddr[14] [4]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r[9]_i_1 
       (.I0(s_axi_araddr[9]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(ADDRBWRADDR[5]),
        .O(\s_axi_araddr[14] [5]));
  LUT6 #(
    .INIT(64'h787B78487848787B)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[0]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_araddr[0]),
        .I3(s_axi_arvalid_0),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [0]),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[0]_i_2_n_0 ),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h47)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[0]_i_2 
       (.I0(s_axi_araddr[0]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFB0808FB08FBFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_2 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_7_n_0 ),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_6_n_0 ),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [1]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB888)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[2] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(s_axi_arvalid_0),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_3_n_0 ),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_4_n_0 ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFEFAAEAAA8A0080)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_3 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [1]),
        .I1(s_axi_araddr[1]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(addr_cnt_enb_r[0]),
        .I4(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [1]),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_7_n_0 ),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h65666A66)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_4 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [2]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [2]),
        .I2(addr_cnt_enb_r[1]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I4(s_axi_araddr[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB888)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[3] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I2(s_axi_araddr[3]),
        .I3(s_axi_arvalid_0),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_3_n_0 ),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_4_n_0 ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_5_n_0 ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0]_0 ),
        .I2(s_axi_arlen[2]),
        .I3(s_axi_arlen[1]),
        .I4(s_axi_arlen[0]),
        .I5(s_axi_arlen[7]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h65666A66)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_4 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [3]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [3]),
        .I2(addr_cnt_enb_r[2]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I4(s_axi_araddr[3]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h44440444)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_5 
       (.I0(present_state[0]),
        .I1(s_axi_arvalid),
        .I2(present_state[1]),
        .I3(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I4(s_axi_rready),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAABBBEBEEE)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_2_n_0 ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [4]),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_3_n_0 ),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_4_n_0 ),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [3]),
        .I5(s_axi_arvalid_0),
        .O(D[4]));
  LUT6 #(
    .INIT(64'h2008AAAA00082008)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_2 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ),
        .I1(s_axi_arsize[2]),
        .I2(s_axi_arsize[0]),
        .I3(s_axi_arsize[1]),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4]_0 ),
        .I5(s_axi_araddr[3]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFE8E800)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_3 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [1]),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_6_n_0 ),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_7_n_0 ),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_8_n_0 ),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I2(addr_cnt_enb_r[2]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [3]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_6 
       (.I0(s_axi_araddr[1]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I2(addr_cnt_enb_r[0]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [1]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hA808)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_7 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] [0]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [0]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I3(s_axi_araddr[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_8 
       (.I0(s_axi_araddr[2]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_27_n_0 ),
        .I2(addr_cnt_enb_r[1]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_8_n_0 ));
  MUXF7 \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_2_n_0 ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1] ),
        .O(D[1]),
        .S(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C00000008080000)) 
    \gaxi_full_sm.outstanding_read_r_i_1 
       (.I0(\gaxi_full_sm.S_AXI_RLAST_i_3_n_0 ),
        .I1(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I2(s_axi_rready),
        .I3(outstanding_read_r),
        .I4(present_state[1]),
        .I5(present_state[0]),
        .O(\gaxi_full_sm.outstanding_read_r_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.outstanding_read_r_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(\gaxi_full_sm.outstanding_read_r_i_1_n_0 ),
        .Q(outstanding_read_r),
        .R(SR));
  LUT4 #(
    .INIT(16'hAEAA)) 
    \gaxi_full_sm.r_valid_r_i_1 
       (.I0(E),
        .I1(s_axi_arvalid),
        .I2(present_state[0]),
        .I3(\gaxi_full_sm.r_valid_r_i_2_n_0 ),
        .O(r_valid_c));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \gaxi_full_sm.r_valid_r_i_2 
       (.I0(s_axi_arlen[7]),
        .I1(s_axi_arlen_0_sn_1),
        .I2(s_axi_arlen[3]),
        .I3(s_axi_arlen[4]),
        .I4(s_axi_arlen[5]),
        .I5(s_axi_arlen[6]),
        .O(\gaxi_full_sm.r_valid_r_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.r_valid_r_reg 
       (.C(s_aclk),
        .CE(p_1_out),
        .D(r_valid_c),
        .Q(\gaxi_full_sm.r_valid_r_reg_0 ),
        .R(SR));
  LUT6 #(
    .INIT(64'hBBBBFBBB88880888)) 
    \grid.S_AXI_RID[0]_i_1 
       (.I0(s_axi_arid[0]),
        .I1(s_axi_arvalid_0),
        .I2(present_state[1]),
        .I3(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I4(s_axi_rready),
        .I5(\grid.S_AXI_RID_reg[3] [0]),
        .O(\s_axi_arid[3] [0]));
  LUT6 #(
    .INIT(64'hBBBBFBBB88880888)) 
    \grid.S_AXI_RID[1]_i_1 
       (.I0(s_axi_arid[1]),
        .I1(s_axi_arvalid_0),
        .I2(present_state[1]),
        .I3(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I4(s_axi_rready),
        .I5(\grid.S_AXI_RID_reg[3] [1]),
        .O(\s_axi_arid[3] [1]));
  LUT6 #(
    .INIT(64'hBBBBFBBB88880888)) 
    \grid.S_AXI_RID[2]_i_1 
       (.I0(s_axi_arid[2]),
        .I1(s_axi_arvalid_0),
        .I2(present_state[1]),
        .I3(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I4(s_axi_rready),
        .I5(\grid.S_AXI_RID_reg[3] [2]),
        .O(\s_axi_arid[3] [2]));
  LUT6 #(
    .INIT(64'hF300F3F3A2A2AAAA)) 
    \grid.S_AXI_RID[3]_i_1 
       (.I0(s_axi_arvalid),
        .I1(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I2(s_axi_rready),
        .I3(outstanding_read_r),
        .I4(present_state[1]),
        .I5(present_state[0]),
        .O(E));
  LUT6 #(
    .INIT(64'hBBBBFBBB88880888)) 
    \grid.S_AXI_RID[3]_i_2 
       (.I0(s_axi_arid[3]),
        .I1(s_axi_arvalid_0),
        .I2(present_state[1]),
        .I3(\gaxi_full_sm.r_valid_r_reg_0 ),
        .I4(s_axi_rready),
        .I5(\grid.S_AXI_RID_reg[3] [3]),
        .O(\s_axi_arid[3] [3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \grid.ar_id_r[3]_i_1 
       (.I0(s_axi_arvalid),
        .I1(present_state[0]),
        .O(s_axi_arvalid_0));
endmodule

(* ORIG_REF_NAME = "blk_mem_axi_read_wrapper" *) 
module blk_mem_gen_0_blk_mem_axi_read_wrapper
   (\gaxi_full_sm.r_valid_r_reg ,
    SS,
    s_axi_arready,
    s_axi_rlast,
    E,
    ADDRBWRADDR,
    s_axi_rid,
    s_aclk,
    s_aresetn,
    s_axi_rready,
    s_axi_arvalid,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_araddr,
    s_axi_arid,
    s_axi_arburst);
  output \gaxi_full_sm.r_valid_r_reg ;
  output [0:0]SS;
  output s_axi_arready;
  output s_axi_rlast;
  output [0:0]E;
  output [10:0]ADDRBWRADDR;
  output [3:0]s_axi_rid;
  input s_aclk;
  input s_aresetn;
  input s_axi_rready;
  input s_axi_arvalid;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [14:0]s_axi_araddr;
  input [3:0]s_axi_arid;
  input [1:0]s_axi_arburst;

  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_28_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_29_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_30_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_32_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_33_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_34_n_0 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire [14:1]addr_cnt_enb_r;
  wire [3:0]ar_id_r;
  wire [7:0]arlen_cntr;
  wire axi_read_fsm_n_10;
  wire axi_read_fsm_n_11;
  wire axi_read_fsm_n_12;
  wire axi_read_fsm_n_13;
  wire axi_read_fsm_n_14;
  wire axi_read_fsm_n_15;
  wire axi_read_fsm_n_16;
  wire axi_read_fsm_n_17;
  wire axi_read_fsm_n_18;
  wire axi_read_fsm_n_19;
  wire axi_read_fsm_n_20;
  wire axi_read_fsm_n_21;
  wire axi_read_fsm_n_22;
  wire axi_read_fsm_n_23;
  wire axi_read_fsm_n_24;
  wire axi_read_fsm_n_26;
  wire axi_read_fsm_n_27;
  wire axi_read_fsm_n_28;
  wire axi_read_fsm_n_29;
  wire axi_read_fsm_n_30;
  wire axi_read_fsm_n_31;
  wire axi_read_fsm_n_32;
  wire axi_read_fsm_n_33;
  wire axi_read_fsm_n_34;
  wire axi_read_fsm_n_35;
  wire axi_read_fsm_n_36;
  wire axi_read_fsm_n_37;
  wire axi_read_fsm_n_4;
  wire axi_read_fsm_n_49;
  wire axi_read_fsm_n_5;
  wire axi_read_fsm_n_51;
  wire axi_read_fsm_n_6;
  wire axi_read_fsm_n_7;
  wire axi_read_fsm_n_8;
  wire axi_read_fsm_n_9;
  wire \gaxi_full_sm.arlen_cntr[3]_i_2_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[4]_i_3_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[5]_i_2_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[5]_i_3_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[6]_i_2_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[7]_i_3_n_0 ;
  wire \gaxi_full_sm.arlen_cntr[7]_i_4_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[14]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[1]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[2]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[3]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[4]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[5]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[6]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[7]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_3_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[10] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[11] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[12] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[13] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[14] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[5] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[6] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[7] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[8] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[9] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.incr_en_r_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_3_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_2_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_2_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_6_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_5_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[0] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[1] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[2] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[3] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[0]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[1]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[2]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[3]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[4]_i_1_n_0 ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[0] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[1] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[2] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[3] ;
  wire \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[4] ;
  wire \gaxi_full_sm.r_valid_r_reg ;
  wire incr_en_r;
  wire p_0_in3_in;
  wire [4:4]p_2_out;
  wire p_2_out_0;
  wire s_aclk;
  wire s_aresetn;
  wire [14:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;

  LUT6 #(
    .INIT(64'h0800000000000000)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_28 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[12] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[10] ),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31_n_0 ),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[8] ),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[9] ),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[11] ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_28_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h00800000)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_29 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[11] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[9] ),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[8] ),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31_n_0 ),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[10] ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_29_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_30 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[9] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[8] ),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31_n_0 ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_30_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[6] ),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] ),
        .I2(incr_en_r),
        .I3(p_0_in3_in),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[5] ),
        .I5(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[7] ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_32 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[5] ),
        .I1(p_0_in3_in),
        .I2(incr_en_r),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] ),
        .I4(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[6] ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_32_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_33 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] ),
        .I1(incr_en_r),
        .I2(p_0_in3_in),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[5] ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_33_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_34 
       (.I0(p_0_in3_in),
        .I1(incr_en_r),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] ),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_34_n_0 ));
  blk_mem_gen_0_blk_mem_axi_read_fsm axi_read_fsm
       (.ADDRBWRADDR(ADDRBWRADDR),
        .D({axi_read_fsm_n_6,axi_read_fsm_n_7,axi_read_fsm_n_8,axi_read_fsm_n_9,axi_read_fsm_n_10}),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ({p_0_in3_in,\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[3] ,\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[2] ,\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[1] ,\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[0] }),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ({\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[14] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[13] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[12] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[11] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[10] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[9] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[8] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[7] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[6] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[5] ,\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] }),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_34_n_0 ),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_33_n_0 ),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_32_n_0 ),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_31_n_0 ),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_30_n_0 ),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_29_n_0 ),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_28_n_0 ),
        .E(E),
        .\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 (axi_read_fsm_n_4),
        .Q(arlen_cntr),
        .SR(SS),
        .addr_cnt_enb_r({addr_cnt_enb_r[14],addr_cnt_enb_r[8:1]}),
        .\gaxi_full_sm.arlen_cntr_reg[3] (\gaxi_full_sm.arlen_cntr[3]_i_2_n_0 ),
        .\gaxi_full_sm.arlen_cntr_reg[4] (axi_read_fsm_n_20),
        .\gaxi_full_sm.arlen_cntr_reg[4]_0 (\gaxi_full_sm.arlen_cntr[4]_i_3_n_0 ),
        .\gaxi_full_sm.arlen_cntr_reg[5] (\gaxi_full_sm.arlen_cntr[5]_i_2_n_0 ),
        .\gaxi_full_sm.arlen_cntr_reg[5]_0 (\gaxi_full_sm.arlen_cntr[5]_i_3_n_0 ),
        .\gaxi_full_sm.arlen_cntr_reg[6] (\gaxi_full_sm.arlen_cntr[6]_i_2_n_0 ),
        .\gaxi_full_sm.arlen_cntr_reg[7] (\gaxi_full_sm.arlen_cntr[7]_i_3_n_0 ),
        .\gaxi_full_sm.arlen_cntr_reg[7]_0 (\gaxi_full_sm.arlen_cntr[7]_i_4_n_0 ),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0] (\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[0]_i_1_n_0 ),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0]_0 (\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_6_n_0 ),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1] (\gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_3_n_0 ),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[2] (\gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_2_n_0 ),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[3] (\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_2_n_0 ),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] ({\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[4] ,\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[3] ,\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[2] ,\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[1] ,\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[0] }),
        .\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4]_0 (\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_5_n_0 ),
        .\gaxi_full_sm.outstanding_read_r_reg_0 (axi_read_fsm_n_26),
        .\gaxi_full_sm.r_valid_r_reg_0 (\gaxi_full_sm.r_valid_r_reg ),
        .\gaxi_full_sm.r_valid_r_reg_1 (axi_read_fsm_n_49),
        .\grid.S_AXI_RID_reg[3] (ar_id_r),
        .incr_en_r(incr_en_r),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_araddr(s_axi_araddr),
        .\s_axi_araddr[14] ({axi_read_fsm_n_27,axi_read_fsm_n_28,axi_read_fsm_n_29,axi_read_fsm_n_30,axi_read_fsm_n_31,axi_read_fsm_n_32,axi_read_fsm_n_33,axi_read_fsm_n_34,axi_read_fsm_n_35,axi_read_fsm_n_36,axi_read_fsm_n_37}),
        .s_axi_arburst(s_axi_arburst),
        .\s_axi_arburst[1] (p_2_out_0),
        .s_axi_arid(s_axi_arid),
        .\s_axi_arid[3] ({axi_read_fsm_n_21,axi_read_fsm_n_22,axi_read_fsm_n_23,axi_read_fsm_n_24}),
        .s_axi_arlen(s_axi_arlen),
        .\s_axi_arlen[7] ({axi_read_fsm_n_12,axi_read_fsm_n_13,axi_read_fsm_n_14,axi_read_fsm_n_15,axi_read_fsm_n_16,axi_read_fsm_n_17,axi_read_fsm_n_18,axi_read_fsm_n_19}),
        .s_axi_arlen_0_sp_1(axi_read_fsm_n_5),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arvalid_0(axi_read_fsm_n_11),
        .s_axi_arvalid_1(p_2_out),
        .s_axi_arvalid_2(axi_read_fsm_n_51),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready));
  LUT3 #(
    .INIT(8'h01)) 
    \gaxi_full_sm.arlen_cntr[3]_i_2 
       (.I0(arlen_cntr[0]),
        .I1(arlen_cntr[1]),
        .I2(arlen_cntr[2]),
        .O(\gaxi_full_sm.arlen_cntr[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \gaxi_full_sm.arlen_cntr[4]_i_3 
       (.I0(arlen_cntr[4]),
        .I1(arlen_cntr[3]),
        .I2(arlen_cntr[0]),
        .I3(arlen_cntr[1]),
        .I4(arlen_cntr[2]),
        .O(\gaxi_full_sm.arlen_cntr[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \gaxi_full_sm.arlen_cntr[5]_i_2 
       (.I0(s_axi_arlen[2]),
        .I1(s_axi_arlen[1]),
        .I2(s_axi_arlen[0]),
        .I3(s_axi_arlen[3]),
        .I4(s_axi_arlen[4]),
        .O(\gaxi_full_sm.arlen_cntr[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \gaxi_full_sm.arlen_cntr[5]_i_3 
       (.I0(arlen_cntr[3]),
        .I1(arlen_cntr[0]),
        .I2(arlen_cntr[1]),
        .I3(arlen_cntr[2]),
        .I4(arlen_cntr[4]),
        .O(\gaxi_full_sm.arlen_cntr[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \gaxi_full_sm.arlen_cntr[6]_i_2 
       (.I0(s_axi_arlen[4]),
        .I1(s_axi_arlen[3]),
        .I2(s_axi_arlen[0]),
        .I3(s_axi_arlen[1]),
        .I4(s_axi_arlen[2]),
        .I5(s_axi_arlen[5]),
        .O(\gaxi_full_sm.arlen_cntr[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFFFEFFFF)) 
    \gaxi_full_sm.arlen_cntr[7]_i_3 
       (.I0(s_axi_arlen[6]),
        .I1(s_axi_arlen[5]),
        .I2(s_axi_arlen[4]),
        .I3(s_axi_arlen[3]),
        .I4(axi_read_fsm_n_5),
        .O(\gaxi_full_sm.arlen_cntr[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \gaxi_full_sm.arlen_cntr[7]_i_4 
       (.I0(axi_read_fsm_n_20),
        .I1(arlen_cntr[6]),
        .O(\gaxi_full_sm.arlen_cntr[7]_i_4_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \gaxi_full_sm.arlen_cntr_reg[0] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_19),
        .Q(arlen_cntr[0]),
        .S(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[1] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_18),
        .Q(arlen_cntr[1]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[2] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_17),
        .Q(arlen_cntr[2]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[3] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_16),
        .Q(arlen_cntr[3]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[4] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_15),
        .Q(arlen_cntr[4]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[5] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_14),
        .Q(arlen_cntr[5]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[6] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_13),
        .Q(arlen_cntr[6]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.arlen_cntr_reg[7] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_49),
        .D(axi_read_fsm_n_12),
        .Q(arlen_cntr[7]),
        .R(SS));
  LUT4 #(
    .INIT(16'hABAA)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[14]_i_1 
       (.I0(p_2_out_0),
        .I1(axi_read_fsm_n_51),
        .I2(axi_read_fsm_n_26),
        .I3(addr_cnt_enb_r[14]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[1]_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I2(s_axi_arlen[1]),
        .I3(s_axi_arsize[2]),
        .I4(s_axi_arsize[0]),
        .I5(s_axi_arsize[1]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400040004)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[2]_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I2(s_axi_arsize[2]),
        .I3(s_axi_arsize[1]),
        .I4(s_axi_arlen[1]),
        .I5(s_axi_arsize[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000020000002AA)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[3]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I1(s_axi_arsize[0]),
        .I2(s_axi_arlen[1]),
        .I3(s_axi_arsize[1]),
        .I4(s_axi_arsize[2]),
        .I5(s_axi_arlen[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h001000B0003000FF)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[4]_i_1 
       (.I0(s_axi_arlen[1]),
        .I1(s_axi_arlen[2]),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I3(s_axi_arsize[2]),
        .I4(s_axi_arsize[1]),
        .I5(s_axi_arsize[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000001007500FFFF)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[5]_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(s_axi_arsize[0]),
        .I2(s_axi_arlen[1]),
        .I3(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I4(s_axi_arsize[1]),
        .I5(s_axi_arsize[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00BF003F02BFAABF)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[6]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I1(s_axi_arsize[1]),
        .I2(s_axi_arsize[0]),
        .I3(s_axi_arsize[2]),
        .I4(s_axi_arlen[1]),
        .I5(s_axi_arlen[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0008FFFFAAAAFFFF)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[7]_i_1 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I1(s_axi_arlen[1]),
        .I2(s_axi_arsize[1]),
        .I3(s_axi_arsize[0]),
        .I4(s_axi_arsize[2]),
        .I5(s_axi_arlen[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hD0FFD0FFD0FFFFFF)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_3 
       (.I0(s_axi_arlen[2]),
        .I1(s_axi_arlen[1]),
        .I2(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ),
        .I3(s_axi_arsize[2]),
        .I4(s_axi_arsize[0]),
        .I5(s_axi_arsize[1]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6 
       (.I0(s_axi_arlen[6]),
        .I1(s_axi_arlen[5]),
        .I2(s_axi_arlen[4]),
        .I3(s_axi_arlen[3]),
        .I4(s_axi_arlen[0]),
        .I5(s_axi_arlen[7]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[14] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[14]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[14]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[1] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[1]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[1]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[2] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[2]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[2]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[3] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[3]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[3]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[4] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[4]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[4]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[5] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[5]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[5]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[6] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[6]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[6]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[7] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[7]_i_1_n_0 ),
        .Q(addr_cnt_enb_r[7]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r_reg[8] 
       (.C(s_aclk),
        .CE(p_2_out_0),
        .D(\gaxi_full_sm.gaxifull_mem_slave.addr_cnt_enb_r[8]_i_3_n_0 ),
        .Q(addr_cnt_enb_r[8]),
        .R(axi_read_fsm_n_4));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[10] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_31),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[10] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[11] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_30),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[11] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[12] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_29),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[12] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[13] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_28),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[13] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[14] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_27),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[14] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[4] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_37),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[4] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[5] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_36),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[5] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[6] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_35),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[6] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[7] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_34),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[7] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[8] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_33),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[8] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg[9] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_32),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.bmg_address_r_reg_n_0_[9] ),
        .R(SS));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxi_full_sm.gaxifull_mem_slave.incr_en_r_i_1 
       (.I0(s_axi_arburst[1]),
        .I1(s_axi_arburst[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.incr_en_r_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.incr_en_r_reg 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(\gaxi_full_sm.gaxifull_mem_slave.incr_en_r_i_1_n_0 ),
        .Q(incr_en_r),
        .R(SS));
  LUT5 #(
    .INIT(32'hAAA5AAA6)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_3 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_arsize[0]),
        .I2(s_axi_arsize[2]),
        .I3(s_axi_arsize[1]),
        .I4(s_axi_araddr[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFF3F0F7000C0F08)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_2 
       (.I0(s_axi_araddr[0]),
        .I1(s_axi_araddr[1]),
        .I2(s_axi_arsize[2]),
        .I3(s_axi_arsize[1]),
        .I4(s_axi_arsize[0]),
        .I5(s_axi_araddr[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hAA6A5595)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_2 
       (.I0(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_5_n_0 ),
        .I1(s_axi_arsize[1]),
        .I2(s_axi_arsize[0]),
        .I3(s_axi_arsize[2]),
        .I4(s_axi_araddr[3]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_6 
       (.I0(s_axi_arlen[3]),
        .I1(s_axi_arlen[4]),
        .I2(s_axi_arlen[5]),
        .I3(s_axi_arlen[6]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFCF5FCF7FFFFFFFF)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_5 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_arsize[0]),
        .I2(s_axi_arsize[2]),
        .I3(s_axi_arsize[1]),
        .I4(s_axi_araddr[0]),
        .I5(s_axi_araddr[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.next_address_r[4]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[0] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_10),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[0] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[1] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_9),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[1] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[2] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_8),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[2] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[3] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_7),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg_n_0_[3] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.next_address_r_reg[4] 
       (.C(s_aclk),
        .CE(p_2_out),
        .D(axi_read_fsm_n_6),
        .Q(p_0_in3_in),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[0]_i_1 
       (.I0(s_axi_arsize[2]),
        .I1(s_axi_arsize[1]),
        .I2(s_axi_arsize[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[1]_i_1 
       (.I0(s_axi_arsize[0]),
        .I1(s_axi_arsize[2]),
        .I2(s_axi_arsize[1]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[2]_i_1 
       (.I0(s_axi_arsize[2]),
        .I1(s_axi_arsize[1]),
        .I2(s_axi_arsize[0]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[3]_i_1 
       (.I0(s_axi_arsize[1]),
        .I1(s_axi_arsize[0]),
        .I2(s_axi_arsize[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[4]_i_1 
       (.I0(s_axi_arsize[1]),
        .I1(s_axi_arsize[0]),
        .I2(s_axi_arsize[2]),
        .O(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg[0] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[0]_i_1_n_0 ),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[0] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg[1] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[1]_i_1_n_0 ),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[1] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg[2] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[2]_i_1_n_0 ),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[2] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg[3] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[3]_i_1_n_0 ),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[3] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg[4] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r[4]_i_1_n_0 ),
        .Q(\gaxi_full_sm.gaxifull_mem_slave.num_of_bytes_r_reg_n_0_[4] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.S_AXI_RID_reg[0] 
       (.C(s_aclk),
        .CE(E),
        .D(axi_read_fsm_n_24),
        .Q(s_axi_rid[0]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.S_AXI_RID_reg[1] 
       (.C(s_aclk),
        .CE(E),
        .D(axi_read_fsm_n_23),
        .Q(s_axi_rid[1]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.S_AXI_RID_reg[2] 
       (.C(s_aclk),
        .CE(E),
        .D(axi_read_fsm_n_22),
        .Q(s_axi_rid[2]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.S_AXI_RID_reg[3] 
       (.C(s_aclk),
        .CE(E),
        .D(axi_read_fsm_n_21),
        .Q(s_axi_rid[3]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.ar_id_r_reg[0] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(s_axi_arid[0]),
        .Q(ar_id_r[0]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.ar_id_r_reg[1] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(s_axi_arid[1]),
        .Q(ar_id_r[1]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.ar_id_r_reg[2] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(s_axi_arid[2]),
        .Q(ar_id_r[2]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \grid.ar_id_r_reg[3] 
       (.C(s_aclk),
        .CE(axi_read_fsm_n_11),
        .D(s_axi_arid[3]),
        .Q(ar_id_r[3]),
        .R(SS));
endmodule

(* ORIG_REF_NAME = "blk_mem_axi_write_fsm" *) 
module blk_mem_gen_0_blk_mem_axi_write_fsm
   (s_axi_awready,
    s_axi_wready,
    SR,
    Q,
    \bvalid_count_r_reg[0] ,
    s_axi_wvalid_0,
    \FSM_sequential_gaxi_full_sm.present_state_reg[0]_0 ,
    E,
    \bvalid_count_r_reg[1] ,
    s_axi_wvalid_1,
    s_axi_awvalid_0,
    \FSM_sequential_gaxi_full_sm.present_state_reg[0]_1 ,
    D,
    \gaxif_wlast_gen.awlen_cntr_r_reg[5] ,
    \FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 ,
    \s_axi_awaddr[14] ,
    \FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ,
    I17,
    \bvalid_count_r_reg[2] ,
    SS,
    s_aclk,
    s_axi_awvalid,
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[4] ,
    s_aresetn,
    s_axi_wvalid,
    \bvalid_count_r_reg[0]_0 ,
    s_axi_bready,
    \bvalid_count_r_reg[0]_1 ,
    s_axi_awburst,
    s_axi_awlen,
    \gaxif_wlast_gen.awlen_cntr_r_reg[7] ,
    \gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 ,
    \gaxif_wlast_gen.awlen_cntr_r_reg[5]_0 ,
    \gaxif_wlast_gen.awlen_cntr_r_reg[4] ,
    \gaxif_wlast_gen.awlen_cntr_r_reg[3] ,
    \gaxif_wlast_gen.awlen_cntr_r_reg[2] ,
    \gaxif_ms_addr_gen.next_address_r_reg[4] ,
    s_axi_awaddr,
    \gaxif_ms_addr_gen.next_address_r_reg[3] ,
    \gaxif_ms_addr_gen.next_address_r_reg[2] ,
    \gaxif_ms_addr_gen.next_address_r_reg[1] ,
    \gaxif_ms_addr_gen.next_address_r_reg[0] ,
    \gaxif_ms_addr_gen.next_address_r_reg[0]_0 ,
    ADDRARDADDR);
  output s_axi_awready;
  output s_axi_wready;
  output [0:0]SR;
  output [0:0]Q;
  output \bvalid_count_r_reg[0] ;
  output s_axi_wvalid_0;
  output \FSM_sequential_gaxi_full_sm.present_state_reg[0]_0 ;
  output [0:0]E;
  output [0:0]\bvalid_count_r_reg[1] ;
  output [0:0]s_axi_wvalid_1;
  output [0:0]s_axi_awvalid_0;
  output [0:0]\FSM_sequential_gaxi_full_sm.present_state_reg[0]_1 ;
  output [7:0]D;
  output \gaxif_wlast_gen.awlen_cntr_r_reg[5] ;
  output [4:0]\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 ;
  output [10:0]\s_axi_awaddr[14] ;
  output [0:0]\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ;
  output I17;
  output [1:0]\bvalid_count_r_reg[2] ;
  input [0:0]SS;
  input s_aclk;
  input s_axi_awvalid;
  input \gaxif_ms_addr_gen.addr_cnt_enb_reg[4] ;
  input s_aresetn;
  input s_axi_wvalid;
  input [2:0]\bvalid_count_r_reg[0]_0 ;
  input s_axi_bready;
  input \bvalid_count_r_reg[0]_1 ;
  input [1:0]s_axi_awburst;
  input [7:0]s_axi_awlen;
  input \gaxif_wlast_gen.awlen_cntr_r_reg[7] ;
  input [7:0]\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 ;
  input \gaxif_wlast_gen.awlen_cntr_r_reg[5]_0 ;
  input \gaxif_wlast_gen.awlen_cntr_r_reg[4] ;
  input \gaxif_wlast_gen.awlen_cntr_r_reg[3] ;
  input \gaxif_wlast_gen.awlen_cntr_r_reg[2] ;
  input \gaxif_ms_addr_gen.next_address_r_reg[4] ;
  input [14:0]s_axi_awaddr;
  input \gaxif_ms_addr_gen.next_address_r_reg[3] ;
  input \gaxif_ms_addr_gen.next_address_r_reg[2] ;
  input \gaxif_ms_addr_gen.next_address_r_reg[1] ;
  input [0:0]\gaxif_ms_addr_gen.next_address_r_reg[0] ;
  input [0:0]\gaxif_ms_addr_gen.next_address_r_reg[0]_0 ;
  input [10:0]ADDRARDADDR;

  wire [10:0]ADDRARDADDR;
  wire [7:0]D;
  wire [0:0]E;
  wire \FSM_sequential_gaxi_full_sm.present_state[0]_i_2_n_0 ;
  wire \FSM_sequential_gaxi_full_sm.present_state[0]_i_3_n_0 ;
  wire \FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ;
  wire \FSM_sequential_gaxi_full_sm.present_state_reg[0]_0 ;
  wire [0:0]\FSM_sequential_gaxi_full_sm.present_state_reg[0]_1 ;
  wire [4:0]\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 ;
  wire [0:0]\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ;
  wire I17;
  wire [0:0]Q;
  wire [0:0]SR;
  wire [0:0]SS;
  wire aw_ready_c;
  wire \bvalid_count_r[2]_i_3_n_0 ;
  wire \bvalid_count_r_reg[0] ;
  wire [2:0]\bvalid_count_r_reg[0]_0 ;
  wire \bvalid_count_r_reg[0]_1 ;
  wire [0:0]\bvalid_count_r_reg[1] ;
  wire [1:0]\bvalid_count_r_reg[2] ;
  wire \gaxi_full_sm.aw_ready_r_i_3_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg[4] ;
  wire [0:0]\gaxif_ms_addr_gen.next_address_r_reg[0] ;
  wire [0:0]\gaxif_ms_addr_gen.next_address_r_reg[0]_0 ;
  wire \gaxif_ms_addr_gen.next_address_r_reg[1] ;
  wire \gaxif_ms_addr_gen.next_address_r_reg[2] ;
  wire \gaxif_ms_addr_gen.next_address_r_reg[3] ;
  wire \gaxif_ms_addr_gen.next_address_r_reg[4] ;
  wire \gaxif_wlast_gen.awlen_cntr_r_reg[2] ;
  wire \gaxif_wlast_gen.awlen_cntr_r_reg[3] ;
  wire \gaxif_wlast_gen.awlen_cntr_r_reg[4] ;
  wire \gaxif_wlast_gen.awlen_cntr_r_reg[5] ;
  wire \gaxif_wlast_gen.awlen_cntr_r_reg[5]_0 ;
  wire \gaxif_wlast_gen.awlen_cntr_r_reg[7] ;
  wire [7:0]\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 ;
  wire [1:0]next_state;
  wire [1:1]present_state;
  wire s_aclk;
  wire s_aresetn;
  wire [14:0]s_axi_awaddr;
  wire [10:0]\s_axi_awaddr[14] ;
  wire [1:0]s_axi_awburst;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire [0:0]s_axi_awvalid_0;
  wire s_axi_bready;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire s_axi_wvalid_0;
  wire [0:0]s_axi_wvalid_1;
  wire w_ready_c;

  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_1 
       (.I0(Q),
        .I1(present_state),
        .I2(s_axi_wvalid),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hAAAABAAABFAFAAAA)) 
    \FSM_sequential_gaxi_full_sm.present_state[0]_i_1 
       (.I0(\FSM_sequential_gaxi_full_sm.present_state[0]_i_2_n_0 ),
        .I1(\FSM_sequential_gaxi_full_sm.present_state[0]_i_3_n_0 ),
        .I2(s_axi_wvalid),
        .I3(\gaxi_full_sm.aw_ready_r_i_3_n_0 ),
        .I4(Q),
        .I5(present_state),
        .O(next_state[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h55000030)) 
    \FSM_sequential_gaxi_full_sm.present_state[0]_i_2 
       (.I0(s_axi_bready),
        .I1(s_axi_wvalid),
        .I2(s_axi_awvalid),
        .I3(Q),
        .I4(present_state),
        .O(\FSM_sequential_gaxi_full_sm.present_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_gaxi_full_sm.present_state[0]_i_3 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [7]),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg[5] ),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [6]),
        .O(\FSM_sequential_gaxi_full_sm.present_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0022F3A0FF22F3A0)) 
    \FSM_sequential_gaxi_full_sm.present_state[1]_i_1 
       (.I0(s_axi_wvalid),
        .I1(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I2(s_axi_awvalid),
        .I3(present_state),
        .I4(Q),
        .I5(s_axi_bready),
        .O(next_state[1]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hA8AA)) 
    \FSM_sequential_gaxi_full_sm.present_state[1]_i_2 
       (.I0(s_axi_wvalid_0),
        .I1(\bvalid_count_r_reg[0]_0 [1]),
        .I2(\bvalid_count_r_reg[0]_0 [2]),
        .I3(\bvalid_count_r_reg[0]_0 [0]),
        .O(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "os_wr:01,reg_wraddr:10,wr_mem:11,wait_wraddr:00" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gaxi_full_sm.present_state_reg[0] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(next_state[0]),
        .Q(Q),
        .R(SS));
  (* FSM_ENCODED_STATES = "os_wr:01,reg_wraddr:10,wr_mem:11,wait_wraddr:00" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gaxi_full_sm.present_state_reg[1] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(next_state[1]),
        .Q(present_state),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h9F60609F)) 
    \bvalid_count_r[1]_i_1 
       (.I0(present_state),
        .I1(Q),
        .I2(s_axi_wvalid_0),
        .I3(\bvalid_count_r_reg[0]_0 [0]),
        .I4(\bvalid_count_r_reg[0]_0 [1]),
        .O(\bvalid_count_r_reg[2] [0]));
  LUT6 #(
    .INIT(64'h00FFFFFFFE000000)) 
    \bvalid_count_r[2]_i_1 
       (.I0(\bvalid_count_r_reg[0]_0 [1]),
        .I1(\bvalid_count_r_reg[0]_0 [2]),
        .I2(\bvalid_count_r_reg[0]_0 [0]),
        .I3(s_axi_bready),
        .I4(\bvalid_count_r_reg[0]_1 ),
        .I5(\bvalid_count_r[2]_i_3_n_0 ),
        .O(\bvalid_count_r_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h6AA9)) 
    \bvalid_count_r[2]_i_2 
       (.I0(\bvalid_count_r_reg[0]_0 [2]),
        .I1(\bvalid_count_r[2]_i_3_n_0 ),
        .I2(\bvalid_count_r_reg[0]_0 [1]),
        .I3(\bvalid_count_r_reg[0]_0 [0]),
        .O(\bvalid_count_r_reg[2] [1]));
  LUT6 #(
    .INIT(64'h0000000000000028)) 
    \bvalid_count_r[2]_i_3 
       (.I0(s_axi_wvalid),
        .I1(present_state),
        .I2(Q),
        .I3(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [6]),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg[5] ),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [7]),
        .O(\bvalid_count_r[2]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_i_1 
       (.I0(s_axi_awready),
        .I1(s_axi_awvalid),
        .O(I17));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \gaxi_bid_gen.bvalid_wr_cnt_r[1]_i_1 
       (.I0(s_axi_wvalid_0),
        .I1(Q),
        .I2(present_state),
        .O(E));
  LUT6 #(
    .INIT(64'hCCCC0F000F005555)) 
    \gaxi_full_sm.aw_ready_r_i_2 
       (.I0(s_axi_awvalid),
        .I1(s_axi_bready),
        .I2(\gaxi_full_sm.aw_ready_r_i_3_n_0 ),
        .I3(s_axi_wvalid_0),
        .I4(Q),
        .I5(present_state),
        .O(aw_ready_c));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \gaxi_full_sm.aw_ready_r_i_3 
       (.I0(\bvalid_count_r_reg[0]_0 [0]),
        .I1(\bvalid_count_r_reg[0]_0 [2]),
        .I2(\bvalid_count_r_reg[0]_0 [1]),
        .O(\gaxi_full_sm.aw_ready_r_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    \gaxi_full_sm.aw_ready_r_i_4 
       (.I0(s_axi_wvalid),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [6]),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg[5] ),
        .I3(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [7]),
        .O(s_axi_wvalid_0));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.aw_ready_r_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(aw_ready_c),
        .Q(s_axi_awready),
        .R(SS));
  LUT5 #(
    .INIT(32'h000F2FAA)) 
    \gaxi_full_sm.w_ready_r_i_1 
       (.I0(s_axi_awvalid),
        .I1(\gaxi_full_sm.aw_ready_r_i_3_n_0 ),
        .I2(s_axi_wvalid_0),
        .I3(present_state),
        .I4(Q),
        .O(w_ready_c));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_full_sm.w_ready_r_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(w_ready_c),
        .Q(s_axi_wready),
        .R(SS));
  LUT6 #(
    .INIT(64'hFFBF0000FFFFFFFF)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_1 
       (.I0(Q),
        .I1(s_axi_awvalid),
        .I2(\bvalid_count_r_reg[0] ),
        .I3(\gaxif_ms_addr_gen.addr_cnt_enb_reg[4] ),
        .I4(s_axi_wvalid_0),
        .I5(s_aresetn),
        .O(SR));
  LUT6 #(
    .INIT(64'h0000000040440000)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_2 
       (.I0(Q),
        .I1(s_axi_awvalid),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(present_state),
        .I4(s_axi_awburst[1]),
        .I5(s_axi_awburst[0]),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hFD00FFFF)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_4 
       (.I0(\bvalid_count_r_reg[0]_0 [0]),
        .I1(\bvalid_count_r_reg[0]_0 [2]),
        .I2(\bvalid_count_r_reg[0]_0 [1]),
        .I3(s_axi_wvalid_0),
        .I4(present_state),
        .O(\bvalid_count_r_reg[0] ));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[10]_i_1 
       (.I0(s_axi_awaddr[10]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[6]),
        .O(\s_axi_awaddr[14] [6]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[11]_i_1 
       (.I0(s_axi_awaddr[11]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[7]),
        .O(\s_axi_awaddr[14] [7]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[12]_i_1 
       (.I0(s_axi_awaddr[12]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[8]),
        .O(\s_axi_awaddr[14] [8]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[13]_i_1 
       (.I0(s_axi_awaddr[13]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[9]),
        .O(\s_axi_awaddr[14] [9]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[14]_i_1 
       (.I0(s_axi_awaddr[14]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[10]),
        .O(\s_axi_awaddr[14] [10]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[4]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[0]),
        .O(\s_axi_awaddr[14] [0]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[5]_i_1 
       (.I0(s_axi_awaddr[5]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[1]),
        .O(\s_axi_awaddr[14] [1]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[6]_i_1 
       (.I0(s_axi_awaddr[6]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[2]),
        .O(\s_axi_awaddr[14] [2]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[7]_i_1 
       (.I0(s_axi_awaddr[7]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[3]),
        .O(\s_axi_awaddr[14] [3]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[8]_i_1 
       (.I0(s_axi_awaddr[8]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[4]),
        .O(\s_axi_awaddr[14] [4]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.bmg_address_r[9]_i_1 
       (.I0(s_axi_awaddr[9]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(ADDRARDADDR[5]),
        .O(\s_axi_awaddr[14] [5]));
  LUT6 #(
    .INIT(64'h0080FFBFFFBF0080)) 
    \gaxif_ms_addr_gen.next_address_r[0]_i_1 
       (.I0(s_axi_awaddr[0]),
        .I1(\bvalid_count_r_reg[0] ),
        .I2(s_axi_awvalid),
        .I3(Q),
        .I4(\gaxif_ms_addr_gen.next_address_r_reg[0] ),
        .I5(\gaxif_ms_addr_gen.next_address_r_reg[0]_0 ),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 [0]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.next_address_r[1]_i_1 
       (.I0(s_axi_awaddr[1]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_ms_addr_gen.next_address_r_reg[1] ),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 [1]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.next_address_r[2]_i_1 
       (.I0(s_axi_awaddr[2]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_ms_addr_gen.next_address_r_reg[2] ),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 [2]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_ms_addr_gen.next_address_r[3]_i_1 
       (.I0(s_axi_awaddr[3]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_ms_addr_gen.next_address_r_reg[3] ),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 [3]));
  LUT6 #(
    .INIT(64'h0FFA002A000A000A)) 
    \gaxif_ms_addr_gen.next_address_r[4]_i_1 
       (.I0(s_axi_awvalid),
        .I1(\gaxi_full_sm.aw_ready_r_i_3_n_0 ),
        .I2(present_state),
        .I3(Q),
        .I4(\FSM_sequential_gaxi_full_sm.present_state[0]_i_3_n_0 ),
        .I5(s_axi_wvalid),
        .O(s_axi_awvalid_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'h8AAA8A8A)) 
    \gaxif_ms_addr_gen.next_address_r[4]_i_2 
       (.I0(\gaxif_ms_addr_gen.next_address_r_reg[4] ),
        .I1(Q),
        .I2(s_axi_awvalid),
        .I3(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I4(present_state),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 [4]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h00D0)) 
    \gaxif_ms_addr_gen.num_of_bytes_r[4]_i_1 
       (.I0(present_state),
        .I1(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I2(s_axi_awvalid),
        .I3(Q),
        .O(\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 ));
  LUT6 #(
    .INIT(64'h0000A200FFFFAEFF)) 
    \gaxif_wlast_gen.awlen_cntr_r[0]_i_1 
       (.I0(s_axi_awlen[0]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [0]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hFFBF00800080FFBF)) 
    \gaxif_wlast_gen.awlen_cntr_r[1]_i_1 
       (.I0(s_axi_awlen[1]),
        .I1(\bvalid_count_r_reg[0] ),
        .I2(s_axi_awvalid),
        .I3(Q),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [1]),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [0]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_wlast_gen.awlen_cntr_r[2]_i_1 
       (.I0(s_axi_awlen[2]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[2] ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_wlast_gen.awlen_cntr_r[3]_i_1 
       (.I0(s_axi_awlen[3]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[3] ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_wlast_gen.awlen_cntr_r[4]_i_1 
       (.I0(s_axi_awlen[4]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[4] ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hFFFFAEFF0000A200)) 
    \gaxif_wlast_gen.awlen_cntr_r[5]_i_1 
       (.I0(s_axi_awlen[5]),
        .I1(present_state),
        .I2(\FSM_sequential_gaxi_full_sm.present_state[1]_i_2_n_0 ),
        .I3(s_axi_awvalid),
        .I4(Q),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[5]_0 ),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hFFBF00800080FFBF)) 
    \gaxif_wlast_gen.awlen_cntr_r[6]_i_1 
       (.I0(s_axi_awlen[6]),
        .I1(\bvalid_count_r_reg[0] ),
        .I2(s_axi_awvalid),
        .I3(Q),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg[5] ),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [6]),
        .O(D[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gaxif_wlast_gen.awlen_cntr_r[6]_i_2 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [5]),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [3]),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [1]),
        .I3(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [0]),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [2]),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [4]),
        .O(\gaxif_wlast_gen.awlen_cntr_r_reg[5] ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxif_wlast_gen.awlen_cntr_r[7]_i_1 
       (.I0(s_axi_wvalid_0),
        .I1(s_axi_awvalid_0),
        .O(s_axi_wvalid_1));
  LUT6 #(
    .INIT(64'hFFBF00800080FFBF)) 
    \gaxif_wlast_gen.awlen_cntr_r[7]_i_2 
       (.I0(s_axi_awlen[7]),
        .I1(\bvalid_count_r_reg[0] ),
        .I2(s_axi_awvalid),
        .I3(Q),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg[7] ),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 [7]),
        .O(D[7]));
endmodule

(* ORIG_REF_NAME = "blk_mem_axi_write_wrapper" *) 
module blk_mem_gen_0_blk_mem_axi_write_wrapper
   (s_axi_awready,
    s_axi_wready,
    \gaxi_bvalid_id_r.bvalid_r_reg_0 ,
    \FSM_sequential_gaxi_full_sm.present_state_reg[0] ,
    ADDRARDADDR,
    s_axi_bid,
    SS,
    s_aclk,
    s_axi_awvalid,
    s_aresetn,
    s_axi_wvalid,
    s_axi_awsize,
    s_axi_bready,
    s_axi_awburst,
    s_axi_awlen,
    s_axi_awaddr,
    s_axi_awid);
  output s_axi_awready;
  output s_axi_wready;
  output \gaxi_bvalid_id_r.bvalid_r_reg_0 ;
  output \FSM_sequential_gaxi_full_sm.present_state_reg[0] ;
  output [10:0]ADDRARDADDR;
  output [3:0]s_axi_bid;
  input [0:0]SS;
  input s_aclk;
  input s_axi_awvalid;
  input s_aresetn;
  input s_axi_wvalid;
  input [2:0]s_axi_awsize;
  input s_axi_bready;
  input [1:0]s_axi_awburst;
  input [7:0]s_axi_awlen;
  input [14:0]s_axi_awaddr;
  input [3:0]s_axi_awid;

  wire [10:0]ADDRARDADDR;
  wire [1:0]CONV_INTEGER;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_24_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_26_n_0 ;
  wire \FSM_sequential_gaxi_full_sm.present_state_reg[0] ;
  wire [0:0]SS;
  wire addr_en_c;
  wire axi_wr_fsm_n_10;
  wire axi_wr_fsm_n_2;
  wire axi_wr_fsm_n_20;
  wire axi_wr_fsm_n_26;
  wire axi_wr_fsm_n_27;
  wire axi_wr_fsm_n_28;
  wire axi_wr_fsm_n_29;
  wire axi_wr_fsm_n_30;
  wire axi_wr_fsm_n_31;
  wire axi_wr_fsm_n_32;
  wire axi_wr_fsm_n_33;
  wire axi_wr_fsm_n_34;
  wire axi_wr_fsm_n_35;
  wire axi_wr_fsm_n_36;
  wire axi_wr_fsm_n_38;
  wire axi_wr_fsm_n_39;
  wire axi_wr_fsm_n_4;
  wire axi_wr_fsm_n_40;
  wire axi_wr_fsm_n_5;
  wire axi_wr_fsm_n_7;
  wire axi_wr_fsm_n_9;
  wire [14:4]bmg_address_r;
  wire bvalid_count_r;
  wire \bvalid_count_r[0]_i_1_n_0 ;
  wire \bvalid_count_r_reg_n_0_[0] ;
  wire \bvalid_count_r_reg_n_0_[1] ;
  wire \bvalid_count_r_reg_n_0_[2] ;
  wire bvalid_d1_c;
  wire [1:0]bvalid_rd_cnt_r;
  wire [1:0]bvalid_wr_cnt_r;
  wire \gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_0 ;
  wire \gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_1 ;
  wire \gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_2 ;
  wire \gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_3 ;
  wire \gaxi_bid_gen.bvalid_wr_cnt_r[0]_i_1_n_0 ;
  wire \gaxi_bid_gen.bvalid_wr_cnt_r[1]_i_2_n_0 ;
  wire \gaxi_bvalid_id_r.bvalid_r_i_1_n_0 ;
  wire \gaxi_bvalid_id_r.bvalid_r_reg_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[14]_i_1_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[4]_i_1_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[5]_i_1_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[6]_i_1_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[7]_i_1_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_3_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_5_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[4] ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[5] ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[6] ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[7] ;
  wire \gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[8] ;
  wire \gaxif_ms_addr_gen.next_address_r[1]_i_2_n_0 ;
  wire \gaxif_ms_addr_gen.next_address_r[2]_i_2_n_0 ;
  wire \gaxif_ms_addr_gen.next_address_r[3]_i_2_n_0 ;
  wire \gaxif_ms_addr_gen.next_address_r[4]_i_3_n_0 ;
  wire \gaxif_ms_addr_gen.next_address_r[4]_i_4_n_0 ;
  wire \gaxif_ms_addr_gen.num_of_bytes_r[4]_i_2_n_0 ;
  wire \gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[0] ;
  wire \gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[1] ;
  wire \gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[2] ;
  wire \gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[3] ;
  wire \gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[4] ;
  wire \gaxif_wlast_gen.awlen_cntr_r[2]_i_2_n_0 ;
  wire \gaxif_wlast_gen.awlen_cntr_r[3]_i_2_n_0 ;
  wire \gaxif_wlast_gen.awlen_cntr_r[4]_i_2_n_0 ;
  wire \gaxif_wlast_gen.awlen_cntr_r[5]_i_2_n_0 ;
  wire \gaxif_wlast_gen.awlen_cntr_r[7]_i_3_n_0 ;
  wire [7:0]\gaxif_wlast_gen.awlen_cntr_r_reg__0 ;
  wire incr_en_r;
  wire [4:0]next_address_r;
  wire [3:0]num_of_bytes_c;
  wire [7:0]p_0_in;
  wire p_0_in5_in;
  wire p_0_out;
  wire [3:0]p_1_in;
  wire p_4_out;
  wire [0:0]present_state;
  wire s_aclk;
  wire s_aresetn;
  wire [14:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire [1:0]\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOC_UNCONNECTED ;
  wire [1:0]\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOD_UNCONNECTED ;
  wire [1:0]\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOE_UNCONNECTED ;
  wire [1:0]\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOF_UNCONNECTED ;
  wire [1:0]\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOG_UNCONNECTED ;
  wire [1:0]\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOH_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hAAAAAAAA6AAAAAAA)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_10 
       (.I0(bmg_address_r[6]),
        .I1(bmg_address_r[4]),
        .I2(incr_en_r),
        .I3(p_0_in5_in),
        .I4(bmg_address_r[5]),
        .I5(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[6] ),
        .O(ADDRARDADDR[2]));
  LUT5 #(
    .INIT(32'hAAAA6AAA)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_11 
       (.I0(bmg_address_r[5]),
        .I1(p_0_in5_in),
        .I2(incr_en_r),
        .I3(bmg_address_r[4]),
        .I4(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[5] ),
        .O(ADDRARDADDR[1]));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_12 
       (.I0(bmg_address_r[4]),
        .I1(incr_en_r),
        .I2(p_0_in5_in),
        .I3(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[4] ),
        .O(ADDRARDADDR[0]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hA6AA)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_2 
       (.I0(bmg_address_r[14]),
        .I1(bmg_address_r[12]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_24_n_0 ),
        .I3(bmg_address_r[13]),
        .O(ADDRARDADDR[10]));
  LUT6 #(
    .INIT(64'hFFDFFFFFFFFFFFFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_24 
       (.I0(bmg_address_r[10]),
        .I1(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ),
        .I2(bmg_address_r[8]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ),
        .I4(bmg_address_r[9]),
        .I5(bmg_address_r[11]),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_24_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25 
       (.I0(bmg_address_r[6]),
        .I1(bmg_address_r[4]),
        .I2(incr_en_r),
        .I3(p_0_in5_in),
        .I4(bmg_address_r[5]),
        .I5(bmg_address_r[7]),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_26 
       (.I0(bmg_address_r[5]),
        .I1(p_0_in5_in),
        .I2(incr_en_r),
        .I3(bmg_address_r[4]),
        .I4(bmg_address_r[6]),
        .O(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_26_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_3 
       (.I0(bmg_address_r[13]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_24_n_0 ),
        .I2(bmg_address_r[12]),
        .O(ADDRARDADDR[9]));
  LUT2 #(
    .INIT(4'h9)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_4 
       (.I0(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_24_n_0 ),
        .I1(bmg_address_r[12]),
        .O(ADDRARDADDR[8]));
  LUT6 #(
    .INIT(64'hAAAAA6AAAAAAAAAA)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_5 
       (.I0(bmg_address_r[11]),
        .I1(bmg_address_r[9]),
        .I2(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ),
        .I3(bmg_address_r[8]),
        .I4(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ),
        .I5(bmg_address_r[10]),
        .O(ADDRARDADDR[7]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'hAA9AAAAA)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_6 
       (.I0(bmg_address_r[10]),
        .I1(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ),
        .I2(bmg_address_r[8]),
        .I3(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ),
        .I4(bmg_address_r[9]),
        .O(ADDRARDADDR[6]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hAA9A)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_7 
       (.I0(bmg_address_r[9]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ),
        .I2(bmg_address_r[8]),
        .I3(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ),
        .O(ADDRARDADDR[5]));
  LUT3 #(
    .INIT(8'hA9)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_8 
       (.I0(bmg_address_r[8]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_25_n_0 ),
        .I2(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[8] ),
        .O(ADDRARDADDR[4]));
  LUT3 #(
    .INIT(8'hA9)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_9 
       (.I0(bmg_address_r[7]),
        .I1(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_i_26_n_0 ),
        .I2(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[7] ),
        .O(ADDRARDADDR[3]));
  blk_mem_gen_0_blk_mem_axi_write_fsm axi_wr_fsm
       (.ADDRARDADDR(ADDRARDADDR),
        .D(p_0_in),
        .E(axi_wr_fsm_n_7),
        .\FSM_sequential_gaxi_full_sm.present_state_reg[0]_0 (\FSM_sequential_gaxi_full_sm.present_state_reg[0] ),
        .\FSM_sequential_gaxi_full_sm.present_state_reg[0]_1 (p_4_out),
        .\FSM_sequential_gaxi_full_sm.present_state_reg[0]_2 (next_address_r),
        .\FSM_sequential_gaxi_full_sm.present_state_reg[1]_0 (addr_en_c),
        .I17(axi_wr_fsm_n_38),
        .Q(present_state),
        .SR(axi_wr_fsm_n_2),
        .SS(SS),
        .\bvalid_count_r_reg[0] (axi_wr_fsm_n_4),
        .\bvalid_count_r_reg[0]_0 ({\bvalid_count_r_reg_n_0_[2] ,\bvalid_count_r_reg_n_0_[1] ,\bvalid_count_r_reg_n_0_[0] }),
        .\bvalid_count_r_reg[0]_1 (\gaxi_bvalid_id_r.bvalid_r_reg_0 ),
        .\bvalid_count_r_reg[1] (bvalid_count_r),
        .\bvalid_count_r_reg[2] ({axi_wr_fsm_n_39,axi_wr_fsm_n_40}),
        .\gaxif_ms_addr_gen.addr_cnt_enb_reg[4] (\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_5_n_0 ),
        .\gaxif_ms_addr_gen.next_address_r_reg[0] (p_1_in[0]),
        .\gaxif_ms_addr_gen.next_address_r_reg[0]_0 (\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[0] ),
        .\gaxif_ms_addr_gen.next_address_r_reg[1] (\gaxif_ms_addr_gen.next_address_r[1]_i_2_n_0 ),
        .\gaxif_ms_addr_gen.next_address_r_reg[2] (\gaxif_ms_addr_gen.next_address_r[2]_i_2_n_0 ),
        .\gaxif_ms_addr_gen.next_address_r_reg[3] (\gaxif_ms_addr_gen.next_address_r[3]_i_2_n_0 ),
        .\gaxif_ms_addr_gen.next_address_r_reg[4] (\gaxif_ms_addr_gen.next_address_r[4]_i_3_n_0 ),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[2] (\gaxif_wlast_gen.awlen_cntr_r[2]_i_2_n_0 ),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[3] (\gaxif_wlast_gen.awlen_cntr_r[3]_i_2_n_0 ),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[4] (\gaxif_wlast_gen.awlen_cntr_r[4]_i_2_n_0 ),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[5] (axi_wr_fsm_n_20),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[5]_0 (\gaxif_wlast_gen.awlen_cntr_r[5]_i_2_n_0 ),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[7] (\gaxif_wlast_gen.awlen_cntr_r[7]_i_3_n_0 ),
        .\gaxif_wlast_gen.awlen_cntr_r_reg[7]_0 (\gaxif_wlast_gen.awlen_cntr_r_reg__0 ),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_awaddr(s_axi_awaddr),
        .\s_axi_awaddr[14] ({axi_wr_fsm_n_26,axi_wr_fsm_n_27,axi_wr_fsm_n_28,axi_wr_fsm_n_29,axi_wr_fsm_n_30,axi_wr_fsm_n_31,axi_wr_fsm_n_32,axi_wr_fsm_n_33,axi_wr_fsm_n_34,axi_wr_fsm_n_35,axi_wr_fsm_n_36}),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awvalid_0(axi_wr_fsm_n_10),
        .s_axi_bready(s_axi_bready),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wvalid_0(axi_wr_fsm_n_5),
        .s_axi_wvalid_1(axi_wr_fsm_n_9));
  LUT1 #(
    .INIT(2'h1)) 
    \bvalid_count_r[0]_i_1 
       (.I0(\bvalid_count_r_reg_n_0_[0] ),
        .O(\bvalid_count_r[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \bvalid_count_r_reg[0] 
       (.C(s_aclk),
        .CE(bvalid_count_r),
        .D(\bvalid_count_r[0]_i_1_n_0 ),
        .Q(\bvalid_count_r_reg_n_0_[0] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \bvalid_count_r_reg[1] 
       (.C(s_aclk),
        .CE(bvalid_count_r),
        .D(axi_wr_fsm_n_40),
        .Q(\bvalid_count_r_reg_n_0_[1] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \bvalid_count_r_reg[2] 
       (.C(s_aclk),
        .CE(bvalid_count_r),
        .D(axi_wr_fsm_n_39),
        .Q(\bvalid_count_r_reg_n_0_[2] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.S_AXI_BID_reg[0] 
       (.C(s_aclk),
        .CE(s_aresetn),
        .D(\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_1 ),
        .Q(s_axi_bid[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.S_AXI_BID_reg[1] 
       (.C(s_aclk),
        .CE(s_aresetn),
        .D(\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_0 ),
        .Q(s_axi_bid[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.S_AXI_BID_reg[2] 
       (.C(s_aclk),
        .CE(s_aresetn),
        .D(\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_3 ),
        .Q(s_axi_bid[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.S_AXI_BID_reg[3] 
       (.C(s_aclk),
        .CE(s_aresetn),
        .D(\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_2 ),
        .Q(s_axi_bid[3]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "3" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "3" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    \gaxi_bid_gen.axi_bid_array_reg_0_3_0_3 
       (.ADDRA({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRB({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRC({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRD({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRE({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRF({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRG({1'b0,1'b0,1'b0,CONV_INTEGER}),
        .ADDRH({1'b0,1'b0,1'b0,bvalid_wr_cnt_r}),
        .DIA(s_axi_awid[1:0]),
        .DIB(s_axi_awid[3:2]),
        .DIC({1'b0,1'b0}),
        .DID({1'b0,1'b0}),
        .DIE({1'b0,1'b0}),
        .DIF({1'b0,1'b0}),
        .DIG({1'b0,1'b0}),
        .DIH({1'b0,1'b0}),
        .DOA({\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_0 ,\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_1 }),
        .DOB({\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_2 ,\gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_n_3 }),
        .DOC(\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOC_UNCONNECTED [1:0]),
        .DOD(\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOD_UNCONNECTED [1:0]),
        .DOE(\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOE_UNCONNECTED [1:0]),
        .DOF(\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOF_UNCONNECTED [1:0]),
        .DOG(\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOG_UNCONNECTED [1:0]),
        .DOH(\NLW_gaxi_bid_gen.axi_bid_array_reg_0_3_0_3_DOH_UNCONNECTED [1:0]),
        .WCLK(s_aclk),
        .WE(axi_wr_fsm_n_38));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \gaxi_bid_gen.bvalid_rd_cnt_r[0]_i_1 
       (.I0(bvalid_rd_cnt_r[0]),
        .I1(\gaxi_bvalid_id_r.bvalid_r_reg_0 ),
        .I2(s_axi_bready),
        .O(CONV_INTEGER[0]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \gaxi_bid_gen.bvalid_rd_cnt_r[1]_i_1 
       (.I0(bvalid_rd_cnt_r[1]),
        .I1(s_axi_bready),
        .I2(\gaxi_bvalid_id_r.bvalid_r_reg_0 ),
        .I3(bvalid_rd_cnt_r[0]),
        .O(CONV_INTEGER[1]));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.bvalid_rd_cnt_r_reg[0] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(CONV_INTEGER[0]),
        .Q(bvalid_rd_cnt_r[0]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.bvalid_rd_cnt_r_reg[1] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(CONV_INTEGER[1]),
        .Q(bvalid_rd_cnt_r[1]),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gaxi_bid_gen.bvalid_wr_cnt_r[0]_i_1 
       (.I0(bvalid_wr_cnt_r[0]),
        .O(\gaxi_bid_gen.bvalid_wr_cnt_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gaxi_bid_gen.bvalid_wr_cnt_r[1]_i_2 
       (.I0(bvalid_wr_cnt_r[0]),
        .I1(bvalid_wr_cnt_r[1]),
        .O(\gaxi_bid_gen.bvalid_wr_cnt_r[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.bvalid_wr_cnt_r_reg[0] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_7),
        .D(\gaxi_bid_gen.bvalid_wr_cnt_r[0]_i_1_n_0 ),
        .Q(bvalid_wr_cnt_r[0]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bid_gen.bvalid_wr_cnt_r_reg[1] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_7),
        .D(\gaxi_bid_gen.bvalid_wr_cnt_r[1]_i_2_n_0 ),
        .Q(bvalid_wr_cnt_r[1]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bvalid_id_r.bvalid_d1_c_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(axi_wr_fsm_n_7),
        .Q(bvalid_d1_c),
        .R(SS));
  LUT5 #(
    .INIT(32'hFEFFAAAA)) 
    \gaxi_bvalid_id_r.bvalid_r_i_1 
       (.I0(bvalid_d1_c),
        .I1(\bvalid_count_r_reg_n_0_[1] ),
        .I2(\bvalid_count_r_reg_n_0_[2] ),
        .I3(s_axi_bready),
        .I4(\gaxi_bvalid_id_r.bvalid_r_reg_0 ),
        .O(\gaxi_bvalid_id_r.bvalid_r_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxi_bvalid_id_r.bvalid_r_reg 
       (.C(s_aclk),
        .CE(1'b1),
        .D(\gaxi_bvalid_id_r.bvalid_r_i_1_n_0 ),
        .Q(\gaxi_bvalid_id_r.bvalid_r_reg_0 ),
        .R(SS));
  LUT6 #(
    .INIT(64'h5555755500003000)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[14]_i_1 
       (.I0(axi_wr_fsm_n_5),
        .I1(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_5_n_0 ),
        .I2(axi_wr_fsm_n_4),
        .I3(s_axi_awvalid),
        .I4(present_state),
        .I5(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000010D050FF)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[4]_i_1 
       (.I0(s_axi_awlen[2]),
        .I1(s_axi_awlen[1]),
        .I2(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ),
        .I3(s_axi_awsize[1]),
        .I4(s_axi_awsize[0]),
        .I5(s_axi_awsize[2]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h002F000F01FF000F)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[5]_i_1 
       (.I0(s_axi_awlen[1]),
        .I1(s_axi_awsize[0]),
        .I2(s_axi_awsize[1]),
        .I3(s_axi_awsize[2]),
        .I4(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ),
        .I5(s_axi_awlen[2]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5557151515FF1515)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[6]_i_1 
       (.I0(s_axi_awsize[2]),
        .I1(s_axi_awsize[0]),
        .I2(s_axi_awsize[1]),
        .I3(s_axi_awlen[2]),
        .I4(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ),
        .I5(s_axi_awlen[1]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0008FFFFAAAAFFFF)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[7]_i_1 
       (.I0(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ),
        .I1(s_axi_awlen[1]),
        .I2(s_axi_awsize[1]),
        .I3(s_axi_awsize[0]),
        .I4(s_axi_awsize[2]),
        .I5(s_axi_awlen[2]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hD0FFD0FFD0FFFFFF)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_3 
       (.I0(s_axi_awlen[2]),
        .I1(s_axi_awlen[1]),
        .I2(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ),
        .I3(s_axi_awsize[2]),
        .I4(s_axi_awsize[0]),
        .I5(s_axi_awsize[1]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_5 
       (.I0(s_axi_awburst[0]),
        .I1(s_axi_awburst[1]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6 
       (.I0(s_axi_awlen[5]),
        .I1(s_axi_awlen[6]),
        .I2(s_axi_awlen[7]),
        .I3(s_axi_awlen[4]),
        .I4(s_axi_awlen[3]),
        .I5(s_axi_awlen[0]),
        .O(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[14] 
       (.C(s_aclk),
        .CE(1'b1),
        .D(\gaxif_ms_addr_gen.addr_cnt_enb[14]_i_1_n_0 ),
        .Q(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[14] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[4] 
       (.C(s_aclk),
        .CE(p_4_out),
        .D(\gaxif_ms_addr_gen.addr_cnt_enb[4]_i_1_n_0 ),
        .Q(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[4] ),
        .R(axi_wr_fsm_n_2));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[5] 
       (.C(s_aclk),
        .CE(p_4_out),
        .D(\gaxif_ms_addr_gen.addr_cnt_enb[5]_i_1_n_0 ),
        .Q(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[5] ),
        .R(axi_wr_fsm_n_2));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[6] 
       (.C(s_aclk),
        .CE(p_4_out),
        .D(\gaxif_ms_addr_gen.addr_cnt_enb[6]_i_1_n_0 ),
        .Q(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[6] ),
        .R(axi_wr_fsm_n_2));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[7] 
       (.C(s_aclk),
        .CE(p_4_out),
        .D(\gaxif_ms_addr_gen.addr_cnt_enb[7]_i_1_n_0 ),
        .Q(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[7] ),
        .R(axi_wr_fsm_n_2));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.addr_cnt_enb_reg[8] 
       (.C(s_aclk),
        .CE(p_4_out),
        .D(\gaxif_ms_addr_gen.addr_cnt_enb[8]_i_3_n_0 ),
        .Q(\gaxif_ms_addr_gen.addr_cnt_enb_reg_n_0_[8] ),
        .R(axi_wr_fsm_n_2));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[10] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_30),
        .Q(bmg_address_r[10]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[11] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_29),
        .Q(bmg_address_r[11]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[12] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_28),
        .Q(bmg_address_r[12]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[13] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_27),
        .Q(bmg_address_r[13]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[14] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_26),
        .Q(bmg_address_r[14]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[4] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_36),
        .Q(bmg_address_r[4]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[5] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_35),
        .Q(bmg_address_r[5]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[6] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_34),
        .Q(bmg_address_r[6]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[7] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_33),
        .Q(bmg_address_r[7]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[8] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_32),
        .Q(bmg_address_r[8]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.bmg_address_r_reg[9] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(axi_wr_fsm_n_31),
        .Q(bmg_address_r[9]),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \gaxif_ms_addr_gen.incr_en_r_i_1 
       (.I0(s_axi_awburst[1]),
        .I1(s_axi_awburst[0]),
        .O(p_0_out));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.incr_en_r_reg 
       (.C(s_aclk),
        .CE(addr_en_c),
        .D(p_0_out),
        .Q(incr_en_r),
        .R(SS));
  LUT4 #(
    .INIT(16'h8778)) 
    \gaxif_ms_addr_gen.next_address_r[1]_i_2 
       (.I0(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[0] ),
        .I1(p_1_in[0]),
        .I2(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[1] ),
        .I3(p_1_in[1]),
        .O(\gaxif_ms_addr_gen.next_address_r[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF880077F077FF880)) 
    \gaxif_ms_addr_gen.next_address_r[2]_i_2 
       (.I0(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[0] ),
        .I1(p_1_in[0]),
        .I2(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[1] ),
        .I3(p_1_in[1]),
        .I4(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[2] ),
        .I5(p_1_in[2]),
        .O(\gaxif_ms_addr_gen.next_address_r[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \gaxif_ms_addr_gen.next_address_r[3]_i_2 
       (.I0(\gaxif_ms_addr_gen.next_address_r[4]_i_4_n_0 ),
        .I1(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[3] ),
        .I2(p_1_in[3]),
        .O(\gaxif_ms_addr_gen.next_address_r[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h566A)) 
    \gaxif_ms_addr_gen.next_address_r[4]_i_3 
       (.I0(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[4] ),
        .I1(p_1_in[3]),
        .I2(\gaxif_ms_addr_gen.next_address_r[4]_i_4_n_0 ),
        .I3(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[3] ),
        .O(\gaxif_ms_addr_gen.next_address_r[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFEAEAAAAA808000)) 
    \gaxif_ms_addr_gen.next_address_r[4]_i_4 
       (.I0(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[2] ),
        .I1(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[0] ),
        .I2(p_1_in[0]),
        .I3(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[1] ),
        .I4(p_1_in[1]),
        .I5(p_1_in[2]),
        .O(\gaxif_ms_addr_gen.next_address_r[4]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.next_address_r_reg[0] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(next_address_r[0]),
        .Q(p_1_in[0]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.next_address_r_reg[1] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(next_address_r[1]),
        .Q(p_1_in[1]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.next_address_r_reg[2] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(next_address_r[2]),
        .Q(p_1_in[2]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.next_address_r_reg[3] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(next_address_r[3]),
        .Q(p_1_in[3]),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.next_address_r_reg[4] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_10),
        .D(next_address_r[4]),
        .Q(p_0_in5_in),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \gaxif_ms_addr_gen.num_of_bytes_r[0]_i_1 
       (.I0(s_axi_awsize[1]),
        .I1(s_axi_awsize[0]),
        .I2(s_axi_awsize[2]),
        .O(num_of_bytes_c[0]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \gaxif_ms_addr_gen.num_of_bytes_r[1]_i_1 
       (.I0(s_axi_awsize[0]),
        .I1(s_axi_awsize[1]),
        .I2(s_axi_awsize[2]),
        .O(num_of_bytes_c[1]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \gaxif_ms_addr_gen.num_of_bytes_r[2]_i_1 
       (.I0(s_axi_awsize[1]),
        .I1(s_axi_awsize[2]),
        .I2(s_axi_awsize[0]),
        .O(num_of_bytes_c[2]));
  LUT3 #(
    .INIT(8'h08)) 
    \gaxif_ms_addr_gen.num_of_bytes_r[3]_i_1 
       (.I0(s_axi_awsize[1]),
        .I1(s_axi_awsize[0]),
        .I2(s_axi_awsize[2]),
        .O(num_of_bytes_c[3]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \gaxif_ms_addr_gen.num_of_bytes_r[4]_i_2 
       (.I0(s_axi_awsize[1]),
        .I1(s_axi_awsize[0]),
        .I2(s_axi_awsize[2]),
        .O(\gaxif_ms_addr_gen.num_of_bytes_r[4]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.num_of_bytes_r_reg[0] 
       (.C(s_aclk),
        .CE(addr_en_c),
        .D(num_of_bytes_c[0]),
        .Q(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[0] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.num_of_bytes_r_reg[1] 
       (.C(s_aclk),
        .CE(addr_en_c),
        .D(num_of_bytes_c[1]),
        .Q(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[1] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.num_of_bytes_r_reg[2] 
       (.C(s_aclk),
        .CE(addr_en_c),
        .D(num_of_bytes_c[2]),
        .Q(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[2] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.num_of_bytes_r_reg[3] 
       (.C(s_aclk),
        .CE(addr_en_c),
        .D(num_of_bytes_c[3]),
        .Q(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[3] ),
        .R(SS));
  FDRE #(
    .INIT(1'b0)) 
    \gaxif_ms_addr_gen.num_of_bytes_r_reg[4] 
       (.C(s_aclk),
        .CE(addr_en_c),
        .D(\gaxif_ms_addr_gen.num_of_bytes_r[4]_i_2_n_0 ),
        .Q(\gaxif_ms_addr_gen.num_of_bytes_r_reg_n_0_[4] ),
        .R(SS));
  LUT3 #(
    .INIT(8'hE1)) 
    \gaxif_wlast_gen.awlen_cntr_r[2]_i_2 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [1]),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [0]),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [2]),
        .O(\gaxif_wlast_gen.awlen_cntr_r[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \gaxif_wlast_gen.awlen_cntr_r[3]_i_2 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [2]),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [0]),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [1]),
        .I3(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [3]),
        .O(\gaxif_wlast_gen.awlen_cntr_r[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    \gaxif_wlast_gen.awlen_cntr_r[4]_i_2 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [3]),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [1]),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [0]),
        .I3(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [2]),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [4]),
        .O(\gaxif_wlast_gen.awlen_cntr_r[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    \gaxif_wlast_gen.awlen_cntr_r[5]_i_2 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [4]),
        .I1(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [2]),
        .I2(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [0]),
        .I3(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [1]),
        .I4(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [3]),
        .I5(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [5]),
        .O(\gaxif_wlast_gen.awlen_cntr_r[5]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \gaxif_wlast_gen.awlen_cntr_r[7]_i_3 
       (.I0(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [6]),
        .I1(axi_wr_fsm_n_20),
        .O(\gaxif_wlast_gen.awlen_cntr_r[7]_i_3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[0] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[0]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [0]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[1] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[1]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [1]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[2] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[2]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [2]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[3] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[3]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [3]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[4] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[4]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [4]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[5] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[5]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [5]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[6] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[6]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [6]),
        .S(SS));
  FDSE #(
    .INIT(1'b1)) 
    \gaxif_wlast_gen.awlen_cntr_r_reg[7] 
       (.C(s_aclk),
        .CE(axi_wr_fsm_n_9),
        .D(p_0_in[7]),
        .Q(\gaxif_wlast_gen.awlen_cntr_r_reg__0 [7]),
        .S(SS));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module blk_mem_gen_0_blk_mem_gen_generic_cstr
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [127:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [127:0]s_axi_wdata;
  input [15:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [127:0]s_axi_rdata;
  wire [127:0]s_axi_wdata;
  wire [15:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[15:0]),
        .s_axi_wdata(s_axi_wdata[15:0]),
        .s_axi_wstrb(s_axi_wstrb[1:0]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[31:16]),
        .s_axi_wdata(s_axi_wdata[31:16]),
        .s_axi_wstrb(s_axi_wstrb[3:2]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[47:32]),
        .s_axi_wdata(s_axi_wdata[47:32]),
        .s_axi_wstrb(s_axi_wstrb[5:4]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[63:48]),
        .s_axi_wdata(s_axi_wdata[63:48]),
        .s_axi_wstrb(s_axi_wstrb[7:6]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[79:64]),
        .s_axi_wdata(s_axi_wdata[79:64]),
        .s_axi_wstrb(s_axi_wstrb[9:8]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized4 \ramloop[5].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[95:80]),
        .s_axi_wdata(s_axi_wdata[95:80]),
        .s_axi_wstrb(s_axi_wstrb[11:10]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized5 \ramloop[6].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[111:96]),
        .s_axi_wdata(s_axi_wdata[111:96]),
        .s_axi_wstrb(s_axi_wstrb[13:12]),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_gen_prim_width__parameterized6 \ramloop[7].ram.r 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata[127:112]),
        .s_axi_wdata(s_axi_wdata[127:112]),
        .s_axi_wstrb(s_axi_wstrb[15:14]),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized0
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized1
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized2
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized2 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized3
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized3 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized4
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized4 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized5
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized5 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module blk_mem_gen_0_blk_mem_gen_prim_width__parameterized6
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized6 \prim_init.ram 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hA39919A01A6AF89C1DEB4B69629D0F1FD7045EB2C7FB279E888857EC8888047A),
    .INIT_01(256'h7DD2A886A0DE55357DE88F1911A0B70CD4C4F8C80AF926E9AFC93B10CBE08B56),
    .INIT_02(256'h6F6E3CBDC391641C85DC806E815A8FD740E4000608438C312A0172DB5FFEA33F),
    .INIT_03(256'h0BFB4A1C9864C256FD3160318078E7878888564988885793AE2EC17B4B0FC428),
    .INIT_04(256'hED4AB8CB590A8E1ABAA541DD5392DB268818811DD33BE53869C1AD9396C66C2F),
    .INIT_05(256'h943A8051E60A8C5D96239E65CB9FF111CC34FF078080A40F52C380804EDBEEA2),
    .INIT_06(256'hC72CAC2747D554FC46B77F0B848CB2747135D9D4E13965A40E78186CB38DB63E),
    .INIT_07(256'hD503CCF56D3814C089913ABBADB0D44BF33CBEC77FC5BD5D639A0C42D9270928),
    .INIT_08(256'h23F1BB5E513CEB2BF48DAD62FDE201C7F2487F7F37F842AC091A6FDC8080F147),
    .INIT_09(256'hDE0BDF21B6B429C49455EC5CFAC9A45B357886A21BD644EC8C0FFED7584BDF09),
    .INIT_0A(256'h0437583277C37192411315FB7E88EAB9805FABE98BC1468ABF6B3496B5337414),
    .INIT_0B(256'hB2887F7F80800C14619C80808080200B809F52D88F183475D2C814554799A758),
    .INIT_0C(256'h63522FE789EEEC77A2EAFAF9263A20E989B05E9F83C3CE3F0ECFB327B704DD6E),
    .INIT_0D(256'h97F81305D2FE4F0E4D95E1A377AC251DF0EBB6BC6807E6FDA26CB6695AD39C23),
    .INIT_0E(256'hE8E28EE713099A10973D3BF5FF98E2342B98F3EBF2B592ED44AAFE1F3B6CE8FE),
    .INIT_0F(256'h08CA9528A59820F72F960979330A09BC29DD0F5C1F05ACFD9C153BB53180C15E),
    .INIT_10(256'h4A18926F12DFB381BE26AB6BA6043F948EE1262C37A193E4A4AE84A99850BB4A),
    .INIT_11(256'h8286BD8D0BB23EE1AADB1D3345B28B20895DB98611520020492E498B4FD0A514),
    .INIT_12(256'h190217B1106B8EA60331A418948FAA22CCDA2ED613214F47958CA9130C0D17F4),
    .INIT_13(256'hCFBFAE03295A2DFC8C110B9005F3CF1A3FB9AA8D802F13FD3955041803718836),
    .INIT_14(256'hBB1B9A484529A7B82C48481D4EC62D4B1006B23D21CA8C7B24F13987229F06AB),
    .INIT_15(256'h8ECBCFFD1B9D15553BA5B8763BDFA60E2EAF365623B9ADD83E021F57138F3F54),
    .INIT_16(256'h9FBCCB8327702BDD2B8098570D6932A2091DC96188C20B8D0000B37123C936FF),
    .INIT_17(256'h87A53FB98DAACC66BC22B7603E50CECCA59FCE45BAAB89F39F5F2529460992F7),
    .INIT_18(256'hC151A55FA96A87AFCD559215B3A4898E3874B93FF91A1ECEBF560A42445015DF),
    .INIT_19(256'h076297BB975DB8FB128B2AB485B38DE535DA18C7CE39332802834C2BC9D949D4),
    .INIT_1A(256'hCFB015BFB67998C5235C4C5E335C9074C6A8AB722175400B43AB9D6143E8CC27),
    .INIT_1B(256'h8B8AAED9A87BA086AB373448B5E6C21F3D77A611C9C1AF22969144731ACD2F05),
    .INIT_1C(256'hA9EF845610302D69195F4CA542A504DD1C3C2E3EC6183A9B1495C6770F25C43B),
    .INIT_1D(256'h46861C79441300918A6AA83CC3494081C866B6CACE5D0BC19D1247008A58B345),
    .INIT_1E(256'h0B992E3E20CBB952AAA8880A4B43B05144B29D2595EC312445311B4AAAA917F8),
    .INIT_1F(256'h807C28C6C89BC0CC1F1E2D4215A5CCEB9DD8ACE3B131A7408DB58C9C1C938A24),
    .INIT_20(256'h1604AABBAE2D36FF975426A0C1ABCB63CD9CBE93129A1BDD10190E4204FE0EC5),
    .INIT_21(256'h01A7C6FB93158AE51CEE40DA0F1989413923C21986210C5A9E0C054C3551B92C),
    .INIT_22(256'hC4790B8DAD11152D1F4792740D773BB69275324687CC31C509E4C73B8790A2B5),
    .INIT_23(256'hCA64816A498F060E57F69AD7AC110A638D0DE5222EDCDC8A8988B222DCB96AFF),
    .INIT_24(256'hB553C5E5033D91C3043EE3DFCF25E100DA7F7E9A5C8EC4333F573C02C738C6FE),
    .INIT_25(256'hAB83999F20DDBBE54A45A510453E1CC6BFB43B29FE7E78C8D753DB73DB731D4B),
    .INIT_26(256'h3F153F1C3B8D826C71118F8D206A9298BCB3CF8A87723B040C6904A786F947C9),
    .INIT_27(256'h88BDAF4AFF515AD1D28B0779AE8A8F95B938BA9F36C46EC45F6C9AF2BA9FEC06),
    .INIT_28(256'h5C099AF2F3DCE8F1D592261D9DA6ED6C04530000F95D9D1DEE00365983412E76),
    .INIT_29(256'hFECBEAC8408163763F8209AFF175044745D85B0C82E6292A833207D21008A01D),
    .INIT_2A(256'h30DBA1425E34DC011B29BF50F98F88342F9C732C905EB5F984DD0001B63B4ED2),
    .INIT_2B(256'h5E3D0C63EA70A64853364153F09A8459BDF3F0DBE9CDCDBE2D6CD75AFA8B7B98),
    .INIT_2C(256'hAD820164B0EAB70BFF08D82C7B5E5D36214F88F46A3C0B9D57975225386F996D),
    .INIT_2D(256'h6F6E80A85545A0D4F0AB6D902137FE6372DE7293DB83BDA22A520010FE7C653F),
    .INIT_2E(256'h227577A1D2E65F205B5A0E3488C31FF587FB724FDEDF4C5F6D01142C81C3A9A1),
    .INIT_2F(256'hBB8A327F17EE716173A1C2D94EDF1A0EB1EC93C934C0754079E474CF09659876),
    .INIT_30(256'h08CEB57E34AFF6CF02DAFBD56E6BC2E49C1382CA1BB796CF1BB97266E613508D),
    .INIT_31(256'h3683BB3E08CB0FE14AF3B357AE388A346BABB3851BEB3634CC4AB21C6F34D743),
    .INIT_32(256'hBD471013DB17324A67BFE1E30CF1D42C5E60CC13F290025F6AB3DA1C5995ADD2),
    .INIT_33(256'h65716F093B49BD2C7F7F82DE933140278175D9F250FB9A3FE8FA62C658320E08),
    .INIT_34(256'hE2AE53116431EA8515CBC2EB149810AD2683BDC4EBC78FBD010A6CFD3253DCEE),
    .INIT_35(256'h84E94E8C9C64ED3F18DCA7B974D38F55A269635ED9E85884B86AE40F23A1077A),
    .INIT_36(256'h8EC43A59FC639AEBFD37AF96E6024914C0D4B3E045694B1842CEC9C1E4CC413A),
    .INIT_37(256'hF27A7F5C11EBB1558022CD4C01BFC0C0413868EE5D06A2DBA34B7B8F589EBEE2),
    .INIT_38(256'hE3E9E3424FDD44ECC912F7E5CC2FD49E298CB034A96914CED3BC182F4C2C9747),
    .INIT_39(256'hDA0CA1D31196229A2CE3A45EC6BD879711625A359F27470188BB255C9771E5B8),
    .INIT_3A(256'hB2C2162775F215DFE548104AF7F3DED80E66741102AC1939FFB06E122189B6B5),
    .INIT_3B(256'hEEA82A711DA9EB680129DCF5417705598A2FAE1E8F595BB57BC8C128334AFAC9),
    .INIT_3C(256'hB6990F6648F0F207239862AD5D2D78D0A1E2D1CF602388BCBA2BBF83753DA319),
    .INIT_3D(256'hFEFE87D915856CE20ED57291C26E68F56DC8322F797CA24CD12A20347CD55755),
    .INIT_3E(256'h9DFABDD1E99680661A125F28C591228701C40AFF59CE8C4BE90E32007EE13DD6),
    .INIT_3F(256'h60BE6AA5823E08E2A38D4C8EECAE97BCCA3CA4BFE20B8A582C51E540B7C21BD5),
    .INIT_40(256'hEBBD99E19425911DD5A819B2B2DE64715B71935437A31AD546FB5B567A65427A),
    .INIT_41(256'h1B204CEFDF9412FE03BDCC9292857B25EA601E5C5489D44A9B5796E813DE145B),
    .INIT_42(256'h885D7D94680D85368EE99824312BF074C7C1B2BDCA25EA748DE26E91B536CC0E),
    .INIT_43(256'hDF4D111574A40511A3FF638A4B265FBD1C84FAB754F84309AB813DD1E905B780),
    .INIT_44(256'hD40E676DA6B47EB94F6B228ADFF50708C37F70345D61E412EA8B082CFD7FD25E),
    .INIT_45(256'hF3BEDC9148D3BF5A3345F4551E396F0C387338D40203E04DE6763DCC2DC438A3),
    .INIT_46(256'h141E0793D94734ABF349CE5AF0BB953738BF5C0B4681127A3398F0901A906CD5),
    .INIT_47(256'hFF4449D32B38F5AB135DA747CD28B3C3A37592D569EA39BC8B176A615EB3F59F),
    .INIT_48(256'h10220E4989AA9547696C84E66FFCCA66861D793283C4E93145B5FD24548F3689),
    .INIT_49(256'h77A137D073A93E567D1096226A7DDFCA5C9078266F215A237CB0A67922DC2CB5),
    .INIT_4A(256'h42E6AC27DBA45BC7F27D823BA00FA0DFCC72FFB5B4549BB6C15349B9EE8D7BA5),
    .INIT_4B(256'h75F7325DE5AB2B3818FFCBF7103353EC3314084E768EE93788885C1388883995),
    .INIT_4C(256'h37F476F17A6BD71489BBE75CB01F67558D8B867A07BA2E42C6B4DC05B12C4A8A),
    .INIT_4D(256'hD43EF61C0000B28F2FBB77E6FE912912B6F2B24F020320BFF0E8C6E0E7C350CB),
    .INIT_4E(256'hCE61CE44433864CC644C3FD805C14BCB9987DAD0D70E26A0F9A0AEBD364E5CF0),
    .INIT_4F(256'hEE68C105F31C54F6F8214C97229893D2DAB6E59BFE90052C9C93A3B241C194E1),
    .INIT_50(256'hABCFF053A3557F854AD4D79DE5B7E672BBF79B15816EA4A460B4580EE90133AE),
    .INIT_51(256'h022CB68B973A7319B88B3A635A93375816D1B312BD87BC978EB188AB87A78270),
    .INIT_52(256'hF8F77D1412E2CAA99314409093E6B390A5545ED084FA6A6C5450DDF1D3D8E87D),
    .INIT_53(256'hFE0F585DDB6A6E8AABDADFC318C75F210555C9F1A154C719142783516BBE4E53),
    .INIT_54(256'h04C5F8A90AF9D2B0E05E7BE28F840F4D2CE5AF31B314580939985DB8E105DFD2),
    .INIT_55(256'h327429DCD7975861221CD49FD68423E98888D57F888826B7767B08E9D245494C),
    .INIT_56(256'hBCFA91ECA9F41349BFE35A4085DC22B04502BCC713CD0EF67AD49BBD63376566),
    .INIT_57(256'h08293AE41955DA8A302F80591FDF8E73B9866BA74647F807A15403DB95CE940B),
    .INIT_58(256'hE3815C2E46AA799503ECEC07037ED3D87E68089CB058051F191A8550F32A9B37),
    .INIT_59(256'h27490C96782B97FD58A7D51CC3DD0BF5C331B349FED9116F7572A7C90EC43F8F),
    .INIT_5A(256'hAE6817458080507C0C88808026665F4054AE6EE4B376C52846563F2C000032FD),
    .INIT_5B(256'hBFCF8454F61C63F1B68DBABCABB37D7DA189B9ACA949D012506B96B1C83A6DAB),
    .INIT_5C(256'hF678B1F350DAC215A910F9B9942E4329D4848F1B72D829FDC7B13E23B01F7E3A),
    .INIT_5D(256'hF6D4C0700000C091D93FE75A67E9276D047B4307FD41CA3075B88C30933FC7B4),
    .INIT_5E(256'hD249089AB137D5D02D02818481435A58B8B54563EA746EA76C3F1145152B7DC7),
    .INIT_5F(256'h28192FD8E55E76BE292FE00830EE2F7269256F26E3B6E341C72A2F30FAC63C8F),
    .INIT_60(256'h7C3B7F7FD56E760967C3C43C80802DC0493CC692F61DB5C65A5417D64315FC55),
    .INIT_61(256'hD9C634AAAD202901173A59799FF7B98D7C4881874D7713F09A3123FAA983B6A6),
    .INIT_62(256'h1AC3B2B0BF76C903CEE998F71AF7D39D2EDFC53654FF6A2A8720D4092D0E6074),
    .INIT_63(256'hBA5381EEBCB8FFFFF57C1D889205762A02C85E544853114C5113DA0FE4F7E0C2),
    .INIT_64(256'h328910E3E0A85BEE4DA1DD04543378241F766AF13DB895B5B355BEC7DD2755DE),
    .INIT_65(256'h7FCC0CA92D7EE3B84AD0F5BF49D7368BD98ECDD43AD04EFC656A99124A01DFB3),
    .INIT_66(256'h9CCA32EF9E44B18FB16C14A92A5B17534BCF6CEA441FAB901DBB5F3AEACEB163),
    .INIT_67(256'h668009D0D64B2329DFC122FE872132BDEBF07F7F808078C53F06808080803B49),
    .INIT_68(256'h1D5B42FB9FF233AF7626C11543BB2D6E5A3BBDDC545F358C1A9C0432216E9490),
    .INIT_69(256'h2B744647482F3EBE1FBDB1880D798A9C1B2B64F1621B760F5BB32CF939B0BEF5),
    .INIT_6A(256'hB991C77CF7E73BD0FF62B00D679843F686EDA545AD401A03B5AD9E8C31D590D9),
    .INIT_6B(256'hF84251ED805DA5DFEDB4D7DEA99CD6BAEDDF136345144F09B3C490A833AB06BB),
    .INIT_6C(256'hDED6EB0B81FDF0DCC5166B61E5F7FFFFAD63C3812659401AAC5FE69100003A33),
    .INIT_6D(256'h000000000000000000000000000000000F8C87A2C5F8F6F0D4D3B93D503A57F8),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized0
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h7E35B923F384BAC9F5F753019D9C1D3AEBB5033F15A93E108888A24F8888F6B7),
    .INIT_01(256'h808DCEECC98B87370E2ED20AF4F05ED533E194B85A13FE292FFE3BB24FF43D46),
    .INIT_02(256'hCE46F9FC9511D6BB6437DED788E7CD37FB82DFCF2CE162255F84636FF10DC7ED),
    .INIT_03(256'h72E47EC2B0E6CB15B68B676BC78D20C9888825C48888B0E2D82C212FA3B5F76E),
    .INIT_04(256'hF48A25247E50EA9DF5D0CFDE1094B8B8225DA7E68AA8A86BFC77A2BC849857A0),
    .INIT_05(256'hF34F20EAE9B1E86E301E62243AFA954E371AA6EF8080A8DC959E80803EA21EBD),
    .INIT_06(256'hF50941A2FC32294F12E4DA5ACC9108575791412C36EDEED7A6D6F060BD728345),
    .INIT_07(256'h02031CDC0E37C04FB7CB1D46546D7C6559ED37A4DCF218E06172084F668AA2C6),
    .INIT_08(256'hFC016AE69ED75C75F4CA5A174D53D8C66F707F7F7628FB517C53D385808055CA),
    .INIT_09(256'h67C9FFD4A6670D454DD7EBCDDDD720065F01995B137B665D83719A77C82DDC01),
    .INIT_0A(256'h533231FCC51B8F7F12BC994074227F2F80038049805C807780B2809480F5805C),
    .INIT_0B(256'h03857F7F80808DC2FB8F8080808063B50975B97AADEE5711F48F34A1787273E9),
    .INIT_0C(256'hB119F262E6413DA7FB387D6CE3242B936EC22D46DCF523B5185E8233DD72C037),
    .INIT_0D(256'h178DF892347AA523BFC1365891B67E61EAA946DB788F3044C505521486E23134),
    .INIT_0E(256'hDDA35311C81966D8F794944AC0B2D4BA2A51D8F62046A9595437895CAAAD66AB),
    .INIT_0F(256'h401C0792271F28079A4B000098C8A1034564AC064CF5B6A44D770764945AC56E),
    .INIT_10(256'hCD1D1B32C3B23AE80B5CC25F8F61945CC69524C09B99AC9DC222962706232248),
    .INIT_11(256'h01B94C2B9058379C4E55C3D6088DBA1D263BA98AB58B2B9C264041C12607C518),
    .INIT_12(256'hBA5F09883F1F83AB9672218D4F91B9EFB785A545208C4E0689BFBBB0B2D18F33),
    .INIT_13(256'hC040883C4EFCA71BBEA34842CEEAA15B2DBD1DA2A46B1BDA41DC003E8F73A763),
    .INIT_14(256'hA6AB08678E4E4D9211E698D7948702BC0D68AFB4B699CD3CA58F28AABA0C0EC3),
    .INIT_15(256'h8B76A926C297C47C83370A59233198E21CC545119C88C01B4F4703BA40B4C156),
    .INIT_16(256'hC4B6174E1E0839F12A9E109A464E38CD3A090121C8AC94070000236345DECD23),
    .INIT_17(256'h4080B93F1CD8943F11750DFD209C8BF9412910972EDF39F33885487686B599A3),
    .INIT_18(256'hA088CC532F5687BF2AC21D1A187103CB621537A789B0AF941C9D0CC3AA45B900),
    .INIT_19(256'h11AF873B2E7FC728105241573686B78BBE2E0188991FC968A1B2AE2A2EC026E7),
    .INIT_1A(256'h9B1E3BA1817AC5A400002AB29A1DA52A2D541F5E2132C839882986FFBF8F0840),
    .INIT_1B(256'h4AA6AFD685CE86232BA4BF64110927EF3E6244BB1BA20BFDB21D1832281192CF),
    .INIT_1C(256'h01DE3F072F5120FFA140A7EB4D95038B4E6717A92DC3890A32833509CF23309C),
    .INIT_1D(256'h007B8000B7E800003D54CD7BB3E5C94638C3918F30B78E4EC6C09DFD8882CB12),
    .INIT_1E(256'h377F267AB13A46614A8D36164064B3C3CCBCC1BEB9AFA3751369ADFD01C207E6),
    .INIT_1F(256'h9D8AA0382B0D973BB32A46C1CE9C42178214A76F3A1A06994185448225C31978),
    .INIT_20(256'h9AC13A514B1B096085619B41AB273EE44C3387A7212A85131520A0678C9E1880),
    .INIT_21(256'hBE164AB102C9910740173F49AB078FCCB7512478C98D8B7C4D2791B208D382A6),
    .INIT_22(256'h94D3B34C800014301FA199B338FE9A52285D11EF310CBA09CEBD187E4007C0DF),
    .INIT_23(256'h4C848A3940A983923CD78C5BAE8AA45B8CA78677ACA8377B0C79C406B2F7B03F),
    .INIT_24(256'h029EB8CC1762C94AD5C0B59B5DC63F905E344F6ADEBB3FAD352C2737959F0F43),
    .INIT_25(256'h3130B2B3496EDDD0844B123781420CDB0816BCAE54FC2FA80042000580250004),
    .INIT_26(256'hBB0F2F3BA9494D84BA133C43B0F6091A1E210008976ADC91D219BD2FCCAB1393),
    .INIT_27(256'h940F40E09F59CCC5A7CA000BD2943FC127FC3084C8CDD27D97761B071AA4541C),
    .INIT_28(256'h20EF41678FFFAF7CC61F2B02BBAB1BDFD3D8000002C8142586260D81D5B61EA0),
    .INIT_29(256'h2EA9BF9CD6CCDC30D96300003E1D9276C78132049FD0B587D0051BC6B69AB7F8),
    .INIT_2A(256'h9AD10059064DDDE9D8C4000D2187D5E98421000A1CC0295AB1E180000343104F),
    .INIT_2B(256'h49C95A04C6212D371673B08FDE4F50138D4B30A0C515C508A4AF3155546801F0),
    .INIT_2C(256'h2F34A3EE37CB3B125D8F39A4B6FD2C912FB0AF593029C341A3B1180785D2593B),
    .INIT_2D(256'h34608901186CDA9F3DB1A1BA3320A30F2EA6B5EC2E4DCC31D4298000236D4976),
    .INIT_2E(256'h4F16580DBB1BC2D1C408D8DFB2AF52760707C629DD360C640FACDD05CF0E0E3F),
    .INIT_2F(256'h9789DD530117BDD348D409AFCEA1463237724757DAFBCB6624E92D988CAEB7A4),
    .INIT_30(256'hBE3586AC8DA61DDF18E71FF25579577FD63DC0479C5607A7A9EE252FD0EC1EA0),
    .INIT_31(256'h1D4CA73950C6D12788E2DD751D77D3649837AF61B9885D5941C6317B8C4BDB4A),
    .INIT_32(256'h02AB84195070B5E0A251342A8A67417FD7B74F124EC540E71AD25C2D38F2D639),
    .INIT_33(256'h8E498BE9B12ACE3613B12504464E0D47894BC7D9A8D80C68B62F5A6019E5832A),
    .INIT_34(256'hD634BAC12CEB5B69C5541C4CBCDD52715098A22453FD0606817DCDC2AFDC15D3),
    .INIT_35(256'hC5F4010FBC36359714C2447F2D98585BAB5B104A57F337999199B0653A75833C),
    .INIT_36(256'h2BAF2AD1C3805600BE349D642E4B01E49AA0C33DD55C568FAE45218E847E22AF),
    .INIT_37(256'h9252CC990F7E42A1812B0F570841B32B07D1C3B0C7C02B3912BEBC5C36A6D810),
    .INIT_38(256'hDAFA8E21D7D84916D602ADC452D3492FC39C5594C84A30FC019B5130A4078B17),
    .INIT_39(256'h1ED29B8E95781B02D5F808B190FFA48DB6A683E405163A3D9BA6C342950F5AB6),
    .INIT_3A(256'h0C058AEC90CB8E201C84227ED3B936D0549923E9C5F481769A2C5CA798282463),
    .INIT_3B(256'h84DAB850C4A3CFA3BC0D3E52CF97A3934883C65F11EDC47EB29317A1432CBD67),
    .INIT_3C(256'h33B511CCBB09815739D3A6BBB918411D11DB82DC020CCF98151101D69AD08D13),
    .INIT_3D(256'h1796D4902B7B9689C5EE847A8BED947A3C3E4FFACDF63E56DE414238C1B9B7F3),
    .INIT_3E(256'h1CCE241DB657CA654DAD0FED020756CB429F39AB02C1CB122FFE3916CDBE58AA),
    .INIT_3F(256'h5BBCC7B1102A15FC18AE8C010935599528C654115EEE43D5B3863A388C94DD1E),
    .INIT_40(256'h4A32C2ABA889076A8146BB3C32C0535D10CA0B46A3A4492C3C4A2D742C3C3E69),
    .INIT_41(256'h56AE5EB5D5958C7E446807CF826597DBC1A5AF29B0FE45D13702A039552999D3),
    .INIT_42(256'h1F16804539F9D8D321CE23D8A06321912719BF08BFBBC8F98DF4CDBF97835920),
    .INIT_43(256'hA81CB602D7C45E4886D685D356AD94619DC1029BB50F1DEE1BA1A0DF93BE830A),
    .INIT_44(256'h1B1F9F2EC0A326224E0E071CA68AB349505F4CD1AF7D348530A62023DA3F22D0),
    .INIT_45(256'hB1ADCE579025CD1B12B6378B4AD72C2DA3C60B354E562B673FB8D721AFEF96E7),
    .INIT_46(256'hC7A302E43DA52B531250A59386A54D0EDA8125115DFAB10946F0BB48550F279F),
    .INIT_47(256'hCA63C175B845D9A4B490B45D163F05E316FE28F0CEE3BD59AB2C527415FC126E),
    .INIT_48(256'h30F214C639563B90A31003093C0933A83E304F1FA66258E8C6F94B535CAB7F7F),
    .INIT_49(256'hD87FA81D2433A13521A3DDD0AF2E0AFDDD9CCDB054894427B8BB115102CA3EB9),
    .INIT_4A(256'h5940B08781A2A48EAF83C5940C79B53AB345A12FB45BC7F7B27E9175C937AE8A),
    .INIT_4B(256'h6C0062BCF733104E7B258A9907732CA22ADA02E1F6E7A4D58888805488885203),
    .INIT_4C(256'h0EB56B2E4729CC1720AFDE89862BD73A0C3D3FF55982736741BA511F77073B2E),
    .INIT_4D(256'h682FA1B5800011886E0BFC6B4206453A2197352B073DB5CFB07E6FE5ED730A9D),
    .INIT_4E(256'h9999D52BC1ECAF5E3C25CA3BEA22449A47040328B6EA2631B647D5DD0DC0992D),
    .INIT_4F(256'h1C9A55858358212969FEB2B4624C50639870E12F4A0906B67A0C236AD7ED6F97),
    .INIT_50(256'h6574C89B56DE0575BBF1ECC051BAFD752B895C43D880A034B8D2E9C8F86A1735),
    .INIT_51(256'hA4D75BD1AA0F1D4522CC284208EE356DF26BFD9126741694B1472FD7D7971B47),
    .INIT_52(256'hD66DD0F9049B4051978537E274E3F9F8F95311E882468DF8365804E5171DABC2),
    .INIT_53(256'h501A41FE70FF1AEB9F5BC6E209EAC113DD107A197891F3AF8BFE154CF835069F),
    .INIT_54(256'h2A33E6BA2A12BD537DD6061E93DA2C8A610912D9CB60D7E3F4FDD7F3E51D8895),
    .INIT_55(256'hE456B8AE84093A3BD6F30195FA9F793F88883F608888B9C8BEDE86516CAAC926),
    .INIT_56(256'h1D35ABB3BD288679E119A1E22FBD0B0D982DDF2E86FBCFA97322F8460C8F2A0D),
    .INIT_57(256'hDDD75C977093901115FFF4791C200464D085A706F70860AB08202B9E69785344),
    .INIT_58(256'h734E9855C1762EAF729135DD28120F94CF18174777D782C69BEA576841851814),
    .INIT_59(256'h31488F142BB5CA78105B8ACCCD0C506D4061567C888BAC9FCE474FA3029F8DEB),
    .INIT_5A(256'h83D26E8E8080A502CA408080E20BE6A89133E160EAC73F28AEA87349800024D1),
    .INIT_5B(256'h11300E4332F3C73E1A0A90B48DF1F29309A8A02444B06472BE5B3BBF4B435672),
    .INIT_5C(256'h8D2547D80D0CB326EF404D767E7A92B33E8E06519F26CAEE712AD085D100A044),
    .INIT_5D(256'hF7F56F418000032A84B2A1113E7598A868E7AEB5D4E4589428FF1A6890FD088A),
    .INIT_5E(256'h71B712ABC8EF1B01820E5BA7ABFC775B9F7BC47CE9E351790F7E54705842C3F5),
    .INIT_5F(256'h44C43E895E874E011223831216B0C820BF74A7699691D6CE9D1DF2280C605A20),
    .INIT_60(256'h338E7F7F69A14C69324A39ED80804B1CE33ED0EBE0019D7B4106E063331A7486),
    .INIT_61(256'h1BC9AFE34301EE4596E122C32B42C32DB1B7DE2CD151D9BB92B1133CEF5A9EB3),
    .INIT_62(256'h80EB803E80718044802C80A88023803813223BA212DD1EA7632C60CFEA460E9A),
    .INIT_63(256'h23A745536E527FFFE34DB11635B9862553284BE3B3AF2E1FF4C2BA338E06D78B),
    .INIT_64(256'h9C5BB0AA0F780B2C6A1C8C5BCD369412489E3E56FBBFAC1557FD13FB9A864BB6),
    .INIT_65(256'hE457C71F4CF512CE267B3D6E8C523F7D8F517854F5F3CEED063A5B38A102C06E),
    .INIT_66(256'h6EF00E01E64D6C19F8AE8607837A1CF0E28D41571FB799C8BEDE7BD640EA3B8E),
    .INIT_67(256'hC8F3BDEA4B05A44FCC866ACABED0DEE831837F7F80809C6500948080808061FA),
    .INIT_68(256'hC9330422C351CDD72D9F972E69F91AD9314C1EC0516DDED290058EF138AD82C7),
    .INIT_69(256'hA30DEF3F24E632F41F8B7CB8AB57E2086BD53382B56AF862E8E32E169DC6C36D),
    .INIT_6A(256'h7A67B14FC5E9115D5B4019D7218A470BEEE43DE703C0EE5B3B45DB444EC4CA1E),
    .INIT_6B(256'hB9DC99741246F28EC8F9DD5847C4AF8B6F73B5AE7D9E6A97BB6EB8DC08498753),
    .INIT_6C(256'hE6DD4FE3F5620E67E3EB7DCF1D427FFF7BDB6EC32C66820A4539772B8000372E),
    .INIT_6D(256'h0000000000000000000000000000000080F1B75A3906FE9C4EBC8BDFC5399120),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized1
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h558FF580E48F8083B9817C83AF8EED806E16D0C659A895958888242588889C80),
    .INIT_01(256'h70A3CECD40F4218988276FC937F1B31D9172BD0AA7133D878B88EDFC973AA4F8),
    .INIT_02(256'hF60CD9CF71AC2764825F81E58A948012D5F7030809BF6E3E12843D366F787D06),
    .INIT_03(256'h5DF72FE8F8BEDFBF2CFAB443F2D6677388889C758888A74A316E791097CEA295),
    .INIT_04(256'h8DD7B219E6F291A6661F06523E901181A4A8A2A02B730FB476D1FDB857CB8321),
    .INIT_05(256'h5CD03A2B7EC7EB8F80FDC1E34CFD1F1F27AB14D880806D13CC64808028CC110E),
    .INIT_06(256'h3D7CEE51765E63E45EC151C0ABD613BE33DB230415FDB00FA8A03C7D124668F3),
    .INIT_07(256'hB746E70AD1B97BAF7A18F84E2B407ED53C4E18FD41E3D6B3909918F0242F8AFB),
    .INIT_08(256'h8D4F813FB557955C0FF63A6D12E29DF6A9D17F7FF0F0C9C6224F13858080D609),
    .INIT_09(256'h7DBDFC22A703E813B0205496D51BDD67340435D2C72225681A76AA466A04330F),
    .INIT_0A(256'h0F44FB9A8019685CB16D36750A5BFE61C37FB37FD77FA07F4D7F2B7F637F267F),
    .INIT_0B(256'h0ABA7F7F808036991E96808080807FEE19230CCA12C2848187A36028333D2B84),
    .INIT_0C(256'hD7AB1EB9797BCB3BC0D15377A4969FF760D454A339D5A5A832598BC143710E0E),
    .INIT_0D(256'h9863FA3447640876B5303923ACACDC18103BA501479A3A9DB7AE06C341DCA704),
    .INIT_0E(256'h66E037F79F8B154A930A4B3871E562BB783F453A9D76FA830B127308577A1E84),
    .INIT_0F(256'h3BCEC8674D160471800159042013CB8E80341F5A8F933BC3B07D9771A5854660),
    .INIT_10(256'hB5F435ECB96A2D4E8E3798869E8F165A001A8F3EAFDC8C65288FBFF3322841C2),
    .INIT_11(256'hCE8826D74DDB425D0D393BAB119BCB8087891570C2702F8E4D041A0C90282080),
    .INIT_12(256'h225DC6C2C69C92DB0DA227064AFBC58FA94743F8126412921540133B071213B7),
    .INIT_13(256'hAED38FA41EDB86101D5A18A4213391A7BD8231B14E33C0462A13887B0F1E8736),
    .INIT_14(256'hA79F8D46B8E93BB38A81A4BD2D03816D48C990BF80E8BC9D4BF0858EAA608A06),
    .INIT_15(256'hA2CA4D5D9C0D89E922959842C63737C38E12C26B3E6DB3BDBD034D074F47AD26),
    .INIT_16(256'hA27F157AB4E681FE181C115300D948363AAF28D79ACC034132B7B9BE04E829A9),
    .INIT_17(256'hC44817778C6B08CB2D4C1C113B29914109864C79BEB0C408A68FC8A000273BCC),
    .INIT_18(256'h0A131DC8C0EDC680A37C858349D81629E3EC0A231A8995039EDD9B518EAD46AB),
    .INIT_19(256'hA99FB3551A251EB2A8AB0E8207988D7BCA6E07C93787921324F8C9B9A8290C3D),
    .INIT_1A(256'h2742B6023C72384D89414466208605152FAFA7BC406D42F09AB80CFB344703AD),
    .INIT_1B(256'h105F9AD819FB17FB955A291F81454750B184C928BF88A60F278F969B324524CC),
    .INIT_1C(256'h4F8B3E9B1592B5490E3719760420230B3D14ABB3CAC9C535471636EB0858877B),
    .INIT_1D(256'hFC008E4CAC1AA81E9EB838F93D1BA9B51EBE135AA84A39A615C2C89510B93855),
    .INIT_1E(256'h993F4222C2C594AB3BC2B6EB2D773C174CF62FDA40794B8D83C3325602768A47),
    .INIT_1F(256'h4F0ACB62BF23169D44F09EC11E82C8E8BDD337CE85BA8DEE10D02BDDC832232A),
    .INIT_20(256'h02CCA0E48BEB29160D1F1BA01A3647DC168D37E4C942957AAE3C90B208558212),
    .INIT_21(256'hA8323074079A885B315F9404A0542B51832C860F01BB33348CDA83373BBCA003),
    .INIT_22(256'hCBCD1F35014C043C403FC9870D7F8FB8A55C42459C6AAF067C0093984B280CBB),
    .INIT_23(256'hF92FA6AF207F0789D94C08632DC502FC1C40E1C0DAB252CEB9E27FEF2FD4210C),
    .INIT_24(256'h2B269B76A686917B51ECE98B73D5CC94D221ED2D5D22A4C4AAEDB410D9BC9510),
    .INIT_25(256'hE991FB945F4E60C60C6B151CAB0FB5D5116F5824BC79D84F9F3813B9907747FE),
    .INIT_26(256'h0B3CCA04259E179C5CC34795A93266693B84607DFF09DC0F2C4C32E89F8F4CA8),
    .INIT_27(256'h7C7C06F44C3C9999289B16AE7F86D79BBE98E490BF08BBD1EB3C8E1AAC1F57A5),
    .INIT_28(256'h5DD34C4ABCE6D9816F9D8AB9A71CD72C386204972B5877B02F6C191E044C50B7),
    .INIT_29(256'hDFADB0C3E3D92CFE8C877851606E5063B97DCD7909304FE2C260F1C03D137EC4),
    .INIT_2A(256'h5FD21615E77FFFBD42C886EDA37FBF969193C55F6E5308A8DA5BFE813796FEB9),
    .INIT_2B(256'h76012B9E3026EFEB0A847762FC25C2CC977ADB5B597BDEF69B2A931409E692E6),
    .INIT_2C(256'hF200F2282DA6890B86D765D785BC938688C84EA7CE597851EC47ED647692DE2C),
    .INIT_2D(256'h63F56B62113152DEBE6FC967DCA17CCBF90BFB4E335B6FCA2351A9F43163F60A),
    .INIT_2E(256'h8F39A9E2A7F3C71F4471A0E7AAF95DC3FF6C8F0B40F8DBB26F63E78DACF11974),
    .INIT_2F(256'h7728F4367F1137F1160FE3B3CB14F9EE2A9342BD2808140289284C056869D1F1),
    .INIT_30(256'h0B1D74BC6FB6B65B147C71D1E9DDCA921CC15AF16B864F1916800AA9712747FE),
    .INIT_31(256'hC5A05BE9FC875E879A6646F12DF75195181D6D3AA882A3F865414DF225ED87E4),
    .INIT_32(256'h54958CFAB09A0AA1E7293759C2A99FFDBCDAD3926CA4306747CA01F178144EBB),
    .INIT_33(256'h0000FAB85B546594528A458BF5F070D4D4810958BC2F65871434E05B606FF4E5),
    .INIT_34(256'hD8283473A1F5C7401C269D7A7BD99F59BE89C2007D1F1399FE1A0C0575792B0A),
    .INIT_35(256'hE0E43353A171AE3A6F6D5991BF05DE24791A58A04247AB586978CD4B6D63976C),
    .INIT_36(256'h3A23566E434E0E1800894BFAAD9015BF9CDEAAA4F0AA7D72F9C138C01E1824FB),
    .INIT_37(256'h241F59B2711EA04667336AAB81975FC34E28F0140D46A0D8204B3953D05716FC),
    .INIT_38(256'hE9378EFB736ED8817CDB07D21582FE90DB878B0C595E682373E1AECF5AC08017),
    .INIT_39(256'hCB77385FF6144DF7270D462DCE24E7CCBA4BC0BBB296DFB70E50F7C69107C9EC),
    .INIT_3A(256'hAA2C89CE5FC19DE04FF6E3FB91F8716A2C212003F6B0BAC370D16605222F2B60),
    .INIT_3B(256'hD7E148E1608AB7A7EBF68790EE9436A1A884861CCB6D02B0AE026C6E5073962A),
    .INIT_3C(256'h6A230CD0F6430AFD64C530BE466F1930F11C62D7E6C622BB44C529E0E0181B5E),
    .INIT_3D(256'hD57EEA6B019BFC558B976730828F98AF9AD49C1E08C2D322FCDE85859F50C864),
    .INIT_3E(256'h7F4F79A7BD231282AD9578DF0000FFA36A888E2B35F57C64ADA8671777F93199),
    .INIT_3F(256'hACFDC383A0F52B473ACA03A90C8F9A2B531E62475DE12C81E76ABF79C8ED45A9),
    .INIT_40(256'h8259ADC04677EBF0946A607A542B92869CB135A593E61F1DD5612E520A41736E),
    .INIT_41(256'h48759C6A9C2BB9B35E2944A28931C5BC408DEE20DEE99071AE2DC353886BB743),
    .INIT_42(256'h3CE6F4924DCE3BC9ADFE21C0825340F9745C867DD9CB260FE6DFB4740000790C),
    .INIT_43(256'hED6AEDB446A52FDDD3660E8F3DB55106EA35061DF16C0F4430515409C3AADB14),
    .INIT_44(256'h7A11CAC4F3ABAB0AA20AEB086F413675AC74F89288F93AED8D35C9326107CFCD),
    .INIT_45(256'hF0489DA9E737BB640536A2DE4BDCA2ADFE3C2BB1369C3652AA0A18A1977FC760),
    .INIT_46(256'h608D9EDBC7688783961FF3962ED6193B5C33B82F664DD57E58B6A576A83EA9D6),
    .INIT_47(256'h9D58CE93B78E99FB0331ECE3131A1BA5900647449C916A593FF236B901491A8A),
    .INIT_48(256'h961F629FEBA17A0DBEA5940463CAC37BD287064787893D13B14C000019B90000),
    .INIT_49(256'h6896E5122B93E5952911BA3E74FBC2F97E39160A3030A17B3941030DDF88BB6D),
    .INIT_4A(256'hD02F05E5163CA863B2C7B82FF832FCA34FE4B53D900F34CE47E799445B860A3D),
    .INIT_4B(256'hBF8AA1823882FC8AF582208DD38AD785653274C79EE5A6188888AFF78888B791),
    .INIT_4C(256'h4F2816DCBF169A7673C97D22725E66958AFF53D36D887C3DFD85BDA3D201F086),
    .INIT_4D(256'h2BD182337340AA195943494E0D8C49F29B6CE072E123835C02FA35A3F229A0E8),
    .INIT_4E(256'hDBEE1B5C4B2AD687A1E726338660F2D10B1F53FBDC9BDECEFF060A832F93952D),
    .INIT_4F(256'hA62B542DD3B68E971568E4585BEC0F2B440A21E816BCB13E98D0B9DEE1FCF5DC),
    .INIT_50(256'h8E5C82839846DBA4FE7FA4E62437485092E27B502586E6019E073FC841633BA4),
    .INIT_51(256'h3314039C3A8A6CB7B47A15D5C912E8D56560F3352D8FFFFE8E4E887985EC8D23),
    .INIT_52(256'h90D966388CB897FC6F7BF249CCDE7A4C7EEF40E7C22282F62DEFAC2ED96E76F6),
    .INIT_53(256'hD184270AE105C23983F5AA5D1E46E0B4CD68D46BFB02ED408F81DA491630FDEF),
    .INIT_54(256'hD594BB3F123748C65830F7F70916894BCF4F332888CC65810C11DB6F3BFD2B33),
    .INIT_55(256'hB1A259C9C97B77E99C95AC90519F1BAE88884DFC8888B1D4587241D6C9C559CC),
    .INIT_56(256'hC232016BC3C931BD0A1EAFFD45F3FFFEC5C6DD4565D9D0486F987BC9FCECDD21),
    .INIT_57(256'h1C193360E6DD103A8DA0825C2BB20734DB93142DB2509320A2E6146C8D534FA6),
    .INIT_58(256'h2350B720FB532EA1B7EFAD198FB58270C4E035CB422192D5A3162410BDD800F5),
    .INIT_59(256'h1CC997470FA00BEB865CBAC28570435FD70AF56B7D871B883744068458E1DA8B),
    .INIT_5A(256'h4B28095D808046C2416D80805BE0B6D20128F39F9EA18410E3F195B955F773AA),
    .INIT_5B(256'hB89FACD544AE38734EEFCBC4A6841B2B43BFFCF84B000D1E4D95FA0C5B7F608B),
    .INIT_5C(256'hB894C37DCD3684CE61D6CAFFF3C5191901816E636825D15B7232A908C10951E8),
    .INIT_5D(256'h9AF5A3A32E3D88F07959648DC0E30A5FC889424DB7CF663691CFAF673CDCEA4B),
    .INIT_5E(256'h2C0177B262EE34701B006100EDF47E52FB28D2388EEA2823319C04169D7121B2),
    .INIT_5F(256'hFF444470FF4358ED9D9FCB0706C032D475A8B69F9D06946D7DD1FDFA13C3C4E9),
    .INIT_60(256'hB9247F7FBB12628D0CB112318080E3E07B0992BACC990C8864FB26B153A52FE1),
    .INIT_61(256'hFA10CA12B8CF75301F5F07A41820FFB68202DE4348A845E4DAFAF7656543EEF1),
    .INIT_62(256'h1C7FA57F947F157F737F467FCD7FE27FD3FAD749715DDC00B542AA97AF055CCA),
    .INIT_63(256'h2169F18BD47AA0C388580A9E64CF3F67BD8AD41BA84C3DBAFCF4FC24F54CF328),
    .INIT_64(256'h2B281C68B039110679435771B1AB42CAF51BB47DB62D9E929BDDA98846ED3005),
    .INIT_65(256'h3394EB855826516EE3A7B303D689825EB9D7AB5E48EDC3D84A08E737AFBE6753),
    .INIT_66(256'h59192F9DB35EEB6E9E52990F42E126EA940C09C8C4F9F42668C0D90596AD5328),
    .INIT_67(256'h3C7EAE5CD07D4B04E4531A00CCA721B011087F7F80803DA638E780808080C592),
    .INIT_68(256'h176A0CF1E00D677F4D588A339E90C7CE4D67C85F78836AF7B450245FAECAF152),
    .INIT_69(256'hB9DC1CB8FAF5106068DF6FCD204C590F9C28EDA55786784DA588E2022B624F82),
    .INIT_6A(256'h243CBA8F9A49F099366EE77A4491E0E40C7D7432A70833F59AFDF2B6B5964112),
    .INIT_6B(256'h5F23218A6A8DB37AD898D30E8C4FEF915F084E79CD6E28C6F24C418EF0546721),
    .INIT_6C(256'h5748CDF07EF8532B8840395F3D86625954A87DB9AF71A3D541238A6D14BF556B),
    .INIT_6D(256'h0000000000000000000000000000000025D231AC2822741C6CC9772E858223DB),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized2
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h711976AB703E7B3375A870837D527F014D336D6DBFE104CB88881D8A888895AD),
    .INIT_01(256'h14CB6151265888138BB55726956066FA41DB65CFBC45C69EB045A2A88E7F3D3A),
    .INIT_02(256'h63AACA0147CBD986DED7E1B736C750879384B932CB710453D5C8ED55D87A5626),
    .INIT_03(256'h200B7E8526FB169E66824D7469358A3E8888684088881071C0E77B92F852FC59),
    .INIT_04(256'hED590A2B434348C2328C961AD2AA498BD2F51365ED502BC360056DC59FDB4CA0),
    .INIT_05(256'h9C3067A93234BBA9422791233FD9464D561665A78080AD71BFA18080B088D420),
    .INIT_06(256'h760F469082226D7D24221A70E2C0A94B803B58EA414462BFCA3D580347E258C1),
    .INIT_07(256'hDD0C0FD9FD854C8F81EBB13FB23F8F060103AEEF6EB1CE5CB610A130CE1A98FD),
    .INIT_08(256'h8C166797F5849E2C840CB6D21EB7567F55967F7FF0A1BB879998F43980800A70),
    .INIT_09(256'h7CFF9672466EAE8F095ABD0BC59DAC74E25C34FCA70EE458B7473BE0559C3FAC),
    .INIT_0A(256'h298F15F276DC336BE22B15CCFBF8905B01CEC0B859F7659C89CBF3DE8BBB18FE),
    .INIT_0B(256'hBFB27F7F808092A32D26808080802DDC60FA1D0B32FC709311CE1035CB0E65B8),
    .INIT_0C(256'h6799A91EB783DB8A9DBDD304863B3E227A849BC1995DA4A0EC4D8C86CC647707),
    .INIT_0D(256'h2D89C0EE194CCB0990B616C4E4C423EBE758366D000F791F0BA81996B7D91F47),
    .INIT_0E(256'h634EFFFF66B63EAAFA5AA9C0135E20D2BCE786B69208869D2AB74891B19B5B89),
    .INIT_0F(256'h311919364BD840D49BCB9F0087D90D6EC438AD088D7FC1B2C3819EC9CA4C18D0),
    .INIT_10(256'h827B189A06CB16958BA03E691856CBF91035367C207345F3CDA790BB9FE5B9A9),
    .INIT_11(256'h05FDBC8A166C8289A8B0BF82BA1B8EAECDE440142C6A19C0B44CC6578AE5C870),
    .INIT_12(256'h0C02A6AE90DEA6AE43428579BAEB4AEE373F1A3DB7903D2BB9B8BB47CE97153D),
    .INIT_13(256'h1EC2C4D6BA7EC2B0038099D813518BD34DFF03C7A4F507560A081D40C89C439F),
    .INIT_14(256'hB61B962006B2A55502EB45E13A600A2C2E11CE4F1081080B4AC7356C9E1C3629),
    .INIT_15(256'h37FE8D06981B9261A0A2C0B19D8685E54ADA1DB914F887609A142F0A114A49BA),
    .INIT_16(256'h418CAA7F8D2F0B5381A3A73C81CB4E10883B44D1AC50065921341733A6660881),
    .INIT_17(256'h37FEB5640DE4855CBCDE3A8D94172721250640938A06AB8BAFA309658D5A03DC),
    .INIT_18(256'h2696838AA40911262EC6A4DB0AB804BDBC998A185D472A53BDAAB4A1C09449EA),
    .INIT_19(256'h85C23C99051C3D684230453A30D3ADAA02509EE9B38CB2798CF84F24AB554C20),
    .INIT_1A(256'h0DC1B6D109CCC0C2959D8DBACD46492E3F1A2C48B7159D6D8BA61AA11A53447D),
    .INIT_1B(256'h1E2E36330875AD8A1608ACDB8C940B37B37506729823BA19CEAA1BD10634CA6C),
    .INIT_1C(256'h054984553D92C756BC9DA9E78BC69298B1153835B27396DF0DF841301A5DC3BA),
    .INIT_1D(256'hC2CA9FF334C5C775B442AF528CE64837C844488B0B3B2E898B6ABB9080798546),
    .INIT_1E(256'h0DFF92DD0FD9C2FC8637939A4F752D52B9CDC74EA90B27190FCBCAD4A4DD9DD4),
    .INIT_1F(256'h1566076B2A5ECCA81C2D014E0B2D8F76CF58473412000F80079714D60FE1307F),
    .INIT_20(256'hC7CF27B51BB6CF42C363055AB0521742AC90C13CCDFF1F3CBD602BC72BD22292),
    .INIT_21(256'h1658A5442EA196EE3240392B9644BEAA45DB94E0427E2EA90DA50E2116B8CA4E),
    .INIT_22(256'h96EF1C6F0862A1B2C2B79C882242950F08B791964152B009B27E45790C763984),
    .INIT_23(256'hBB8F5CA4A370DA35155A5BD2D8692F6FDAF1472FB7BC44C0A6932BD61CC6CD68),
    .INIT_24(256'hBEFACF10DDDD08339A45C1AC3954928B0BDE3FD05493D85AD0D8D4F83C93C8EE),
    .INIT_25(256'h84A08C7D24EB901F59D481E8A89F4EE14B828695D780ACC33FE2424412C93F86),
    .INIT_26(256'h110F3CB013D41D47B4F0B739573F184D81C83C2C96D11A57022AB10E573CB71B),
    .INIT_27(256'hD3B72107D87A9F3B94D137C4C8DFA5165B7C59702E36573F8E1A14C75EC81C33),
    .INIT_28(256'hA1899EF2B193B9629782CED43BCB18BFC7433DEFD43C3EA2520DDC9D2DD8C689),
    .INIT_29(256'h893BA71C537DAD8156001F45A578868C057B3917152723C381D3A5C45B7BD266),
    .INIT_2A(256'h264F906F3985B9512D6B4854CFBA1871BBEE2496B46D30798E0C4195A09A9F5C),
    .INIT_2B(256'h805C82DFBA6A3BC34B704269085439CAC34837FF352FC6A15B21AEE239323465),
    .INIT_2C(256'hB667D1E80D0D18A4C4DB132549B5AEDB4BD9D44D15C74A9ADB5630A11F80D4C5),
    .INIT_2D(256'h9E919890A843D4254D919FC3D2BC017DB5E1944991D958A43E6C13241A28BBB9),
    .INIT_2E(256'hD24E89AF1F0E91C99A610D2E23E88F6E85975AE0B31B28825986BE292C7BD2AC),
    .INIT_2F(256'h542C4D9304583F82069A9B451E7814323EFCD6A30C4F4799C7632FD752F641A9),
    .INIT_30(256'h16A3D6C33492C1D120C0CB408F5153ECCF0D3941266481E368D2AAB6A2A942D6),
    .INIT_31(256'hC2C4C1B52CE18CE89473D82D21625B2A11BF59A782122B5E886F10A00F1F23B5),
    .INIT_32(256'hA49A5961269BAADA99C3242EB30389B0AF4882411E23C24EC16100074495A12F),
    .INIT_33(256'hBF80A4A206E1A48ACF582572AD4349064DB8DED15323CAF00924508B3E6A8CAE),
    .INIT_34(256'hD5F08A5F8BCB54E5323A9C48A5BD0C0FCE270AD5916238D0D5BD9F9A1B2E147F),
    .INIT_35(256'hA9C5336F3EBB89FDA430B626AB1E5A6945FCB94BDA13B1AA0121C64A130ED971),
    .INIT_36(256'h5DB50BD799B2312F41ABC56D3A535A87BC4B9924BB2458430149B948527F28F2),
    .INIT_37(256'h3DD99E96D263D6F0CC57130095EE1D93AE98D4ED14CB5AE5561C251BD5DA4935),
    .INIT_38(256'hBEE5220B3C9863A956135ED6AB444EF29BA81A3C091187CC11D4AEBD9E1E0352),
    .INIT_39(256'h111031B1581AD59DDDDEDBE59A755C793ADB1DAEAFDD142E41EDB36DD3DE9056),
    .INIT_3A(256'hBDEC5E4B4382C758C4239F141DC344CAC24CC408378630F9AFB2B42B92DC42FE),
    .INIT_3B(256'hAFC70BA7AFF88247B924BACBB4B89E33930589313DFF394B9C9A368D397909B6),
    .INIT_3C(256'h4B6C4821169CC3F53DE827F712372B88B50A85A8468EB7691157DD861D90915B),
    .INIT_3D(256'h1A459B86A77A811AB8B3CEA04E38B05F271C4815BDF72065498D54012081A8AD),
    .INIT_3E(256'hC14E3CB848EC32D941EB187F0000D5BAB89D452609CA15389192A6F050EB9457),
    .INIT_3F(256'h17988D771FD7DA2738FAA7D28E02A2AA22442281AA6543CC9ABEA6D69F59803C),
    .INIT_40(256'h45B24C2102AFD9B9A21CA6F9277C8D78819299378E89BD5B0449B28EAF8D3619),
    .INIT_41(256'h01E2A1891ED783C9152D1CC783834062CC393F2555CCBDEDAF5D1BF3C9895DB9),
    .INIT_42(256'h928FA9120E823F67878294CA4070267B51DF49AF5EB82C5E5669A61F0000556D),
    .INIT_43(256'hBB052F818B7305A4091E9693CEE8D439D3D137E48C9932ABC17EC68BABA43584),
    .INIT_44(256'h9066C8D990BA52390EC7A778AB76210D2BD90F111F57899B15174CAF96B7C921),
    .INIT_45(256'h9FF3096CAF73CFEB4D5D56E6B3D5234C0C9A984F0710273B198423651B791204),
    .INIT_46(256'h0850CF202DE405E0B972055B9478A5675B1F849A9C04B30736F00DDF13F7226C),
    .INIT_47(256'h3AC425121714ACD615813C14237B3BDF59662E9F9A4E42CC3154A3DBBEB6962A),
    .INIT_48(256'hAC25B04C224648D6AE32BE69B23231951ED4D815474DC7365D5D80005E483F80),
    .INIT_49(256'h8EB3B7E9C3CAB7614842DAE143181E9B9B5DB7A4BE561479AB580E5021F23521),
    .INIT_4A(256'hC9519C61049ABB0724019EE59CB9371A1B6A3663B85A3CE1290F0CB72E89D3DB),
    .INIT_4B(256'h75FC75E2708378A3711279437BDE790BDF71086C591A4DE988880E198888474B),
    .INIT_4C(256'hCCA8DD500F671A3705A99847F9647A492C752EE24F46E71E52098E326A72314F),
    .INIT_4D(256'hBED39721919B385D1B5F543D5B1BFFC40325841EAF310831A6FB89E8EAA4407F),
    .INIT_4E(256'hEAC3B67FBB75155A314FE4FB2634C0578742F82B953BC62AF772A0B442AC2FA8),
    .INIT_4F(256'hAB2E659FB8DD76ADBB4AD0CB53E750303286AA2D9F9F4EF8D33D70619860355F),
    .INIT_50(256'hBCDDEDC24427B190F5FBB59F06869352E7D9D13565BA2C20FE87194E85FED923),
    .INIT_51(256'h75A43D3EF0D551EEAB414038712FD69D38C5C1134FD07FFF35D7A6870B577AA7),
    .INIT_52(256'hAC063A0D198A5B72EAC2273E0D0D5B34CA33AC013799F4EF6547E35C6C0C05E4),
    .INIT_53(256'hE082C74C076C246AB41840EBC8762B66E04F50FBDF3BBE87C22BA47E76A32196),
    .INIT_54(256'h4134A48E3658EBA27117D94EF9FE5BF16B2AEE5FA53E7EB0C84EE7D72D57EB00),
    .INIT_55(256'h7BD1F21F0FAC6FAEF278466EE905F68A888861B788887B91912D7613EAC08DF7),
    .INIT_56(256'h5278A377CD5E304D9E925A4F6C347FFF00F314FC181CBFDD208CD4E803562A4A),
    .INIT_57(256'hF1319C0F7223B5B228587D0FEFA8F83270672A5703012E2C6E87243E18E840CB),
    .INIT_58(256'h4041652339DF8DF554BBE0B636B898EC5EC1EDA0310AA3B164CEF557E1437971),
    .INIT_59(256'h80602D3C1A4D60953FC6EF94F0137AAA82FE201FA5906C48F3C23B5CC473560D),
    .INIT_5A(256'hBD92D03B80809316A2418080C41DF53FE682B68C351F6F04FC02554DABE42BDB),
    .INIT_5B(256'hD46BF35B7EF766421634753318B85DDCCCE0A51851A6632DAABAD7E044FD6531),
    .INIT_5C(256'hF5C2C67B6B94990C0605C459494184F57F28F0F31C899C94CB46B00525B6AC60),
    .INIT_5D(256'h2AD4D1C8262E1B227169F1F8F72216D36E8E8998D87B49BD2741B9C3937770AF),
    .INIT_5E(256'h4763232DE5B5EB421309821E28FC0C4FCC5556E449911DE02BFF5323B4C2C5D8),
    .INIT_5F(256'h73988DB7761BB9B3117482FE0E65104235115BBD70AEAFC15B6125D99AA53CCC),
    .INIT_60(256'h771D7F7F75E20693D7DE6D958080A4141B87731D21349758A9571FB72880C74E),
    .INIT_61(256'h47C54D2D08512C628C4C2D9C9073C31EC4391A75FC876B8DF7C98620D555713D),
    .INIT_62(256'h42056019166912CFCC180C6E5EBF9076566482583C85EC900F0385DD77FB93F0),
    .INIT_63(256'h0D9C6BFF8276167D4353DB87E0AA35312D9FA17BA533E2EF47BE5E070A0E50E9),
    .INIT_64(256'h972EAF8E58245AE71E7CD308425DE46C73D0C03D6E8B7DC4E29D401EB94F7E83),
    .INIT_65(256'h34AA3D2E25C002C4EF2F0FE1B18B30CFD74F48AD5A1322002EEB0D99681FFF7A),
    .INIT_66(256'h6CC4F281C6679A479ABF207B0AA5DD653A42CB8DCEF34CDFFB570494CEB23F69),
    .INIT_67(256'h11A9824D26F6B057D2FBED192893D55845AB7F7F8080F8A6CB6D808080808387),
    .INIT_68(256'h3E9C8A4241F1EB00E43C4B5BAC7DEDA2A35DB811F9F2C7D4F61E6B6289845C97),
    .INIT_69(256'h699BFDD68E6367CBFF2873A3955309A4ACDC6BD7578442DD30A7C0D908FE1FEB),
    .INIT_6A(256'h9B8598930E02F33561000AE93F1D3EA79341ED5566F9FD111F60E93F12FC1305),
    .INIT_6B(256'hEE7D1A33D6A9F5C1801FCA3380A1348203289D35F47D7983662292944680ACE1),
    .INIT_6C(256'hC809B3146F99D8F52464E5E66009864A14F9EFCC766EB1969F648EDA255863C5),
    .INIT_6D(256'h000000000000000000000000000000009E5202E101EC26869981BDD13902C459),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized3
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hFA851956AFB143D69B3C07632EB2920D9C1A3BCAE119EF8CAB8D7E658C9F3B7B),
    .INIT_01(256'h6F08F8E1052985B48888494DC22A7777A926DCBD569D1A92836020B0D2C78A3C),
    .INIT_02(256'hE147FE775A8507A587628E8486448AAB3186CE8F6E5D9C89C48B6006920E8D25),
    .INIT_03(256'h64F5BEE4016DE440034D7FB393D376F788888CDEC9727777172946737A4F5F1D),
    .INIT_04(256'hA9EDF12C0B9127B5056F10AE226BC8B23F14EF495F0E31DC62350E1EA4D78346),
    .INIT_05(256'hE4598EF64A630E36E554DDF59D12D98569B68ACE808063531CDA8080C367E6EB),
    .INIT_06(256'hF37F6D7F227FEC7FA57FE77F7A7F527F527FF37F9F7F167F797FE17FB67F9C7F),
    .INIT_07(256'h8FA58D2CA8EF2347EC99801A5E302A3955A26692D980FD5213B55C5DF2FAF106),
    .INIT_08(256'hE98C325E7918560A193CFB388460D8AC40B27F7FE6E3573562CC671B80809EAF),
    .INIT_09(256'hDB6A1C239CBB64F18DDCB7D203C6EC175217B21E0D4000DFDCF7AEF6F9D3FA4B),
    .INIT_0A(256'h6BF312A32C0CB3773A9D5D659DB3F1F2BF7CC4C0DF622F196709967F5B2F4710),
    .INIT_0B(256'hFEDD7F7F80802AD246A080808080E78EFD389CBA3C9B18B43A69328BFEA75DE4),
    .INIT_0C(256'h9049147F27DD597FD999E77F7893F17FC85AB97F90D5D97FD5C58E7F7F52617F),
    .INIT_0D(256'h2A17FE7F55DB917F6E89F87F9615017FFA22517FB893F97F9F9F967FF3F5137F),
    .INIT_0E(256'h48B6A975C7B5517350292C80AF319B937166939DE1B9F2D5E0AF80DD1ADD642E),
    .INIT_0F(256'h0C373647076E9D47BCDDCD1A4A111E9FBFAC066BCC8992A4A3DE0C613B200698),
    .INIT_10(256'hB67E93FD179D4B45C76FA17AA51099FD189B15318C220AE08015CBE42069405D),
    .INIT_11(256'h8401338791456B02B0830048096D2E8E23E400AF090728DF24C9AF5D4199448B),
    .INIT_12(256'h42C620253F6F3C2839B6F4A1CCE1B0EFA96D0308B1CABB110C3F98B28CFC03A5),
    .INIT_13(256'h4D7BB41AC299B5D494AA800045B64BAFB37A48450DC18DAE091942910B12927F),
    .INIT_14(256'h16A596A2AAE30F9D4D00A4C6B888A14817D5200207742780B744398CAEF916A8),
    .INIT_15(256'hADF794EA2ED83E638316073242FAA68EA16294D18ADFCF522AED3030C2CF4CDE),
    .INIT_16(256'h1FB2433A227F9BF112A64D662C9C2A579DC20CBE41A2A8DABF578A30B74C817B),
    .INIT_17(256'hCCC6930D2E840C8BC555AD851D700F4CBAA2B721BF92AAB5C7C2878C23C7AA67),
    .INIT_18(256'hA12EB86436332BBCC16898FB25CFCDEA9BEFC943ACFF23CBCEF4B9323F0E30D5),
    .INIT_19(256'h0ED3BF3093754739C8A122158520B0BB0FCEB9C686A1A3E23231C6E7089E3C5D),
    .INIT_1A(256'h8C5BC1518148991E3A89350C0EAA02039C67A8D5C24300269A3418EC0A6F1700),
    .INIT_1B(256'h0B3499AD269D0C18B3D9230C83B4C4C24FEFBF6DC536AFB7B7020F53BFED201E),
    .INIT_1C(256'h93F299708C0C32670E1A000020B3B3063B0DCDBA9F2EC7350A6807AAC33C2CDB),
    .INIT_1D(256'hA27CB4C88B7C8FD9CD88A3B39C1886119A309D0A3E114F004D2712170157BF88),
    .INIT_1E(256'h98801777299730D396E39D1F83044B83C0D7288542AD86D69325C7389656C4FC),
    .INIT_1F(256'h05BB8D61CFEE196B93C8AE192DA33893337D320F23340F1B1BB245CEBD2740D3),
    .INIT_20(256'h06B699723EDFB7F4B6231E63BB7F2C53CC0416CBA522467D0B5B3621C68DA73E),
    .INIT_21(256'h10780ABE9402A4B040E23631212BC080A5F125CC24E929F932FC23B196A4A109),
    .INIT_22(256'h13B410CE3D9DC56D0CE1803EBA4D20833EE73A859EE9419BB53B99D69EC30498),
    .INIT_23(256'hFE9DA6FB6F3F213F246A3ACBCE598CCDA236C9C48AE62EE5C6581215995CA7D1),
    .INIT_24(256'h1EB08DF971A3DCD1A6C1AD2786060090B8828ED4973607315F883D5B65FE5F54),
    .INIT_25(256'hBDB853A83A1C9AC97C8C8AF7F66E11901AEBCF01B5ADE62FBD21AEF7F06C5545),
    .INIT_26(256'hDAEC42AC782FBB72FF6608A3EF28EC5AE5234A71524EEC84CA37F73329C2AF44),
    .INIT_27(256'hE63834419C71173AE1EB69F22324C561E9958331166B9FBE77E84FFD26456686),
    .INIT_28(256'h2BB5CC70B2DAE947EAE865607E4FE2535965ACC10A6CFA287833941C4D16F507),
    .INIT_29(256'h7ED906B587F9FB81AF3B9FD59F1CAF979439F84980703FC59D2C0BC1587BD192),
    .INIT_2A(256'h7DF3E296F71F914E7EF00D96DCDE9D33C4B70B8A197B1EE0611056F96BF30348),
    .INIT_2B(256'hFDEF8F2F8953F9BB28A6BD550790E37676FFD369440AF24B058484410C1AF135),
    .INIT_2C(256'h35A58348C638F117C83B8FB4F6AF1A02CB1BEF23B45D8CF73BF26B8D536AAA55),
    .INIT_2D(256'hA3D79A716F8A5689D43E55780E391FDDC8A27377EF9382C5AC38AC7E5762FF50),
    .INIT_2E(256'h593E2917691293370D608896EDAA1AACF03B9A519CC76C518BF21D91C7E427A5),
    .INIT_2F(256'h4CE7C65C4ACEDA4BE29CAABF5672AD3434A95D94FAC24ABC1A6D19DE0A6E13A8),
    .INIT_30(256'h37A76FC972391D6D1724D54D52E99D1402C95019DE8F9CAFA94DB48E1A53E23A),
    .INIT_31(256'hAC4BD972D13D82F14CAAFF21238DF247510754F212B13AC01FAD0BAB6CAC5B7C),
    .INIT_32(256'h12F2EA6878F8DA3ED27F58AD610B6C64F2DD41CABCB56C1B6B658FA7884F285C),
    .INIT_33(256'h996C0A227C0719149468620C82663DA0C7A68AB821A73258AB3443CE2E308211),
    .INIT_34(256'h15AA6F746D6DE82798AC4C302D5EA4008F7B0AC661F88845C357304408E4D712),
    .INIT_35(256'h4D390B68EED69BCFB977450242F55B3F6C2AA19080A2B5AFD750BD2FEFDCCCDC),
    .INIT_36(256'hC21C3FA3A364C1240FF0A341C595269743287009A78CE509468D32A7286EF300),
    .INIT_37(256'h892CB0B53280778A27B1A9E51533F75C13E08AA7A27CA0BBA08B25726F7FF1A4),
    .INIT_38(256'hB17824770B53527E7A48724DEECBAD6566CCE184CE4A1AD565200ECE05E0BA40),
    .INIT_39(256'h2598220719400A34D3A7305E28621E47FB6D05DA8F07DE30D8C5D98879DB15A4),
    .INIT_3A(256'hCDBEDCB22ABAAE1F1583F04C45F1469FFA86709B0E8268900AA7B3922AE1051E),
    .INIT_3B(256'h15AA229825625750342C10D41FE06C2259198E9D256240F407E8BB34210A121D),
    .INIT_3C(256'hEE969ED462CFED12B4B3B3ADC990281808879AC04E682E52639D5F66776710E7),
    .INIT_3D(256'h1FA0C6D46E0A8A82000020F382209B511F03B04E715D6D217338A3F31CC89894),
    .INIT_3E(256'hE8132EE90B68F2909C528415009BD0F315D94377C29684C4BE9CC947F4402ACB),
    .INIT_3F(256'hCA59E2E1F5FF50AAE7A281DC3E721BF48359E40AA1864C38F04AA018E81095ED),
    .INIT_40(256'h57B0E03142A7FF390D67856B82E14E83C9F9E3FD8610A1FB1C8C90FAD924D8C5),
    .INIT_41(256'h53727B533A3EACDDB775597008F4558B5BB89418C027BEFB05A2C914D1216683),
    .INIT_42(256'h0C51C91355C465C045BE0D367C50F6C461174BA39BF4AA0AF21ACE81E6BA0000),
    .INIT_43(256'hF751A3E9E9BA238FC4031B922995855AEE85D6CE55AF4890D34BA22068AEA3D9),
    .INIT_44(256'h9AD26D925EB2CE7F86DCCFAC3D4591569DFA36827880EDE683F72420B29A2227),
    .INIT_45(256'hCD88F84D2F5AC14530FBC871B35F24310B4850A039503EE491D5C114AE37C7B9),
    .INIT_46(256'h851FE71239C671FB1546056690065804C2EAAB5BA10408DC9E3CEDBD7C1DDA46),
    .INIT_47(256'h8A783F9284778CABF9E54F9B6E0FE32B285DF46FA8C3626489CEF60CEE93DCA8),
    .INIT_48(256'h25E302944823035DC98F1996A4AA3D6E4A7AC20A60F797CD1341E557C6EBF07D),
    .INIT_49(256'h5FD3E8F2FC0D93D3D516464B029D428B019B9F670DB44CFA1A3FFBE947600000),
    .INIT_4A(256'h6296C1202F14D34E9A6B6076C2AFE2D0ED78417F519DFFFFD6DEA7482CB3D76F),
    .INIT_4B(256'h81E49CDA28F0CF9BD3BB0DA0A0F051AA20C0ADD25972E9EFCCB98025B0889134),
    .INIT_4C(256'h0BF2DB030B290001C2697814B1F54B29EB6A2387540784DAAC6C05FCB16241E5),
    .INIT_4D(256'h7D6F031E68F81E9F324C76DBEC252CAEC19C38BBE2FBD6C9220B34BC571F78E3),
    .INIT_4E(256'h6B77ADE1978494C92A1FE37D5CB7961E2807B0F6C5992716E5AE45CD72F1FB52),
    .INIT_4F(256'hA0B2627F3CE531685E0DAFBAD13D6200F8C3A73F01F932565FD0CC15ECF32C0C),
    .INIT_50(256'hB5BB6843786A3C6DF4407DD9E00F9DDC5A40BAFF9D8F2E278888FEA0811E7777),
    .INIT_51(256'h30FA7414CA6EB166FDA79DFED737198AF97761A71BD984E787FD869280C2818C),
    .INIT_52(256'h4F9CAB10837EF6EBC064D263BA9BAAFF317E7537AE1DF8741E540746FFFE16D5),
    .INIT_53(256'h5ED0BA5FC47C2B415ACE462340D3C4EFBA582A6FEC0CB02E9B148D3B690F7BC1),
    .INIT_54(256'h07B6856DDFB8DBF6E6251697403F50E8D5C1F68056C385FECE2D567986CC7621),
    .INIT_55(256'h99CCB253515A25D9EC14A0027C96CF1488887095321677775ADD8305CA8E18A9),
    .INIT_56(256'h7F5A5E2C23EB5E6AD30E324B5CB7549F9A9FF5492C43DB6600FEFDEF040B9758),
    .INIT_57(256'h2A241FD85365BC3A672294C36E03ADE8AC80EDD1AE8DB1A8CDBE8869DCA070E4),
    .INIT_58(256'hC46E1D3CAF125A289DCA32312AF89CA5270001F86796846BC9C2DDC931E20001),
    .INIT_59(256'hD520A95892A441B48C7922A4FFFECC8B89C210CC9FC482955BC75D509A6348B1),
    .INIT_5A(256'h896B2D8780800E32BB63808038695C5580DBE0036C0E4E247724203F0DE94E9E),
    .INIT_5B(256'hE17FBA7FC67FE87F1C7FD17F447F367F4CF5F611E98A3B55C3DE947BA475F808),
    .INIT_5C(256'hCA91F4DAA0096412EF4A934E8AB6265BE77F927FFF7F007FD07FAE7FA27FD37F),
    .INIT_5D(256'h87F8DC7C42114A47EC6DECE68D5741B69BB151BEB865E062B47FF9F60000A00B),
    .INIT_5E(256'h20CE56E443090C03968CCF54AA3C93426DA991F81B5CFC741F59D5E2DB17ED10),
    .INIT_5F(256'hBFEC4F2F44331CDE01CFE5DF642766C74C91B652E38C4DBC395E471B3681BEEA),
    .INIT_60(256'h7F1C7F7F13B8071638E644B78080A8CC923FCC5DAB17BFA0BED08D8FAD5F80D4),
    .INIT_61(256'h8A419D7265C3F2F7397D78096E835BEE302648B1DBACFC08D737695B73E688AE),
    .INIT_62(256'hC02078EBDEA049F24DA446FFD8E267F30207E38ECB4C20E32513D7864207744C),
    .INIT_63(256'h5F0A3A7CA06FE02B76BD683848906C9F0A520FE8953EE9C438682D7C43E1C00B),
    .INIT_64(256'h9C859FE1C5FBECAC1879D31FC6CDE035EAF0EC5DC82EE051114E9ACEEA76BFF4),
    .INIT_65(256'h74B41EFD869F1113344BF12E495774AA22BAEE998095983A0A4E154026FC467B),
    .INIT_66(256'h5A280E4865710877FCCB69419358BFC4F400AF386E3D9745573B61FF7BEAA56C),
    .INIT_67(256'h2DCAC97F51361F7F85BBEE7FA432AF7F87917F7F80805341AF0280808080CEC9),
    .INIT_68(256'h1BCD257FD515977F104D4F7F8AB9517FC191107F28B0F67F3D67697F9FC6A37F),
    .INIT_69(256'hA0D5B05C4C991BF15F95F2744817C07C3840867FC157487FECAF6B7F8B2BC37F),
    .INIT_6A(256'h72B50A6FEA54F9B1396783C500000C1AFC4FD59D2F2F515B8FCC41087ECE9426),
    .INIT_6B(256'h08FA6C5699885200930B036F43FD599617AE4F94FEA1103AAD74FCC8D2FB5A19),
    .INIT_6C(256'h9D4CD1CA45CAF3E6DC3CE9C92B937EE3757C6A6B25C6DAEA30428609CFF18577),
    .INIT_6D(256'h00000000000000000000000000000000958063C3D9F04907F9C904416175B81A),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized4
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h1EF7C3DC2FEBB2E446AE5ABE511F82C5C746E07AED404212B9900C8D8651531B),
    .INIT_01(256'h994839B8491AEBB388889B87F65C77778C0EA656E95BE52FBDF7EE72E213C70E),
    .INIT_02(256'h7B018193D89FDC6B4CC79F8749C7D8B7E813205AFA6BD8B970EBA136934AD714),
    .INIT_03(256'hC3F6F663AEDDBE88C25D71ED17E42415888862F69FDB77775BBB7395691522E1),
    .INIT_04(256'h222E383076777241DD1420EBA3A9F439CE64D1002CF7028D860AD68F8C55D067),
    .INIT_05(256'h7C8D1CAD5475B6B4CF2C685B51D8C92111AA3E6480806B1182CA80808D625BC3),
    .INIT_06(256'hE18040807B80C480C1801C808980C5802880AF805080AA80EF80F280BC800A80),
    .INIT_07(256'h497709C64C0745BFA61B5A420396DF6D4BFD3E0910F21F7CBA0723806A8809C6),
    .INIT_08(256'h0D089A46D1277CC683A05C553356E10395217F7F2C238A399B8190D28080334D),
    .INIT_09(256'h55E0848578FE00A82BBFA7D279324172E6143CEA63231B409D350464BD8A7087),
    .INIT_0A(256'h0678BB6469AF02FC83B0AE05CEDBA7B1802880AF80A280C5800E804E80588023),
    .INIT_0B(256'h58F27F7F80806F1339AF8080808088450EB9E254E9952610F8A4E88F898B27D5),
    .INIT_0C(256'h78808080D4618080113E80802A078080003D808007DE808019328080B2108080),
    .INIT_0D(256'hC62F80801C5A80801F438080E86280807B4B80805B5A8080344E8080B7E28080),
    .INIT_0E(256'hA1F5DDAB93C7CD3DCBC348C085E3FD0E44209DD7857DA280B6AB7FBC53D04EBF),
    .INIT_0F(256'hB14626920D6EC636916F9F7EA5741BF3002E92CEA4228AE948CD1AEF90408FDE),
    .INIT_10(256'h49DC2E929B29A74DCFECC2023D711C781A231A87070E4113B8388985418BB13F),
    .INIT_11(256'h8B08C34CC76B3CE691B1B7FB0651320037A6B8F31A41425C3920125CA925B0CA),
    .INIT_12(256'hAF6DB26E9055888393679CE619749550BE7932E393C99DD6BA80948DBDFB9334),
    .INIT_13(256'h86CD1B60A7682C472B4C9CF28AF32BA7845A24831F52277DA0EBB24DC69EB168),
    .INIT_14(256'h4CF6BA9AAA35AA63481DC8629E30CFFC0E8E38BF9F81ABC239BA2FEA10E8A42F),
    .INIT_15(256'h8E9B3542437036988773169A9C5E93D61D49CFBBB7CB88193565968497009160),
    .INIT_16(256'h37EFB9FBA4B7BEF6944D010C28793BD2AE6447D8A4C4B6C10564B873A0BA3959),
    .INIT_17(256'hAC20116AA99A1A154BEE2D37C76547932BE7A83A31D904CC2835A25FAA043D2A),
    .INIT_18(256'hCE1128E0413986C31C42B6BBAF2B00DF271B99CAB23E906915C6A795916848D8),
    .INIT_19(256'h48255CDCC8BBCEE1628C6AC88EE8C61B9B1E53243751CCE8B5B7A3283DA1C037),
    .INIT_1A(256'h8371A4B1A6A9353DB9C11CF700C14358C1E337CF2EF64511BC530D21CF540C24),
    .INIT_1B(256'h3BAA112E3C31899D9F07802DA8730336181020A18BF12DF4CBB48EDC03C227C8),
    .INIT_1C(256'h04990B51A4E1B3CAAFB500959E70318EA9BF9F1243C591451A5695F7CBBB49C1),
    .INIT_1D(256'h98A087592A6E2BE78D559A1C21D5B8E74D5D053AB471ADCAA9CE0EDF810B8E02),
    .INIT_1E(256'h869C8C8C8B5ABFF54F9096AF8F890E3638F7106CC913A6BC3AA4B477937E2DD8),
    .INIT_1F(256'h1ED89CFC3362C978115C38A1CD8BC0ABA8B682FA4BD7B531CA253F59A23C9A36),
    .INIT_20(256'h299A888CCE91C08C9D8E14FBA7B218681991B5C801E411B0144BA3D79B2CABA1),
    .INIT_21(256'h3DA14FB393274CCD0516A8DA3849334B1B3638582EA6118F2E941F9A1B350000),
    .INIT_22(256'h436A826D20730D55AFE0B761CEED806908AEC501AB7A2BD4A43B9797439D1DCE),
    .INIT_23(256'h2F0B8A7D130159848193B7A242CE537B0315BA4514C3A3D8C1E31C65C98ED5D6),
    .INIT_24(256'hB255542FBD29A560B64A4902CB1E50DD4117469951EC9EB0C33C246C4CB3D847),
    .INIT_25(256'h10E6BC4B2A3734CC244405F6900839431A071A54B3FA217F4037064EDC478F8C),
    .INIT_26(256'hC4881222D25DBB46989A4D3D2C81ADD7B626595B9358AE922134087543A34C12),
    .INIT_27(256'hC53BB59B254957D135B24B0D385DBF4B528BBCD32180292EAA0D88A49F25348D),
    .INIT_28(256'h55DB2471061A917F3BD014DBAAE3B7591F0B350E5D344DC258DEA899CB8A02F8),
    .INIT_29(256'h995809BC2187DAEBA471C4FACDDBBC8689C3BDDBD0F28ACDDAB8000842DF58D2),
    .INIT_2A(256'h22B1445B969949B022981D960A94167551EFAA290C0C8EBA273898CBC63BBC36),
    .INIT_2B(256'h2DB82E4E433711394DAECE5326EAAEE3BB2021D90F0DB2FDA6449D2C8908DEA3),
    .INIT_2C(256'h82EFBC5A9EA9A47D5E191CC656D94EE63558BEAD8437B3F231F23B7B254C332F),
    .INIT_2D(256'h05143DE55AA7599B55BAB54B1914D8912D1DDCA9D241CEAE16E7C6244E0DB20C),
    .INIT_2E(256'h1B3B17DAD711A962B0CB5D6C8D1613639C0D3DDAB81B4F3FDB5711C238FA3833),
    .INIT_2F(256'h05292F7E173F9F54D2CDD1C535FA485E26E58A895D50341C3D378FDF44770B9F),
    .INIT_30(256'h39D8413308CF57FE453A4F4284891A4D9FD596618798D84D55315B26BF5DD244),
    .INIT_31(256'h0F42D49747741B4E094959C3B209C3E4BDDC34C50E1DA686C2C6D9A3BB1B44F5),
    .INIT_32(256'h354351EBB40799BB8816217D8996C4334120947359CE9269D3762CFEC05A3BAF),
    .INIT_33(256'h9A0B19C5095C1F5C51651CB7867FCD2A2D799093D949881433B3B00DBDBA1F92),
    .INIT_34(256'h242938C5CF2F171D5D0D9B240E599E9F01A4306EDC624832B2BDC394525D9D65),
    .INIT_35(256'h369A48708D4F912691285E1FBFAB2CFA332B306603161180CC6250D92E741A28),
    .INIT_36(256'hB25512B24C13073450EB82D9125254F0488313BD2DE81C1AB00EA9FE87873D92),
    .INIT_37(256'h95F3D048C4A41AB23FE9D73643CE3B7FD5363E241A3181524E4CB3AB14B52BA8),
    .INIT_38(256'hD5648AB0115F5748095C5105A7005592D4670A96D32157C1C7A6BFCB48A59E53),
    .INIT_39(256'h9169B629C054C2F59D122AE104BBB9A147B01D928BF63BA04B43C6632DD64AF1),
    .INIT_3A(256'hAD68166FC148DED45B05B4AF1241CB891E285BC9B76F5895A90B1C0745BA1EF9),
    .INIT_3B(256'h3B6837ECA42397B39DEADDA488C391B54714B9C641E4D913DBDB29040D244ED2),
    .INIT_3C(256'h4BCB49DBB55B2E320E90B3CA804D16CF520180675D21B3FDB07556B956E79599),
    .INIT_3D(256'hD368A3264B7454E30000C2FD5B53A12CC7F2855CC67D1E8A8441976889F3A8B6),
    .INIT_3E(256'h8D522E0B4146032FAFC84EE9CE58B8B78920801732C6806F47C797BD0E53835B),
    .INIT_3F(256'h9B39A0B3DBF82D8A36C1B2CD3073AEF25BA0BABF1B1422B8C22E127ED85CAA89),
    .INIT_40(256'h4F7F430CD7158A604031800A95793E6EBEA4BC5934D193BDBAC3AA5587CCBBBB),
    .INIT_41(256'h40EE09AA0A425433539DBE17250D34DA4E14414419682D9090D100359D2902B7),
    .INIT_42(256'hDB6D58E28339B9804E3831E70F1D892D444E0B65A1D50DB2A2480E5C17FA7F80),
    .INIT_43(256'hBBDF2B8154BFAB48217044EFB0D18EC01CB032B1AA9255A851FA8D2D85530A53),
    .INIT_44(256'h2FA89547AA3FC93CAB19B7839DB0A293010138F1DD21AEC045EADBA0B2F4DB3E),
    .INIT_45(256'h102DA8F8CD7012A80B9B2844CE6F39E820955658299D0D9B39A4C58F1F9D8E36),
    .INIT_46(256'hD9B2AA70BAC926E9D5F32A7E0A5EC0B5B96B0773A68E25578FE3140AD1C20EF3),
    .INIT_47(256'h4ED616E9B0EFC8F72B3B4BC4DE0B171B8327D51DD9B8B65CD0D70C00BAB288DB),
    .INIT_48(256'h1C9E3352C7AEDE9AABA1A7B044A7871EC254188EC7A504E8A878C1E2854ED8D3),
    .INIT_49(256'h366ED7470C44826C831B2DDC2DAA1A5D51014FDB4C09269D4F92CA6ABBDFFF80),
    .INIT_4A(256'h4A6D8DBE8FDC31F4C14B0C6555C41764464D57C99B94FFFFA6170AFB847B4B2E),
    .INIT_4B(256'h592767886DD9C3C357320303EF60E74D04DF8F6AE7D9F3A99D5044AC2CF91557),
    .INIT_4C(256'h92A95B06AEAB80009DCBE29021022D3901A5229B1E89D2D9A57CD14B802C9C55),
    .INIT_4D(256'hCF4D0057A8748AE53787B3527EAEBC3E5DBE80B535A8111AFD5C61BF5FD3ECE2),
    .INIT_4E(256'h474A3E8C30EC5619A62F8A3D24F085771EDAE6C7C63673AE4BE3054EF02C9559),
    .INIT_4F(256'h8A0E19D1725933F7EA684FB7D8419670B885538CE185BDF8B22C59A2E6765C70),
    .INIT_50(256'h9C0B44DCDF766046430EE2134450A19F9691D66D1C154BD78888D8455A2D7777),
    .INIT_51(256'h68591D11B7CF2B4FFFCE28EA829A80F0CF04A86521EBC322AB37F0D7CEA76317),
    .INIT_52(256'h5390EDCC2B71F9F4CE5BB3FE1693C720B0BCCAE27AFCFBFB94DC7EA97FFF524E),
    .INIT_53(256'h768E4EB3D7A4B4275EDF0FEF02633D8BABA72197524A72B664FD08B006112EF4),
    .INIT_54(256'h9E0B4469EDDACDC6C3D2B5D9DAB198B6659CE58E56DB5A727C37AD4512E5391E),
    .INIT_55(256'h9F43C9BDE3F5E9EC9A84F6ECFCD8591D8888AB2864FB77772BE7A2739ED1289F),
    .INIT_56(256'hCC2F28634BE2D78993301ECF2880B2C80745D6C7D41C828C7A666E25B8E17997),
    .INIT_57(256'hD613B33B7B9F259B25DB0686AE69B635FA5E52043DC965CF6C864EACF9BC49F2),
    .INIT_58(256'h76381734C6750D57770BD78490EFE72BF2D2EC1BDE0468BDF1D49652C8E58000),
    .INIT_59(256'h42DA479D5B6C8DBFD7F57F087FFF4AD432E058B728864DAC5F64523CACC257AE),
    .INIT_5A(256'hDEAD6E4580809946D3DB8080A7DA3901A895A274AF73670C2A2D9F3B7BBA947E),
    .INIT_5B(256'hB380C380CB807780A8801D806C80E180818AD916E3F9E43EA54D43BD3153497C),
    .INIT_5C(256'h3811945F3B371B83DAFE33F67853B5391D80E480EF8053800780AE806A801280),
    .INIT_5D(256'h35FCD9D83F0EDBFF153D9B31564F9454031BE476909E9087358DB2D38000C1B6),
    .INIT_5E(256'h94AE38CCE1BFD6F950328C5CE9C4A2A623E5F5B44B3FA8E4C7D0796E7B324F69),
    .INIT_5F(256'hFD85142AB2FF81F5845F34FBCAE8109EC630CD6F2D190D1C89C52D2491AF8C76),
    .INIT_60(256'h68557F7F624BB59AA0C6113C8080C243C9CAD8B783A44CB178D0A83845FEA8C8),
    .INIT_61(256'h9B7518E98D03FC51A22BE06FE9B9401682479797AE8B95B03A3421D9467DC551),
    .INIT_62(256'h807080BE80D8804F801B80B0806580D047B42CBD3ECACECE629D7679E1FBD48A),
    .INIT_63(256'h78B156CB0644F9711506CA2FDD07C8976B9F99499F73C032FC6A81507B09E0D9),
    .INIT_64(256'h39C7A3BD10BB27FA76F2927D607146E586331C6B33220C217F3ECFE999F2744A),
    .INIT_65(256'h74EBF09F8D377A2CD47C57F5B5BB5CEFA60142F6A19C9B1311D999A0706D14D8),
    .INIT_66(256'h0B9E5614D00807C21AA3CF5A365179498EC7553D5EDEE7146C54D2F140EF45B1),
    .INIT_67(256'h9BD38080443680800E5A808071D28080CBB87F7F80805C8DFD4B80808080FC88),
    .INIT_68(256'hDDB480802521808065C4808014E680804F0F8080DCDC8080D2618080AB078080),
    .INIT_69(256'h84D4386984784A848A3221DDC9129E7353318080BAD28080A9458080D12E8080),
    .INIT_6A(256'h5607774197F5F2D30C96A3B68000CF3413092E8256376E2F3D1FA640E2AAE43F),
    .INIT_6B(256'h7F6BEE7C1D25151CC83683B5A6CDE68137F29BDFEB955A33C922294D5B977151),
    .INIT_6C(256'hA5C58E7A2212251D24BCD5B0F6AD010150C92F3A4EB60AD13D74A73FC8A13F6A),
    .INIT_6D(256'h000000000000000000000000000000003E9BD4D0AD701CE2EDE1512ECFB9E052),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized5
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hE9869886DA854D89388D168B9E82EB8BA41E77E2AD2DB816B13FC2122874AC6C),
    .INIT_01(256'h639DFA5BC206CC7B8888B520E10377776A460B22978172EAC312E43197803D9F),
    .INIT_02(256'h6BDE5403436770B48B6881D1887D88AF7430FAF3CAD95B967F57E65BFDFDB8B2),
    .INIT_03(256'h878F8C8A868984898C87818089878C8F888806C3E6947777BD3A7A1A5CCD64B9),
    .INIT_04(256'h2C827A1AFB6F8B15A6EB4F37C52218C0848A8382818D8F858C838E8782848083),
    .INIT_05(256'h93233CD7A06FD59044B8C13AC065F43AAB80B059808038899F3680807FA8FE75),
    .INIT_06(256'h67606B382E06E57DB9D4D137A056E42D4FEE43F29B974EEF4DD00361A7FDDD72),
    .INIT_07(256'hEF411717CF1480ABDD6652BA2CA020C6F9B45D7135029341CBE245EF9809DB76),
    .INIT_08(256'h99B477F3466556EA689CB45CEC7791E9EE967F7FDF979E95DC799CBD8080E1CB),
    .INIT_09(256'hD907267C4765A6096CC002D851660AC18F05268CA600B156FED6B8EA4AF7301A),
    .INIT_0A(256'h2A0DC7E4D4763652637FB0B59F84FCABAF7F917FF17FCC7F5F7F777F787FE87F),
    .INIT_0B(256'hF8737F7F80801595FC9F80808080F7928DA1B06808E9116C08F93106E80FB065),
    .INIT_0C(256'h0ED8177F3886DF7F5702367FF7F3CF7F5756AF7F5326467FB1E5087FDAF4A87F),
    .INIT_0D(256'h5DCE597F7D95E87FA8E5C67F9E700E7FFEA0287F5BA35F7FE2DA2E7FC9AE667F),
    .INIT_0E(256'hF98C3AE53A1D1F7F493A5E4E320AA90A3ABED22B054C7E60221F34079DCFF5C1),
    .INIT_0F(256'h0BA109521E5AB176251E9CC6A4624ABC8EA905AC32661EA54AE2B43633B83551),
    .INIT_10(256'h982331388807878B267296F69D0920473CE70CE0289618781032428C05068373),
    .INIT_11(256'h935C4E8447A594D92669C527165FACE444792EEE397896FC198522ADB2E5CBA1),
    .INIT_12(256'h254E07A316FAC45FA3709021B13E89A5C8EA2B37AAF02D28A764151B16F2AEA8),
    .INIT_13(256'h42A749542E1721AC4FE9BC1B3E6EC152248F9E1D9F07B44D2905B60B07BA3843),
    .INIT_14(256'hC30204C3981228C41F2DB5333007C9D2BD1B8156884C90F0CCED007D98FCA48F),
    .INIT_15(256'h1EEFB4E30930CB932B8BCB7C96F0A2E3AE2621E5B2194C1D21CEC2F51F6948D1),
    .INIT_16(256'h448395529CABCE861F0C1D3F9A3B2881ADF12924C763B005488880004F88012F),
    .INIT_17(256'h2A310E058922072C484B181C419DCBD086E20401A28543111A331CBD08A9B4CB),
    .INIT_18(256'hC807893C3C98C55902EAB70B26352F30B83FB756AC15B77C225199191864C6A3),
    .INIT_19(256'hA7004177C73E1BFE3A1EA83B25BF2700B2269FF9ABBF11C905E32A1300007692),
    .INIT_1A(256'h25E517350AC90C2D31BA93030000F66800001A9A9F4C2FDE9D45237F30F0C6A2),
    .INIT_1B(256'h0181967E4844BA250655A8FD90E1C5E92B30A6952CB3B3833433473031413109),
    .INIT_1C(256'h195C185D054899B79EC5B3939AA59762240100F719273D88B75639B495ADA180),
    .INIT_1D(256'h1CBD1C998B14B691CD3641629A424352BF31CDFE0260A6C6CF82B264A47B1064),
    .INIT_1E(256'h157E329C069F130C301326CF8611A07B4874256BBD7BC7BA060DA324968C2EDC),
    .INIT_1F(256'h8F9DBC663ECD9DAA93EEA4A0A5F5A47CCD6C471B463F92EC8E922F0E396F10D6),
    .INIT_20(256'h0F5615BF16CC8A0B1797BC70B80CC347393F0A650FAD14930565A4539BB4BB5D),
    .INIT_21(256'hB6B0AB703D8E9DA586C5BB27B0E517A984F828E9067F247FA0EF83681BD52692),
    .INIT_22(256'h92080C1BBA9D2D118AD1FC000C46AC8F4ED9A3789AA5B94C13EF908EC853482B),
    .INIT_23(256'h71E045347BAD8DA6D59CA2F4E7B575C61285D4F1B7AF89429C66B541A140AF33),
    .INIT_24(256'hE20440AEDC47A023BBDF000CBD9306888CE6F67496FB4EC7205F28C3600EC626),
    .INIT_25(256'h2AD670AD4E6FF57E111ECF9F746227F79884496857A0A52E154EA94D0328DB73),
    .INIT_26(256'hEC9E8BCBE359DD48322600FC02589F9F09853A583A51F97748B781C3EFB61052),
    .INIT_27(256'h79C156709B82730BAC4A0DD78E5A7F392288CD25372D4871E9E9830A45FDAE36),
    .INIT_28(256'h4A3761A7DD9EC3274F404BE2200C2564412E23D1A865E428AB6E3A0836FE0CD3),
    .INIT_29(256'hFD34322E632F5277F353963FA18A258F0FFA93BB41872E203B48F4F8797C63B7),
    .INIT_2A(256'h2F639069DD3555C3402A689B4A3D5E6DB04AEC0B0B2F5F2BB71EA8DD2019905E),
    .INIT_2B(256'hC77B78BA2A73F351B67901333BF2BB38BA623579C4E3699D8B120BF253C918D6),
    .INIT_2C(256'h0F0046E7547FDB17112EAD9FF290FBF99A7B0C672FFC164D140616315772E28E),
    .INIT_2D(256'h97D27BA3D2C91D84B66EF6EC88032AE51CA1FD837714830E77819035C22BF318),
    .INIT_2E(256'h003385B3B08D7DFCB484D8F69B80F41FB0B03E420654F9CCE784530BE77D13F6),
    .INIT_2F(256'h5FD6B5224E8944E649542B88825B267C213027E8307A53522A26DE9148949E4A),
    .INIT_30(256'hD46916EB56981573301E66F2262ED5EA0E774AB96DF566D248B59624BBF8DB73),
    .INIT_31(256'h3B3FE30C935F9F6DBB1DAF854492A58BF9E61E8429E11B690485929DD3A199F6),
    .INIT_32(256'h21EF34FF6EC4C158FD71112A72106FA3B302E55069ADDC7D3CCAA1022989FED0),
    .INIT_33(256'h5FBF800A53DEEFD8545E9D27B351009D0BFB458C08216FA7CC5FFA903C64A16B),
    .INIT_34(256'h38C372EFE0584EC2FAE0BF68DE42B35DC2D6266A9356531CFCE68D6C94C2B0E9),
    .INIT_35(256'h2C43A472413D0A703E4EF911EB7DAA843F95AFF44BDA930D1E1C2812CDF87224),
    .INIT_36(256'hD70F4313E639D0F41DDE9C3080F8165884E66FC2F648661656BFEC059964C40F),
    .INIT_37(256'h515C3420FE843C8F68F951B5E05573291049697285193772EE55867DE63EF212),
    .INIT_38(256'hED24C896118BCEE735A942A518BB18893FAE4050E63DA02704F09502AE61034F),
    .INIT_39(256'h2B7088B45C2B654975F8A4D202153C1956FB32E71E40540F90E0D9CEC263E0C4),
    .INIT_3A(256'h90660F031302E4F3B71089D7A5A85B04C87AF50F7766BEE1B4F8DD9B25A16A3F),
    .INIT_3B(256'hA7F13B23EC41C7D03B220DB37BCFBC22EFBA63D94AA7A57BDE232EB5A0AABD66),
    .INIT_3C(256'hAD6108A1326CA2711089F058DF54418D36E498887C63B08DD6B540339F43E3CA),
    .INIT_3D(256'h4AAA374D2021C6A9BE353F98B167CF86F405BA320E4AB92661E1D087170F180B),
    .INIT_3E(256'hD3EF2B03B701649291B1ADB499641CADAD4FA32A284477E0091884DCB663DE46),
    .INIT_3F(256'h74D4CB0E2BB2ACA978DD6B82BE620B50261F40C22BB06FB4D148CB3FFB6EBB80),
    .INIT_40(256'h8AF059B44F80495CBBA0F35EEAEAD54FEB69FE215A18DD3C6E943505C5AAC388),
    .INIT_41(256'h86C125C39D39B33319528F794C3E5230AE0598BC269A2C35F184AD976B8CCF2E),
    .INIT_42(256'hAEEDB6E56ECE91B6018C91B1FB75F04D8478558ABA0B6EEF73E27A1ACAF8CD60),
    .INIT_43(256'h9FB1723526CAB16E5D291CB680FAF21E06A74E1BA0DAD2E942A6CDBA5F5DEBC0),
    .INIT_44(256'h578B07A44A4B6313B135654314A6EC84A76CE2CC24D4D6290DB595ECB49093BB),
    .INIT_45(256'h0AF9B8B4DFD965393B4B6DF602E43FE41D0504058EE0745BF4AC9BD010028E11),
    .INIT_46(256'hD2FF9D28AF232B5FEFA911610A047D147715E697918D064F814A27A1290A2DC2),
    .INIT_47(256'hF0FB4DB559139C8EB0D48A250D42E80AB94D1CD49320E5F9D1FC98F3F10E11DE),
    .INIT_48(256'h41E7ACFDA3ED2B38A28CECFE54A8A7179402EB38DF328650A62A9E0C48C37547),
    .INIT_49(256'hA3CDB5822F8BA60728EDFFAB992A6F07D6A6C28965E3FE9228B46BC0320E8DAE),
    .INIT_4A(256'h3186F9E638FA77844AAC7B0172DEB26EDFA9B41286083C8C9F5873D1A9D70E7A),
    .INIT_4B(256'hFB80E580878E7882E787E2862181568167F59C7C716CDF92FBE2A73D7AF038D2),
    .INIT_4C(256'hEF958C40EE6CE17301368D6F2BEADFAB6FFD3D9FE1312E0947B9F82B91B6DB23),
    .INIT_4D(256'hD203A4510206E11463D997F34C9E4D7BBD83A02D0EC28327EF17BFC902CCFC30),
    .INIT_4E(256'hAFB504194B232D8ADB7F05B5769933F9D5857E9A82FB56AC193376AF525372A5),
    .INIT_4F(256'h4266AFCF99B8878B54BED3BD926AF19A73E48FAC05877350093CFD58739EA661),
    .INIT_50(256'h0E3F2307EA49029BCDBF03BF96262E985294ECA4746737E3888841AA6A8E7777),
    .INIT_51(256'h2CFC67CEA5410F53FB7AF660F836320E5087D6E92F4798548E128C5D8CA28910),
    .INIT_52(256'h63AAFD2D3D7DA54E9F8F7EE32EF7AE07956A0E1510625DA2036CF3C83C2AFC0C),
    .INIT_53(256'hA5E82FBD4ED646D7B8A83946363C4C3B491BC0A103FCCBBFED7FAE6402D97594),
    .INIT_54(256'hF22566B80148B9D41A7AAB4C6E6861DF82A63DC9F13E10407C082E186F86D1E4),
    .INIT_55(256'h8B89868A8784808A848781888E81838388889BD5074877779BBA0F1C6AE9E1AB),
    .INIT_56(256'h2272DF04AD2A99F2F2AC17DA04DFD25984848E8F818F8E8A85858A808E8F8285),
    .INIT_57(256'h5D64133DA84C1B4B6A71842EC5611CE31925F60D6AB8E69571D9F29727E01799),
    .INIT_58(256'h314B95D550FFBE03011300310E8E697144CE953F2CF42A72EF267A232858AB66),
    .INIT_59(256'hE26BB1E168702B04DF7775D52A59D1F2C8E47A385D029F820369950F39D1FCF4),
    .INIT_5A(256'h21D9C7E68080999EDE99808065B68779EC6184A1D69F407323973CD1D51EA28E),
    .INIT_5B(256'hFCF3CD4E08119CDDF5406D75E2AA65942667700DE515384D855060DE86A5BCAF),
    .INIT_5C(256'hEBC09E8F0C46A9823088A66FFC865CE6165964A0C8BF00FEF0B40873F0883A28),
    .INIT_5D(256'h833DF8405702EC07858BF5C64E3AFD8E6F440FA1566262AFE0DA41CCA75E65A6),
    .INIT_5E(256'hB0B3AF3773B00F1AF75C87C11CF25D98D71B6E4615417413D4702BB40BC08F43),
    .INIT_5F(256'h2B5F1E3105EFCE6E548EC4C0AC58552AEFC05869BD59E38874B8CF9AC90E45DE),
    .INIT_60(256'h72457F7FD8E6785EA5FC8A1D8080CDBACCD467824F319F0969E9349DE7427E26),
    .INIT_61(256'h0BA63757FA800F85A9725EFC981AC4BA32715F1BE7BED9902C4160937C593170),
    .INIT_62(256'hE87F477F047F697F347FA47F8D7FA87F8EE0F520AB3B4477D6BFB6157BDF41F2),
    .INIT_63(256'h153805168FF056455977EEA4BBBF229C0FCADD6A7C9C3269FFFF3B7537B37D2E),
    .INIT_64(256'h0E22D55654EDEFA3FF2AF066CED2040E02B38F55BCBEFDA7EAAD4D017418DF2D),
    .INIT_65(256'hB2E6C11ADD3491769915155B01B4BD8E95AA49C3F3BD7CB19824FC51CF53AFFA),
    .INIT_66(256'hE3F6959040413C49EE8EA13C9C009E422C8BA22D968742CFC02ECF6CF1FC1681),
    .INIT_67(256'hDD3FE57F1360097F5C395A7FF34C247F52667F7F8080BF9593228080808063DD),
    .INIT_68(256'h076A0B7F38F29E7F4B4F7C7F354D6C7F9D54917F7B04807F9B12607FA9D8527F),
    .INIT_69(256'h956D11AE6E18BA2E29EC643BFA653003F49D587FC4C11C7F26C6907F66AB9C7F),
    .INIT_6A(256'hF8936660E6B56BC7F965BC7C708CA0222F99CF335CF4D0B1A45E07E1FFFF3FAE),
    .INIT_6B(256'h7657479054AF5403D437ADB81F242F58CF273B5C62924619E5167AE63F903CF4),
    .INIT_6C(256'hE1ACFB374438C3EF7EC0195567CFD2F8ED01DFDD0AA1121CC86445A9DD79BA90),
    .INIT_6D(256'h000000000000000000000000000000007E94631C9B853F437F342829A6DE8DE8),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module blk_mem_gen_0_blk_mem_gen_prim_wrapper_init__parameterized6
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [15:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [15:0]s_axi_wdata;
  input [1:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [15:0]s_axi_rdata;
  wire [15:0]s_axi_wdata;
  wire [1:0]s_axi_wstrb;
  wire sleep;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h73787AA376D2740B7FC27581751C766A580047ABD1BF77B16B10EFAEE6DB10FE),
    .INIT_01(256'hC046F665F08D2D748888C78641A677779C2AD2EFD3A7D08F1BD262F70D17AC9F),
    .INIT_02(256'hFBC605FEED51B7477E17BC376B77DEF7A2B90A100228CA809F429DC3BC969FDD),
    .INIT_03(256'h7BE7780775C7748774977147775775778888498F8B2F77778E3320A155EE6E1F),
    .INIT_04(256'h979EA3F59137FF7A8CF501AC70B045077EE771F777F775E77197770770077127),
    .INIT_05(256'h9153A395B33278852B6D3D51FADFCEB1189C26ED80801287209D8080B7CC1C87),
    .INIT_06(256'h4ABA85DA346A157B2CDCE7DB25426320C0830B791E63A8DCAB97276AC6938506),
    .INIT_07(256'h04EEA27DCFD8AA6CC515C12720E4FB55590B3935EEB59A633A48FDAB15E0A50B),
    .INIT_08(256'hB0B7C8E314EA6CA2839B34D4DE467EF1DBF37F7F5DE4C62B4FC505F980806258),
    .INIT_09(256'h60BDADB4916CFFE4E3490571E20613736095CA3B9295BDC2B18F5FB89C9C0385),
    .INIT_0A(256'h990D2F5D49C02CF7D20024544486890B26F2B7D2C70AE7318C8DF06B9DE1CEC7),
    .INIT_0B(256'h9EE97F7F80800DDDB09980808080031F4A5D71086A4C17ED8B6D17C57A6F2FF9),
    .INIT_0C(256'hB5E1119777F885A40EA827DEA9B60F01898B8E094E968ED91984A392B20ADF90),
    .INIT_0D(256'h272ECB126EE7520F46D914366B70B02C4A825DA646CFFD7CB7FFB4B245464BD6),
    .INIT_0E(256'h9D795CB610BDDBCEAFAADBDFB596DE86971FB441EE5E741B0EF46A2A830B39EF),
    .INIT_0F(256'hADA79A7B36AF38A300F6810B3A4921A2A826968537E2212A062019BFBCA03A6A),
    .INIT_10(256'hAD3BB04332B2C2EE469FAF7C986A48750655CA9FA6569D13B9361E9B111512ED),
    .INIT_11(256'h40FD02F00B582757C4B4A8A617D787FF0163B0959EDA387C054D18B3940DC54C),
    .INIT_12(256'hAC4E46E3ACF2CDBFCDD383E3C87736C5A087A520A48F4ABB3F1701143013C99E),
    .INIT_13(256'h335802593085147042338F1926AF0E0F80D89E812077AEE285270EE12E4ABB8E),
    .INIT_14(256'h8474086782CE256C3A5C09CCBB99AFE3C8AF364D3680B02A81AB0AA6430238D5),
    .INIT_15(256'hA4DB0025092E12FB36549EAEA90A215F29D429E90C679736966BBB91A1DB8592),
    .INIT_16(256'h8B25959E1878AC2922452D351D674243CDEE8E7104EFA64FBEEE00258CD54251),
    .INIT_17(256'h0FAA909B49BC18E4CED382AB40BA28A4AA4F0726997DB8BC4EC915F049CE1FAF),
    .INIT_18(256'h4DBF950337FECFA497AA9C71C6AA08E3A2AD1CD01CD13AF43AC8AB8303FC00D2),
    .INIT_19(256'h1240B63338F92E6BAB91C4D7384EBE6D18D7377D11263C3F1B26A49F11890E4A),
    .INIT_1A(256'hA851A7C7045BBB96010F06E88B318C70442700B11F2CAABF301A2821017508A3),
    .INIT_1B(256'h164F251F20D9B6D8848D407A35F01B92A25F3F51462E0D3F2490C1FE09ED92D8),
    .INIT_1C(256'hB49F885E0F761F43A08912270358CC34AF4237044DF1909FA8ABA98F9A998BF1),
    .INIT_1D(256'h180EC93819F613BE15E84003C3D708B0C7A6C565BBD0A7C7C32693AB46F98C63),
    .INIT_1E(256'h222CA1D42E789BEF07670A38A8D70E3DAC5BB9BC886B0432A395A9F600DC1188),
    .INIT_1F(256'hCDC93AD047FDB946CE5C87520FE4C903490C951B8EA480D80890CF5C8789A931),
    .INIT_20(256'h8758A852AD00185B14984AFBAB5EA2951E311E758BB626CEA9DF8F171EA30D36),
    .INIT_21(256'hC0564F5408719588C2844BD436D6BEB92AD393C43C0D8AE219972C1B2C913537),
    .INIT_22(256'h1CE3171547C92E9DC77A9AA4463727BA3DB7C74E1360230EAA900DA83CF047DF),
    .INIT_23(256'h97EB9963C51C52D985580F0BD00009E68DC98978AAB2A5641D275E6FCF97DE8B),
    .INIT_24(256'hDD77B1642FBC28650185079F2A19A9D0582A0D3E45740D5B122A9361C6DB5B62),
    .INIT_25(256'h29F718FF33C681545B7DD3682861B9EAD757DE67A61C358C49A0253132401C45),
    .INIT_26(256'h5650C03DD3398C3827D98D762CA639299F4A3AFC8D5937EA2DAB4B5951D58354),
    .INIT_27(256'h8FED5320BA468AD4A595C204AB7D0F8138C0BA2046138A261887C5650CD78D19),
    .INIT_28(256'hBE3958EE56EC07B1AA730E615858844E153A23EA809658BE22F64B3AC7E3D70E),
    .INIT_29(256'hBB73871D848DD23FACD210DB8B32DA023B4D84978C7C88538FF850C8CFDBD891),
    .INIT_2A(256'h43F2B8872FFBCF6B3E7695C256130470A15DB593D7D3B78D514E192636DE9C28),
    .INIT_2B(256'hBEC4975CD91C9A3F85228333DED556350C5EDC963BCC56B9B17E8EC9D323AE96),
    .INIT_2C(256'h13FE443F0A7399ED5A08A1DE98DFBDF11F4CA84A96355AFFC243B87E3B284D9D),
    .INIT_2D(256'hC87D3AAB0FF847F2119FC0A0DCD42B563BB5B739D08F95D3563434282554BBD5),
    .INIT_2E(256'h2F0897AD4D5C3300368C98A306E4300043D5D49B1E2E3DE11486115D46E3B07C),
    .INIT_2F(256'h9A749BE11A8B1ED2A0895E6CC430C13A4B8C9ED30302290E4551B636AA4CC6A6),
    .INIT_30(256'hD1CB4B7DDCDB9E08A3DF523E13F80D8EAF9139AE4DE39C115E943D56386D5945),
    .INIT_31(256'hC64351ED247AC7D89EF0D43B39C2BD1E3FD7936AC00A1DC431405CEF008A06F8),
    .INIT_32(256'hC7D34E041A86136F15B58A943BEB1492995F0B215CEA2B0E51A0994BACDFBF9F),
    .INIT_33(256'h08531C1C82DC1C02AE0CA0BE1B07CE4E844326653FF420019862A8039BF78D0B),
    .INIT_34(256'h19EF96B43E4480BBAB565562476DD140940E4A839E1FBF63C4C092989D61348D),
    .INIT_35(256'hBCAA24CC1C0E92D3D5F65735A44A8171150326599AF697FB3FF7CD99D84D2EEE),
    .INIT_36(256'hC4DE5567838ABC9A00C61DD9AE038E9440178D0D04CFC8552FA6ADE4411F5319),
    .INIT_37(256'h46B543B8B115B9EAC92DBBCA329701F828C6DA9DD4A2B522ADE5272CDD60BEEB),
    .INIT_38(256'h1E72C9599F46D15098AF9B5553EB17E89770194E80A9A06E33DBAD6BBAFC81BD),
    .INIT_39(256'h0062C2F516FE3CBB879E4DD9B0BF006883BD4B840C175E04A07BCAE9A826A820),
    .INIT_3A(256'h03083532854C38A593D63AD1B63117E9194A4F8682F2CA1EC395B2A108858D78),
    .INIT_3B(256'hA7630E66D4428B658A25AB5B39622613C5AE2720B898927A145C905A30CE5E58),
    .INIT_3C(256'h95E9A8E5951BD12847F28FD926A7480CBFCC13C7528DB06693D7AB3225E00129),
    .INIT_3D(256'h2D65A4800BD1138F8527B44F48476235DE43B6004768BC698F46A83BD8932119),
    .INIT_3E(256'h9FFE337381561257B3DFD7460D7BB503A564D68B9B642455585ECAB7B0BAA478),
    .INIT_3F(256'hA7A9CEC10DF8DD81BEA9BB5C8C6ED51ECDBA9BC0898627271F77279F1A538A20),
    .INIT_40(256'h1B445542B4A3AE59DD4C5A7F9BA611BE22B62472BC8F0F2D15B2D1E0C73789B4),
    .INIT_41(256'h532DD9518DCE91D390B2BF83348C81D291FD5382394DD64DC9891BFD1D1E850C),
    .INIT_42(256'h266AB5423E42CC3E37B6BBB1DDD0C74EB1DC343751B01DD8A3A6A1B335953BFB),
    .INIT_43(256'h934F57CEB644DB7A11C246BA9C3754C7AD4C06A09C628B9D3B40B77D151E9ED9),
    .INIT_44(256'h529941079C59BF925E6BB8645B2ED64D4F1C03E83440145EB0BB163C9621268C),
    .INIT_45(256'h43A00E5014E226702E61978B464EA833B0C5AFA45DFD84AADC5C3C7AD84132E0),
    .INIT_46(256'h44D20B481EAC0DD753D2C0F55CCCA09B25568FA604679F8BAF4202229CB89126),
    .INIT_47(256'h875AA606C8983024C8325D21C153DA77DC51A6232B30C5DFAFE8CE05A0E728DA),
    .INIT_48(256'h52A5950A40C257D5380FC2053067AFBC21455D440A974ED598D8B37997AB4C30),
    .INIT_49(256'hD424B806A7E0193327E1BC5DD0A294D81CB637DBD14CDE5A82F8DEC11F3BC5E7),
    .INIT_4A(256'h049FC2869D2E863B3C423103021783D4D7EFD2D9CE4ECD38049E52E921EEB572),
    .INIT_4B(256'h77BB77C17C5F7B5970B97B047B2C7BDD2BE191EE7A09DE8BFCB39B47C95446C8),
    .INIT_4C(256'h7A1C523B474693597471C2E6BFD6AABEE93366636A93D881F0253C250F687AD8),
    .INIT_4D(256'hF1A3AE3D18F271EF99953ED5AC98EC44E97252D2388499548FDC12217593B23E),
    .INIT_4E(256'h39C7EC1C3DDE1D729C0CAEC9AB4B7872B51B06E8ABD713F6FF44FAD7E1F037AA),
    .INIT_4F(256'h961A1FD143369C6C6374A7B31885F80EA1C7129CE26B5FD1E37769D847D47EE0),
    .INIT_50(256'hB20DD4815249A39EE29980BBA40542099A7E6C973965FB5F88887861AF107777),
    .INIT_51(256'h56A09D1ACF3CDB297BA95820B8B52F83EF1B300ECDB78C0B494719B749175517),
    .INIT_52(256'h2072E9F16D34C8027DE58BAC38E6B8F24073720C1C7485858254D35BBD95DAAA),
    .INIT_53(256'h2E33032A3556304B36EE8F0581D073209219378E839AAAF4E78499E1DE926851),
    .INIT_54(256'h2F45F6C34AB01D94B2E5ADF9189B4A17141DD80F59080C4381AA178DFA4AEBDA),
    .INIT_55(256'h77F772A773B77A277ED775877E2775378888C7EDAC4977777C793AE328F0531C),
    .INIT_56(256'hC9613A270351B5C207234363E5D8A4D17FE7733770C77BB7794772E77FE77E57),
    .INIT_57(256'hD7F0F8E4EBE38A1E1703E303B19771373332517443F207F944268D0C35A99FA7),
    .INIT_58(256'hC01C42400FA940728B349EB0CBD8726EA25022CD62538E5CCC94058864F314EE),
    .INIT_59(256'hE4FD06AF3D628235E1B810406A02CC93B150289EBE934243D729794AE56B8985),
    .INIT_5A(256'h0620A4C18080C5DE11F9808052045C47D988202FF89C3B2F7AB6CC880DD32FEA),
    .INIT_5B(256'hDCF1112C5E651B1DF65780050083E017766C0761A2490CB571C9D274875B0069),
    .INIT_5C(256'hC354C3F48768948466F3485622532509DB0288E11BED397A8BF3405759428BE0),
    .INIT_5D(256'h1102846AF0E524568D019F44EC92AC10A1BD429B69BD7177CFFBD642823EC86F),
    .INIT_5E(256'h62869B0D68066F0B5A1E09111A7C7610861C97BA7A8CB74D7D45E5D9412D9FA9),
    .INIT_5F(256'h200C8E67C2C17CCAE16D74F2FE8346961885F7FDF67A7DDABFA71BA7AE8062B6),
    .INIT_60(256'h632D7F7F81BE952FA1AA42308080AD6BA43CEB7585F661067A7948A19267253A),
    .INIT_61(256'hEBCA3C2C3C0665D35543A8FBD7704653DBDFA1529002AF2A739874802266F118),
    .INIT_62(256'hF8F5A2CE0962777E365A6CE5DA27A9E1804BB14B9964D2BF80EA9E0B953F58EA),
    .INIT_63(256'h7849DE666DB979AB426A39F159EAF62B6E9E89BAC037D9177FFF52A3280ABD63),
    .INIT_64(256'hB774DE26C7F5D9C6383F441A4110A9B7F2E5163B197D256A8B57476C88CFA135),
    .INIT_65(256'h1D58F299085010840D4B2468779D05D2373F5421411514411CC321EAD5E620D1),
    .INIT_66(256'h3A10C912CDE8D0FCE430649FCC7792AF86BF9FF2F97A87D8B6E9430AFA647A65),
    .INIT_67(256'hAD19EFF593C87C9E316BB19CAD5B2DC965F57F7F80800BA21698808080800E06),
    .INIT_68(256'h6996AD33F4DF645DA1F168A034F9EE40B902964A849860F90D36F5AB0C63B99D),
    .INIT_69(256'h08EA8EAD35BE6E406B04CEA35A1052D7F9126C34DCD32BD361942A1F22507508),
    .INIT_6A(256'hFB0E6B349D5F5B715A30FE40168AEF3B20BA11487CF8468DAD949C197FFF0196),
    .INIT_6B(256'h34A5AE0EB4336054702BFFF3C14F62571ED5785D9D0697FAAC02079C81D0356A),
    .INIT_6C(256'h10E7135F9164020AFC1807BD88B4CEAF9AE9866470547D2ACD8D842D27953E58),
    .INIT_6D(256'h00000000000000000000000000000000B9803C360FD9D86042E8125437759F32),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({ADDRARDADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({ADDRBWRADDR,1'b0,1'b0,1'b0,1'b0}),
        .ADDRENA(1'b0),
        .ADDRENB(1'b0),
        .CASDIMUXA(1'b0),
        .CASDIMUXB(1'b0),
        .CASDINA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASDINPA({1'b0,1'b0,1'b0,1'b0}),
        .CASDINPB({1'b0,1'b0,1'b0,1'b0}),
        .CASDOMUXA(1'b0),
        .CASDOMUXB(1'b0),
        .CASDOMUXEN_A(1'b0),
        .CASDOMUXEN_B(1'b0),
        .CASDOUTA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTA_UNCONNECTED [31:0]),
        .CASDOUTB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTB_UNCONNECTED [31:0]),
        .CASDOUTPA(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPA_UNCONNECTED [3:0]),
        .CASDOUTPB(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASDOUTPB_UNCONNECTED [3:0]),
        .CASINDBITERR(1'b0),
        .CASINSBITERR(1'b0),
        .CASOREGIMUXA(1'b0),
        .CASOREGIMUXB(1'b0),
        .CASOREGIMUXEN_A(1'b0),
        .CASOREGIMUXEN_B(1'b0),
        .CASOUTDBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTDBITERR_UNCONNECTED ),
        .CASOUTSBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASOUTSBITERR_UNCONNECTED ),
        .CLKARDCLK(s_aclk),
        .CLKBWRCLK(s_aclk),
        .DBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DINADIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .DINBDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DINPADINP({1'b0,1'b0,1'b0,1'b0}),
        .DINPBDINP({1'b0,1'b0,1'b0,1'b0}),
        .DOUTADOUT(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTADOUT_UNCONNECTED [31:0]),
        .DOUTBDOUT({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTBDOUT_UNCONNECTED [31:16],s_axi_rdata}),
        .DOUTPADOUTP(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPADOUTP_UNCONNECTED [3:0]),
        .DOUTPBDOUTP({\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOUTPBDOUTP_UNCONNECTED [3:2],\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_146 ,\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_147 }),
        .ECCPARITY(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ECCPIPECE(1'b0),
        .ENARDEN(\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .ENBWREN(E),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(SS),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .SLEEP(sleep),
        .WEA({1'b0,1'b0,s_axi_wstrb}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module blk_mem_gen_0_blk_mem_gen_top
   (s_axi_rdata,
    s_aclk,
    \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    E,
    SS,
    sleep,
    ADDRARDADDR,
    ADDRBWRADDR,
    s_axi_wdata,
    s_axi_wstrb);
  output [127:0]s_axi_rdata;
  input s_aclk;
  input \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [0:0]E;
  input [0:0]SS;
  input sleep;
  input [10:0]ADDRARDADDR;
  input [10:0]ADDRBWRADDR;
  input [127:0]s_axi_wdata;
  input [15:0]s_axi_wstrb;

  wire [10:0]ADDRARDADDR;
  wire [10:0]ADDRBWRADDR;
  wire \DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [0:0]E;
  wire [0:0]SS;
  wire s_aclk;
  wire [127:0]s_axi_rdata;
  wire [127:0]s_axi_wdata;
  wire [15:0]s_axi_wstrb;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_generic_cstr \valid.cstr 
       (.ADDRARDADDR(ADDRARDADDR),
        .ADDRBWRADDR(ADDRBWRADDR),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .E(E),
        .SS(SS),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
endmodule

(* C_ADDRA_WIDTH = "11" *) (* C_ADDRB_WIDTH = "11" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "8" *) (* C_COMMON_CLK = "1" *) (* C_COUNT_18K_BRAM = "0" *) 
(* C_COUNT_36K_BRAM = "8" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     31.967058 mW" *) 
(* C_FAMILY = "virtexuplus" *) (* C_HAS_AXI_ID = "1" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "1" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "1" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
(* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) (* C_INTERFACE_TYPE = "1" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "1" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "1752" *) (* C_READ_DEPTH_B = "1752" *) (* C_READ_LATENCY_A = "1" *) 
(* C_READ_LATENCY_B = "1" *) (* C_READ_WIDTH_A = "128" *) (* C_READ_WIDTH_B = "128" *) 
(* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) (* C_RST_PRIORITY_A = "CE" *) 
(* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) (* C_USE_BRAM_BLOCK = "0" *) 
(* C_USE_BYTE_WEA = "1" *) (* C_USE_BYTE_WEB = "1" *) (* C_USE_DEFAULT_DATA = "1" *) 
(* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) (* C_USE_URAM = "0" *) 
(* C_WEA_WIDTH = "16" *) (* C_WEB_WIDTH = "16" *) (* C_WRITE_DEPTH_A = "1752" *) 
(* C_WRITE_DEPTH_B = "1752" *) (* C_WRITE_MODE_A = "READ_FIRST" *) (* C_WRITE_MODE_B = "READ_FIRST" *) 
(* C_WRITE_WIDTH_A = "128" *) (* C_WRITE_WIDTH_B = "128" *) (* C_XDEVICEFAMILY = "virtexuplus" *) 
(* ORIG_REF_NAME = "blk_mem_gen_v8_4_2" *) (* downgradeipidentifiedwarnings = "yes" *) 
module blk_mem_gen_0_blk_mem_gen_v8_4_2
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [15:0]wea;
  input [10:0]addra;
  input [127:0]dina;
  output [127:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [15:0]web;
  input [10:0]addrb;
  input [127:0]dinb;
  output [127:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [10:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [127:0]s_axi_wdata;
  input [15:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [127:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [10:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire s_aclk;
  wire s_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [127:0]s_axi_rdata;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [127:0]s_axi_wdata;
  wire s_axi_wready;
  wire [15:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire sleep;

  assign dbiterr = \<const0> ;
  assign douta[127] = \<const0> ;
  assign douta[126] = \<const0> ;
  assign douta[125] = \<const0> ;
  assign douta[124] = \<const0> ;
  assign douta[123] = \<const0> ;
  assign douta[122] = \<const0> ;
  assign douta[121] = \<const0> ;
  assign douta[120] = \<const0> ;
  assign douta[119] = \<const0> ;
  assign douta[118] = \<const0> ;
  assign douta[117] = \<const0> ;
  assign douta[116] = \<const0> ;
  assign douta[115] = \<const0> ;
  assign douta[114] = \<const0> ;
  assign douta[113] = \<const0> ;
  assign douta[112] = \<const0> ;
  assign douta[111] = \<const0> ;
  assign douta[110] = \<const0> ;
  assign douta[109] = \<const0> ;
  assign douta[108] = \<const0> ;
  assign douta[107] = \<const0> ;
  assign douta[106] = \<const0> ;
  assign douta[105] = \<const0> ;
  assign douta[104] = \<const0> ;
  assign douta[103] = \<const0> ;
  assign douta[102] = \<const0> ;
  assign douta[101] = \<const0> ;
  assign douta[100] = \<const0> ;
  assign douta[99] = \<const0> ;
  assign douta[98] = \<const0> ;
  assign douta[97] = \<const0> ;
  assign douta[96] = \<const0> ;
  assign douta[95] = \<const0> ;
  assign douta[94] = \<const0> ;
  assign douta[93] = \<const0> ;
  assign douta[92] = \<const0> ;
  assign douta[91] = \<const0> ;
  assign douta[90] = \<const0> ;
  assign douta[89] = \<const0> ;
  assign douta[88] = \<const0> ;
  assign douta[87] = \<const0> ;
  assign douta[86] = \<const0> ;
  assign douta[85] = \<const0> ;
  assign douta[84] = \<const0> ;
  assign douta[83] = \<const0> ;
  assign douta[82] = \<const0> ;
  assign douta[81] = \<const0> ;
  assign douta[80] = \<const0> ;
  assign douta[79] = \<const0> ;
  assign douta[78] = \<const0> ;
  assign douta[77] = \<const0> ;
  assign douta[76] = \<const0> ;
  assign douta[75] = \<const0> ;
  assign douta[74] = \<const0> ;
  assign douta[73] = \<const0> ;
  assign douta[72] = \<const0> ;
  assign douta[71] = \<const0> ;
  assign douta[70] = \<const0> ;
  assign douta[69] = \<const0> ;
  assign douta[68] = \<const0> ;
  assign douta[67] = \<const0> ;
  assign douta[66] = \<const0> ;
  assign douta[65] = \<const0> ;
  assign douta[64] = \<const0> ;
  assign douta[63] = \<const0> ;
  assign douta[62] = \<const0> ;
  assign douta[61] = \<const0> ;
  assign douta[60] = \<const0> ;
  assign douta[59] = \<const0> ;
  assign douta[58] = \<const0> ;
  assign douta[57] = \<const0> ;
  assign douta[56] = \<const0> ;
  assign douta[55] = \<const0> ;
  assign douta[54] = \<const0> ;
  assign douta[53] = \<const0> ;
  assign douta[52] = \<const0> ;
  assign douta[51] = \<const0> ;
  assign douta[50] = \<const0> ;
  assign douta[49] = \<const0> ;
  assign douta[48] = \<const0> ;
  assign douta[47] = \<const0> ;
  assign douta[46] = \<const0> ;
  assign douta[45] = \<const0> ;
  assign douta[44] = \<const0> ;
  assign douta[43] = \<const0> ;
  assign douta[42] = \<const0> ;
  assign douta[41] = \<const0> ;
  assign douta[40] = \<const0> ;
  assign douta[39] = \<const0> ;
  assign douta[38] = \<const0> ;
  assign douta[37] = \<const0> ;
  assign douta[36] = \<const0> ;
  assign douta[35] = \<const0> ;
  assign douta[34] = \<const0> ;
  assign douta[33] = \<const0> ;
  assign douta[32] = \<const0> ;
  assign douta[31] = \<const0> ;
  assign douta[30] = \<const0> ;
  assign douta[29] = \<const0> ;
  assign douta[28] = \<const0> ;
  assign douta[27] = \<const0> ;
  assign douta[26] = \<const0> ;
  assign douta[25] = \<const0> ;
  assign douta[24] = \<const0> ;
  assign douta[23] = \<const0> ;
  assign douta[22] = \<const0> ;
  assign douta[21] = \<const0> ;
  assign douta[20] = \<const0> ;
  assign douta[19] = \<const0> ;
  assign douta[18] = \<const0> ;
  assign douta[17] = \<const0> ;
  assign douta[16] = \<const0> ;
  assign douta[15] = \<const0> ;
  assign douta[14] = \<const0> ;
  assign douta[13] = \<const0> ;
  assign douta[12] = \<const0> ;
  assign douta[11] = \<const0> ;
  assign douta[10] = \<const0> ;
  assign douta[9] = \<const0> ;
  assign douta[8] = \<const0> ;
  assign douta[7] = \<const0> ;
  assign douta[6] = \<const0> ;
  assign douta[5] = \<const0> ;
  assign douta[4] = \<const0> ;
  assign douta[3] = \<const0> ;
  assign douta[2] = \<const0> ;
  assign douta[1] = \<const0> ;
  assign douta[0] = \<const0> ;
  assign doutb[127] = \<const0> ;
  assign doutb[126] = \<const0> ;
  assign doutb[125] = \<const0> ;
  assign doutb[124] = \<const0> ;
  assign doutb[123] = \<const0> ;
  assign doutb[122] = \<const0> ;
  assign doutb[121] = \<const0> ;
  assign doutb[120] = \<const0> ;
  assign doutb[119] = \<const0> ;
  assign doutb[118] = \<const0> ;
  assign doutb[117] = \<const0> ;
  assign doutb[116] = \<const0> ;
  assign doutb[115] = \<const0> ;
  assign doutb[114] = \<const0> ;
  assign doutb[113] = \<const0> ;
  assign doutb[112] = \<const0> ;
  assign doutb[111] = \<const0> ;
  assign doutb[110] = \<const0> ;
  assign doutb[109] = \<const0> ;
  assign doutb[108] = \<const0> ;
  assign doutb[107] = \<const0> ;
  assign doutb[106] = \<const0> ;
  assign doutb[105] = \<const0> ;
  assign doutb[104] = \<const0> ;
  assign doutb[103] = \<const0> ;
  assign doutb[102] = \<const0> ;
  assign doutb[101] = \<const0> ;
  assign doutb[100] = \<const0> ;
  assign doutb[99] = \<const0> ;
  assign doutb[98] = \<const0> ;
  assign doutb[97] = \<const0> ;
  assign doutb[96] = \<const0> ;
  assign doutb[95] = \<const0> ;
  assign doutb[94] = \<const0> ;
  assign doutb[93] = \<const0> ;
  assign doutb[92] = \<const0> ;
  assign doutb[91] = \<const0> ;
  assign doutb[90] = \<const0> ;
  assign doutb[89] = \<const0> ;
  assign doutb[88] = \<const0> ;
  assign doutb[87] = \<const0> ;
  assign doutb[86] = \<const0> ;
  assign doutb[85] = \<const0> ;
  assign doutb[84] = \<const0> ;
  assign doutb[83] = \<const0> ;
  assign doutb[82] = \<const0> ;
  assign doutb[81] = \<const0> ;
  assign doutb[80] = \<const0> ;
  assign doutb[79] = \<const0> ;
  assign doutb[78] = \<const0> ;
  assign doutb[77] = \<const0> ;
  assign doutb[76] = \<const0> ;
  assign doutb[75] = \<const0> ;
  assign doutb[74] = \<const0> ;
  assign doutb[73] = \<const0> ;
  assign doutb[72] = \<const0> ;
  assign doutb[71] = \<const0> ;
  assign doutb[70] = \<const0> ;
  assign doutb[69] = \<const0> ;
  assign doutb[68] = \<const0> ;
  assign doutb[67] = \<const0> ;
  assign doutb[66] = \<const0> ;
  assign doutb[65] = \<const0> ;
  assign doutb[64] = \<const0> ;
  assign doutb[63] = \<const0> ;
  assign doutb[62] = \<const0> ;
  assign doutb[61] = \<const0> ;
  assign doutb[60] = \<const0> ;
  assign doutb[59] = \<const0> ;
  assign doutb[58] = \<const0> ;
  assign doutb[57] = \<const0> ;
  assign doutb[56] = \<const0> ;
  assign doutb[55] = \<const0> ;
  assign doutb[54] = \<const0> ;
  assign doutb[53] = \<const0> ;
  assign doutb[52] = \<const0> ;
  assign doutb[51] = \<const0> ;
  assign doutb[50] = \<const0> ;
  assign doutb[49] = \<const0> ;
  assign doutb[48] = \<const0> ;
  assign doutb[47] = \<const0> ;
  assign doutb[46] = \<const0> ;
  assign doutb[45] = \<const0> ;
  assign doutb[44] = \<const0> ;
  assign doutb[43] = \<const0> ;
  assign doutb[42] = \<const0> ;
  assign doutb[41] = \<const0> ;
  assign doutb[40] = \<const0> ;
  assign doutb[39] = \<const0> ;
  assign doutb[38] = \<const0> ;
  assign doutb[37] = \<const0> ;
  assign doutb[36] = \<const0> ;
  assign doutb[35] = \<const0> ;
  assign doutb[34] = \<const0> ;
  assign doutb[33] = \<const0> ;
  assign doutb[32] = \<const0> ;
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign rdaddrecc[10] = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  blk_mem_gen_0_blk_mem_gen_v8_4_2_synth inst_blk_mem_gen
       (.S_AXI_RVALID(s_axi_rvalid),
        .\gaxi_bvalid_id_r.bvalid_r_reg (s_axi_bvalid),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_araddr(s_axi_araddr[14:0]),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arid(s_axi_arid),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr[14:0]),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awid(s_axi_awid),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(s_axi_bid),
        .s_axi_bready(s_axi_bready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(s_axi_rid),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .sleep(sleep));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_4_2_synth" *) 
module blk_mem_gen_0_blk_mem_gen_v8_4_2_synth
   (S_AXI_RVALID,
    s_axi_rdata,
    s_axi_awready,
    s_axi_wready,
    s_axi_arready,
    s_axi_rlast,
    s_axi_rid,
    s_axi_bid,
    \gaxi_bvalid_id_r.bvalid_r_reg ,
    s_axi_awvalid,
    s_aresetn,
    s_axi_wvalid,
    s_axi_rready,
    s_axi_arvalid,
    s_axi_arlen,
    s_axi_awsize,
    s_axi_arsize,
    s_axi_araddr,
    s_aclk,
    sleep,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_arid,
    s_axi_awid,
    s_axi_bready,
    s_axi_awburst,
    s_axi_awlen,
    s_axi_awaddr,
    s_axi_arburst);
  output S_AXI_RVALID;
  output [127:0]s_axi_rdata;
  output s_axi_awready;
  output s_axi_wready;
  output s_axi_arready;
  output s_axi_rlast;
  output [3:0]s_axi_rid;
  output [3:0]s_axi_bid;
  output \gaxi_bvalid_id_r.bvalid_r_reg ;
  input s_axi_awvalid;
  input s_aresetn;
  input s_axi_wvalid;
  input s_axi_rready;
  input s_axi_arvalid;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_awsize;
  input [2:0]s_axi_arsize;
  input [14:0]s_axi_araddr;
  input s_aclk;
  input sleep;
  input [127:0]s_axi_wdata;
  input [15:0]s_axi_wstrb;
  input [3:0]s_axi_arid;
  input [3:0]s_axi_awid;
  input s_axi_bready;
  input [1:0]s_axi_awburst;
  input [7:0]s_axi_awlen;
  input [14:0]s_axi_awaddr;
  input [1:0]s_axi_arburst;

  wire S_AXI_RVALID;
  wire \gaxi_bvalid_id_r.bvalid_r_reg ;
  wire \gnbram.gaxibmg.axi_wr_fsm_n_3 ;
  wire s_aclk;
  wire s_aresetn;
  wire s_aresetn_a_c;
  wire [14:0]s_axi_araddr;
  wire [10:0]s_axi_araddr_out_c;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [14:0]s_axi_awaddr;
  wire [10:0]s_axi_awaddr_out_c;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire s_axi_rd_en_c;
  wire [127:0]s_axi_rdata;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [127:0]s_axi_wdata;
  wire s_axi_wready;
  wire [15:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire sleep;

  blk_mem_gen_0_blk_mem_gen_top \gnbram.gaxibmg.axi_blk_mem_gen 
       (.ADDRARDADDR(s_axi_awaddr_out_c),
        .ADDRBWRADDR(s_axi_araddr_out_c),
        .\DEVICE_8SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\gnbram.gaxibmg.axi_wr_fsm_n_3 ),
        .E(s_axi_rd_en_c),
        .SS(s_aresetn_a_c),
        .s_aclk(s_aclk),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .sleep(sleep));
  blk_mem_gen_0_blk_mem_axi_read_wrapper \gnbram.gaxibmg.axi_rd_sm 
       (.ADDRBWRADDR(s_axi_araddr_out_c),
        .E(s_axi_rd_en_c),
        .SS(s_aresetn_a_c),
        .\gaxi_full_sm.r_valid_r_reg (S_AXI_RVALID),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arid(s_axi_arid),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_rid(s_axi_rid),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready));
  blk_mem_gen_0_blk_mem_axi_write_wrapper \gnbram.gaxibmg.axi_wr_fsm 
       (.ADDRARDADDR(s_axi_awaddr_out_c),
        .\FSM_sequential_gaxi_full_sm.present_state_reg[0] (\gnbram.gaxibmg.axi_wr_fsm_n_3 ),
        .SS(s_aresetn_a_c),
        .\gaxi_bvalid_id_r.bvalid_r_reg_0 (\gaxi_bvalid_id_r.bvalid_r_reg ),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awid(s_axi_awid),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(s_axi_bid),
        .s_axi_bready(s_axi_bready),
        .s_axi_wready(s_axi_wready),
        .s_axi_wvalid(s_axi_wvalid));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
