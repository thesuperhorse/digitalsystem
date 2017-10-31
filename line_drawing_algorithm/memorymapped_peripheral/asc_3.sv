module avalon_slave_controller(avs_s1_chipselect, avs_s1_address, avs_s1_read, avs_s1_write, avs_s1_writedata, avs_s1_readdata, avs_s1_waitrequest,
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
	
	//wires
	logic [31:0] mode_in, mode_out, status_in, status_out, go_in, go_out, line_start_in, line_start_out, line_end_in, line_end_out, colour_in, colour_out;
	logic mode_enable, status_enable, go_enable, line_start_enable, line_end_enable, colour_enable;

    wire go, done;
	wire [2:0] colour; // driven by controller and drives adapter
	wire [8:0] X0;
	wire [7:0] Y0;
	wire [8:0] X1;
	wire [7:0] Y1;
	
	wire to_VGA_plot;
	wire [8:0] to_VGA_X;
	wire [7:0] to_VGA_Y;
	
	//registers
	register32 Mode_000 (csi_clockreset_clk, i_reset, mode_in, mode_out, mode_enable); // on i_reset, will go to stall mode
	register32 Status_001 (csi_clockreset_clk, i_reset, status_in, status_out, status_enable);
	register32 Go_010 (csi_clockreset_clk, i_reset, go_in, go_out, go_enable);
	register32 Line_Start_011 (csi_clockreset_clk, i_reset, line_start_in, line_start_out, line_start_enable);
	register32 Line_End_100 (csi_clockreset_clk, i_reset, line_end_in, line_end_out, line_end_enable);
	register32 Colour_101 (csi_clockreset_clk, i_reset, colour_in, colour_out, colour_enable);

    // vga adapter
    vga_adapter u0(
			csi_clockreset_reset_n,
			csi_clockreset_clk,
			colour,
			to_VGA_X, to_VGA_Y, to_VGA_plot,
			/* Signals for the DAC to drive the monitor. */
			coe_vgar_export_VGA_R,
			coe_vgar_export_VGA_G,
			coe_vgar_export_VGA_B,
			coe_vgar_export_VGA_HS,
			coe_vgar_export_VGA_VS,
			coe_vgar_export_VGA_BLANK_N,
			coe_vgar_export_VGA_SYNC_N,
			coe_vgar_export_VGA_CLK);

    LDA u1 (csi_clockreset_clk, csi_clockreset_reset_n, go, X0, Y0, X1, Y1, to_VGA_X, to_VGA_Y, to_VGA_plot, done);
	
	//output assignments
	assign colour =  colour_out[2:0];
	assign X0 =  line_start_out[8:0];
	assign Y0 = line_start_out[16:9] ;
	assign X1 =  line_end_out[8:0];
	assign Y1 = line_end_out [16:9];
	// done
	// go
		
	// stall = variable duration
	// poll = single cycle
	enum int unsigned {
		S_DRAW, S_RW
	} state, nextstate;
	
	// mode_out[0] == 0 is stall (default), == 1 is poll
	always_ff @ (posedge csi_clockreset_clk or posedge i_reset) begin
		if (i_reset) begin state <= S_RW; end
		else begin state <= nextstate; end
	end
	
	always_comb begin
		nextstate = state;
		// set outputs to 0
		avs_s1_readdata = 32'd0;
		avs_s1_waitrequest = 1'b0;
		go = 1'b0;
		mode_enable = 1'b0;
		status_enable = 1'b0;
		go_enable = 1'b0;
		line_start_enable = 1'b0;
		line_end_enable = 1'b0;
		colour_enable = 1'b0;
		colour_in = 32'd0;
		line_end_in = 32'd0;
		line_start_in = 32'd0;
		go_in = 32'd0;
		status_in = 32'd0;
		mode_in = 32'd0;
		
		case (state)
            S_DRAW: begin go = 1'b1; status_in = 32'd0; status_enable = 1'b1;
                avs_s1_waitrequest = mode_out[0] ? 1'b1 : 1'b0;
				if(done) nextstate = S_RW;
			end
			S_RW: begin
                status_in = 32'd1; status_enable = 1'b1;
                case(avs_s1_address)
					3'b000: begin avs_s1_writedata = mode_out; if(avs_s1_write)
                                begin mode_in = avs_s1_avs_s1_readdata; mode_enable = 1'b1; end end
					3'b001: begin avs_s1_writedata = status_out; /*if(avs_s1_write) 
                                begin status_in = avs_s1_avs_s1_readdata; status_enable = 1'b1; end*/ end
					3'b010: begin avs_s1_writedata = go_out; if(avs_s1_write)
                                begin go_in = avs_s1_avs_s1_readdata; go_enable = 1'b1; end end
					3'b011: begin avs_s1_writedata = line_start_out; 
                                begin line_start_in = avs_s1_avs_s1_readdata; line_start_enable = 1'b1; end end
					3'b100: begin avs_s1_writedata = line_end_out; if(avs_s1_write) 
                                begin line_end_in = avs_s1_avs_s1_readdata; line_end_enable = 1'b1; end end
					3'b101: begin avs_s1_writedata = colour_out; if(avs_s1_write)
                                begin colour_in = avs_s1_avs_s1_readdata; colour_enable = 1'b1; end end
					default: ;
				endcase
				if(go_enable) begin nextstate = S_DRAW; go = 1'b1; status_in = 32'd0; status_enable = 1'b1;
                    avs_s1_waitrequest = mode_out[0] ? 1'b1 : 1'b0; end
		endcase
	end
endmodule




