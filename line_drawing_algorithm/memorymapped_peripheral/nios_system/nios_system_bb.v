
module nios_system (
	clk_clk,
	lda_hw_interface_0_ledr_export,
	lda_hw_interface_0_vgab_export,
	lda_hw_interface_0_vgablank_export,
	lda_hw_interface_0_vgaclk_export,
	lda_hw_interface_0_vgag_export,
	lda_hw_interface_0_vgahs_export,
	lda_hw_interface_0_vgar_export,
	lda_hw_interface_0_vgasync_export,
	lda_hw_interface_0_vgavs_export,
	reset_reset_n);	

	input		clk_clk;
	output	[9:0]	lda_hw_interface_0_ledr_export;
	output	[9:0]	lda_hw_interface_0_vgab_export;
	output		lda_hw_interface_0_vgablank_export;
	output		lda_hw_interface_0_vgaclk_export;
	output	[9:0]	lda_hw_interface_0_vgag_export;
	output		lda_hw_interface_0_vgahs_export;
	output	[9:0]	lda_hw_interface_0_vgar_export;
	output		lda_hw_interface_0_vgasync_export;
	output		lda_hw_interface_0_vgavs_export;
	input		reset_reset_n;
endmodule
