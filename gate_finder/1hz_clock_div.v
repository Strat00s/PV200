module clock_divider(
    input clk,        // input clock (50 MHz)
    input rst,
    output reg out    // output clock
);

// Determine the number of bits for the counter. 
// Since 25,000,000 is a 25-bit number, use a 25-bit counter.
reg [24:0] counter;  

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the counter and the output
        counter <= 0;
        out <= 0;
    end else begin
        if (counter == 1000000) begin
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