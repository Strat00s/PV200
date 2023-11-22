`timescale 1 ns/1 ns

module adder_tb();

	// Wires and variables to connect to DUT
	reg  [3:0] a, b;
	wire [3:0] sum;
	
	integer i,j;
	
	// Instantiate unit under test (adder)
	adder adder1 (.a(a), .b(b), .sum(sum));
	

	// Assign values to "a" and "b" to test adder block
	initial begin
		a = 4'd0;
		b = 4'd0;
		
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; i < 16; j = j + 1) begin
				#10 a = i;
				b = j;
				
				#10 if (sum != a + b) begin
					$display("ERROR a=%0d, b=%0d sum=%0d", a, b, sum);
				end
			end
		end
	end
	
	
endmodule
