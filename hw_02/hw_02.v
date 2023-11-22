
module hw_02(input CLOCK_50, input [3:0] KEY, output [9:0] LEDR);
	
	//assign LEDR[3:0] = KEY;
	running_light m1(!KEY[0], !KEY[1], !KEY[2], !KEY[3], LEDR);
	
endmodule
