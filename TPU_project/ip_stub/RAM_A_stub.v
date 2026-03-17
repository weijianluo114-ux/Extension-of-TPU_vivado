// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Jul 13 05:14:56 2025
// Host        : Simple running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/electronic2/IC_bisai_jichuangsai/zhon_ke_xin_bei/fensaiqu_chusai/project/RAM_BRIDGE/RAM_BRIDGE_1.4/RAM_BRIDGE_1.4/RAM_BRIDGE_1.4.srcs/sources_1/ip/RAM_A/RAM_A_stub.v
// Design      : RAM_A
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu9p-flga2104-2L-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module RAM_A(clka, ena, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[4:0],dina[511:0],douta[511:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [4:0]addra;
  input [511:0]dina;
  output [511:0]douta;
endmodule
