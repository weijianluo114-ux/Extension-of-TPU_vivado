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
// Descriptions:           8bit4级流水线乘法器
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module fix_mul_8bits #(
    parameter WIDTH_INT8 = 8,
    parameter WIDTH_BOOTH = 3,
    parameter WIDTH_PRODUCT = 16,
    parameter WIDTH_PRODUCT_SHIFT = 22,
    parameter WIDTH_INT32 = 32
) (
    input                  clk,
    input                  rst_n,
    input                  valid_input,
    input [WIDTH_INT8-1:0] a,
    input [WIDTH_INT8-1:0] b,

    output                   valid_output,  //输出有效
    output [WIDTH_INT32-1:0] p              //乘积输出
);

    /******************************* 网表信号 ***********************************/
    // 第一级：Booth编码
    wire [        WIDTH_BOOTH-1:0] enc0_w1;
    wire [        WIDTH_BOOTH-1:0] enc1_w1;
    wire [        WIDTH_BOOTH-1:0] enc2_w1;
    wire [        WIDTH_BOOTH-1:0] enc3_w1;

    // 第二级：部分积生成
    wire [      WIDTH_PRODUCT-1:0] pp0_w2;
    wire [      WIDTH_PRODUCT-1:0] pp1_w2;
    wire [      WIDTH_PRODUCT-1:0] pp2_w2;
    wire [      WIDTH_PRODUCT-1:0] pp3_w2;

    // 第三级：压缩树 + 最终加法（组合逻辑）
    wire [WIDTH_PRODUCT_SHIFT-1:0] sum_w3;
    wire [WIDTH_PRODUCT_SHIFT-1:0] carry_w3;
    wire [        WIDTH_INT32-1:0] adder_input_a;
    wire [        WIDTH_INT32-1:0] adder_input_b;

    //加法器输入有效信号
    wire                           valid_input_fix_adder;

    /******************************* reg信号 ***********************************/
    //第一级输入寄存
    reg  [         WIDTH_INT8-1:0] a_r1;
    reg  [         WIDTH_INT8-1:0] b_r1;
    reg                            enable_r1;

    // 第二级流水级寄存器
    reg  [         WIDTH_INT8-1:0] a_r2;
    reg                            enable_r2;
    reg  [        WIDTH_BOOTH-1:0] enc0_r2;
    reg  [        WIDTH_BOOTH-1:0] enc1_r2;
    reg  [        WIDTH_BOOTH-1:0] enc2_r2;
    reg  [        WIDTH_BOOTH-1:0] enc3_r2;

    //第三级流水线
    reg                            enable_r3;
    reg  [      WIDTH_PRODUCT-1:0] pp0_r3;
    reg  [      WIDTH_PRODUCT-1:0] pp1_r3;
    reg  [      WIDTH_PRODUCT-1:0] pp2_r3;
    reg  [      WIDTH_PRODUCT-1:0] pp3_r3;

    /******************************* 组合逻辑 ***********************************/
    assign valid_input_fix_adder = enable_r3;

    //将补高位后的值赋值给加法器输入
    assign adder_input_a = {{(WIDTH_INT32 - WIDTH_PRODUCT_SHIFT) {sum_w3[WIDTH_PRODUCT_SHIFT-1]}}, sum_w3};  //对于sum，不需要左移
    assign adder_input_b = {{(WIDTH_INT32 - WIDTH_PRODUCT_SHIFT - 1) {carry_w3[WIDTH_PRODUCT_SHIFT-1]}}, carry_w3, 1'b0};  //对于cin，要左移一位

    /******************************* 时序逻辑 ***********************************/
    //第一级流水线，首先存储输入
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_r1 <= 8'd0;
            b_r1 <= 8'd0;
            enable_r1 <= 1'b0;
        end else if (valid_input) begin
            a_r1 <= a;
            b_r1 <= b;
            enable_r1 <= 1'b1;
        end else begin
            enable_r1 <= 1'b0;
        end
    end

    //第二级流水线
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            {enc0_r2, enc1_r2, enc2_r2, enc3_r2} <= 0;
            enable_r2 <= 1'b0;
        end else if (enable_r1) begin
            a_r2 <= a_r1;
            enable_r2 <= enable_r1;

            enc0_r2 <= enc0_w1;
            enc1_r2 <= enc1_w1;
            enc2_r2 <= enc2_w1;
            enc3_r2 <= enc3_w1;
        end else begin
            enable_r2 <= 1'b0;
        end
    end

    //第三级流水线
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pp0_r3 <= 16'd0;
            pp1_r3 <= 16'd0;
            pp2_r3 <= 16'd0;
            pp3_r3 <= 16'd0;
            enable_r3 <= 1'b0;
        end else if (enable_r2) begin
            enable_r3 <= enable_r2;

            pp0_r3 <= pp0_w2;
            pp1_r3 <= pp1_w2;
            pp2_r3 <= pp2_w2;
            pp3_r3 <= pp3_w2;
        end else begin
            enable_r3 <= 1'b0;
        end
    end

    /******************************* 模块例化 ***********************************/
    //第一级，波兹编码
    booth_encoder_8bits booth_encoder_8bits_inst (
        .b   (b_r1),
        .enc0(enc0_w1),
        .enc1(enc1_w1),
        .enc2(enc2_w1),
        .enc3(enc3_w1)
    );

    //第二级，部分积生成
    patial_product_gen_8bits patial_product_gen_8bits_inst (
        .a   (a_r2),
        .enc0(enc0_r2),
        .enc1(enc1_r2),
        .enc2(enc2_r2),
        .enc3(enc3_r2),
        .pp0 (pp0_w2),
        .pp1 (pp1_w2),
        .pp2 (pp2_w2),
        .pp3 (pp3_w2)
    );

    //第三级：压缩树
    compress_tree_8bits compressor_tree_8bits_inst (
        .pp0  (pp0_r3),
        .pp1  (pp1_r3),
        .pp2  (pp2_r3),
        .pp3  (pp3_r3),
        .sum  (sum_w3),
        .carry(carry_w3)
    );

    //最后使用一个2级流水加法器
    carry_sel_adder_32bit carry_sel_adder_32bit_inst (
        .clk         (clk),
        .valid_input (valid_input_fix_adder),
        .is_add      (1'b1),
        .a           (adder_input_a),
        .b           (adder_input_b),
        .sum         (p),
        .cout        (),
        .valid_output(valid_output),
        .overflow    ()                        //由于最高位是22，故这里相乘不存在溢出
    );
endmodule
