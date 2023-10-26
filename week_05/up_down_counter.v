// bidirectional counter with asynchronous reset

module up_down_counter(
	input direction,  // 1 - up, 0 - down
	input clk,			// clock, active in rising edge
	input arst,		   // asynchronous reset
	output reg [7:0] data // output data
	);
	
	//TASK 2: write the code
	always @(posedge clk, posedge arst) begin
		if (arst) begin
			data <= 0;
		end else begin
			if (direction) begin
				data <= data + 1;
			end else begin
				data <= data - 1;
			end
		end
	end
	
endmodule