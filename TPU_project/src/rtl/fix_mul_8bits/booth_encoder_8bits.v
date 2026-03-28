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
// Last modified Date:     2026/03/28 16:56:40
// Last Version:           V1.0
// Descriptions:           
//----------------------------------------------------------------------------------------
// Created by:             Please Write You Name 
// Created date:           2026/03/28 16:56:40
// mail      :             Please Write mail 
// Version:                V1.0
// TEXT NAME:              booth_encoder_8bits.v
// PATH:                   E:\electronic2\project\verilog_pro\TPU_vivado\TPU_project\src\rtl\booth_encoder_8bits.v
// Descriptions:           此模块用于给8位乘数进行波兹编码
//                         
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module booth_encoder_8bits (
    input      [7:0] b,
    output reg [2:0] enc0,  // 编码值，用3位表示 -2~2
    output reg [2:0] enc1,
    output reg [2:0] enc2,
    output reg [2:0] enc3
);
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

    always @(*) begin
        // 组0: b[1], b[0], b[-1]=0
        enc0 = booth_code({b[1], b[0], 1'b0});
        // 组1: b[3], b[2], b[1]
        enc1 = booth_code({b[3], b[2], b[1]});
        // 组2: b[5], b[4], b[3]
        enc2 = booth_code({b[5], b[4], b[3]});
        // 组3: b[7], b[6], b[5]
        enc3 = booth_code({b[7], b[6], b[5]});
    end
endmodule
