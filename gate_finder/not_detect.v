// Simple not detect

module not_detect(
    input clk,            // main clock
    input rst,            // asynchronous reset
    input enable,         // enable signal to start working
    // GPIO control
    input  [11:0]pins_in,
    output [11:0]pins_out,
    output [11:0]pins_dir,
    // module output
    output reg is_done,      // is this module done
    output reg is_not,    // did we find a NOT?
    output reg [5:0]gates // what gates corespond to NOT
);


    parameter RUN  = 0;
    parameter STOP = 1;
    reg state      = RUN;


    parameter READ  = 0;
    parameter WRITE = 1;
    reg rw          = WRITE;


    reg test_val = 0; //value being tested on pins
    reg [1:0] func_match = 0; // counter to test if output matches the function in every step
    reg [3:0] match_cnt = 0; // total matches


    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state      = RUN;
            rw         = WRITE;
            test_val   = 0;
            func_match = 0;
            match_cnt  = 0;
            is_done  = 0;
            is_not   = 0;
            gates = 6'b000000;
        end

        else if (enable && state == RUN) begin
            // Go through every possible gate for NOT (3 on each side)
            // First write to pins
            if (rw == WRITE) begin
                rw = READ; //next will be read operation
                pins_out[i] = test_val;
                pins_dir[i] = OUT;
                test_val = 1; //next test value
            end

            // Then read from them
            else begin
                rw = WRITE;

                // NOT -> input is not output
                if (pins_out[i] == ~GPIO_0[pins[i + 1]])
                    func_match = func_match + 1;

               // NOT only has 2 states
                if (test_val == 1) begin
                    test_val = 0;
                    
                    // if we have conseutive function matches, it is most likely a valid NOT gate
                    if (func_match == 2) begin
                        match_cnt = match_cnt + 1;
                        gates[i / 2] = 1;
                    end

                    func_match = 0; //reset function match
                    i = i + 2;  // move to next pin
                end
            end

            // end once all pins were tested
            if (i >= 12) begin
                state = STOP;
                // at least half for a valid NOT gate array
                is_not = match_cnt >= 3 ? 1 : 0;
                is_done = 1;
            end
        end
    end

endmodule