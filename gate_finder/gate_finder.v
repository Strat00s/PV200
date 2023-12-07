// Sequential gate finder

module gate_finder(input CLOCK_50, input [3:0]KEY, output reg [9:0]LEDR, inout [35:0]GPIO_0);
	assign rst = ~KEY[0];
	
    // pin configuration
    wire [11:0] pins_in;
    reg  [11:0] pins_out = 0; // all to 0
    reg  [11:0] pins_dir = 0; // all inputs (high Z)

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

    // assign outputs
    assign pins_in[0]  = GPIO_0[24];
    assign pins_in[1]  = GPIO_0[22];
    assign pins_in[2]  = GPIO_0[20];
    assign pins_in[3]  = GPIO_0[34];
    assign pins_in[4]  = GPIO_0[32];
    assign pins_in[5]  = GPIO_0[30];
    assign pins_in[6]  = GPIO_0[25];
    assign pins_in[7]  = GPIO_0[23];
    assign pins_in[8]  = GPIO_0[21];
    assign pins_in[9]  = GPIO_0[35];
    assign pins_in[10] = GPIO_0[33];
    assign pins_in[11] = GPIO_0[31];


    // slow clock for debuging
    wire slow;
	clock_divider s_clk(
		.clk(CLOCK_50),
		.reset(1'b0),
		.out(slow)
	);
	
	

    // state
    parameter RESET         = 0;
    parameter NOT_TEST      = 1;
    parameter AND_TEST      = 2;
    parameter OR_TEST       = 3;
    parameter XOR_TEST      = 4;
    parameter FINISHED      = 5;
    parameter FAILED        = 6;
    reg [7:0] state    = RESET; // current state


    // gpio read/write action
    parameter READ  = 0;
    parameter WRITE = 1;
    // gpio in/out config
    parameter IN  = 0;
    parameter OUT = 1;
    reg rw = WRITE; //gpio read/write state


    reg [9:0] result    = 0; // resulting LED pattern to show once gate type is determined
    integer i           = 0;
    integer test_val    = 0; // value for which to test the output for (0, 1, 10, ...)
    integer func_match  = 0; // counter for determining if all function outputs were encountered
    integer match_cnt   = 0; // valid gate output counter
    reg reset_all     = 0;

    always @(posedge slow, posedge rst) begin
        // go to rst state on rset
        if (rst) begin
            state = RESET;
        end

        else if (state == RESET) begin
            reset_all = 1;
            state     = NOT_TEST;
        end

        // reset everything
        else if (reset_all) begin
            reset_all  = 0;
            rw         = WRITE;
            test_val   = 0;
            func_match = 0;
            match_cnt  = 0;
            LEDR       = 0;
            result     = 0;

            //reset all pins
            for (i = 0 ; i < 12; i = i + 1) begin
                pins_dir = IN;
                pins_out = 0;
            end

            i = 0;
        end

        // Start with NOT
        else if (state == NOT_TEST) begin
            result[9] = 1; // last LED is for NOT
            // Go through every possible gate for NOT (3 on each side)
            // Write to pins
            if (rw == WRITE) begin
                rw = READ;
                pins_out[i] = test_val[0];
                pins_dir[i] = OUT;
                test_val = test_val + 1;
            end

            // Read from pins on next clock
            else begin
                rw = WRITE;

                // NOT -> match if input is not output
                if (pins_out[i] == ~pins_in[i + 1])
                    func_match = func_match + 1;

               // NOT only has 2 states
                if (test_val == 2) begin
                    test_val = 0;

                    // if we have a match, it is most likely a valid NOT gate
                    if (func_match == 2) begin
                        match_cnt = match_cnt + 1;
                        result[i / 2] = 1;
                    end

                    i = i + 2;  // move to next pin
                    func_match = 0;
                end
            end

            if (i >= 12) begin
                if (match_cnt >= 3) begin
                    state = FINISHED;
                end
                else begin
                    reset_all = 1;
                    state = AND_TEST;
                end
            end
        end

        // AND test
        else if (state == AND_TEST) begin
            result[8] = 1; // second to last LED is for AND
            // Write to pins
            if (rw == WRITE) begin
                rw = READ;
                pins_out[i]     = test_val[0];
                pins_out[i + 1] = test_val[1];
                pins_dir[i]     = OUT;
                pins_dir[i + 1] = OUT;
                test_val = test_val + 1;
            end

            // Read from pins on next clock
            else begin
                rw = WRITE;

                // A and B == X
                if ((pins_out[i] & pins_out[i + 1]) == pins_in[i + 2])
                    func_match = func_match + 1;

               // AND has 4 func values
                if (test_val == 4) begin
                    test_val = 0;

                    // if we have a full function match, it is most likely an AND gate
                    if (func_match == 4) begin
                        match_cnt = match_cnt + 1;
                        result[i / 3] = 1;
                    end

                    i = i + 3;  // move to next pin
                    func_match = 0;
                end
            end

            if (i >= 12) begin
                if (match_cnt >= 2) begin
                    state = FINISHED;
                end
                else begin
                    reset_all = 1;
                    state = OR_TEST;
                end
            end
        end


        // OR test
        else if (state == OR_TEST) begin
            result[7] = 1; // third to last for OR
            // Write to pins
            if (rw == WRITE) begin
                rw = READ;
                pins_out[i]     = test_val[0];
                pins_out[i + 1] = test_val[1];
                pins_dir[i]     = OUT;
                pins_dir[i + 1] = OUT;
                test_val = test_val + 1;
            end

            // Read from pins on next clock
            else begin
                rw = WRITE;

                // A or B == X
                if ((pins_out[i] | pins_out[i + 1]) == pins_in[i + 2])
                    func_match = func_match + 1;

               // OR has 4 func values
                if (test_val == 4) begin
                    test_val = 0;

                    // if we have a full function match, it is most likely an AND gate
                    if (func_match == 4) begin
                        match_cnt = match_cnt + 1;
                        result[i / 3] = 1;
                    end

                    i = i + 3;  // move to next pin
                    func_match = 0;
                end
            end

            if (i >= 12) begin
                if (match_cnt >= 2) begin
                    state = FINISHED;
                end
                else begin
                    reset_all = 1;
                    state = XOR_TEST;
                end
            end
        end


        // XOR test
        else if (state == XOR_TEST) begin
            result[6] = 1; // fourth to last for XOR

            // Write to pins
            if (rw == WRITE) begin
                rw = READ;
                pins_out[i]     = test_val[0];
                pins_out[i + 1] = test_val[1];
                pins_dir[i]     = OUT;
                pins_dir[i + 1] = OUT;
                test_val = test_val + 1;
            end

            // Read from pins on next clock
            else begin
                rw = WRITE;

                // A xor B == X
                if ((pins_out[i] ^ pins_out[i + 1]) == pins_in[i + 2])
                    func_match = func_match + 1;

                if (test_val == 4) begin
                    test_val = 0;

                    // full function match
                    if (func_match == 4) begin
                        match_cnt = match_cnt + 1;
                        result[i / 3] = 1;
                    end

                    i = i + 3;  // move to next pin
                    func_match = 0;
                end
            end

            if (i >= 12) begin
                if (match_cnt >= 2) begin
                    state = FINISHED;
                end
                else begin
                    reset_all = 1;
                    state = FAILED;
                end
            end
        end


        else if (state == FINISHED) begin
            // nothing to see here. Just wait for a reset
        end

        else if (state == FAILED) begin
            // nothing to see here. Just wait for a reset
        end

        LEDR = result;

	end
	
	
	
	
	
endmodule