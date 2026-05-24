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

module patial_product_gen_4_8bits (
    input      [ 7:0] a,         //这里8位的话就直接使用，4位则分为高四位和低4位的部分积
    input             is_8bits,
    input      [ 2:0] enc0,
    input      [ 2:0] enc1,
    input      [ 2:0] enc2,
    input      [ 2:0] enc3,
    output reg [15:0] pp0,
    output reg [15:0] pp1,
    output reg [15:0] pp2,
    output reg [15:0] pp3
);
    /******************************* 参数 ***********************************/
    parameter IS_HIGH = 1'b1;
    parameter IS_LOW = 1'b0;

    /******************************* 网表信号 ***********************************/
    wire [7:0] a_ext_low = is_8bits ? a : {{4{a[3]}}, a[3:0]};  // 符号扩展到16位
    wire [7:0] a_ext_high = is_8bits ? {8{a[7]}} : {{4{a[7]}}, a[7:4]};  // 符号扩展到16位
    wire [7:0] a_ext_shl_low = is_8bits ? {a[6:0], 1'b0} : {{3{a[3]}}, a[3:0], 1'b0};  // 左移1位并符号扩展
    wire [7:0] a_ext_shl_high = is_8bits ? {8{a[7]}} : {{3{a[7]}}, a[7:4], 1'b0};  // 左移1位并符号扩展

    /******************************* 函数 ***********************************/
    function [15:0] gen_pp;  //
        input is_8bits;
        input is_high;
        input [2:0] enc;
        input [15:0] a_ext;
        input [15:0] a_ext_shl;
        begin
            case (enc)  //波兹编码最终只有5种情况，0，+-1，+-2  ，注意这里4位的部分积，只有8位，故高8位存0，只在低4位存
                //0
                3'b000: begin
                    gen_pp = 16'b0;
                end
                //+1
                3'b001: begin
                    gen_pp = is_8bits ? a_ext : is_high ? {8'b0, a_ext[15:8]} : {8'b0, a_ext[7:0]};
                end
                //+2
                3'b010: begin
                    gen_pp = is_8bits ? a_ext_shl : is_high ? {8'b0, a_ext_shl[15:8]} : {8'b0, a_ext_shl[7:0]};
                end
                //以下逻辑需要区分4位和8位
                //-2
                3'b110: begin
                    gen_pp = is_8bits ? {~a_ext_shl + 1'b1} : is_high ? {8'b0, {~a_ext_shl[15:8] + 1'b1}} : {8'b0, {~a_ext_shl[7:0] + 1'b1}};
                end
                //-1
                3'b111, 3'b101: begin
                    gen_pp = is_8bits ? {~a_ext + 1'b1} : is_high ? {8'b0, {~a_ext[15:8] + 1'b1}} : {8'b0, {~a_ext[7:0] + 1'b1}};
                end
                //默认是0
                default: begin
                    gen_pp = 16'b0;
                end
            endcase
        end
    endfunction

    /******************************* 组合逻辑 ***********************************/
    always @(*) begin  //enc0,1对应的是a的高位
        pp0 = gen_pp(is_8bits, IS_LOW, enc0, {a_ext_high, a_ext_low}, {a_ext_shl_high, a_ext_shl_low});
        pp1 = gen_pp(is_8bits, IS_LOW, enc1, {a_ext_high, a_ext_low}, {a_ext_shl_high, a_ext_shl_low});
        pp2 = gen_pp(is_8bits, IS_HIGH, enc2, {a_ext_high, a_ext_low}, {a_ext_shl_high, a_ext_shl_low});
        pp3 = gen_pp(is_8bits, IS_HIGH, enc3, {a_ext_high, a_ext_low}, {a_ext_shl_high, a_ext_shl_low});
    end
endmodule
