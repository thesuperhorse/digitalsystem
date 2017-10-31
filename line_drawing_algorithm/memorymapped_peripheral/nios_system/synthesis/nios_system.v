// nios_system.v

// Generated using ACDS version 16.0 211

`timescale 1 ps / 1 ps
module nios_system (
		input  wire       clk_clk,                            //                         clk.clk
		output wire [9:0] lda_hw_interface_0_ledr_export,     //     lda_hw_interface_0_ledr.export
		output wire [9:0] lda_hw_interface_0_vgab_export,     //     lda_hw_interface_0_vgab.export
		output wire       lda_hw_interface_0_vgablank_export, // lda_hw_interface_0_vgablank.export
		output wire       lda_hw_interface_0_vgaclk_export,   //   lda_hw_interface_0_vgaclk.export
		output wire [9:0] lda_hw_interface_0_vgag_export,     //     lda_hw_interface_0_vgag.export
		output wire       lda_hw_interface_0_vgahs_export,    //    lda_hw_interface_0_vgahs.export
		output wire [9:0] lda_hw_interface_0_vgar_export,     //     lda_hw_interface_0_vgar.export
		output wire       lda_hw_interface_0_vgasync_export,  //  lda_hw_interface_0_vgasync.export
		output wire       lda_hw_interface_0_vgavs_export,    //    lda_hw_interface_0_vgavs.export
		input  wire       reset_reset_n                       //                       reset.reset_n
	);

	wire  [31:0] nios2_gen2_0_data_master_readdata;                          // mm_interconnect_0:nios2_gen2_0_data_master_readdata -> nios2_gen2_0:d_readdata
	wire         nios2_gen2_0_data_master_waitrequest;                       // mm_interconnect_0:nios2_gen2_0_data_master_waitrequest -> nios2_gen2_0:d_waitrequest
	wire         nios2_gen2_0_data_master_debugaccess;                       // nios2_gen2_0:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:nios2_gen2_0_data_master_debugaccess
	wire  [13:0] nios2_gen2_0_data_master_address;                           // nios2_gen2_0:d_address -> mm_interconnect_0:nios2_gen2_0_data_master_address
	wire   [3:0] nios2_gen2_0_data_master_byteenable;                        // nios2_gen2_0:d_byteenable -> mm_interconnect_0:nios2_gen2_0_data_master_byteenable
	wire         nios2_gen2_0_data_master_read;                              // nios2_gen2_0:d_read -> mm_interconnect_0:nios2_gen2_0_data_master_read
	wire         nios2_gen2_0_data_master_write;                             // nios2_gen2_0:d_write -> mm_interconnect_0:nios2_gen2_0_data_master_write
	wire  [31:0] nios2_gen2_0_data_master_writedata;                         // nios2_gen2_0:d_writedata -> mm_interconnect_0:nios2_gen2_0_data_master_writedata
	wire  [31:0] nios2_gen2_0_instruction_master_readdata;                   // mm_interconnect_0:nios2_gen2_0_instruction_master_readdata -> nios2_gen2_0:i_readdata
	wire         nios2_gen2_0_instruction_master_waitrequest;                // mm_interconnect_0:nios2_gen2_0_instruction_master_waitrequest -> nios2_gen2_0:i_waitrequest
	wire  [13:0] nios2_gen2_0_instruction_master_address;                    // nios2_gen2_0:i_address -> mm_interconnect_0:nios2_gen2_0_instruction_master_address
	wire         nios2_gen2_0_instruction_master_read;                       // nios2_gen2_0:i_read -> mm_interconnect_0:nios2_gen2_0_instruction_master_read
	wire  [31:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata;    // nios2_gen2_0:debug_mem_slave_readdata -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_readdata
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest; // nios2_gen2_0:debug_mem_slave_waitrequest -> mm_interconnect_0:nios2_gen2_0_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess; // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_debugaccess -> nios2_gen2_0:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address;     // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_address -> nios2_gen2_0:debug_mem_slave_address
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read;        // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_read -> nios2_gen2_0:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable;  // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_byteenable -> nios2_gen2_0:debug_mem_slave_byteenable
	wire         mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write;       // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_write -> nios2_gen2_0:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata;   // mm_interconnect_0:nios2_gen2_0_debug_mem_slave_writedata -> nios2_gen2_0:debug_mem_slave_writedata
	wire         mm_interconnect_0_onchip_memory2_0_s1_chipselect;           // mm_interconnect_0:onchip_memory2_0_s1_chipselect -> onchip_memory2_0:chipselect
	wire  [31:0] mm_interconnect_0_onchip_memory2_0_s1_readdata;             // onchip_memory2_0:readdata -> mm_interconnect_0:onchip_memory2_0_s1_readdata
	wire   [9:0] mm_interconnect_0_onchip_memory2_0_s1_address;              // mm_interconnect_0:onchip_memory2_0_s1_address -> onchip_memory2_0:address
	wire   [3:0] mm_interconnect_0_onchip_memory2_0_s1_byteenable;           // mm_interconnect_0:onchip_memory2_0_s1_byteenable -> onchip_memory2_0:byteenable
	wire         mm_interconnect_0_onchip_memory2_0_s1_write;                // mm_interconnect_0:onchip_memory2_0_s1_write -> onchip_memory2_0:write
	wire  [31:0] mm_interconnect_0_onchip_memory2_0_s1_writedata;            // mm_interconnect_0:onchip_memory2_0_s1_writedata -> onchip_memory2_0:writedata
	wire         mm_interconnect_0_onchip_memory2_0_s1_clken;                // mm_interconnect_0:onchip_memory2_0_s1_clken -> onchip_memory2_0:clken
	wire         mm_interconnect_0_lda_hw_interface_0_s1_chipselect;         // mm_interconnect_0:lda_hw_interface_0_s1_chipselect -> lda_hw_interface_0:avs_s1_chipselect
	wire  [31:0] mm_interconnect_0_lda_hw_interface_0_s1_readdata;           // lda_hw_interface_0:avs_s1_readdata -> mm_interconnect_0:lda_hw_interface_0_s1_readdata
	wire         mm_interconnect_0_lda_hw_interface_0_s1_waitrequest;        // lda_hw_interface_0:avs_s1_waitrequest -> mm_interconnect_0:lda_hw_interface_0_s1_waitrequest
	wire   [2:0] mm_interconnect_0_lda_hw_interface_0_s1_address;            // mm_interconnect_0:lda_hw_interface_0_s1_address -> lda_hw_interface_0:avs_s1_address
	wire         mm_interconnect_0_lda_hw_interface_0_s1_read;               // mm_interconnect_0:lda_hw_interface_0_s1_read -> lda_hw_interface_0:avs_s1_read
	wire         mm_interconnect_0_lda_hw_interface_0_s1_write;              // mm_interconnect_0:lda_hw_interface_0_s1_write -> lda_hw_interface_0:avs_s1_write
	wire  [31:0] mm_interconnect_0_lda_hw_interface_0_s1_writedata;          // mm_interconnect_0:lda_hw_interface_0_s1_writedata -> lda_hw_interface_0:avs_s1_writedata
	wire  [31:0] nios2_gen2_0_irq_irq;                                       // irq_mapper:sender_irq -> nios2_gen2_0:irq
	wire         rst_controller_reset_out_reset;                             // rst_controller:reset_out -> [irq_mapper:reset, lda_hw_interface_0:csi_clockreset_reset_n, mm_interconnect_0:nios2_gen2_0_reset_reset_bridge_in_reset_reset, nios2_gen2_0:reset_n, onchip_memory2_0:reset, rst_translator:in_reset]
	wire         rst_controller_reset_out_reset_req;                         // rst_controller:reset_req -> [nios2_gen2_0:reset_req, onchip_memory2_0:reset_req, rst_translator:reset_req_in]
	wire         nios2_gen2_0_debug_reset_request_reset;                     // nios2_gen2_0:debug_reset_request -> rst_controller:reset_in1

	lab5_interface lda_hw_interface_0 (
		.avs_s1_chipselect               (mm_interconnect_0_lda_hw_interface_0_s1_chipselect),  //               s1.chipselect
		.avs_s1_address                  (mm_interconnect_0_lda_hw_interface_0_s1_address),     //                 .address
		.avs_s1_read                     (mm_interconnect_0_lda_hw_interface_0_s1_read),        //                 .read
		.avs_s1_write                    (mm_interconnect_0_lda_hw_interface_0_s1_write),       //                 .write
		.avs_s1_writedata                (mm_interconnect_0_lda_hw_interface_0_s1_writedata),   //                 .writedata
		.avs_s1_readdata                 (mm_interconnect_0_lda_hw_interface_0_s1_readdata),    //                 .readdata
		.avs_s1_waitrequest              (mm_interconnect_0_lda_hw_interface_0_s1_waitrequest), //                 .waitrequest
		.coe_ledr_export_LEDR            (lda_hw_interface_0_ledr_export),                      //             ledr.export
		.coe_vgar_export_VGA_R           (lda_hw_interface_0_vgar_export),                      //             vgar.export
		.coe_vgag_export_VGA_G           (lda_hw_interface_0_vgag_export),                      //             vgag.export
		.coe_vgab_export_VGA_B           (lda_hw_interface_0_vgab_export),                      //             vgab.export
		.coe_vgahs_export_VGA_HS         (lda_hw_interface_0_vgahs_export),                     //            vgahs.export
		.coe_vgavs_export_VGA_VS         (lda_hw_interface_0_vgavs_export),                     //            vgavs.export
		.coe_vgablank_export_VGA_BLANK_N (lda_hw_interface_0_vgablank_export),                  //         vgablank.export
		.coe_vgasync_export_VGA_SYNC_N   (lda_hw_interface_0_vgasync_export),                   //          vgasync.export
		.coe_vgaclk_export_VGA_CLK       (lda_hw_interface_0_vgaclk_export),                    //           vgaclk.export
		.csi_clockreset_clk              (clk_clk),                                             //       clockreset.clk
		.csi_clockreset_reset_n          (~rst_controller_reset_out_reset)                      // clockreset_reset.reset_n
	);

	nios_system_nios2_gen2_0 nios2_gen2_0 (
		.clk                                 (clk_clk),                                                    //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                            //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                         //                          .reset_req
		.d_address                           (nios2_gen2_0_data_master_address),                           //               data_master.address
		.d_byteenable                        (nios2_gen2_0_data_master_byteenable),                        //                          .byteenable
		.d_read                              (nios2_gen2_0_data_master_read),                              //                          .read
		.d_readdata                          (nios2_gen2_0_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (nios2_gen2_0_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (nios2_gen2_0_data_master_write),                             //                          .write
		.d_writedata                         (nios2_gen2_0_data_master_writedata),                         //                          .writedata
		.debug_mem_slave_debugaccess_to_roms (nios2_gen2_0_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (nios2_gen2_0_instruction_master_address),                    //        instruction_master.address
		.i_read                              (nios2_gen2_0_instruction_master_read),                       //                          .read
		.i_readdata                          (nios2_gen2_0_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (nios2_gen2_0_instruction_master_waitrequest),                //                          .waitrequest
		.irq                                 (nios2_gen2_0_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (nios2_gen2_0_debug_reset_request_reset),                     //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                            // custom_instruction_master.readra
	);

	nios_system_onchip_memory2_0 onchip_memory2_0 (
		.clk        (clk_clk),                                          //   clk1.clk
		.address    (mm_interconnect_0_onchip_memory2_0_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_memory2_0_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_memory2_0_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_memory2_0_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_memory2_0_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_memory2_0_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_memory2_0_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),                   // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req)                //       .reset_req
	);

	nios_system_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                  (clk_clk),                                                    //                                clk_0_clk.clk
		.nios2_gen2_0_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                             // nios2_gen2_0_reset_reset_bridge_in_reset.reset
		.nios2_gen2_0_data_master_address               (nios2_gen2_0_data_master_address),                           //                 nios2_gen2_0_data_master.address
		.nios2_gen2_0_data_master_waitrequest           (nios2_gen2_0_data_master_waitrequest),                       //                                         .waitrequest
		.nios2_gen2_0_data_master_byteenable            (nios2_gen2_0_data_master_byteenable),                        //                                         .byteenable
		.nios2_gen2_0_data_master_read                  (nios2_gen2_0_data_master_read),                              //                                         .read
		.nios2_gen2_0_data_master_readdata              (nios2_gen2_0_data_master_readdata),                          //                                         .readdata
		.nios2_gen2_0_data_master_write                 (nios2_gen2_0_data_master_write),                             //                                         .write
		.nios2_gen2_0_data_master_writedata             (nios2_gen2_0_data_master_writedata),                         //                                         .writedata
		.nios2_gen2_0_data_master_debugaccess           (nios2_gen2_0_data_master_debugaccess),                       //                                         .debugaccess
		.nios2_gen2_0_instruction_master_address        (nios2_gen2_0_instruction_master_address),                    //          nios2_gen2_0_instruction_master.address
		.nios2_gen2_0_instruction_master_waitrequest    (nios2_gen2_0_instruction_master_waitrequest),                //                                         .waitrequest
		.nios2_gen2_0_instruction_master_read           (nios2_gen2_0_instruction_master_read),                       //                                         .read
		.nios2_gen2_0_instruction_master_readdata       (nios2_gen2_0_instruction_master_readdata),                   //                                         .readdata
		.lda_hw_interface_0_s1_address                  (mm_interconnect_0_lda_hw_interface_0_s1_address),            //                    lda_hw_interface_0_s1.address
		.lda_hw_interface_0_s1_write                    (mm_interconnect_0_lda_hw_interface_0_s1_write),              //                                         .write
		.lda_hw_interface_0_s1_read                     (mm_interconnect_0_lda_hw_interface_0_s1_read),               //                                         .read
		.lda_hw_interface_0_s1_readdata                 (mm_interconnect_0_lda_hw_interface_0_s1_readdata),           //                                         .readdata
		.lda_hw_interface_0_s1_writedata                (mm_interconnect_0_lda_hw_interface_0_s1_writedata),          //                                         .writedata
		.lda_hw_interface_0_s1_waitrequest              (mm_interconnect_0_lda_hw_interface_0_s1_waitrequest),        //                                         .waitrequest
		.lda_hw_interface_0_s1_chipselect               (mm_interconnect_0_lda_hw_interface_0_s1_chipselect),         //                                         .chipselect
		.nios2_gen2_0_debug_mem_slave_address           (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address),     //             nios2_gen2_0_debug_mem_slave.address
		.nios2_gen2_0_debug_mem_slave_write             (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write),       //                                         .write
		.nios2_gen2_0_debug_mem_slave_read              (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read),        //                                         .read
		.nios2_gen2_0_debug_mem_slave_readdata          (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata),    //                                         .readdata
		.nios2_gen2_0_debug_mem_slave_writedata         (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata),   //                                         .writedata
		.nios2_gen2_0_debug_mem_slave_byteenable        (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable),  //                                         .byteenable
		.nios2_gen2_0_debug_mem_slave_waitrequest       (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest), //                                         .waitrequest
		.nios2_gen2_0_debug_mem_slave_debugaccess       (mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess), //                                         .debugaccess
		.onchip_memory2_0_s1_address                    (mm_interconnect_0_onchip_memory2_0_s1_address),              //                      onchip_memory2_0_s1.address
		.onchip_memory2_0_s1_write                      (mm_interconnect_0_onchip_memory2_0_s1_write),                //                                         .write
		.onchip_memory2_0_s1_readdata                   (mm_interconnect_0_onchip_memory2_0_s1_readdata),             //                                         .readdata
		.onchip_memory2_0_s1_writedata                  (mm_interconnect_0_onchip_memory2_0_s1_writedata),            //                                         .writedata
		.onchip_memory2_0_s1_byteenable                 (mm_interconnect_0_onchip_memory2_0_s1_byteenable),           //                                         .byteenable
		.onchip_memory2_0_s1_chipselect                 (mm_interconnect_0_onchip_memory2_0_s1_chipselect),           //                                         .chipselect
		.onchip_memory2_0_s1_clken                      (mm_interconnect_0_onchip_memory2_0_s1_clken)                 //                                         .clken
	);

	nios_system_irq_mapper irq_mapper (
		.clk        (clk_clk),                        //       clk.clk
		.reset      (rst_controller_reset_out_reset), // clk_reset.reset
		.sender_irq (nios2_gen2_0_irq_irq)            //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                         // reset_in0.reset
		.reset_in1      (nios2_gen2_0_debug_reset_request_reset), // reset_in1.reset
		.clk            (clk_clk),                                //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),         // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req),     //          .reset_req
		.reset_req_in0  (1'b0),                                   // (terminated)
		.reset_req_in1  (1'b0),                                   // (terminated)
		.reset_in2      (1'b0),                                   // (terminated)
		.reset_req_in2  (1'b0),                                   // (terminated)
		.reset_in3      (1'b0),                                   // (terminated)
		.reset_req_in3  (1'b0),                                   // (terminated)
		.reset_in4      (1'b0),                                   // (terminated)
		.reset_req_in4  (1'b0),                                   // (terminated)
		.reset_in5      (1'b0),                                   // (terminated)
		.reset_req_in5  (1'b0),                                   // (terminated)
		.reset_in6      (1'b0),                                   // (terminated)
		.reset_req_in6  (1'b0),                                   // (terminated)
		.reset_in7      (1'b0),                                   // (terminated)
		.reset_req_in7  (1'b0),                                   // (terminated)
		.reset_in8      (1'b0),                                   // (terminated)
		.reset_req_in8  (1'b0),                                   // (terminated)
		.reset_in9      (1'b0),                                   // (terminated)
		.reset_req_in9  (1'b0),                                   // (terminated)
		.reset_in10     (1'b0),                                   // (terminated)
		.reset_req_in10 (1'b0),                                   // (terminated)
		.reset_in11     (1'b0),                                   // (terminated)
		.reset_req_in11 (1'b0),                                   // (terminated)
		.reset_in12     (1'b0),                                   // (terminated)
		.reset_req_in12 (1'b0),                                   // (terminated)
		.reset_in13     (1'b0),                                   // (terminated)
		.reset_req_in13 (1'b0),                                   // (terminated)
		.reset_in14     (1'b0),                                   // (terminated)
		.reset_req_in14 (1'b0),                                   // (terminated)
		.reset_in15     (1'b0),                                   // (terminated)
		.reset_req_in15 (1'b0)                                    // (terminated)
	);

endmodule