// timmer,  generates one pulse of clk period width each PERIOD count of clk

// parameter 2^WIDTH must be bigger then PERIOD
// parameter PERIOD must be bigger then 2

module timer #(parameter WIDTH = 32, parameter PERIOD = 1000)(
	input  clk,
	output reg out
	);
	
	reg [WIDTH - 1:0] cnt = 0;
	
// TASK 1a: here is a place for your code
	always @(posedge clk) begin
		cnt <= cnt + 1;
		
		if (cnt == PERIOD - 2) begin
			out <= 1;
			cnt <= 0;
		end else begin
			out <= 0;
		end;
	end

endmodule