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

module fix_mul_8bits_tb;
    /******************************* 网表信号 ***********************************/
    wire        output_valid;
    wire [31:0] p;

    /******************************* reg信号 ***********************************/
    reg         clk;
    reg         rst_n;
    reg         enable;
    reg  [ 7:0] a;
    reg  [ 7:0] b;

    reg         mismatch;

    /******************************* 时序逻辑 ***********************************/
    always #5 clk = !clk;

    /******************************* 仿真过程 ***********************************/
    integer i;
    integer j;
    initial begin
        clk = 0;
        rst_n = 0;
        enable = 0;
        #100;
        rst_n = 1;

        for (i = -128; i < 128; i = i + 1) begin
            for (j = -128; j < 128; j = j + 1) begin
                @(posedge clk);
                #1;
                enable = 1;
                a = i[7:0];
                b = j[7:0];
                @(posedge clk);
                #1;
                enable = 0;
                if (p !== i * j) begin
                    $error("Mismatch");
                    mismatch <= 0;
                end
            end
        end

        #100;
        $stop;

    end

    fix_mul_8bits fix_mul_8bits_inst (
        .clk         (clk),
        .rst_n       (rst_n),
        .valid_input (enable),
        .a           (a),
        .b           (b),
        .valid_output(output_valid),
        .p           (p)
    );


endmodule
