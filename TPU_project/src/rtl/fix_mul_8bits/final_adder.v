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
// Last modified Date:     2026/03/28 20:03:06
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 20:03:06
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              final_adder.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits\final_adder.v
// Descriptions:           最终得到的32位乘法结果
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module final_adder (
    input  [21:0] sum,
    input  [21:0] carry,
    input  [ 2:0] neg_cnt,  // 负部分积个数 (0~4)
    output [31:0] product
);

    /******************************* 网表信号 ***********************************/
    wire [21:0] sum_carry;

    /******************************* 组合逻辑 ***********************************/
    assign sum_carry = sum + (carry << 1) + neg_cnt;
    assign product   = {{10{sum_carry[21]}}, sum_carry};  // 补高位作为乘积结果
endmodule
