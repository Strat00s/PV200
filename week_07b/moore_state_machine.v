// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)


// state machine of the code lock

module moore_state_machine
(
	input	clk,  			// system clock
	input	[3:0] keys,		// input keys, log 1 is after pressing of key for one cycle of clk
	output reg reset,		// reset of the timer and bcd counters
	output reg enable,	// enable of the timer
	output reg freeze		// freezes data on the display
);

   // **************************************************
	// TASK :  build the Moore state machine
	//
	// KEY[0] - resets the stopwatch, numbers are not running
	//
	// when numbers on the display are not running
	//      kEY[1] or KEY[2] unfreeze/starts stopwatch
	//
	// when numbers on the display are running
	//      KEY[1] freezes the display
	//      KEY[2] pauses the stopwatch
	//  
	// **************************************************

	
	// Declare state register
	(* syn_encoding = "gray" *) reg	[1:0]state;

	// Declare states
	parameter RESET = 0, RUN = 1, FREEZE = 2, PAUSE = 3;
	
	
	always @(posedge clk) begin
		if (keys == 4'b0001) begin
			enable = 0;
			reset = 1;
		end else if ((keys == 4'b0010 || keys == 4'b0100) && (!enable || !freeze)) begin
			enable = 1;
			freeze = 0;
			reset = 0;
		end else if (keys == 4'b0010 && (enable || freeze)) begin
			freeze = 1;
		end else if (keys == 4'b0100 && (enable || freeze)) begin
			enable = 0;
		end
	end


endmodule
