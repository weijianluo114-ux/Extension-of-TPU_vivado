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
// Last modified Date:     2026/03/28 17:35:11
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 17:35:11
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              csa_3to2.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits\csa_3to2.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//
// 3:2 进位保留加法器
module csa_3to2 #(
    parameter WIDTH = 22
) (
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input  [WIDTH-1:0] c,
    output [WIDTH-1:0] s,
    output [WIDTH-1:0] c_out
);

    /******************************* 模块例化 ***********************************/
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : gen_csa
            full_adder full_adder_inst (
                .a   (a[i]),
                .b   (b[i]),
                .c   (c[i]),
                .s   (s[i]),
                .cout(c_out[i])
            );
        end
    endgenerate
endmodule
