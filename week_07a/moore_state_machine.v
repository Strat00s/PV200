// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)


// state machine of the code lock

module moore_state_machine
(
	input	clk, reset,         // input clock and asynchronous reset
	input	[3:0] keys,         // input keys, log 1 is after pressing of key for one cycle of clk
	output reg unlock,        // 1 after right sequence of keys, 0 in other states
	output reg [3:0]progress  // progress of keys pressing
);

   // **************************************************
	// TASK :  build the Moore state machine
	//  
	//   states: RESET                    - initial state 
	//           KEY1, KEY2,  KEY3, KEY4  - waiting for keys
   //				 UNLOCK                   - the lock is unlocked
	//  
	//   sequence for unlocking: keys = 0001,0100,1000,0010
	//   
	//   wrong sequence of keys resets state machiine
	// 
	// **************************************************
	reg [3:0] state = 0;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state = 0;
			unlock = 0;
	
		end else begin
			if (keys == 4'b0001) begin
				if (state == 0) begin
					state = 4'b0001;
				end else begin
					state = 0;
				end
			end else if (keys == 4'b0100) begin
				if (state == 4'b0001) begin
					state = 4'b0011;
				end else begin
					state = 0;
				end
			end else if (keys == 4'b1000) begin
				if (state == 4'b0011) begin
					state = 4'b0111;
				end else begin
					state = 0;
				end
			end else if (keys == 4'b0010) begin
				if (state == 4'b0111) begin
					state = 4'b1111;
					unlock = 1;
				end else begin
					state = 0;
				end
			end
		end
		progress = state;
	end

endmodule
