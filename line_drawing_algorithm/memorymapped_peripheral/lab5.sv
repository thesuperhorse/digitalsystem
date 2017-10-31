module lab5 (LEDR, CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK, chipselect, address, read, write, writedata, readdata, waitrequest, reset_n);
	input CLOCK_50, reset_n;
	input [9:0] LEDR; // undriven
	output [9:0] VGA_R;
	output [9:0] VGA_G;
	output [9:0] VGA_B;
	output VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK;
	
	input chipselect, read, write;
	input [2:0] address;
	input [31:0] writedata;
	output waitrequest;
	output [31:0] readdata;
	
	wire go, done;
	wire [2:0] colour; // driven by controller and drives adapter
	wire [8:0] X0;
	wire [7:0] Y0;
	wire [8:0] X1;
	wire [7:0] Y1;
	
	wire to_VGA_plot;
	wire [8:0] to_VGA_X;
	wire [7:0] to_VGA_Y;
	
	avalon_slave_controller avs (chipselect, address, read, write, writedata, readdata, waitrequest, CLOCK_50, reset_n, done, go, colour, X0, Y0, X1, Y1);
	LDA le_LDA (CLOCK_50, reset_n, go, X0, Y0, X1, Y1, to_VGA_X, to_VGA_Y, to_VGA_plot, done);
	vga_adapter u0 (
			reset_n,
			CLOCK_50,
			colour,
			to_VGA_X, to_VGA_Y, to_VGA_plot,
			/* Signals for the DAC to drive the monitor. */
			VGA_R,
			VGA_G,
			VGA_B,
			VGA_HS,
			VGA_VS,
			VGA_BLANK,
			VGA_SYNC,
			VGA_CLK);
	
endmodule