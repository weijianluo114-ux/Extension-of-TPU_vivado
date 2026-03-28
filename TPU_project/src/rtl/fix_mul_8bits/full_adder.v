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
// Last modified Date:     2026/03/28 17:34:28
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 17:34:28
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              full_adder.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits\full_adder.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

// 全加器
module full_adder (
    input  a,
    input  b,
    input  c,
    output s,
    output cout
);
    /******************************* 组合逻辑 ***********************************/
    assign s = a ^ b ^ c;
    assign cout = (a & b) | (a & c) | (b & c);
endmodule
