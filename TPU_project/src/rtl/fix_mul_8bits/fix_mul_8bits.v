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
    input       clk,
    input       rst_n,
    input       enable,
    input [7:0] a,
    input [7:0] b,

    output reg        output_valid,  //输出有效
    output reg [31:0] p              //乘积输出
);

    /******************************* 网表信号 ***********************************/
    // 第二级：Booth编码
    wire [2:0] enc0_w1, enc1_w1, enc2_w1, enc3_w1;

    // 第三级：部分积生成
    wire [15:0] pp0_w3, pp1_w3, pp2_w3, pp3_w3;
    wire neg0_w3, neg1_w3, neg2_w3, neg3_w3;

    // 第四级：压缩树 + 最终加法（组合逻辑）
    wire [21:0] sum_w4, carry_w4;
    wire [ 2:0] neg_cnt_w4;
    wire [31:0] product_w4;

    //输出寄存
    /******************************* reg信号 ***********************************/
    //第一级输入寄存
    reg [7:0] a_r1, b_r1;
    reg enable_r1;

    // 第二级流水级寄存器
    reg a_r2;
    reg enable_r2;
    reg [2:0] enc0_r2, enc1_r2, enc2_r2, enc3_r2;

    //第三级流水线
    reg enable_r3;
    reg [15:0] pp0_r3, pp1_r3, pp2_r3, pp3_r3;
    reg neg0_r3, neg1_r3, neg2_r3, neg3_r3;



    /******************************* 组合逻辑 ***********************************/
    assign neg_cnt_w4 = neg0_r3 + neg1_r3 + neg2_r3 + neg3_r3;  // 负部分积个数

    /******************************* 时序逻辑 ***********************************/
    //第一级流水线，首先存储输入
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_r1 <= 8'd0;
            b_r1 <= 8'd0;
            enable_r1 <= 1'b0;
        end else if (enable) begin
            a_r1 <= a;
            b_r1 <= b;
            enable_r1 <= 1'b1;
        end else begin
            a_r1 <= 8'd0;
            b_r1 <= 8'd0;
            enable_r1 <= 1'b0;
        end
    end

    //第二级流水线
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            {enc0_r2, enc1_r2, enc2_r2, enc3_r2} <= 0;
        end else if (enable_r1) begin
            a_r2 <= a_r1;
            enable_r2 <= enable_r1;

            enc0_r2 <= enc0_w1;
            enc1_r2 <= enc1_w1;
            enc2_r2 <= enc2_w1;
            enc3_r2 <= enc3_w1;
        end else begin
            enc0_r2 <= 3'd0;
            enc1_r2 <= 3'd0;
            enc2_r2 <= 3'd0;
            enc3_r2 <= 3'd0;
        end
    end

    //第三级流水线
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pp0_r3  <= 16'd0;
            pp1_r3  <= 16'd0;
            pp2_r3  <= 16'd0;
            pp3_r3  <= 16'd0;
            neg0_r3 <= 1'b0;
            neg1_r3 <= 1'b0;
            neg2_r3 <= 1'b0;
            neg3_r3 <= 1'b0;
        end else if (enable_r2) begin
            enable_r3 <= enable_r2;

            pp0_r3 <= pp0_w3;
            pp1_r3 <= pp1_w3;
            pp2_r3 <= pp2_w3;
            pp3_r3 <= pp3_w3;
            neg0_r3 <= neg0_w3;
            neg1_r3 <= neg1_w3;
            neg2_r3 <= neg2_w3;
            neg3_r3 <= neg3_w3;
        end else begin
            pp0_r3  <= 16'd0;
            pp1_r3  <= 16'd0;
            pp2_r3  <= 16'd0;
            pp3_r3  <= 16'd0;
            neg0_r3 <= 1'b0;
            neg1_r3 <= 1'b0;
            neg2_r3 <= 1'b0;
            neg3_r3 <= 1'b0;
        end
    end

    //第4级流水线
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) p <= 0;
        else if (enable_r3) begin
            output_valid <= 1'b1;
            p <= product_w4;
        end else begin
            output_valid <= 1'b0;
            p <= 32'd0;
        end
    end

    /******************************* 模块例化 ***********************************/
    //第二级，波兹编码
    booth_encoder_8bits booth_encoder_8bits_inst (
        .b   (b_r1),
        .enc0(enc0_w1),
        .enc1(enc1_w1),
        .enc2(enc2_w1),
        .enc3(enc3_w1)
    );

    //第三级，部分积生成
    patial_product_gen_8bits patial_product_gen_8bits_inst (
        .a   (a_r2),
        .enc0(enc0_r2),
        .enc1(enc1_r2),
        .enc2(enc2_r2),
        .enc3(enc3_r2),
        .pp0 (pp0_w3),
        .pp1 (pp1_w3),
        .pp2 (pp2_w3),
        .pp3 (pp3_w3),
        .neg0(neg0_w3),
        .neg1(neg1_w3),
        .neg2(neg2_w3),
        .neg3(neg3_w3)
    );

    //第四级：压缩树
    compress_tree_8bits compressor_tree_8bits_inst (
        .pp0_w3(pp0_r3),
        .pp1_w3(pp1_r3),
        .pp2_w3(pp2_r3),
        .pp3_w3(pp3_r3),
        .sum   (sum_w4),
        .carry (carry_w4)
    );

    //第四级，加法器
    final_adder final_adder_inst (
        .sum       (sum_w4),
        .carry     (carry_w4),
        .neg_cnt_w4(neg_cnt_w4),
        .product_w4(product_w4)
    );
endmodule
