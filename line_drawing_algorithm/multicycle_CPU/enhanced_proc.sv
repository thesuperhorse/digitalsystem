`timescale 1 ns / 1 ns

module enhanced_proc (
	input i_Clock,
	input i_Resetn, 
	input i_Run, 
	
	output logic [15:0] o_Data
);

	logic [15:0] DIN, A, DOUT;
	logic Done, W, wren_sig, o_Data_reg_en;

	proc p0 (
		.DIN(DIN),

		.Resetn(i_Resetn), 
		.Clock(i_Clock), 
		.Run(i_Run), 

		.Done(Done),
		.W(W),
		
		.ADDR(A),
		.DOUT(DOUT)
	);
	
	memory	memory_inst_0 (
		.address ( A[6:0] ),
		.clock ( i_Clock ),
		.data ( DOUT ),
		.wren ( wren_sig ),
		.q ( DIN )
	);
	
	assign wren_sig = W & (~(A[15] | A[14] | A[13] | A[12]));
	
	always_ff @(posedge i_Clock) begin
	
		if (o_Data_reg_en) o_Data = DOUT;
	
	end
	
	assign o_Data_reg_en = W & (~(A[15] | A[14] | A[13] | (~A[12])));

endmodule
