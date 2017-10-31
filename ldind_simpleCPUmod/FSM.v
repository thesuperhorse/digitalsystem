// ---------------------------------------------------------------------
// Copyright (c) 2007 by University of Toronto ECE 243 development team 
// ---------------------------------------------------------------------
// 					    	 	 	  		 	 		  		   	
// Major Functions:	control processor's datapath
// 
// Input(s):	1. instr: input is used to determine states
//				2. N: if branches, input is used to determine if
//					  negative condition is true
//				3. Z: if branches, input is used to determine if 
//					  zero condition is true
//
// Output(s):	control signals
//
//				** More detail can be found on the course note under
//				   "Multi-Cycle Implementation: The Control Unit"
//
// ---------------------------------------------------------------------

module FSM
(
reset, instr, clock,
N, Z,
PCwrite, AddrSel, MemRead,
MemWrite, IRload, OpASel, MDRload,
OpABLoad, ALU1, ALU2, ALUop,
ALUOutWrite, RFWrite, RegIn, FlagWrite, state
);
	input	[3:0] instr;
	input	N, Z;
	input	reset, clock;
	output	PCwrite, MemRead, MemWrite, IRload, OpASel, MDRload;
	output 	[1:0] AddrSel;
	output	OpABLoad, ALU1, ALUOutWrite, RFWrite, RegIn, FlagWrite;
	output	[2:0] ALU2, ALUop;
	output	[4:0] state;
	
	reg [4:0]	state;			// 5-bit state can encode 32 distinct values.
	reg	PCwrite, MemRead, MemWrite, IRload, OpASel, MDRload;
	reg [1:0]	AddrSel;
	reg	OpABLoad, ALU1, ALUOutWrite, RFWrite, RegIn, FlagWrite;
	reg	[2:0] ALU2, ALUop;
	
	// state constants (note: asn = add/sub/nand, asnsh = add/sub/nand/shift)
	parameter [4:0] reset_s = 0, c1 = 1, c2 = 2, c3_asn = 3,
					c4_asnsh = 4, c3_shift = 5, c3_ori = 6,
					c4_ori = 7, c5_ori = 8, c3_load = 9, c4_load = 10,
					c3_store = 11, c3_bpz = 12, c3_bz = 13, c3_bnz = 14,
					c3_ldind = 15, c4_ldind = 16, c5_ldind = 17, c6_ldind = 18;
	
	// determines the next state based on the current state; supports
	// asynchronous reset
	always @(posedge clock or posedge reset)
	begin
		if (reset) state = reset_s;
		else
		begin
			case(state)
				reset_s:	state = c1; 		// reset state
				c1:			state = c2; 		// cycle 1
				c2:			begin				// cycle 2
								if(instr == 4'b0100 | instr == 4'b0110 | instr == 4'b1000) state = c3_asn;
								else if( instr[2:0] == 3'b011 ) state = c3_shift;
								else if( instr[2:0] == 3'b111 ) state = c3_ori;
								else if( instr == 4'b0000 ) state = c3_load;
								else if( instr == 4'b0010 ) state = c3_store;
								else if( instr == 4'b1101 ) state = c3_bpz;
								else if( instr == 4'b0101 ) state = c3_bz;
								else if( instr == 4'b1001 ) state = c3_bnz;
								else if( instr == 4'b0001 ) state = c3_ldind;
								else state = 0;
							end
				c3_asn:		state = c4_asnsh;	// cycle 3: ADD SUB NAND
				c4_asnsh:	state = c1;			// cycle 4: ADD SUB NAND/SHIFT
				c3_shift:	state = c4_asnsh;	// cycle 3: SHIFT
				c3_ori:		state = c4_ori;		// cycle 3: ORI
				c4_ori:		state = c5_ori;		// cycle 4: ORI
				c5_ori:		state = c1;			// cycle 5: ORI
				c3_load:	state = c4_load;	// cycle 3: LOAD
				c4_load:	state = c1; 		// cycle 4: LOAD
				c3_store:	state = c1; 		// cycle 3: STORE
				c3_bpz:		state = c1; 		// cycle 3: BPZ
				c3_bz:		state = c1; 		// cycle 3: BZ
				c3_bnz:		state = c1; 		// cycle 3: BNZ
				c3_ldind:	state = c4_ldind;	// cycle 3: LDIND
				c4_ldind:	state = c5_ldind;	// cycle 4: LDIND
				c5_ldind:	state = c6_ldind;	// cycle 5: LDIND
				c6_ldind:	state = c1;			// cycle 6: LDIND
			endcase
		end
	end

	// sets the control sequences based on the current state and instruction
	always @(*)
	begin
		case (state)
			reset_s:	//control = 19'b0000000000000000000;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end					
			c1: 		//control = 19'b1110100000010000000;
				begin
					PCwrite = 1;
					AddrSel = 1;
					MemRead = 1;
					MemWrite = 0;
					IRload = 1;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b001;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end	
			c2: 		//control = 19'b0000000100000000000;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 1;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
			c3_asn:		begin
							if ( instr == 4'b0100 ) 		// add
								//control = 19'b0000000010000001001;
							begin
								PCwrite = 0;
								AddrSel = 0;
								MemRead = 0;
								MemWrite = 0;
								IRload = 0;
								OpASel = 0;
								MDRload = 0;
								OpABLoad = 0;
								ALU1 = 1;
								ALU2 = 3'b000;
								ALUop = 3'b000;
								ALUOutWrite = 1;
								RFWrite = 0;
								RegIn = 0;
								FlagWrite = 1;
							end	
							else if ( instr == 4'b0110 ) 	// sub
								//control = 19'b0000000010000011001;
							begin
								PCwrite = 0;
								AddrSel = 0;
								MemRead = 0;
								MemWrite = 0;
								IRload = 0;
								OpASel = 0;
								MDRload = 0;
								OpABLoad = 0;
								ALU1 = 1;
								ALU2 = 3'b000;
								ALUop = 3'b001;
								ALUOutWrite = 1;
								RFWrite = 0;
								RegIn = 0;
								FlagWrite = 1;
							end
							else 							// nand
								//control = 19'b0000000010000111001;
							begin
								PCwrite = 0;
								AddrSel = 0;
								MemRead = 0;
								MemWrite = 0;
								IRload = 0;
								OpASel = 0;
								MDRload = 0;
								OpABLoad = 0;
								ALU1 = 1;
								ALU2 = 3'b000;
								ALUop = 3'b011;
								ALUOutWrite = 1;
								RFWrite = 0;
								RegIn = 0;
								FlagWrite = 1;
							end
				   		end
			c4_asnsh: 	//control = 19'b0000000000000000100;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 1;
					RegIn = 0;
					FlagWrite = 0;
				end
			c3_shift: 	//control = 19'b0000000011001001001;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 1;
					ALU2 = 3'b100;
					ALUop = 3'b100;
					ALUOutWrite = 1;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 1;
				end
			c3_ori: 	//control = 19'b0000010100000000000;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 1;
					MDRload = 0;
					OpABLoad = 1;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
			c4_ori: 	//control = 19'b0000000010110101001;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 1;
					ALU2 = 3'b011;
					ALUop = 3'b010;
					ALUOutWrite = 1;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 1;
				end
			c5_ori: 	//control = 19'b0000010000000000100;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 1;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 1;
					RegIn = 0;
					FlagWrite = 0;
				end
			c3_load: 	//control = 19'b0010001000000000000;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 1;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 1;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
			c4_load: 	//control = 19'b0000000000000001110;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 1;
					RFWrite = 1;
					RegIn = 1;
					FlagWrite = 0;
				end
			c3_store: 	//control = 19'b0001000000000000000;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 1;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
			c3_bpz: 	//control = {~N,18'b000000000100000000};
				begin
					PCwrite = ~N;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b010;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
			c3_bz: 		//control = {Z,18'b000000000100000000};
				begin
					PCwrite = Z;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b010;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
			c3_bnz: 	//control = {~Z,18'b000000000100000000};
				begin
					PCwrite = ~Z;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b010;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
	//R1 and R2 hold OpA and OpB
	//MEM[R2], MDRload
	//RFWrite into OpA
	//Mem[OpA], MDRload
	//RFWrite into OpA
			c3_ldind: 	//control = {20'b00010001100100000110};
				begin
					PCwrite = 0; // 0
					AddrSel = 2'b00; // OpB
					MemRead = 1; // read from memory
					MemWrite = 0; // 0
					IRload = 0; // 0
					OpASel = 0; // OpA
					MDRload = 1; // MDR
					OpABLoad = 0; // x Register write enable
					ALU1 = 0; // x
					ALU2 = 3'b000; // xxx
					ALUop = 3'b000; // xxx
					ALUOutWrite = 0; // x
					RFWrite = 0; // x write
					RegIn = 0; // x
					FlagWrite = 0; // 0
				end
			c4_ldind: 	//control = 20'b01010001100100000110;
				begin
					PCwrite = 0; // 0
					AddrSel = 2'b00; // xx
					MemRead = 0; // don't read from memory
					MemWrite = 0; // 0
					IRload = 0; // 0
					OpASel = 0; // OpA
					MDRload = 0; // 0, loaded last cycle
					OpABLoad = 1; // Register write enable
					ALU1 = 0; // x
					ALU2 = 3'b000; // xxx
					ALUop = 3'b000; // xxx
					ALUOutWrite = 0; // x
					RFWrite = 1;
					RegIn = 1; // MDR
					FlagWrite = 0; // 0
				end
			c5_ldind: 	//control = 20'b01010001100100000110;
				begin
					PCwrite = 0; // 0
					AddrSel = 2'b10; // OpA
					MemRead = 1; // read from memory
					MemWrite = 0; // 0
					IRload = 0; // 0
					OpASel = 0; // OpA
					MDRload = 1; // MDR
					OpABLoad = 0; // Register write enable
					ALU1 = 0; // x
					ALU2 = 3'b000; // xxx
					ALUop = 3'b000; // xxx
					ALUOutWrite = 0; // x
					RFWrite = 0;
					RegIn = 0; // x
					FlagWrite = 0; // 0
				end
			c6_ldind: 	//control = 20'b01010001100100000110;
				begin
					PCwrite = 0; // 0
					AddrSel = 2'b10; // OpA
					MemRead = 0; // read from memory
					MemWrite = 0; // 0
					IRload = 0; // 0
					OpASel = 0; // OpA
					MDRload = 0; // MDR
					OpABLoad = 1; // Register write enable
					ALU1 = 0; // x
					ALU2 = 3'b000; // xxx
					ALUop = 3'b000; // xxx
					ALUOutWrite = 0; // x
					RFWrite = 1;
					RegIn = 1; // MDR
					FlagWrite = 0; // 0
				end
			default:	//control = 20'b00000000000000000000;
				begin
					PCwrite = 0;
					AddrSel = 0;
					MemRead = 0;
					MemWrite = 0;
					IRload = 0;
					OpASel = 0;
					MDRload = 0;
					OpABLoad = 0;
					ALU1 = 0;
					ALU2 = 3'b000;
					ALUop = 3'b000;
					ALUOutWrite = 0;
					RFWrite = 0;
					RegIn = 0;
					FlagWrite = 0;
				end
		endcase
	end
	
endmodule	     				 	 	 		  	 	  		  			 
                   