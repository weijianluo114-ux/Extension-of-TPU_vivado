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
// Last modified Date:     2026/03/28 16:51:48
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 16:51:48
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              fix_mul_8bits.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits.v
// Descriptions:           8bit3级流水线乘法器
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module fix_mul_8bits (
    input clk,
    input rst_n,

    input [7:0] a,
    input [7:0] b,

    output [31:0] c
);

    booth_encoder_8bits booth_encoder_8bits_inst (
        .b   (b),
        .enc0(enc0),
        .enc1(enc1),
        .enc2(enc2),
        .enc3(enc3)
    );

endmodule
