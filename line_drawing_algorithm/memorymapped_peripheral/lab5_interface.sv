module lab5_interface(avs_s1_chipselect, avs_s1_address, avs_s1_read, avs_s1_write, avs_s1_writedata, avs_s1_readdata, avs_s1_waitrequest,
	coe_ledr_export_LEDR, coe_vgar_export_VGA_R, coe_vgag_export_VGA_G, coe_vgab_export_VGA_B, coe_vgahs_export_VGA_HS, coe_vgavs_export_VGA_VS,
	coe_vgablank_export_VGA_BLANK_N, coe_vgasync_export_VGA_SYNC_N, coe_vgaclk_export_VGA_CLK, 
	csi_clockreset_clk, csi_clockreset_reset_n);
	
	input avs_s1_chipselect;
	input [2:0] avs_s1_address;
	input avs_s1_read;
	input avs_s1_write;
	input [31:0] avs_s1_writedata;
	output [31:0] avs_s1_readdata;
	output avs_s1_waitrequest;
	output [9:0] coe_ledr_export_LEDR;
	output [9:0] coe_vgar_export_VGA_R;
	output [9:0] coe_vgag_export_VGA_G;
	output [9:0] coe_vgab_export_VGA_B;
	output coe_vgahs_export_VGA_HS;
	output coe_vgavs_export_VGA_VS;
	output coe_vgablank_export_VGA_BLANK_N;
	output coe_vgasync_export_VGA_SYNC_N;
	output coe_vgaclk_export_VGA_CLK;
	input csi_clockreset_clk;
	input csi_clockreset_reset_n;
	
		
	lab5 lab (coe_ledr_export_LEDR, csi_clockreset_clk, coe_vgar_export_VGA_R, coe_vgag_export_VGA_G, coe_vgab_export_VGA_B,
		coe_vgahs_export_VGA_HS, coe_vgavs_export_VGA_VS, coe_vgablank_export_VGA_BLANK_N, coe_vgasync_export_VGA_SYNC_N, coe_vgaclk_export_VGA_CLK,
		avs_s1_chipselect, avs_s1_address, avs_s1_read, avs_s1_write, avs_s1_writedata, avs_s1_readdata, avs_s1_waitrequest, csi_clockreset_reset_n);

endmodule