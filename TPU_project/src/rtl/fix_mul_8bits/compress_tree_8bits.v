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
// Last modified Date:     2026/03/28 17:20:01
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 17:20:01
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              compress_tree_8bits.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits\compress_tree_8bits.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module compress_tree_8bits (
    input  [15:0] pp0,
    input  [15:0] pp1,
    input  [15:0] pp2,
    input  [15:0] pp3,
    output [21:0] sum,
    output [21:0] carry
);
    /******************************* 参数 ***********************************/
    // 每个部分积需要左移的位数
    localparam SHIFT0 = 0;
    localparam SHIFT1 = 2;
    localparam SHIFT2 = 4;
    localparam SHIFT3 = 6;

    /******************************* 网表信号 ***********************************/
    // 将16位部分积符号扩展到22位，并左移对应位数
    wire [21:0] pp0_aligned = {{6{pp0[15]}}, pp0} << SHIFT0;
    wire [21:0] pp1_aligned = {{6{pp1[15]}}, pp1} << SHIFT1;
    wire [21:0] pp2_aligned = {{6{pp2[15]}}, pp2} << SHIFT2;
    wire [21:0] pp3_aligned = {{6{pp3[15]}}, pp3} << SHIFT3;

    // 使用进位保留加法器将四个数压缩为两个
    wire [21:0] s1, c1;

    /******************************* 模块例化 ***********************************/
    csa_3to2 #(
        .WIDTH(22)
    ) csa_3to2_inst1 (
        .a    (pp0_aligned),
        .b    (pp1_aligned),
        .c    (pp2_aligned),
        .s    (s1),
        .c_out(c1)
    );

    csa_3to2 #(
        .WIDTH(22)
    ) csa_3to2_inst2 (
        .a    (s1),
        .b    (c1),
        .c    (pp3_aligned),
        .s    (sum),
        .c_out(carry)
    );

endmodule



