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
// Last modified Date:     2026/03/19 19:40:53
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/19 19:40:53
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              carry_sel_adder_4bit_tb.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\sim\carry_sel_adder_4bit_tb.v
// Descriptions:           该文件为8bit进位旁路加法器的testbench    
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//


module carry_bypass_8bit_tb;

  /******************************* reg信号 ***********************************/
  reg cin;
  reg clk;
  reg [15:0] count;  //使用一个8位的计数器来遍历所有的16位的情况
  reg start;  //开始信号

  /******************************* 网表信号 ***********************************/
  wire [7:0] a;
  wire [7:0] b;
  wire [7:0] sum;
  wire [8:0] gold_result;
  wire cout;
  wire mismatch;

  /******************************* 组合逻辑 ***********************************/
  assign a = count[7:0];
  assign b = count[15:8];
  assign gold_result = a + b;
  assign mismatch = gold_result ^ {cout, sum};

  /******************************* 时序逻辑 ***********************************/
  always #5 clk = ~clk;
  always @(posedge clk) begin
    if (start == 1) begin
      count <= count + 1;
    end else begin
      count = 0;
    end
  end

  /******************************* 仿真过程 ***********************************/
  initial begin
    clk   = 0;
    start = 0;
    count = 0;
    cin   = 0;

    #100;
    start = 1;

    //等到所有的数都计算完就结束
    wait (count == ((9'd1 << 16) - 1));
    #100 $stop;
  end

  /******************************* 模块例化 ***********************************/
  carry_bypass_8bit carry_bypass_8bit_inst (
      .a(a),
      .b(b),
      .cin(cin),
      .sum(sum),
      .cout(cout),
      .g(g),
      .p(p)
  );

endmodule

