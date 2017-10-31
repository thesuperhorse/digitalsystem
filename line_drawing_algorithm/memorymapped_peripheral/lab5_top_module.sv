module lab5_top_module (KEY, LEDR, CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	input [3:0] KEY;
	input CLOCK_50;
	output [9:0] LEDR;
	output [9:0] VGA_R;
	output [9:0] VGA_G;
	output [9:0] VGA_B;
	output VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK;		
			
			

    nios_system u0 (
        .clk_clk                            (CLOCK_50),                            //                         clk.clk
        .lda_hw_interface_0_ledr_export     (LEDR),     //     lda_hw_interface_0_ledr.export
        .lda_hw_interface_0_vgab_export     (VGA_B),     //     lda_hw_interface_0_vgab.export
        .lda_hw_interface_0_vgablank_export (VGA_BLANK), // lda_hw_interface_0_vgablank.export
        .lda_hw_interface_0_vgaclk_export   (VGA_CLK),   //   lda_hw_interface_0_vgaclk.export
        .lda_hw_interface_0_vgag_export     (VGA_G),     //     lda_hw_interface_0_vgag.export
        .lda_hw_interface_0_vgahs_export    (VGA_HS),    //    lda_hw_interface_0_vgahs.export
        .lda_hw_interface_0_vgar_export     (VGA_R),     //     lda_hw_interface_0_vgar.export
        .lda_hw_interface_0_vgasync_export  (VGA_SYNC),  //  lda_hw_interface_0_vgasync.export
        .lda_hw_interface_0_vgavs_export    (VGA_VS),    //    lda_hw_interface_0_vgavs.export
        .reset_reset_n                      (KEY[0])                       //                       reset.reset_n
    );
		

endmodule


