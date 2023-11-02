// PWM module
module pwm(
	input 		clk,   // input clock
	input [7:0] duty,  // duty cycle
	output reg 	out	 // generated signal
	);

	reg [7:0] cnt = 0;
// TASK 4: write the code for PWM
	always @(posedge clk) begin
		cnt <= cnt + 1;
		out <= cnt < duty ? 1:0;
	end
endmodule
	
	
	