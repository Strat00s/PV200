// debouncer module
module debouncer #(parameter WIDTH = 10, parameter PERIOD = 500)(
	input clk,
	input clken, // only for sampling principle of the debouncer
	input in,
	output reg out);
	
	reg [WIDTH - 1:0] cnt = 0;
	reg enabled = 0;
   // TASK 4a: here is a place for your code
	
	// you can use slow sampling by using clken as in TOP module (easy)
	// or you can measure time after detection of change of input signal (good for training :-) )
	
	//always @(*) out = 1'b0;
	
	always @(posedge clk) begin		
		if (in == 1 && enabled == 0) begin
			enabled <= 1;
			out <= 1;
		end else begin
			out <= 0;
		end
		
		if (cnt == PERIOD) begin
			enabled <= 0;
			cnt <= 0;
		end else if (enabled == 1) begin
			cnt <= cnt + 1;
		end
	end
	
endmodule
	