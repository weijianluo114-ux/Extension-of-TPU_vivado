`timescale 1ns / 1ps
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE     
// VSCODE plug-in version: Verilog-Hdl-Format-4.1.20260207
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            Please Write Company name
// All rights reserved     
// File name:              
// Last modified Date:     2026/03/19 20:20:31
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/19 20:20:31
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              carry_bypass_8bit.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\carry_bypass_8bit.v
// Descriptions:           本模块将2个4位进位选择加法器融合并组成8位旁路进位加法器
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module carry_bypass_8bit (
    input [7:0] a,   //8位加数a
    input [7:0] b,   //8位加数b
    input       cin, //低位进位cin

    output [7:0] sum,   //和sum
    output       cout,  //输出进位cout
    output [7:0] g,     //生成（generate）
    output [7:0] p      //传播（propagate）信号
);

  /******************************* 网表信号 ***********************************/

  wire cout_lower;  //低位的输出进位信号
  wire cout_upper;  //高位的输出进位信号

  wire cin_upper;  //高位的输入进位信号

  wire sel_lower;  //低位选择信号
  wire sel_upper;  //高位选择信号

  /******************************* 组合逻辑 ***********************************/
  //mux选择信号的产生
  assign sel_lower = &p[3:0];
  assign sel_upper = &p[7:4];

  //进位旁路的mux
  assign cin_upper = sel_lower ? cin : cout_lower;
  assign cout = sel_upper ? cin_upper : cout_upper;


  /******************************* 模块例化 ***********************************/
  //这里使用mux将2个4位的加法器串联组成8位加法器
  carry_sel_adder_4bit carry_sel_adder_4bit_inst_lower (
      .a(a[3:0]),
      .b(b[3:0]),
      .cin(cin),
      .sum(sum[3:0]),
      .cout(cout_lower),
      .g(g[3:0]),
      .p(p[3:0])
  );

  carry_sel_adder_4bit carry_sel_adder_4bit_inst_upper (
      .a(a[7:4]),
      .b(b[7:4]),
      .cin(cin_upper),
      .sum(sum[7:4]),
      .cout(cout_upper),
      .g(g[7:4]),
      .p(p[7:4])
  );
endmodule
