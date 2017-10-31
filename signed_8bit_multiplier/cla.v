module carry_lookahead_adder (a, b, s, cout, cin);
	input [7:0] a;
	input [7:0] b;
	input cin;
	output cout;
	output [7:0] s;
	
	wire [7:0] g;
	wire [7:0] p;
	wire [8:0] c;
	assign c[0] = cin;
	
	genvar i;
	parameter n = 8;
	generate
		for(i=0; i<n; i=i+1) begin: lookahead
			assign g[i] = a[i] & b[i];
			assign p[i] = a[i] | b[i];
			assign c[i+1] = g[i] | p[i] & c[i];
			assign s[i] = a[i] ^ b[i] ^ c[i];
		end
	endgenerate
	assign cout = c[8];
	
endmodule