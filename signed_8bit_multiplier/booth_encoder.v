module booth_encoder (j_0_1, j_0, plus, minus);
	input j_0_1, j_0;
	output plus, minus;
	
	assign plus = j_0_1 & (~j_0);
	assign minus = j_0 & (~j_0_1);
endmodule