`timescale 1 ns/1 ns

module adder_tb();

	// Wires and variables to connect to DUT
	reg  [3:0] a, b;
	wire [3:0] sum;
	
	// Instantiate unit under test (adder)
	adder adder1 (.a(a), .b(b), .sum(sum));
	

	// Assign values to "a" and "b" to test adder block
	initial begin
		a = 4'd3;
		b = 4'd7;
		#10 $display(" a=%0d,b=%0d,sum=%0d",a,b,sum);
		#10 a = 4'd0;
		b = 16'd1;
		#10 $display(" a=%0d,b=%0d,sum=%0d",a,b,sum);
		#10 a = 4'd10;
		b = 16'd5;
	end
	
	
endmodule
