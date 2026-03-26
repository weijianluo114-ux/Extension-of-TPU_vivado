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
// Last modified Date:     2026/03/22 17:33:47
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/22 17:33:47
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              fp16_to_fp32.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fp16_to_fp32.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module fp16_to_fp32 (
    input  wire [15:0] half_in,
    output wire [31:0] float_out
);

    wire       sign;
    wire [4:0] exp_half;
    wire [9:0] mant_half;

    assign sign      = half_in[15];
    assign exp_half  = half_in[14:10];
    assign mant_half = half_in[9:0];

    reg     [ 7:0] exp_single;
    reg     [22:0] mant_single;

    integer        shift;
    integer        j;
    reg     [ 9:0] mant_shifted;
    always @(*) begin
        if (exp_half == 5'b00000) begin
            if (mant_half == 0) begin
                // 零：正零或负零
                exp_single  = 8'b00000000;
                mant_single = 23'b0;
            end else begin
                // 非规格数（denormalized）
                // 通过优先编码器归一化，替换for循环
                casez (mant_half)
                    10'b1?????????: shift = 0;
                    10'b01????????: shift = 1;
                    10'b001???????: shift = 2;
                    10'b0001??????: shift = 3;
                    10'b00001?????: shift = 4;
                    10'b000001????: shift = 5;
                    10'b0000001???: shift = 6;
                    10'b00000001??: shift = 7;
                    10'b000000001?: shift = 8;
                    10'b0000000001: shift = 9;
                    default:        shift = 10;
                endcase
                mant_shifted = mant_half << shift;
                exp_single   = 8'd126 - 14 - shift;  // 还原指数并加上移位
                mant_single  = mant_shifted[8:0] << 14;  // 对齐到23位尾数
            end
        end else if (exp_half == 5'b11111) begin
            // 特殊数（Inf or NaN）
            exp_single  = 8'b11111111;
            mant_single = (mant_half == 0) ? 23'b0 : {13'b0, mant_half};  // Inf 或 NaN
        end else begin
            // 规格数
            exp_single  = exp_half - 5'd15 + 8'd127;
            mant_single = mant_half << 13;  // 对齐到23位尾数
        end
    end

    assign float_out = {sign, exp_single, mant_single};

endmodule
