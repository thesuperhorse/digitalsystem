`timescale 1 ns / 1 ns

module proc_datapath (
	input clk,
	input resetn,
	
	input [7:0] Rin_sel,
	input Gin, 
	input Ain,
	input IRin,
	input W_D,
	input DOUT_in,
	input ADDR_in,
	
	input [7:0] Rout_sel,
	input G_out,
	input DIN_out,
	input PC_incr,
	
	input AddSub,
	
	input [15:0] DIN,
	
	output [15:0] bus, 
	output [15:0] DOUT,
	output [15:0] ADDR,
	output [8:0] IR,
	output W,
	output logic [15:0] G
);

	logic [15:0] addsub_result;
	logic [15:0] R0, R1, R2, R3, R4, R5, R6, R7, /*G*/ A;
	
	regn R0_reg(bus, Rin_sel[0], clk, R0);
	regn R1_reg(bus, Rin_sel[1], clk, R1);
	regn R2_reg(bus, Rin_sel[2], clk, R2);
	regn R3_reg(bus, Rin_sel[3], clk, R3);
	regn R4_reg(bus, Rin_sel[4], clk, R4);
	regn R5_reg(bus, Rin_sel[5], clk, R5);
	regn R6_reg(bus, Rin_sel[6], clk, R6);
	//regn R7_reg(bus, Rin_sel[7], clk, R7);
	count_reg R7_reg (~resetn, clk, R7, PC_incr, Rin_sel[7], bus);
	regn A_reg (bus, Ain, clk, A);
	regn G_reg (addsub_result, Gin, clk, G);
	
	regn DOUT_reg(bus, DOUT_in, clk, DOUT);
	regn ADDR_reg(bus, ADDR_in, clk, ADDR);
	regn W_reg(W_D, 1'b1, clk, W);
	defparam W_reg.n = 1;
	
	mux mux_proc (
		.R_sel(Rout_sel), 
		.G_sel(G_out),
		.DIN_sel(DIN_out),
		.R0(R0),
		.R1(R1),
		.R2(R2),
		.R3(R3),
		.R4(R4),
		.R5(R5),
		.R6(R6),
		.R7(R7),
		.G(G),
		.DIN(DIN),
		.out(bus)
	);
	
	AddSubModule a0 (
		.a(A),
		.b(bus), 
		.is_sub(AddSub),
		.result(addsub_result)
	);
	
	regn IR_reg (
		.R(DIN[15:7]),
		.Rin(IRin),
		.Clock(clk),
		.Q(IR)
	);
	defparam IR_reg.n = 9;

endmodule