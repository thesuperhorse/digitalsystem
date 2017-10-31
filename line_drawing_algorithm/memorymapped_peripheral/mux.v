module mux (in0, in1, in2, select, out);
	input [8:0] in0, in1, in2;
	input [1:0] select;
	output reg [8:0] out;

	always @(*)
		case (select)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			default: out = 9'b000000000;
		endcase
endmodule 