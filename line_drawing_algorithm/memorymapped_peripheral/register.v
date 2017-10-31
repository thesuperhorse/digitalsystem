module register9 (clock, reset_n, in, out, enable);
	input clock, reset_n, enable;
	input [8:0] in;
	output reg [8:0] out;

	always @(posedge clock)
		if(reset_n == 1'b0) out <= 9'b000000000;
		else if (enable == 1'b1) out <= in;
		else out <= out;
endmodule 

module register8 (clock, reset_n, in, out, enable);
	input clock, reset_n, enable;
	input [7:0] in;
	output reg [7:0] out;

	always @(posedge clock)
		if(reset_n == 1'b0) out <= 8'b00000000;
		else if (enable == 1'b1) out <= in;
		else out <= out;
endmodule 

module register1 (clock, reset_n, in, out, enable);
	input clock, reset_n, enable, in;
	output reg out;
	
	always @(posedge clock)
		if (reset_n == 1'b0) out <= 1'b0;
		else if (enable == 1'b1) out <= in;
		else out <= out;
endmodule

module register32 (clock, reset_n, in, out, enable);
	input clock, reset_n, enable;
	input [31:0] in;
	output reg [31:0] out;
	
	always @(posedge clock)
		if (reset_n == 1'b0) out <= 32'b0;
		else if (enable == 1'b1) out <= in;
		else out <= out;
endmodule
