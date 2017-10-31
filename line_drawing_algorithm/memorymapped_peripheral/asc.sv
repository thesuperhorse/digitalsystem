module avalon_slave_controller(i_chipselect, i_address, i_read, i_write, i_writedata, o_readdata, o_waitrequest, clock, i_reset, i_done, o_go, o_colour, o_X0, o_Y0, o_X1, o_Y1);
	// Inputs and outputs
	input i_chipselect; // high or do nothing
	input [2:0] i_address;
	input i_read;
	input i_write;
	input [31:0] i_writedata;
	output logic [31:0] o_readdata;
	output logic o_waitrequest;
	input clock;
	input i_reset;
	input i_done;
	output logic o_go;
	output [2:0] o_colour;
	output [8:0] o_X0;
	output [7:0] o_Y0;
	output [8:0] o_X1;
	output [7:0] o_Y1;
	
	//wires
	logic [31:0] mode_in, mode_out, status_in, status_out, go_in, go_out, line_start_in, line_start_out, line_end_in, line_end_out, colour_in, colour_out;
	logic mode_enable, status_enable, go_enable, line_start_enable, line_end_enable, colour_enable;
	
	//registers
	register32 Mode_000 (clock, i_reset, mode_in, mode_out, mode_enable); // on i_reset, will o_go to stall mode
	register32 Status_001 (clock, i_reset, status_in, status_out, status_enable);
	register32 Go_010 (clock, i_reset, go_in, go_out, go_enable);
	register32 Line_Start_011 (clock, i_reset, line_start_in, line_start_out, line_start_enable);
	register32 Line_End_100 (clock, i_reset, line_end_in, line_end_out, line_end_enable);
	register32 Colour_101 (clock, i_reset, colour_in, colour_out, colour_enable);
	
	//output assignments
	assign o_colour =  colour_out[2:0];
	assign o_X0 =  line_start_out[8:0];
	assign o_Y0 = line_start_out[16:9] ;
	assign o_X1 =  line_end_out[8:0];
	assign o_Y1 = line_end_out [16:9];
	// i_done
	// o_go
		
	// stall = variable duration
	// poll = single cycle
	enum int unsigned {
		/*S_RESET,
		S_STALL_READ,
		S_STALL_WRITE_0,
		S_STALL_WRITE_1,
		S_STALL_WRITE_2,
		S_POLL_READ, // The master asserts i_address and i_read on the rising edge of the clock. In the same cycle the slave decodes the signals from the master and presents valid o_readdata.
		S_POLL_WRITE,
		S_DRAW_S,
		S_DRAW_P,
		S_DONE_WAIT*/

		S_DRAW, S_RW
	} state, nextstate;
	
	// mode_out[0] == 0 is stall (default), == 1 is poll
	always_ff @ (posedge clock or posedge i_reset) begin
		if (i_reset) begin state <= S_RW; end
		else begin state <= nextstate; end
	end
	
	always_comb begin
		nextstate = state;
		// set outputs to 0
		o_readdata = 32'd0;
		o_waitrequest = 1'b0;
		o_go = 1'b0;
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
            S_DRAW: begin o_go = 1'b1; status_in = 32'd0; status_enable = 1'b1; o_waitrequest = 1'b1;
				if(i_done) {nextstate = S_RW;
			end
			S_RW: begin
                case(i_address)
					3'b000: begin o_readdata = mode_out; if(write)
                                begin mode_in = i_writedata; mode_enable = 1'b1; end end
					3'b001: begin o_readdata = status_out; if(write) 
                                begin status_in = i_writedata; status_enable = 1'b1; end end
					3'b010: begin o_readdata = go_out; if(write)
                                begin go_in = i_writedata; go_enable = 1'b1; end end
					3'b011: begin o_readdata = line_start_out; 
                                begin line_start_in = i_writedata; line_start_enable = 1'b1; end end
					3'b100: begin o_readdata = line_end_out; if(write) 
                                begin line_end_in = i_writedata; line_end_enable = 1'b1; end end
					3'b101: begin o_readdata = colour_out; if(write)
                                begin colour_in = i_writedata; colour_enable = 1'b1; end end
					default: ;
				endcase
				if(go_enable) begin nextstate = S_DRAW; o_waitrequest = 1'b1; end
				/*status_in = 32'd1; status_enable = 1'b1; // to avoid staying at zero forever if reset during the drawing operation
				if(i_chipselect & i_read & !mode_out[0]) nextstate = S_STALL_READ;
				if(i_chipselect & i_write & !mode_out[0]) nextstate = S_STALL_WRITE_0;
				if(i_chipselect & i_read & mode_out[0]) nextstate = S_POLL_READ;
				if(i_chipselect & i_write & mode_out[0]) nextstate = S_POLL_WRITE;
//				if(i_chipselect & !go_out[0] & mode_out[0]) nextstate = S_DRAW_S;
//				if(i_chipselect & !go_out[0] & !mode_out[0]) nextstate = S_DRAW_P;
				end*/
			//S_STALL_READ: begin // read in stall mode is one cycle
				
				//nextstate = S_RESET;
			//end
			/*S_STALL_WRITE_0: begin
				o_waitrequest = 1'b1;
				nextstate = S_STALL_WRITE_1;
			end
			S_STALL_WRITE_1: begin
				o_waitrequest = 1'b1;
				nextstate = S_STALL_WRITE_2;
			end
			S_STALL_WRITE_2: begin*/
				
				//else nextstate = S_RESET;
			//end
			/*S_POLL_READ: begin
				case(i_address)
					3'b000: begin o_readdata = mode_out; end
					3'b001: begin o_readdata = status_out; end
					3'b010: begin o_readdata = go_out; end
					3'b011: begin o_readdata = line_start_out; end
					3'b100: begin o_readdata = line_end_out; end
					3'b101: begin o_readdata = colour_out; end
					default: ;
				endcase
				nextstate = S_RESET;
			end
			S_POLL_WRITE: begin
				case(i_address)
					3'b000: begin mode_in = i_writedata; mode_enable = 1'b1; end
					3'b001: begin status_in = i_writedata; status_enable = 1'b1; end
					3'b010: begin go_in = i_writedata; go_enable = 1'b1; end
					3'b011: begin line_start_in = i_writedata; line_start_enable = 1'b1; end
					3'b100: begin line_end_in = i_writedata; line_end_enable = 1'b1; end
					3'b101: begin colour_in = i_writedata; colour_enable = 1'b1; end
					default: ;
				endcase
				if(go_enable) nextstate = S_DRAW_P;
				else nextstate = S_RESET;
			end
			S_DRAW_P: begin o_go = 1'b1; status_in = 32'd0; status_enable = 1'b1;
				nextstate = S_DONE_WAIT;
			end*/
			/*S_DONE_WAIT: begin o_go = 1'b1;
				if(i_done) begin o_go = 1'b0; status_in = 32'd1; status_enable = 1'b1;
					nextstate = S_RESET;
				end
				if(!mode_out[0]) o_waitrequest = 1'b1;
			end*/
		endcase
	end
	
	
	
endmodule

//module register32 (clock, reset_n, in, out, enable);
//	input clock, reset_n, enable;
//	input [31:0] in;
//	output reg [31:0] out;
//	
//	always @(posedge clock)
//		if (reset_n == 1'b0) out <= 32'b0;
//		else if (enable == 1'b1) out <= in;
//		else out <= out;
//endmodule
