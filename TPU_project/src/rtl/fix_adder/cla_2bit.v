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
// Last modified Date:     2026/03/19 20:41:11
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/19 20:41:11
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              cla_2bit.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\cla_2bit.v
// Descriptions:           该模块是一个2位超前进位加法器       
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module cla_2bit (
    input  [1:0] a,     // 加数A
    input  [1:0] b,     // 加数B
    input        cin,   // 进位输入
    output [1:0] s,     // 和
    output       cout,  // 进位输出
    output [1:0] g,     //生成（generate）
    output [1:0] p      //传播（propagate）信号
);

  /*************************************** 信号 ********************************/
  // 进位计算
  wire c;

  /****************************************** 组合逻辑 ****************************************/
  assign g = a & b;
  assign p = a ^ b;

  // 第1位（最低位）产生的进位
  assign c = g[0] | (p[0] & cin);
  assign cout = g[1] | (p[1] & c);

  // 和计算
  assign s[0] = p[0] ^ cin;
  assign s[1] = p[1] ^ c;

endmodule
