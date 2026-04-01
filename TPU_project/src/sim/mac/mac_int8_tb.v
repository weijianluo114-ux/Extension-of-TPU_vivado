
module mac_int8_tb;

    /******************************* 网表信号 ***********************************/
    wire        [31:0] c_out;
    wire               valid_output;
    wire               overflow_output;
    wire signed [31:0] c_out_gold;
    wire signed [31:0] fix_mul_gold;
    wire               mismatch;

    /******************************* reg信号 ***********************************/
    reg                clk;
    reg                rst_n;
    reg                valid_input;
    reg signed  [ 7:0] a;
    reg signed  [ 7:0] b;
    reg signed  [31:0] c_in;
    reg signed  [31:0] r_c_out_gold    [6:0];
    reg signed  [31:0] r_fix_mul_gold  [6:0];

    /******************************* 组合逻辑 ***********************************/
    assign c_out_gold = a * b + c_in;
    assign fix_mul_gold = a * b;
    assign mismatch = (r_c_out_gold[6] != c_out);

    /******************************* 时序逻辑 ***********************************/
    always #5 clk = !clk;

    //打拍
    integer i;
    always @(posedge clk) begin
        r_c_out_gold[0]   <= c_out_gold;
        r_fix_mul_gold[0] <= fix_mul_gold;
        for (i = 1; i < 7; i = i + 1) begin
            r_c_out_gold[i]   <= r_c_out_gold[i-1];
            r_fix_mul_gold[i] <= r_fix_mul_gold[i-1];
        end
    end

    // 随机激励 
    always @(posedge clk) begin
        if (!rst_n) begin
            a <= 0;
            b <= 0;
            c_in <= 0;
            valid_input <= 1'b0;
        end else begin
            valid_input <= 1'b1;
            a    <= $urandom_range(-128, 127);  // int8  
            b    <= $urandom_range(-128, 127);  // int8  
            c_in <= $urandom_range(-345, 133);  // int32  
        end
    end

    /******************************* 仿真过程 ***********************************/
    initial begin
        clk = 0;
        rst_n = 0;
        valid_input = 0;
        #100;
        rst_n = 1;
        #10000;
        $stop;
    end

    /******************************* 模块例化 ***********************************/
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
