`timescale 1ns / 1ns

module ram_tb ();
	reg [3:0] addr_tb;
	reg clock_tb;
	reg [7:0] din_tb;
	reg rden_tb;
	reg wren_tb;
	wire [7:0] dout_tb;
	
	initial
		begin: CLOCK_GENERATOR
			clock_tb = 0;
			forever
				begin
					#5 clock_tb = ~clock_tb;
				end
		end
	
	initial
		begin
			addr_tb <= 4'h0; din_tb <= 8'h0; rden_tb <= 0; wren_tb <= 0;

			#20 din_tb <= 8'h05; wren_tb <= 1;
			#10 din_tb <= 8'h00; wren_tb <= 0;

			#20 addr_tb <= 4'h5; din_tb <= 8'h03; wren_tb <= 1;
			#10 addr_tb <= 4'h5; din_tb <= 8'h00; wren_tb <= 0;

			#10 addr_tb <= 4'h0; rden_tb <= 1;
			#10 addr_tb <= 4'h5; rden_tb <= 1;
			#10 addr_tb <= 4'h0; rden_tb <= 1;
		end
		
	ram ram1 (din_tb, dout_tb, addr_tb, rden_tb, wren_tb, clock_tb);
endmodule