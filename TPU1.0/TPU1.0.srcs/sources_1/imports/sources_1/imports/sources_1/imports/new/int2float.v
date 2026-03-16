module int2float (
    input wire clk,
    input wire rst_n,
    input wire [5:0]  input_precision,
    input wire signed [31:0] int_in,
    input wire        in_valid,
    input wire        mode,             //0为传输模式，1为转换模式

    output reg [31:0] float_out,
    output reg        out_valid
);

    // ----------- pre-process -----------
    reg [31:0] r_int_in;
    reg pre_valid;
    reg r_mode;

    // ----------- Stage 0: Sign & Abs -----------
    reg [31:0] stage0_abs_val;
    reg        stage0_sign;
    reg        stage0_valid;
    reg [31:0] stage0_int_in;
    reg        stage0_if_input_0;

    // ----------- Stage 1: Leading-One Position -----------
    reg [4:0]  stage1_leading_one_pos;
    reg [31:0] stage1_abs_val;
    reg        stage1_sign;
    reg        stage1_valid;
    reg [31:0] stage1_int_in;
    reg        stage1_if_input_0;

    // ----------- Stage 2: Exponent + Mantissa -----------
    reg [7:0]  stage2_exponent;
    reg [22:0] stage2_mantissa;
    reg        stage2_sign;
    reg        stage2_valid;
    reg [31:0] stage2_int_in;
    reg        stage2_if_input_0;

    // ----------- leading one position detect -----------
    reg [4:0] leading_one_result;
    integer i;
    
    always @(*) begin
        if(r_mode) begin
            if (stage0_abs_val[31:24] != 0) begin
                // 最高8位有1
                casez (stage0_abs_val[31:24])
                    8'b1???????: leading_one_result = 30;
                    8'b01??????: leading_one_result = 29;
                    8'b001?????: leading_one_result = 28;
                    8'b0001????: leading_one_result = 27;
                    8'b00001???: leading_one_result = 26;
                    8'b000001??: leading_one_result = 25;
                    8'b0000001?: leading_one_result = 24;
                    8'b00000001: leading_one_result = 23;
                    default: leading_one_result = 22; // 不应该到达这里
                endcase
            end else if (stage0_abs_val[23:16] != 0) begin
                // 次高8位有1
                casez (stage0_abs_val[23:16])
                    8'b1???????: leading_one_result = 22;
                    8'b01??????: leading_one_result = 21;
                    8'b001?????: leading_one_result = 20;
                    8'b0001????: leading_one_result = 19;
                    8'b00001???: leading_one_result = 18;
                    8'b000001??: leading_one_result = 17;
                    8'b0000001?: leading_one_result = 16;
                    8'b00000001: leading_one_result = 15;
                    default: leading_one_result = 14; // 不应该到达这里
                endcase
            end else if (stage0_abs_val[15:8] != 0) begin
                // 最低8位有1
                casez (stage0_abs_val[15:8])
                    8'b1???????: leading_one_result = 14;
                    8'b01??????: leading_one_result = 13;
                    8'b001?????: leading_one_result = 12;
                    8'b0001????: leading_one_result = 11;
                    8'b00001???: leading_one_result = 10;
                    8'b000001??: leading_one_result = 9 ;
                    8'b0000001?: leading_one_result = 8 ;
                    8'b00000001: leading_one_result = 7 ;
                    default: leading_one_result = 7; // 不应该到达这里
                endcase
            end else begin
                // 最低8位有1
                casez (stage0_abs_val[7:0])
                    8'b1???????: leading_one_result = 7;
                    8'b01??????: leading_one_result = 6;
                    8'b001?????: leading_one_result = 5;
                    8'b0001????: leading_one_result = 4;
                    8'b00001???: leading_one_result = 3;
                    8'b000001??: leading_one_result = 2;
                    8'b0000001?: leading_one_result = 1;
                    8'b00000001: leading_one_result = 0;
                    default: leading_one_result = 0; // 全0情况
                endcase
            end
        end 
    end

    //预处理
    always @(posedge clk) begin
        if (!rst_n) begin
            r_int_in <= 'd0;
            pre_valid <= 0;
            r_mode <= 0;
        end
        if (in_valid) begin
            pre_valid <= 1;
            r_int_in <= int_in;
            r_mode <= mode;
        end
        else begin
            r_int_in <= 'd0;
            pre_valid <= 0;
            r_mode <= 0;
        end
    end

    // -------------------- Stage 0 --------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage0_valid <= 0;
            stage0_abs_val <= 0;
            stage0_sign <= 0;
        end else begin
            if(pre_valid) begin
                if (mode && r_int_in != 0) begin
                    stage0_valid <= pre_valid;
                    stage0_if_input_0 <= 0;
                    stage0_sign <= r_int_in[31];
                    if (r_int_in[31]) begin
                        stage0_abs_val <= ~r_int_in + 1;
                    end
                    else begin
                        stage0_abs_val <= r_int_in;
                    end
                end
                else if (mode && r_int_in == 0) begin
                    stage0_valid <= pre_valid;
                    stage0_if_input_0 <= 1;
                end
                else begin
                    stage0_valid <= pre_valid;
                    stage0_int_in <= r_int_in;
                end
            end
            else begin
                stage0_valid <= 0;
                stage0_sign <= 0;
                stage0_abs_val <= 'd0;
                stage0_if_input_0 <= 0;
            end
        end
    end

    // -------------------- Stage 1 --------------------

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage1_valid <= 0;
            stage1_leading_one_pos <= 0;
        end
        else if (stage0_valid) begin
            if (mode && !stage0_if_input_0) begin
                stage1_valid <= stage0_valid;
                stage1_if_input_0 <= stage0_if_input_0;
                stage1_abs_val <= stage0_abs_val;
                stage1_sign <= stage0_sign;
                stage1_leading_one_pos <= leading_one_result;    // leading one position
            end
            else if (mode && stage0_if_input_0) begin
                stage1_if_input_0 <= stage0_if_input_0;
            end
            else begin
                stage1_valid <= stage0_valid;
                stage1_int_in <= stage0_int_in;
            end
        end
        else begin
            stage1_valid <= 0;
            stage1_sign <= 0;
            stage1_abs_val <= 'd0;
            stage1_leading_one_pos <= 'd0;
            stage1_if_input_0 <= 0;
        end
    end

    // -------------------- Stage 2 --------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage2_valid <= 0;
        end
        else if (stage1_valid) begin
            if (mode && !stage1_if_input_0) begin
                stage2_valid <= stage1_valid;
                stage2_if_input_0 <= stage1_if_input_0;
                stage2_sign  <= stage1_sign;
                stage2_exponent <= stage1_leading_one_pos + 127;
                if (stage1_leading_one_pos > 23) begin
                    stage2_mantissa <= stage1_abs_val[(stage1_leading_one_pos - 1) -: 23];
                end else begin
                    stage2_mantissa <= stage1_abs_val << (23 - stage1_leading_one_pos);
                end
            end
            else if (mode && stage1_if_input_0) begin
                stage2_if_input_0 <= stage1_if_input_0;
            end
            else if(!mode && stage1_valid) begin
                stage2_valid <= stage1_valid;
                stage2_int_in <= stage1_int_in;
            end
        end
        else begin
            stage2_valid <= 0;
            stage2_sign  <= 0;
            stage2_exponent <= 'd0;
            stage2_if_input_0 <= 0;
        end
    end

    // -------------------- Stage 3: Output --------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            float_out <= 32'b0;
            out_valid <= 1'b0;
        end else begin
            if (stage2_valid) begin
                if (mode && !stage2_if_input_0) begin
                    out_valid <= 1'b1;
                    float_out <= {stage2_sign, stage2_exponent, stage2_mantissa};
                end
                else if (mode && stage2_if_input_0) begin
                    out_valid <= 1'b1;
                    float_out <= 'd0;
                end
                else begin
                    out_valid <= 1'b1;
                    float_out <= stage2_int_in;
                end
            end
            else begin
                out_valid <= 1'b0;
                float_out <= 'd0;
            end
        end
    end


endmodule

