// Single port RAM with single read/write address 

module ram 
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=4)
(
	input [(DATA_WIDTH-1):0] data_in,
	output reg [(DATA_WIDTH-1):0] data_out,
	input [(ADDR_WIDTH-1):0] addr,
	input re, we, clk
);


// place for your code

	
endmodule
