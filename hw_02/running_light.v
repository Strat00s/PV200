// Quartus Prime Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)

module running_light(input	Clock, START, STOP, RESET, output reg [9:0] LEDS);

	// Declare state register
	reg [1:0] state = S_RUN;
	reg dir = S_LEFT;
	reg [3:0] out = 0;
	//0000000000 00

	// Declare states
	parameter S_RESET = 0, S_STOP = 1, S_RUN = 2, S_LEFT = 0, S_RIGHT = 1;

	// Output depends only on the state
	always @ (out) begin
		case (out)
			0: LEDS = 'b0000000001;
			1: LEDS = 'b0000000010;
			2: LEDS = 'b0000000100;
			3: LEDS = 'b0000001000;
			4: LEDS = 'b0000010000;
			5: LEDS = 'b0000100000;
			6: LEDS = 'b0001000000;
			7: LEDS = 'b0010000000;
			8: LEDS = 'b0100000000;
			9: LEDS = 'b1000000000;
		endcase
	end

	// Determine the next state
	always @ (posedge Clock) begin
		if (RESET) begin
			state = S_RESET;
			dir = S_LEFT;
			out = 0;
		end
		
		else if (state == S_RESET) begin
			state = S_RUN;
		end
		
		else if (STOP && state == S_RUN) begin
			state = S_STOP;
		end
		
		else if (START && (state == S_STOP || state == S_RESET)) begin
			state = S_RUN;
		end
		
		else if (state == S_RUN) begin
			if (dir == S_LEFT) begin
				out = out + 1;
			end
			else begin
				out = out - 1;
			end
			
			if (out == 0) begin
				dir = S_LEFT;
			end
			if (out == 9) begin
				dir = S_RIGHT;
			end
		end
	end

endmodule
