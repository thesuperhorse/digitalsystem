module mult_cell(plus, minus, cin, cout, pin, pout, m); // following diagram of page 2 on lab 2 handout
	input plus, minus, cin, pin, m;
	output cout, pout;
	wire sign, _plus, _minus;
	
	assign _plus = plus & m;
	assign _minus = minus & (~m);
	assign sign = _plus | _minus;
	full_adder fa(.a(pin), .b(sign), .cin(cin), .cout(cout), .pout(pout));
	
endmodule