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
// Last modified Date:     2026/03/28 20:56:23
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 20:56:23
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              fix_mul_8bits_tb.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\sim\fix_mul_8bits_tb.v
// Descriptions:           
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module config_mul_4_8bits_tb;
    /******************************* 网表信号 ***********************************/
    wire        output_valid;
    wire [31:0] p;
    wire [31:0] p_4bits_low;
    wire [31:0] p_4bits_high;

    wire [31:0] a5_high;
    wire [31:0] a5_low;
    wire [31:0] b5_low;
    wire [31:0] b5_high;

    /******************************* reg信号 ***********************************/
    reg         clk;
    reg         rst_n;
    reg         enable;
    reg  [ 7:0] a;
    reg  [ 7:0] a1;
    reg  [ 7:0] a2;
    reg  [ 7:0] a3;
    reg  [ 7:0] a4;
    reg  [31:0] a5;
    reg  [ 7:0] b;
    reg  [ 7:0] b1;
    reg  [ 7:0] b2;
    reg  [ 7:0] b3;
    reg  [ 7:0] b4;
    reg  [31:0] b5;
    reg         is_8bits;

    reg         mismatch;

    /******************************* 组合逻辑 ***********************************/
    assign a5_high = {{28{a5[7]}}, a5[7:4]};
    assign a5_low  = {{28{a5[3]}}, a5[3:0]};
    assign b5_high = {{28{b5[7]}}, b5[7:4]};
    assign b5_low  = {{28{b5[3]}}, b5[3:0]};


    /******************************* 时序逻辑 ***********************************/
    always #5 clk = !clk;
    always @(posedge clk) begin
        a1 <= a;
        a2 <= a1;
        a3 <= a2;
        a4 <= a3;
        a5 <= {{24{a4[7]}}, a4};
        b1 <= b;
        b2 <= b1;
        b3 <= b2;
        b4 <= b3;
        b5 <= {{24{b4[7]}}, b4};
    end

    always @(negedge clk) begin
        if (is_8bits) begin
            if (p != (a5 * b5)) begin
                mismatch <= 1;
            end else begin
                mismatch <= 0;
            end
        end else begin
            if ((p_4bits_high != a5_high * b5_high) || (p_4bits_low != a5_low * b5_low)) begin
                mismatch <= 1;
            end else begin
                mismatch <= 0;
            end
        end

    end


    /******************************* 仿真过程 ***********************************/
    integer i;
    integer j;
    initial begin
        mismatch <= 0;
        clk <= 0;
        rst_n <= 0;
        enable <= 0;
        is_8bits <= 0;
        #100;
        rst_n <= 1;

        for (i = -128; i < 128; i = i + 1) begin
            if (i <= 0) begin
                is_8bits <= 1'b1;
            end else begin
                is_8bits <= 1'b0;
            end
            for (j = -128; j < 128; j = j + 1) begin
                @(negedge clk);
                #1;
                enable = 1;
                a = i[7:0];
                b = j[7:0];
                @(posedge clk);
                #1;
                enable = 0;
            end
        end

        #100;
        $stop;

    end

    config_mul_4_8bits config_mul_4_8bits_inst (
        .clk         (clk),
        .rst_n       (rst_n),
        .valid_input (enable),
        .is_8bits    (is_8bits),
        .a           (a),
        .b           (b),
        .valid_output(output_valid),
        .p           (p),
        .p_4bits_low (p_4bits_low),
        .p_4bits_high(p_4bits_high)
    );


endmodule
