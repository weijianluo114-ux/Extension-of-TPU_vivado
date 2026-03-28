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
// Last modified Date:     2026/03/28 17:09:24
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 17:09:24
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              patial_product_gen_8bits.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits\patial_product_gen_8bits.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module patial_product_gen_8bits (
    input      [ 7:0] a,
    input      [ 2:0] enc0,
    enc1,
    enc2,
    enc3,
    output reg [15:0] pp0,
    pp1,
    pp2,
    pp3,
    output reg        neg0,
    neg1,
    neg2,
    neg3  // 1 表示该部分积为负
);
    /******************************* 网表信号 ***********************************/
    wire [15:0] a_ext = {{8{a[7]}}, a};  // 符号扩展到16位
    wire [15:0] a_ext_shl = {{7{a[7]}}, a, 1'b0};  // 左移1位并符号扩展

    /******************************* 函数 ***********************************/
    function [16:0] gen_pp;  //注意这里最高位用于存储符号位，0表示正，1表示负
        input [2:0] enc;
        input [15:0] a_ext;
        input [15:0] a_ext_shl;
        begin
            case (enc)  //波兹编码最终只有5种情况，0，+-1，+-2
                3'b000: begin
                    gen_pp = {1'b0, 16'b0};
                end
                3'b001: begin
                    gen_pp = {1'b0, a_ext};
                end
                3'b010: begin
                    gen_pp = {1'b0, a_ext_shl};
                end
                3'b111: begin
                    gen_pp = {1'b1, ~a_ext};
                end  // -1倍：取反，不加1
                3'b110: begin
                    gen_pp = {1'b1, ~a_ext_shl};
                end  // -2倍：取反，不加1
                default: begin
                    gen_pp = {1'b0, 16'b0};
                end
            endcase
        end
    endfunction

    /******************************* 组合逻辑 ***********************************/
    always @(*) begin
        {neg0, pp0} = gen_pp(enc0, a_ext, a_ext_shl);
        {neg1, pp1} = gen_pp(enc1, a_ext, a_ext_shl);
        {neg2, pp2} = gen_pp(enc2, a_ext, a_ext_shl);
        {neg3, pp3} = gen_pp(enc3, a_ext, a_ext_shl);
    end
endmodule
