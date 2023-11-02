// PWM module
module pwm(
	input 		clk,   // input clock
	input 		clken, // input clock enable
	input [7:0] duty,  // duty cycle
	output reg 	out	 // generated signal
	);

	
	reg [7:0] counter;
	
	// TASK 1b: something is missing in this code from last week
	
	always @(posedge clk)
	begin
     counter <= counter + 8'd1;
  
     if ((~|duty)|(counter > duty))
	    out <= 1'b0;
	  else
	    out <= 1'b1;	  
	  end
	  
endmodule
	
	
	