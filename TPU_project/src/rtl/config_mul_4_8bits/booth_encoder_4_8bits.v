`timescale 1ns / 1ps
//****************************************VSCODE PLUG-IN**********************************//
//----------------------------------------------------------------------------------------
// IDE :                   VSCODE     
// VSCODE plug-in version: Verilog-Hdl-Format-4.3.20260413
// VSCODE plug-in author : Jiang Percy
//----------------------------------------------------------------------------------------
//****************************************Copyright (c)***********************************//
// Copyright(C)            SYSU
// All rights reserved     
// File name:              
// Last modified Date:     2026/05/24 11:06:59
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Simple
// Created date:           2026/05/24 11:06:59
// mail      :             luowj63@mail2.sysu.edu.cn
// Version:                V1.0
// TEXT NAME:              booth_encoder_4_8bits.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\fix_mul_8bits\booth_encoder_4_8bits.v
// Descriptions:           该模块用于实现对2个4个加法器的编码以及1个8位的编码，分别生成2个和4个部分积
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module booth_encoder_4_8bits (
    input      [7:0] b,
    input            is_8bits,
    output reg [2:0] enc0,      // 编码值，用3位表示 -2~2
    output reg [2:0] enc1,
    output reg [2:0] enc2,
    output reg [2:0] enc3
);

    /******************************* 函数 ***********************************/
    // 辅助函数：将 3 位组合转换为编码
    function [2:0] booth_code;
        input [2:0] bits;  // {b[2i+1], b[2i], b[2i-1]}
        begin
            case (bits)
                3'b000:  booth_code = 3'b000;  // 0
                3'b001:  booth_code = 3'b001;  // +1
                3'b010:  booth_code = 3'b001;  // +1
                3'b011:  booth_code = 3'b010;  // +2
                3'b100:  booth_code = 3'b110;  // -2 (用补码表示)
                3'b101:  booth_code = 3'b111;  // -1
                3'b110:  booth_code = 3'b111;  // -1
                3'b111:  booth_code = 3'b000;  // 0
                default: booth_code = 3'b000;
            endcase
        end
    endfunction

    /******************************* 组合逻辑 ***********************************/
    always @(*) begin
        //以下是可复用的部分积
        // 组0: b[1], b[0], b[-1]=0
        enc0 = booth_code({b[1], b[0], 1'b0});
        // 组1: b[3], b[2], b[1]
        enc1 = booth_code({b[3], b[2], b[1]});
        // 组3: b[7], b[6], b[5]
        enc3 = booth_code({b[7], b[6], b[5]});
        //注意这里忽略最高的3位，因为有符号数的情况下，最高3位永远是0
        //以下是2个4位的部分积的区别
        if (is_8bits) begin
            // 组2: b[5], b[4], b[3]
            enc2 = booth_code({b[5], b[4], b[3]});
        end else begin
            // 组2: b[5], b[4], b[3]
            enc2 = booth_code({b[5], b[4], 1'b0});
        end
    end
endmodule
