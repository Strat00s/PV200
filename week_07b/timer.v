// timmer,  generates one pulse of clk period width each PERIOD count of clk

// parameter 2^WIDTH must be bigger then PERIOD
// parameter PERIOD must be bigger then 2

module timer #(parameter WIDTH = 32, parameter PERIOD = 1000)(
	input clk,	// clk system clock
	input enable,	// enable of timer
	input reset,	// synchronous reset
	output reg out  // output pulse
	);
	
   // *********************************************************************
	//
	// TASK 1:  we need add inputs enable and reset to the code from week 06
	//
	// *********************************************************************

	reg [WIDTH-1:0] timer;
	
	always @(posedge clk) begin
		if (reset) begin
			timer <= 0;
			out <= 0;
		end else if (enable) begin
			if (timer < PERIOD-1) begin 
				timer <= timer + {{WIDTH-1{1'b0}},1'b1};
					out <= 1'b0;
			end else begin
			timer <= {WIDTH{1'b0}};
				out <= 1'b1;
			end
		end
	end
endmodule