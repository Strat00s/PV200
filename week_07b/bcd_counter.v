// 4-bit bcd counter

module bcd_counter (

	input clk,					// 50MHz clock
	input clken,				// clock enable for counting
	input reset,				// synchronous reset
	input freeze,				// feeze of the output data
	output reg [3:0] data,  // output data 0...9
	output reg carry);      // is 1 for 1clk after transition from 9 to 0
	
	
   // **************************************************
	//
	// TASK 2:  build the bcd counter
	//
	// **************************************************
	
	reg [3:0] cnt = 0;
	reg c = 0;
	
	always @(posedge clk) begin
		if (reset) begin
			cnt = 0;
			data = 0;
			carry = 0;
			c = 0;
		end else if (clken) begin
			if (cnt == 9) begin
				cnt = 0;
				c = 1;
			end else begin 
				cnt = cnt + 1;
				c = 0;
			end
		end
		if (!freeze) begin
			data = cnt;
			carry = c;
		end
	end

		
endmodule