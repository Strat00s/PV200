
//=======================================================
//  Module delcaration
//=======================================================

module week_08a(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
	wire	[7:0] NUM1; // left two digits
	wire	[7:0] NUM2;	// middle two digits
	wire	[7:0] NUM3; // right two digits
	
	

//=======================================================
//  Functional coding
//=======================================================

	segment7 digit0 (1'b1,NUM3[3:0],HEX0);
	segment7 digit1 (1'b1,NUM3[7:4],HEX1);
	segment7 digit2 (1'b1,NUM2[3:0],HEX2);
	segment7 digit3 (1'b1,NUM2[7:4],HEX3);
	segment7 digit4 (1'b1,NUM1[3:0],HEX4);
	segment7 digit5 (1'b1,NUM1[7:4],HEX5);

	assign NUM1 = {4'b0000,SW[9:6]};
	assign NUM2 = {4'b0000,SW[5:2]};
	assign NUM3[7:4] = 4'b0000;
	
	
	adder u1(.a(NUM1[3:0]),.b(NUM2[3:0]),.sum(NUM3[3:0]));

	// **************************************************
	// TASK 1: 
	//   rewrite adder_tb.b for testing of all combinations
	// 
	// **************************************************

	// **************************************************
	// TASK 2: 
	//   1) add to adder v injectioon of error in some combination of inputs
	//   2) add to adder_tb.b detection of wrong adding
	
	// **************************************************


endmodule
