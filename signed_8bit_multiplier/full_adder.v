module full_adder(a, b, cin, cout, pout); // https://www.elprocus.com/half-adder-and-full-adder/
	input a, b, cin;
	output cout, pout;
	wire first_s, first_c, second_c;
	half_adder first(.a(a), .b(b), .s(first_s), .c(first_c));
	half_adder second(.a(first_s), .b(cin), .s(pout), .c(second_c));
	assign cout = second_c | first_c;
endmodule

module half_adder(a, b, s, c); // http://www.circuitstoday.com/half-adder
	input a, b;
	output s, c;
	assign s = a ^ b;
	assign c = a & b;
endmodule