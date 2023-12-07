

module gate_finder(input CLOCK_50, input [3:0]KEY, output reg [9:0]LEDR, inout [35:0]GPIO_0);
	assign reset = ~KEY[0];
	
    // setup """easy""" gpio lookup arrays
	reg [5:0] pins[11:0];

    initial begin
        pins[0]  = 24;
        pins[1]  = 22;
        pins[2]  = 20;
        pins[3]  = 34;
        pins[4]  = 32;
        pins[5]  = 30;
        pins[6]  = 25;
        pins[7]  = 23;
        pins[8]  = 21;
        pins[9]  = 35;
        pins[10] = 33;
        pins[11] = 31;
    end


    // 1Hz clock divider for testing
	wire slow;
	clock_divider s_clk(
		.clk(CLOCK_50),
		.reset(1'b0),
		.out(slow)
	);
	
	
	// gate type
	parameter NONE = 0;
    parameter NOT  = 1;
    parameter AND  = 2;
    parameter OR   = 3;
    parameter XOR  = 4;

    // state
    parameter RESET         = 0;
    parameter NOT_TEST      = 1;
    parameter DETERMINE_NOT = 4;
    parameter GATE_DETECT   = 5;
    parameter FINISHED      = 6;
    parameter FAILED        = 7;


    // gpio read/write action
    parameter WRITE = 0;
    parameter READ  = 1;

    // gpio in/out config
    parameter IN  = 0;
    parameter OUT = 1;
	

    reg [7:0] gate_type = NONE; // found gate type
    reg [7:0] state    = RESET; // current state


    reg rw = WRITE; //gpio read/write state
    reg dir             = 0; // gpio direction
    reg [11:0] pins_out = 0; // all to 0
    reg [11:0] pins_dir = 0; // all inputs (high Z)


    reg [7:0] match_cnt; // valid gate output counter

    // resulting LED pattern to show once gate type is determined
    reg [9:0] result;


    // Assign to all our pins
    assign GPIO_0[24] = pins_dir[0]  ? pins_out[0]  : 1'bz;
    assign GPIO_0[22] = pins_dir[1]  ? pins_out[1]  : 1'bz;
    assign GPIO_0[20] = pins_dir[2]  ? pins_out[2]  : 1'bz;
    assign GPIO_0[34] = pins_dir[3]  ? pins_out[3]  : 1'bz;
    assign GPIO_0[32] = pins_dir[4]  ? pins_out[4]  : 1'bz;
    assign GPIO_0[30] = pins_dir[5]  ? pins_out[5]  : 1'bz;
    assign GPIO_0[25] = pins_dir[6]  ? pins_out[6]  : 1'bz;
    assign GPIO_0[23] = pins_dir[7]  ? pins_out[7]  : 1'bz;
    assign GPIO_0[21] = pins_dir[8]  ? pins_out[8]  : 1'bz;
    assign GPIO_0[35] = pins_dir[9]  ? pins_out[9]  : 1'bz;
    assign GPIO_0[33] = pins_dir[10] ? pins_out[10] : 1'bz;
    assign GPIO_0[31] = pins_dir[11] ? pins_out[11] : 1'bz;


    integer i = 0;
    integer test_val = 0;
    integer j = 0;
    integer state_cnt = 0;
    integer state_match = 0;

    always @(posedge slow, posedge reset) begin
        // go to reset state on rset
        if (reset) begin
            state = RESET;
            gate_type = NONE;
        end

        // reset all pins to high-Z in reset state
        else if (state == RESET) begin
            state       = NOT_TEST;
            i           = 0;
            test_val    = 0;
            match_cnt   = 0;
            state_cnt   = 0;
            state_match = 0;
            LEDR        = 10'b0000000000;
            result      = 10'b0000000000;

            for (j = 0 ; j < 12; j = j + 1) begin
                pins_dir = IN;
                pins_out = 0;
            end
        end

        else if (state == NOT_TEST) begin
            // Go through every possible gate for NOT (3 on each side)
            // Write to pins
            if (rw == WRITE) begin
                rw = READ;
                // toggle pins one by one (while skipping probably input)
                pins_out[i] = test_val[0];
                pins_dir[i] = OUT;

                test_val = test_val + 1;
            end

            // Read from pins on next clock
            else begin
                rw = WRITE;

                // NOT -> match if input is not output
                if (pins_out[i] == ~GPIO_0[pins[i + 1]])
                    state_match = state_match + 1;

               // NOT only has 2 states
                if (test_val == 2) begin
                    test_val = 0;
						  
						  // if we have a match, it is most likely a valid NOT gate
                    if (state_match == 2) begin
                        match_cnt = match_cnt + 1;
                        result[9] = 1;
                        result[i / 2] = 1;
                    end
						  
                    i = i + 2;  // move to next pin
                    state_match = 0;
                end
            end

            // debuging
            LEDR[7:6] = test_val;
            LEDR[4:0] = match_cnt;

            if (i >= 12)
                state = DETERMINE_NOT;
        end

        else if (state == DETERMINE_NOT) begin
            
            // Let's say that at least half must be OK
            if (match_cnt > 3)
                state = FINISHED;
            else
                state = FAILED;
        end

        else if (state == FINISHED) begin
            LEDR = result;
        end
        else if (state == FAILED) begin
            LEDR = 10'b1111111111;
        end
        //else if (gate_type == NOT) begin
        //    if (state == WRITE) begin
        //    end
        //    else if (state == READ) begin
        //    end
        //end
        //else if (gate_type == AND) begin
        //    if (state == WRITE) begin
        //    end
        //    else if (state == READ) begin
        //    end
        //end
        //else if (gate_type == OR) begin
        //    if (state == WRITE) begin
        //    end
        //    else if (state == READ) begin
        //    end
        //end
        //else if (gate_type == XOR) begin
        //    if (state == WRITE) begin
        //    end
        //    else if (state == READ) begin
        //    end
        //end

	end
	
	
	
	
	
endmodule