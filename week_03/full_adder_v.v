module full_adder_v (input C_in, input A, input B, output SUM, output CARRY);
	wire ab_sum;
	wire ab_carry;
	wire abc_carry;
	
	half_adder_v adder1(A, B, ab_sum, ab_carry);
	half_adder_v adder2(C_in, ab_sum, SUM, abc_carry);
	or(CARRY, ab_carry, abc_carry);
endmodule