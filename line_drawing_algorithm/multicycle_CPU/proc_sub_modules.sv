`timescale 1 ns / 1 ns

module upcount(Clear, Clock, Q);
	parameter n = 2;
	input Clear, Clock;
	output [n-1:0] Q;
	
	reg [n-1:0] Q;
	
	always @(posedge Clock)
		if (Clear)
		Q <= {(n){1'b0}};
		else
		Q <= Q + 1'b1;	
endmodule

module count_reg(Clear, Clock, Q, En, L, R);
	parameter n = 16;
	input Clear, Clock, En, L;
	input [n-1:0] R;
	output [n-1:0] Q;
	
	reg [n-1:0] Q;
	
	always @(posedge Clock)
		if (Clear)
		Q <= {(n){1'b0}};
		else if (L)
		Q <= R;
		else
		Q <= Q + (En == 1'b1);	
endmodule

module dec3to8(W, En, Y);
	input [2:0] W;
	input En;
	output [7:0] Y;
	
	reg [7:0] Y;
	
	always @(W or En)
		begin
		if (En == 1)
			case (W)
				3'b000: Y = 8'b00000001;
				3'b001: Y = 8'b00000010;
				3'b010: Y = 8'b00000100;
				3'b011: Y = 8'b00001000;
				3'b100: Y = 8'b00010000;
				3'b101: Y = 8'b00100000;
				3'b110: Y = 8'b01000000;
				3'b111: Y = 8'b10000000;
			endcase
		else
			Y = 8'b00000000;
		end
		
endmodule

module regn(R, Rin, Clock, Q);
	parameter n = 16;
	input [n-1:0] R;
	input Rin, Clock;
	output [n-1:0] Q;
	
	reg [n-1:0] Q;
	
	always @(posedge Clock)
		if (Rin)
			Q <= R;
endmodule

module mux(
	input [7:0] R_sel,
	input G_sel,
	input DIN_sel,
	input [15:0] R0,
	input [15:0] R1,
	input [15:0] R2,
	input [15:0] R3,
	input [15:0] R4,
	input [15:0] R5,
	input [15:0] R6,
	input [15:0] R7,
	input [15:0] G,
	input [15:0] DIN, 
	output logic [15:0] out
);

	always_comb begin
		if 		(R_sel[0]) 	out = R0;
		else if (R_sel[1]) 	out = R1;
		else if (R_sel[2]) 	out = R2;
		else if (R_sel[3]) 	out = R3;
		else if (R_sel[4]) 	out = R4;
		else if (R_sel[5]) 	out = R5;
		else if (R_sel[6]) 	out = R6;
		else if (R_sel[7]) 	out = R7;
		else if (G_sel) 	out = G;
		else if (DIN_sel) 	out = DIN;
		else 				out = 16'd0;
	end

endmodule

module AddSubModule (
	input [15:0] a,
	input [15:0] b, 
	input is_sub,
	output [15:0] result
);
	assign result = (is_sub) ? (a - b) : (a + b);
endmodule
