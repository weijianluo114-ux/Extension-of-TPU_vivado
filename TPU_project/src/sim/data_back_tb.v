`timescale 1ns / 1ns

module data_back_tb (
    input clk,
    input rst_n,

    input tb_write_flag,
    input tb_last_data_back,

    input [127:0] tb_AXI_wdata
    );

/********************* 参数 *********************/
    parameter MATRIX_TEST_NUM = 18;


/********************* 文件处理 *********************/
    integer file_handle;

/********************* 寄存器型 *********************/
    reg [31:0] MATRIX_num_cnt;     //用于计数计算过的矩阵组数目

    //结束标志
    reg end_flag;
/********************* 网表型 *********************/


/********************* 组合逻辑 *********************/
    

/********************* 时序逻辑 *********************/
    //仿真测试矩阵组数计数器
        always @(posedge clk) begin
            if (!rst_n) begin
                MATRIX_num_cnt <= 0;
            end else if (end_flag) begin
                MATRIX_num_cnt <= 0;
            end else if (tb_last_data_back) begin
                MATRIX_num_cnt <= MATRIX_num_cnt+1;
            end else MATRIX_num_cnt <= MATRIX_num_cnt;
        end

    //取出最后一个数据
    always @(posedge clk) begin
        end_flag <= tb_last_data_back && (MATRIX_num_cnt == MATRIX_TEST_NUM-1);                                                
    end


/********************* 打开文件 *********************/
    initial begin
        //----------------------------------------注意！！！！！！！！！！！以下地址记得更改-------------------------------//
        file_handle = $fopen("../../../../../cpp_verification/txt/D_result.txt", "w");      
        if(!file_handle) begin
            $display("Error: Failed to open file!");
        end
    end


/*********************输出数据*********************/
    always@(posedge clk) begin
        if(end_flag) begin                       //时钟上升沿且end_flag为高电平时，结束写文件
            $fclose(file_handle);
            $stop;
        end else if(tb_write_flag) begin                         //时钟上升沿且flag为高电平时，写一个128位数据至txt
            $fdisplay(file_handle, "%b", tb_AXI_wdata);
        end
        
    end


endmodule
