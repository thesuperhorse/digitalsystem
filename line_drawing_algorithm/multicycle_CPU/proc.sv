`timescale 1 ns / 1 ns

/* R7 --> Counter (R7)
ADDR register
DOUT register
*/
module proc (
	input [15:0] DIN,

	input Resetn, 
	input Clock, 
	input Run, 

	output logic Done, 
	output W,
	
	output [15:0] ADDR, 
	output [15:0] DOUT
);
	
	logic [15:0] BusWires, G;
	logic [8:0] IR;
	logic [7:0] Xreg, Yreg, Rin_sel, Rout_sel;
	logic [2:0] I;
	logic [2:0] Tstep_Q;
	logic Clear, Gin, Ain, IRin, G_out, DIN_out, AddSub;
	logic PC_incr, ADDR_in, DOUT_in, W_D;

	assign I = IR[8:6]; 

	upcount Tstep (
		.Clear(Clear),
		.Clock(Clock),
		.Q(Tstep_Q)
	);
	defparam Tstep.n = 3;

	dec3to8 decX (
		.W (IR[5:3]),
		.En(1'b1),
		.Y (Xreg)
	);

	dec3to8 decY (
		.W (IR[2:0]),
		.En(1'b1),
		.Y (Yreg)
	);

	always @* begin
		Rin_sel = 8'b0;
		Rout_sel = 8'b0;
		Gin = 1'b0;
		Ain = 1'b0;
		IRin = 1'b0;
		G_out = 1'b0;
		DIN_out = 1'b0;
		AddSub = 1'b0;
		Done = 1'b0;
		Clear = 1'b1;
		PC_incr = 1'b0;
		ADDR_in = 1'b0;
		DOUT_in = 1'b0;
		W_D = 1'b0;
		
		case (Tstep_Q)
			3'd0: begin ADDR_in = 1'b1; Rout_sel = 8'b10000000; Clear = ~Run; end
			
			3'd1: begin
				IRin = 1'b1;
				Clear = 1'b0;
				case(DIN[15:13])
					3'd1: begin PC_incr = 1'b1; end
					default: ;
				endcase
			end
			
			3'd2:
				case (I)
					3'd0: begin Done = 1'b1; Rout_sel = Yreg; Rin_sel = Xreg; 
						PC_incr = 1'b1; end
					3'd1: begin Rout_sel = 8'b10000000; ADDR_in = 1'b1; Clear = 1'b0; end
					3'd2: begin Ain = 1'b1; Rout_sel = Xreg; Clear = 1'b0; end
					3'd3: begin Ain = 1'b1; Rout_sel = Xreg; Clear = 1'b0; end
					3'd4: begin /*ld Rx, [Ry]*/ ADDR_in = 1'b1; Rout_sel = Yreg; Clear = 1'b0; end
					3'd5: begin /*st Rx, [Ry]*/ DOUT_in = 1'b1; Rout_sel = Xreg;  Clear = 1'b0; end
					3'd6: begin Done = 1'b1; if(G != 16'd0) begin Rout_sel = Yreg; Rin_sel = Xreg; 
						PC_incr = 1'b1; end /*mvnz Rx, Ry*/ end
					default: ;
				endcase 

			3'd3:
				case (I)
					3'd1: begin Clear = 1'b0; DIN_out = 1'b1; Rin_sel = Xreg; end
					3'd2: begin Gin = 1'b1; Rout_sel = Yreg; Clear = 1'b0; end
					3'd3: begin Gin = 1'b1; Rout_sel = Yreg; AddSub = 1'b1; Clear = 1'b0; end 
					3'd4: begin /*ld Rx, [Ry]*/ Clear = 1'b0; end
					3'd5: begin /*st Rx, [Ry]*/ ADDR_in = 1'b1; Rout_sel = Yreg; W_D = 1'b1; Clear = 1'b0; end
					default: ;
				endcase

			3'd4:
				case (I)
					3'd1: begin Done = 1'b1; /*DIN_out = 1'b1; Rin_sel = Xreg;*/ 
						PC_incr = 1'b1; end
					3'd2: begin G_out = 1'b1; Rin_sel = Xreg; Done = 1'b1; 
						PC_incr = 1'b1; end
					3'd3: begin G_out = 1'b1; Rin_sel = Xreg; Done = 1'b1; 
						PC_incr = 1'b1; end
					3'd4: begin /*ld Rx, [Ry]*/ Rin_sel = Xreg; DIN_out = 1'b1; Done = 1'b1; 
						PC_incr = 1'b1; end
					3'd5: begin ADDR_in = 1'b1; Rout_sel = 8'b10000000; Done = 1'b1; 
						PC_incr = 1'b1; end
					default : ;
				endcase
				
			default: ;
		endcase
	end

	proc_datapath pd0 (
		.clk     (Clock),
		.Rin_sel (Rin_sel),
		.Gin     (Gin),
		.Ain     (Ain),
		.IRin    (IRin),
		.Rout_sel(Rout_sel),
		.G_out   (G_out),
		.DIN_out (DIN_out),
		.AddSub  (AddSub),
		.DIN     (DIN),
		.bus     (BusWires),
		.IR      (IR),
		.PC_incr (PC_incr),
		.resetn  (Resetn),
		.W(W),
		.ADDR(ADDR),
		.ADDR_in(ADDR_in),
		.DOUT(DOUT),
		.DOUT_in(DOUT_in),
		.W_D(W_D),
		.G(G)
	);

endmodule