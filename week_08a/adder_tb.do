vlib work
vlog adder.v adder_tb.v
vsim -t ns work.adder_tb
view wave
add wave -radix unsigned /a
add wave -radix unsigned /b
add wave -radix unsigned /sum
run 100 ns