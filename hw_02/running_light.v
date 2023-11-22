// Quartus Prime Verilog Template
// 4-State Moore state machine

// A Moore machine's outputs are dependent only on the current state.
// The output is written only when the state changes.  (State
// transitions are synchronous.)

module running_light(input	Clock, START, STOP, RESET, output reg [9:0] LEDS);

	// Declare state register
	reg [12:0] state = S_RESET;

	// Declare states
    //                                SDD
	 parameter S_RESET   = 'b0000000000000;
    parameter S_RUN_L0  = 'b0000000001001;
    parameter S_RUN_L1  = 'b0000000010001;
    parameter S_RUN_L2  = 'b0000000100001;
    parameter S_RUN_L3  = 'b0000001000001;
    parameter S_RUN_L4  = 'b0000010000001;
    parameter S_RUN_L5  = 'b0000100000001;
    parameter S_RUN_L6  = 'b0001000000001;
    parameter S_RUN_L7  = 'b0010000000001;
    parameter S_RUN_L8  = 'b0100000000001;
    parameter S_RUN_L9  = 'b1000000000001;
    parameter S_RUN_R8  = 'b0100000000010;
    parameter S_RUN_R7  = 'b0010000000010;
    parameter S_RUN_R6  = 'b0001000000010;
    parameter S_RUN_R5  = 'b0000100000010;
    parameter S_RUN_R4  = 'b0000010000010;
    parameter S_RUN_R3  = 'b0000001000010;
    parameter S_RUN_R2  = 'b0000000100010;
    parameter S_RUN_R1  = 'b0000000010010;
    parameter S_STOP_L0 = 'b0000000001101;
    parameter S_STOP_L1 = 'b0000000010101;
    parameter S_STOP_L2 = 'b0000000100101;
    parameter S_STOP_L3 = 'b0000001000101;
    parameter S_STOP_L4 = 'b0000010000101;
    parameter S_STOP_L5 = 'b0000100000101;
    parameter S_STOP_L6 = 'b0001000000101;
    parameter S_STOP_L7 = 'b0010000000101;
    parameter S_STOP_L8 = 'b0100000000101;
    parameter S_STOP_L9 = 'b1000000000101;
    parameter S_STOP_R8 = 'b0100000000110;
    parameter S_STOP_R7 = 'b0010000000110;
    parameter S_STOP_R6 = 'b0001000000110;
    parameter S_STOP_R5 = 'b0000100000110;
    parameter S_STOP_R4 = 'b0000010000110;
    parameter S_STOP_R3 = 'b0000001000110;
    parameter S_STOP_R2 = 'b0000000100110;
    parameter S_STOP_R1 = 'b0000000010110;



	// Output depends only on the state
	always @ (state) begin
		case (state)
            S_RESET:                                  LEDS = 'b0000000001;
            S_RUN_L0, S_STOP_L0: 						   LEDS = 'b0000000001;
            S_RUN_L1, S_RUN_R1, S_STOP_L1, S_STOP_R1: LEDS = 'b0000000010;
            S_RUN_L2, S_RUN_R2, S_STOP_L2, S_STOP_R2: LEDS = 'b0000000100;
            S_RUN_L3, S_RUN_R3, S_STOP_L3, S_STOP_R3: LEDS = 'b0000001000;
            S_RUN_L4, S_RUN_R4, S_STOP_L4, S_STOP_R4: LEDS = 'b0000010000;
            S_RUN_L5, S_RUN_R5, S_STOP_L5, S_STOP_R5: LEDS = 'b0000100000;
            S_RUN_L6, S_RUN_R6, S_STOP_L6, S_STOP_R6: LEDS = 'b0001000000;
            S_RUN_L7, S_RUN_R7, S_STOP_L7, S_STOP_R7: LEDS = 'b0010000000;
            S_RUN_L8, S_RUN_R8, S_STOP_L8, S_STOP_R8: LEDS = 'b0100000000;
            S_RUN_L9, S_STOP_L9:							   LEDS = 'b1000000000;
		endcase
	end

	// Determine the next state
	always @ (posedge Clock) begin
		if (RESET) begin
			state = S_RESET;
		end
		else begin
		    case (state)
                S_RESET:   state = S_RUN_L0;
                S_RUN_L0:  state = STOP ? S_STOP_L0 : S_RUN_L1;
                S_RUN_L1:  state = STOP ? S_STOP_L1 : S_RUN_L2;
                S_RUN_L2:  state = STOP ? S_STOP_L2 : S_RUN_L3;
                S_RUN_L3:  state = STOP ? S_STOP_L3 : S_RUN_L4;
                S_RUN_L4:  state = STOP ? S_STOP_L4 : S_RUN_L5;
                S_RUN_L5:  state = STOP ? S_STOP_L5 : S_RUN_L6;
                S_RUN_L6:  state = STOP ? S_STOP_L6 : S_RUN_L7;
                S_RUN_L7:  state = STOP ? S_STOP_L7 : S_RUN_L8;
                S_RUN_L8:  state = STOP ? S_STOP_L8 : S_RUN_L9;
                S_RUN_L9:  state = STOP ? S_STOP_L9 : S_RUN_R8;
                S_RUN_R8:  state = STOP ? S_STOP_R8 : S_RUN_R7;
                S_RUN_R7:  state = STOP ? S_STOP_R7 : S_RUN_R6;
                S_RUN_R6:  state = STOP ? S_STOP_R6 : S_RUN_R5;
                S_RUN_R5:  state = STOP ? S_STOP_R5 : S_RUN_R4;
                S_RUN_R4:  state = STOP ? S_STOP_R4 : S_RUN_R3;
                S_RUN_R3:  state = STOP ? S_STOP_R3 : S_RUN_R2;
                S_RUN_R2:  state = STOP ? S_STOP_R2 : S_RUN_R1;
                S_RUN_R1:  state = STOP ? S_STOP_R1 : S_RUN_L0;
                S_STOP_L0: if (START) state = S_RUN_L1;
                S_STOP_L1: if (START) state = S_RUN_L2;
                S_STOP_L2: if (START) state = S_RUN_L3;
                S_STOP_L3: if (START) state = S_RUN_L4;
                S_STOP_L4: if (START) state = S_RUN_L5;
                S_STOP_L5: if (START) state = S_RUN_L6;
                S_STOP_L6: if (START) state = S_RUN_L7;
                S_STOP_L7: if (START) state = S_RUN_L8;
                S_STOP_L8: if (START) state = S_RUN_L9;
                S_STOP_L9: if (START) state = S_RUN_R8;
                S_STOP_R8: if (START) state = S_RUN_R7;
                S_STOP_R7: if (START) state = S_RUN_R6;
                S_STOP_R6: if (START) state = S_RUN_R5;
                S_STOP_R5: if (START) state = S_RUN_R4;
                S_STOP_R4: if (START) state = S_RUN_R3;
                S_STOP_R3: if (START) state = S_RUN_R2;
                S_STOP_R2: if (START) state = S_RUN_R1;
                S_STOP_R1: if (START) state = S_RUN_L0;
            endcase
        end
	end

endmodule
