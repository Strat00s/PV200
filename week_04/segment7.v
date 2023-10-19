// module for translating 4-bit number to the 7-segment display
module segment7 (data, seg);

   //TASK1: complete module

	//  INPUT/OUTPUT declarations
	???	[3:0]	data;
	???	[6:0]	seg;

	//  REG/WIRE declarations

	//  Functional coding
			4'h0   : seg = 7'b1000000;
			4'h1   : seg = 7'b1111001;
			4'h2   : seg = 7'b0100100;
			4'h3   : seg = 7'b0110000;
			4'h4   : seg = 7'b0011001;
			4'h5   : seg = 7'b0010010;
			4'h6   : seg = 7'b0000010;
			4'h7   : seg = 7'b1111000;
			4'h8   : seg = 7'b0000000;
			//4'h9   missing
			4'hA   : seg = 7'b0001000;
			4'hb   : seg = 7'b0000011;
			//4'hC   missing
			4'hd   : seg = 7'b0100001;
			4'hE   : seg = 7'b0000110;
			4'hF   : seg = 7'b0001110;
			default: seg = 7'b1111111; 		


endmodule

