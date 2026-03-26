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
// Last modified Date:     2026/03/26 17:18:36
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/26 17:18:36
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              carry_sel_adder_32bit_tb.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\sim\carry_sel_adder_32bit_tb.v
// Descriptions:           32位加法器的testbench
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module carry_sel_adder_32bit_tb;

    /******************************* reg信号 ***********************************/
    reg         clk;
    reg  [31:0] a;
    reg  [31:0] b;
    reg         enable;
    reg         is_add;  //加法标志信号

    /******************************* 网表信号 ***********************************/

    wire [31:0] sum;
    wire [32:0] gold_result;
    wire        cout;
    wire        mismatch;
    wire        output_valid;
    wire        overflow;

    /******************************* 组合逻辑 ***********************************/
    assign gold_result = a + b;
    assign mismatch = (output_valid) ? gold_result ^ {cout, sum} : 1'b0;

    /******************************* 时序逻辑 ***********************************/
    always #5 clk = ~clk;

    /******************************* 仿真过程 ***********************************/
    initial begin
        a = 0;
        b = 0;
        enable = 0;
        clk = 0;
        is_add = 1;
        #100;

        repeat (10) begin
            // 1. 更新输入数据（随机值）
            a = $urandom;  // 32 位随机数
            b = $urandom;  // 32 位随机数

            // 2. 拉高 enable（此时数据已稳定）
            @(posedge clk);
            enable = 1'b1;

            // 3. 等待一个时钟上升沿（DUT 在此边沿采样）
            @(posedge clk);

            // 4. 在时钟上升沿后立即拉低 enable
            enable = 1'b0;

            // 5. 延迟 10 ns，再开始下一组激励
            #10;
        end

        //等到所有的数都计算完就结束
        #100 $stop;
    end

    /******************************* 模块例化 ***********************************/
    carry_sel_adder_32bit carry_sel_adder_32bit_inst (
        .clk         (clk),
        .a           (a),
        .b           (b),
        .sum         (sum),
        .cout        (cout),
        .is_add      (is_add),
        .enable      (enable),
        .overflow    (overflow),
        .output_valid(output_valid)
    );

endmodule
