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
// Last modified Date:     2026/03/26 17:00:17
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/26 17:00:17
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              carry_sel_adder_32bit.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\carry_sel_adder_32bit.v
// Descriptions:           32位有符号加法器，添加了控制逻辑，无最低进位
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module carry_sel_adder_32bit_pipeline1 (
    input        clk,          //时钟
    input        valid_input,  //使能信号
    input        is_add,       //判断是加法还是减法运算a+b或者a-b
    input [31:0] a,            //32位加数a
    input [31:0] b,            //32位加数b
    // input        cin,     //低位进位cin

    output reg [31:0] sum,           //和sum
    output reg        cout,          //输出进位cout
    output reg        valid_output,  //输出有效信号
    output            overflow       //溢出标志
);
    /******************************* 网表信号 ***********************************/
    wire        sel;  //进位选择中间信号

    //进位选择的两个输出和信号
    wire [15:0] sum_temp0;
    wire [15:0] sum_temp1;

    //输出进位的两个中间信号
    wire        cout_temp0;
    wire        cout_temp1;

    //输出信号组合逻辑
    wire [31:0] SUM;
    wire        COUT;

    /******************************* reg信号 ***********************************/
    reg         OVERFLOW;

    /******************************* 组合逻辑 ***********************************/
    //首先对输出的和进行选择
    assign SUM[31:16] = sel ? sum_temp1 : sum_temp0;
    //再对输出的进位进行选择
    assign COUT = sel ? cout_temp1 : cout_temp0;

    assign overflow = OVERFLOW && valid_output;

    /******************************* 时序逻辑 ***********************************/
    //对输出打一拍
    always @(posedge clk) begin
        sum <= SUM;
        cout <= COUT;

        valid_output <= valid_input;
        //溢出检测，符号位相同相加后不同
        OVERFLOW <= (a[31] == b[31]) && (sum[31] != a[31]);
    end
    /******************************* 模块例化 ***********************************/
    //1个16位的加法器作为低位，2个作为进位选择的高位
    carry_sel_adder_16bit carry_sel_adder_16bit_inst_lower (
        .a   (a[15:0]),
        .b   (b[15:0]),
        .cin (1'b0),
        .sum (SUM[15:0]),
        .cout(sel)
    );

    //进位输入为0
    carry_sel_adder_16bit carry_sel_adder_16bit_inst_upper0 (
        .a   (a[31:16]),
        .b   (b[31:16]),
        .cin (1'b0),
        .sum (sum_temp0),
        .cout(cout_temp0)
    );
    //进位输入为1
    carry_sel_adder_16bit carry_sel_adder_16bit_inst_upper1 (
        .a   (a[31:16]),
        .b   (b[31:16]),
        .cin (1'b1),
        .sum (sum_temp1),
        .cout(cout_temp1)
    );

endmodule
