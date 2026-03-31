
module mac_int8_tb;

    /******************************* 网表信号 ***********************************/
    wire       [31:0] c_out;
    wire              valid_output;
    wire              overflow_output;

    /******************************* reg信号 ***********************************/
    reg               clk;
    reg               rst_n;
    reg               valid_input;
    reg signed [ 7:0] a;
    reg signed [ 7:0] b;
    reg signed [31:0] c_in;


    /******************************* 时序逻辑 ***********************************/
    always #5 clk = !clk;

    // 随机激励 
    always @(posedge clk) begin
        a    <= $urandom_range(-128, 127);  // int8  
        b    <= $urandom_range(-128, 127);  // int8  
        c_in <= $urandom_range(-2147483647, 2147483647);  // int32  
    end

    /******************************* 仿真过程 ***********************************/
    initial begin
        clk = 0;
        #10000;
        $stop;
    end


    mac_int8 mac_int8_inst (
        .clk            (clk),
        .rst_n          (rst_n),
        .valid_input    (valid_input),
        .a              (a),
        .b              (b),
        .c_in           (c_in),
        .c_out          (c_out),
        .valid_output   (valid_output),
        .overflow_output(overflow_output)
    );


endmodule
