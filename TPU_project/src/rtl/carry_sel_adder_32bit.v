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
// Last modified Date:     2026/03/26 17:00:17
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/26 17:00:17
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              carry_sel_adder_32bit.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\carry_sel_adder_32bit.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//


module carry_sel_adder_32bit (
    input [31:0] a,   //4位加数a
    input [31:0] b,   //4位加数b
    input        cin, //低位进位cin

    output [31:0] sum,   //和sum
    output        cout,  //输出进位cout
    output [31:0] g,     //生成（generate）
    output [31:0] p      //传播（propagate）信号
);
    /******************************* 网表信号 ***********************************/
    wire        sel;  //进位选择中间信号

    //进位选择的两个输出和信号
    wire [15:0] sum_temp0;
    wire [15:0] sum_temp1;

    //输出进位的两个中间信号
    wire        cout_temp0;
    wire        cout_temp1;

    /******************************* 组合逻辑 ***********************************/
    //首先对输出的和进行选择
    assign sum[31:16] = sel ? sum_temp1 : sum_temp0;
    //再对输出的进位进行选择
    assign cout = sel ? cout_temp1 : cout_temp0;

    /******************************* 模块例化 ***********************************/
    //1个8位的加法器作为低位，2个作为进位选择的高位
    carry_bypass_8bit carry_bypass_8bit_inst_lower (
        .a   (a[15:0]),
        .b   (b[15:0]),
        .cin (cin),
        .sum (sum[15:0]),
        .cout(sel),
        .g   (g[15:0]),
        .p   (p[15:0])
    );

    //进位输入为0
    carry_bypass_8bit carry_bypass_8bit_inst_upper0 (
        .a   (a[31:16]),
        .b   (b[31:16]),
        .cin (1'b0),
        .sum (sum_temp0),
        .cout(cout_temp0),
        .g   (g[31:16]),
        .p   (p[31:16])
    );
    //进位输入为1
    carry_bypass_8bit carry_bypass_8bit_inst_upper1 (
        .a   (a[31:16]),
        .b   (b[31:16]),
        .cin (1'b1),
        .sum (sum_temp1),
        .cout(cout_temp1)
    );


endmodule
