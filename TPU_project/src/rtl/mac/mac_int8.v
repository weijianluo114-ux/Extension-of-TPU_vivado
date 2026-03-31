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
// Last modified Date:     2026/03/28 21:48:59
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 21:48:59
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              mac_int8.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\mac_int8.v
// Descriptions:           8位的最小乘积累加单元
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module mac_int8 (
    //控制信号
    input wire clk,
    input wire rst_n,
    input wire valid_in,

    //输入信号
    input wire signed [ 7:0] a,
    input wire signed [ 7:0] b,
    input wire signed [31:0] c_in,

    //输出信号
    output reg signed [31:0] c_out,
    output reg               valid_out
);

    /******************************* reg信号 ***********************************/
    //4级延时存储
    reg [31:0] C          [3:0];
    reg [ 3:0] r_valid_in;

    /******************************* 时序逻辑 ***********************************/
    // 对第一级的寄存
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            C[0] <= 32'b0;
            C[1] <= 32'b0;
            C[2] <= 32'b0;
            C[3] <= 32'b0;
            r_valid_in[0] <= 4'd0;
        end else if (valid_in) begin
            C[0] <= c_in;
            r_valid_in[0] <= 1'b1;
        end else begin
            r_valid_in[0] <= 1'b0;
        end
    end

    //对后续三级的寄存
    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_valid_in[3:1] <= 4'b0;
        end else begin
            // 使用for循环创建一个状态跟随流水线
            for (i = 0; i < 3; i = i + 1) begin
                if (r_valid_in[i]) begin
                    C[i+1] <= C[i];
                    r_valid_in[i+1] <= 1'b1;
                end else begin
                    r_valid_in[i+1] <= 1'b0;
                end
            end
        end
    end


    /******************************* 模块例化 ***********************************/
    //8位乘法器，四级流水线
    fix_mul_8bits fix_mul_8bits_inst (
        .clk         (clk),
        .rst_n       (rst_n),
        .enable      (valid_in),
        .a           (a),
        .b           (b),
        .output_valid(output_valid),
        .p           (p)
    );
endmodule
