vlib work
vlog ram.v ram_tb.v
vsim -t ns work.ram_tb
view wave
add wave -radix hex /din_tb
add wave -radix hex /dout_tb
add wave -radix binary /clock_tb
add wave -radix binary /rden_tb
add wave -radix binary /wren_tb
run 200 ns