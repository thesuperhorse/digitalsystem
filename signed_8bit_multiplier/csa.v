module carry_save_adder(a, b, s) // 8 bit
// UNTESTED UNTESTED UNTESTED
	input [7:0]a;
	input [7:0]b;
	output [8:0]s;
	
	wire [7:0]carries;
	wire [7:0]p_sum;
	parameter n = 8;
	localparam zero = 1'b0;
	genvar i;
	generate
		for(i = 0; i < n; i=i+1) begin: adding
			full_adder add_stage(.a(a[0]), .b(b[0]), .cin(zero), .cout(carries[i]), .pout(p_sum[i]));
		end
	endgenerate
	wire [7:0]sum;
	carry_lookahead_adder fast_stage(.a(carries[7:0]), .b({1'b0,[7:1]p_sum}), .s(sum), .cout(), .cin(zero));
	assign s = {sum, p_sum[0]};
	
endmodule