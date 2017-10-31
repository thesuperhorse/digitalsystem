module ripple_carry_adder (a, b, cin, cout, s); // 8 bit
	input [7:0] a;
	input [7:0] b;
	output [7:0] s;
	input cin;
	output cout;
	
	wire [8:0] c;
	assign c[0] = cin;
	assign cout = c[8];
	
	genvar i;
	parameter n = 8;
	generate
		for(i=0; i < n; i=i+1) begin: ripple
			full_adder fa_stage(.a(a[i]), .b(b[i]), .cin(c[i]), .cout(c[i+1]), .pout(s[i]));
		end	
	endgenerate
	
endmodule