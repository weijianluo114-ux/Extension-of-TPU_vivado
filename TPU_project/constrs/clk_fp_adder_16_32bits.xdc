# ====================================================
# 时钟约束
# ====================================================
create_clock -name clk -period 5.0 [get_ports clk]

# ====================================================
# 输入延迟约束（相对于时钟 clk）
# ====================================================
# 所有输入信号（除复位外）的输入延迟
set_input_delay -clock clk -max 1.0 [get_ports {read_en input_A[*] input_B[*] input_b_precision[*]}]
set_input_delay -clock clk -min 0.5  [get_ports {read_en input_A[*] input_B[*] input_b_precision[*]}]

# ====================================================
# 输出延迟约束（相对于时钟 clk）
# ====================================================
set_output_delay -clock clk -max 1.0 [get_ports {C[*] indicate}]
set_output_delay -clock clk -min 0.5  [get_ports {C[*] indicate}]

# ====================================================
# 异步复位路径（设为 false path，无需时序约束）
# ====================================================
set_false_path -from [get_ports rst_n]