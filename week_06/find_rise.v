// produce one pulse, when input in was changed from 0 to 1

module find_rise (
	input clk,
	input in,
	output reg out);
	
	reg last_state = 0;
// TASK 2a: here is a place for your code
	always @(posedge clk) begin
		if (last_state != in && in == 1) begin
			out <= 1;
		end else begin
			out <= 0;
		end
		last_state <= in;
	end
endmodule