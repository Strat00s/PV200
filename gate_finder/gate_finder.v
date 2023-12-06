module gate_finder(input CLOCK_50, input [9:0]SW, output reg [9:0]LEDR, inout [35:0]GPIO_0 );
	//assign GPIO_0[32] = 0;
	//assign LEDR[0] = GPIO_0[34];
	
	// Internal signals
	reg [35:0] gpio_data_out;  // Data to send to GPIO
	reg [35:0] gpio_data_in;   // Data read from GPIO
	reg [35:0] gpio_direction; // Control signal for GPIO direction
	
	localparam [5:0] indexes[5:0] = {0, 5, 6, 7, 8, 9};
	
	//set everything to 0
	//read current state (default state)
	//pick one pin and start toggling the rest
	//
	
	
	wire slow;
	reg flip = 0;
	
	clock_divider s_clk(
		.clk(CLOCK_50),
		.reset(1'b0),
		.out(slow)
	);
	
	always @(posedge slow) begin
		flip = !flip;
		LEDR[0] = flip;
	end
	
	
	
	
	
endmodule