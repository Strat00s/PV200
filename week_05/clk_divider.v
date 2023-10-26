// the divider of the input clock by 2^WIDTH

module clk_divider #(parameter WIDTH = 8)(
	input  clk_in,
	output clk_out
	);
	reg [WIDTH:0] div = 0;
// TASK 3: write the code for the divider with width as parameter
// use the auxiliary reg for counting, clk_out is in the MSB

// note: in fact, this way for dividing of the clock is not good practise, better way is only generate clk enable signal
	always @(posedge clk_in) begin
		div <= div + 1;
	end
	assign clk_out = div[WIDTH - 1];

endmodule