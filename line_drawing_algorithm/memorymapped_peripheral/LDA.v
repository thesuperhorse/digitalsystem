module LDA (clock, reset_n, go, X0_UI, Y0_UI, X1_UI, Y1_UI, to_VGA_X, to_VGA_Y, to_VGA_plot, done);
	
	input clock, reset_n, go;
	input [8:0] X0_UI, X1_UI;
	input [7:0] Y0_UI, Y1_UI;
	output to_VGA_plot;
	output [8:0] to_VGA_X;
	output [7:0] to_VGA_Y;
	output done;
	
	wire [8:0] X, abs_x1_x0, delta_x, X_in, X0_in, X1_in, Y0_in, Y1_in, X_1, X_0, Y_1, Y_0;
	wire [8:0] Y, abs_y1_y0, Y_in;
	wire [8:0] error, error_in;
	wire [1:0] Y_sel, error_sel, X0_sel, Y0_sel, X1_sel, Y1_sel;
	wire EX, EX0, EX1, EY, EY0, EY1, E_error, E_steep, X_sel, plot_sel, steep;

	assign delta_x = X_1 - X_0;

	mux mux_X0 (X_1, Y_0, X0_UI, X0_sel, X0_in);
	mux mux_Y0 (Y_1, X_0, Y0_UI, Y0_sel, Y0_in);
	mux mux_X1 (X_0, Y_1, X1_UI, X1_sel, X1_in);
	mux mux_Y1 (Y_0, X_1, Y1_UI, Y1_sel, Y1_in);
	assign X_in = (X_sel == 1'b1) ? X_0 : (X+1'b1);
	mux mux_Y (Y_0, (Y+1'b1), (Y-1'b1), Y_sel, Y_in);
	mux mux_error ((X_0-X_1)/2, (error+abs_y1_y0), (error-delta_x), error_sel, error_in);
	assign to_VGA_X = (plot_sel == 1'b1) ? X : Y;
	assign to_VGA_Y = (plot_sel == 1'b1) ? Y : X;

	register9 reg_X (clock, reset_n, X_in, X, EX);
	register9 reg_X0 (clock, reset_n, X0_in, X_0, EX0);
	register9 reg_X1 (clock, reset_n, X1_in, X_1, EX1);
	register9 reg_Y (clock, reset_n, Y_in, Y, EY);
	register9 reg_Y0 (clock, reset_n, Y0_in, Y_0, EY0);
	register9 reg_Y1 (clock, reset_n, Y1_in, Y_1, EY1);

	register9 reg_error (clock, reset_n, error_in, error, E_error);
	register1 reg_steep (clock, reset_n, (abs_y1_y0 > abs_x1_x0) ? 1'b1 : 1'b0, steep, E_steep);

	absolute abs_x (X_1, X_0, abs_x1_x0);
	absolute abs_y (Y_1, Y_0, abs_y1_y0);

	/* Line algorithm FSM */
	LDA_FSM lda_fsm (clock, reset_n, go, done, X, X_0, X_1, Y_0, Y_1, error, steep, X0_sel, X1_sel, X_sel, Y0_sel, Y1_sel, Y_sel, error_sel, plot_sel, EX, EX0, EX1, EY, EY0, EY1, E_error, E_steep, to_VGA_plot);
	
endmodule

module LDA_FSM (clock, reset_n, go, done, X, X_0, X_1, Y_0, Y_1, error, steep, X0_sel, X1_sel, X_sel, Y0_sel, Y1_sel, Y_sel, error_sel, plot_sel, EX, EX0, EX1, EY, EY0, EY1, E_error, E_steep, plot);

	input clock, reset_n, go, steep;
	input [8:0] X, X_0, X_1;
	input [8:0] Y_0, Y_1;
	input [8:0] error;
	output reg done, plot, X_sel, plot_sel, EX, EX0, EX1, EY, EY0, EY1, E_error, E_steep;
	output reg [1:0] Y_sel, error_sel, X0_sel, X1_sel, Y0_sel, Y1_sel;

	localparam S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, SD = 3'b110, S12 = 3'b111;
	
	reg [2:0] nextS, currS;
	
	// state variables
	always @(posedge clock, negedge reset_n)
		if (reset_n == 1'b0) currS <= S0; else currS <= nextS;
		
	// state transitions
	always @(*)
		case (currS)
			S0: if(go) nextS = S1; else nextS = S0;
			S1: nextS = S12;
			S12: nextS = S2;
			S2: nextS = S3;
			S3: nextS = S4;
			S4: nextS = S5;
			S5: if(X<X_1) nextS = S4; else nextS = SD;
			SD: if(go) nextS = SD; else nextS = S0;
		endcase
		
	// outputs
	always @(posedge clock)
		case (currS)
			S0: begin
				done <= 1'b0;
				plot <= 1'b0;
				EX0 <= 1'b1; EY0 <= 1'b1; EX1 <= 1'b1; EY1 <= 1'b1;
				X0_sel <= 2'b10; Y0_sel <= 2'b10; X1_sel <= 2'b10; Y1_sel <= 2'b10;
				EX <= 1'b0; EY <= 1'b0; E_error <= 1'b0; E_steep <= 1'b1;
			end
			S1: begin
				EX <= 1'b0; EY <= 1'b0; E_error <= 1'b0; E_steep <= 1'b0;
				if(steep == 1'b1) begin
					EX0 <= 1'b1; EY0 <= 1'b1; EX1 <= 1'b1; EY1 <= 1'b1; 
					X0_sel <= 2'b01; Y0_sel <= 2'b01; X1_sel <= 2'b01; Y1_sel <= 2'b01;
				end
			end
			S12: begin
				EX0 <= 1'b0; EY0 <= 1'b0; EX1 <= 1'b0; EY1 <= 1'b0; 
			end
			S2: begin
				if(X_0 > X_1) begin
					EX0 <= 1'b1; EY0 <= 1'b1; EX1 <= 1'b1; EY1 <= 1'b1;
					X0_sel <= 2'b00; Y0_sel <= 2'b00; X1_sel <= 2'b00; Y1_sel <= 2'b00;
				end
				else begin
					EX0 <= 1'b0; EY0 <= 1'b0; EX1 <= 1'b0; EY1 <= 1'b0; 
				end
			end
			S3: begin
				EX0 <= 1'b0; EY0 <= 1'b0; EX1 <= 1'b0; EY1 <= 1'b0; 
				EX <= 1'b1; EY <= 1'b1; E_error <= 1'b1;
				X_sel <= 1'b1; Y_sel <= 2'b00; error_sel <= 2'b00;
			end
			S4: begin
				plot <= 1'b1;
				EX <= 1'b0; EY <= 1'b0; E_error <= 1'b1;
				error_sel <= 2'b01;
				plot_sel <= (steep == 1'b1) ? 1'b0 : 1'b1;
			end
			S5: begin
				plot <= 1'b0;
				EX <= 1'b1;
				X_sel <= 1'b0;
				if(error[8] == 1'b0) begin
					EY <= 1'b1; E_error <= 1'b1;
					Y_sel <= (Y_0 < Y_1) ? 2'b01 : 2'b10;
					error_sel <= 2'b10;
				end
				else E_error <= 1'b0;
			end
			SD: begin
				done <= 1'b1;
				plot <= 1'b0;
				EX0 <= 1'b0; EY0 <= 1'b0; EX1 <= 1'b0; EY1 <= 1'b0;
				EX <= 1'b0; EY <= 1'b0; E_error <= 1'b0;
			end
		endcase

endmodule
