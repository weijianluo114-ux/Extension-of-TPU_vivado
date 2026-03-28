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
    input             clk,
    input             rst_n,
    input      [ 7:0] a,
    input      [ 7:0] b,
    output reg [31:0] p
);

    /******************************* 网表信号 ***********************************/
    // 第一级：Booth编码
    wire [2:0] enc0, enc1, enc2, enc3;

    // 第二级：部分积生成
    wire [15:0] pp0, pp1, pp2, pp3;
    wire neg0, neg1, neg2, neg3;

    // 第三级：压缩树 + 最终加法（组合逻辑）
    wire [21:0] sum, carry;

    wire [ 2:0] neg_cnt;
    wire [31:0] product;
    /******************************* reg信号 ***********************************/
    // 流水级寄存器
    reg [2:0] enc0_r, enc1_r, enc2_r, enc3_r;
    reg [15:0] pp0_r, pp1_r, pp2_r, pp3_r;
    reg neg0_r, neg1_r, neg2_r, neg3_r;
    reg [21:0] sum_r, carry_r;


    /******************************* 组合逻辑 ***********************************/
    assign neg_cnt = neg0_r + neg1_r + neg2_r + neg3_r;  // 负部分积个数

    /******************************* 时序逻辑 ***********************************/
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            {enc0_r, enc1_r, enc2_r, enc3_r} <= 0;
        end else begin
            enc0_r <= enc0;
            enc1_r <= enc1;
            enc2_r <= enc2;
            enc3_r <= enc3;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) p <= 0;
        else p <= product;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            {pp0_r, pp1_r, pp2_r, pp3_r} <= 0;
            {neg0_r, neg1_r, neg2_r, neg3_r} <= 0;
        end else begin
            pp0_r  <= pp0;
            pp1_r  <= pp1;
            pp2_r  <= pp2;
            pp3_r  <= pp3;
            neg0_r <= neg0;
            neg1_r <= neg1;
            neg2_r <= neg2;
            neg3_r <= neg3;
        end
    end

    /******************************* 模块例化 ***********************************/
    compressor_tree compressor_tree_inst (
        .pp0  (pp0_r),
        .pp1  (pp1_r),
        .pp2  (pp2_r),
        .pp3  (pp3_r),
        .sum  (sum),
        .carry(carry)
    );

    final_adder final_adder_inst (
        .sum    (sum),
        .carry  (carry),
        .neg_cnt(neg_cnt),
        .product(product)
    );

    booth_encoder booth_encoder_inst (
        .b   (b),
        .enc0(enc0),
        .enc1(enc1),
        .enc2(enc2),
        .enc3(enc3)
    );

    partial_product_gen partial_product_gen_inst (
        .a   (a),
        .enc0(enc0_r),
        .enc1(enc1_r),
        .enc2(enc2_r),
        .enc3(enc3_r),
        .pp0 (pp0),
        .pp1 (pp1),
        .pp2 (pp2),
        .pp3 (pp3),
        .neg0(neg0),
        .neg1(neg1),
        .neg2(neg2),
        .neg3(neg3)
    );
endmodule
