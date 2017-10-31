`timescale 1 ns / 1 ns

module tb_enhanced_proc();

	logic Clock, Resetn, Run;
	logic [15:0] Data;

	enhanced_proc e0 (
		.i_Clock(Clock),
		.i_Resetn(Resetn), 
		.i_Run(Run), 
		
		.o_Data(Data)
	);
	
	always #10 Clock = ~Clock;
	
	initial begin
	
		Clock = 1'b0;
		Resetn = 1'b0;
		Run = 1'b0;
		#20;
		
		Resetn = 1'b1;
		#20;
		
		Run = 1'b1;
		#1200;
	
		$stop;
	
	end

endmodule