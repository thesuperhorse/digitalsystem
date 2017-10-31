module absolute (A, B, result);
	input [8:0] A, B;
	output [8:0] result;
	
	assign result = (A > B) ? (A-B) : (B-A);
endmodule
