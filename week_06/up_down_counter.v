// synchronous up/down counter

module up_down_counter(
	input clk,					// clock, active in rising edge
	input up,					// counting enable up, higher priority then down counting
	input down,		   		// counting enable down
	output reg [7:0] data 	// output data
	);
	
	//TASK 2b: here is a place for your code
	
	//always @(*) data = 8'd8; // it is only for possibility to translate and check TASK 1
	
	always @(posedge clk) begin
		if (up) begin
			data <= data + 1;
		end else if (down) begin
			data <= data - 1;
		end
	end
		
endmodule
