`timescale 1ns / 1ps

//该模块只负责时钟和启动测试信号的生成
module TOP_tb();
/******************************* 参数 **********************************/
  //------------------------------- 普通参数 ---------------------------//


  //------------------------------- 本地参数 ---------------------------//
    localparam CLOCK_PERIOD           = 5;         //200MHz的时钟周期


/******************************* 信号 *********************************/
  //------------------------------- 寄存器型 ---------------------------//
    reg clk;
    reg rst_n;
    reg start_test;

  //------------------------------- 网表型 ---------------------------//
    wire the_last_matrix;


/******************************* testbench总控 ************************/
    initial clk = 1;
    always #2.5 clk = ~clk;   //200MHz跑
    // always #(CLOCK_PERIOD/2) clk = ~clk;

    initial begin
        rst_n           = 0;
        start_test      = 0;

        #300 rst_n      = 1;
            start_test  = 1;
            
        #200 start_test = 0;
        #20 @(the_last_matrix);

        // #5_000 $finish;      //10us结束仿真
    end


/******************************* 模块例化 *****************************/
    test_start test_start (
        //input
        .clk            (clk            ),
        .rst_n          (rst_n          ),
        .start_test     (start_test     ),
        //output
        .the_last_matrix(the_last_matrix)     //标志着最后一个矩阵从ddr3读出来
    );

endmodule
