module half_adder_v (input A, input B, output SUM, output CARRY);
	xor(SUM, A, B);
	and(CARRY, A, B);
endmodule


module full_adder_v (input A, input B, input C_in, input SUM, input CARRY);
	reg [0:0] tmp_sum;
	reg [0:0] tmp_carry1;
	reg [0:0] tmp_carry2;
	
	half_adder_v adder1(A, B, tmp_sum, tmp_carry1);
	half_adder_v adder2(C_in, tmp_sum, SUM, tmp_carry2);
	or(CARRY, tmp_carry1, tmp_carry2);
endmodule




