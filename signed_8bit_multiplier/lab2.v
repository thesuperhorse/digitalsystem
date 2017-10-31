/*
 * This is a top level module that connects the switches and the 7-segment hex displays
 * to your multiplier.
 *
 * inputs:
 *		SW[7:0]			The 8-bit multiplier/multiplicand
 *		KEY[0]			Enter 1st number
 *		KEY[1]			Enter 2nd number
 *	outputs:
 *		HEX[3:0]			The multiplication result
*/

module lab2(SW, KEY, HEX3, HEX2, HEX1, HEX0);
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	input [8:0] SW;
	input [1:0] KEY;

	reg [7:0] a_reg;
	reg [7:0] b_reg;
	wire signed [15:0] result;

	/* Connect switches to the multiplier. */
	always @(negedge KEY[0], negedge KEY[1])begin
		if (KEY[0] == 1'b0) begin
			a_reg <= SW[7:0];
		end else if (KEY[1] == 1'b0) begin
			b_reg <= SW[7:0];
		end
	end // actually not a good design pattern so we will change it once we have everything working

	/* Your multiplier circuit goes here. */
	parameter n = 8; // 8x8 multiplication
	localparam zero = 1'b0;
	genvar i, j; // two iterators for cascading of FAs

	// step 1: create initial set of wires with initial weights
	wire [7:0] mat [7:0];
	generate
		for(i=0; i<n; i=i+1) begin: first iterator
			for(j=0; j<n; j=j+1) begin: second iterator
				assign mat[i][j] = a_reg[i] & b_reg[j];
			end
		end
	endgenerate

	// step 2: dissolve all wires of different weights into one wire
	// lowercase ~ horizontal, uppercase ~ vertical
	wire [12:0] a;
	wire [10:0] b;
	wire [8:0] c;
	wire [6:0] d;
	wire [5:0] F, G;
	wire [4:0] e, E, H;
	wire [3:0] D, I;
	wire [2:0] f, C, J;
	wire [1:0] B, K;
	wire [0:0] g, A, L;


	assign result[0] = mat[0][0];
	generate
		for(i=0; i<n-1/*8*/; i=i+1) // 8 HAs, but only generate 7 HAs, last HA is special
		begin: first row; half-adders part
			half_adder row1(.a(a[i]), .b(), .c(a[i+1]), .s(result[i+2]));
		end
		for(i=7; i<2(n-2); i=i+1) begin: first row; full-adders part
			full_adder row1_f(.a(), .b(), .cin(a[i]), .cout(a[i+1], .pout(result[i+1]));
		end
	endgenerate

	assign result = {};

	/* Multiplication result goes to HEX displays. */
	hex_digits h0(result[3:0],   HEX0);
	hex_digits h1(result[7:4],   HEX1);
	hex_digits h2(result[11:8],  HEX2);
	hex_digits h3(result[15:12], HEX3);

endmodule
