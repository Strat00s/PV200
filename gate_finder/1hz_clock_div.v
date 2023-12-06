module clock_divider(
    input clk,        // Input clock (50 MHz)
    input reset,      // Synchronous reset
    output reg out    // Output clock (1 Hz)
);

// Determine the number of bits for the counter. 
// Since 25,000,000 is a 25-bit number, use a 25-bit counter.
reg [24:0] counter;  

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the counter and the output
        counter <= 0;
        out <= 0;
    end else begin
        if (counter == 24_999_999) begin
            // Reset the counter and toggle the output
            counter <= 0;
            out <= ~out;
        end else begin
            // Increment the counter
            counter <= counter + 1;
        end
    end
end

endmodule