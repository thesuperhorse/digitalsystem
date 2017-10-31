module rateDivider (HEX5, reset, spdUp, spdDown, CLOCK_50, rate_clk);
	output [6:0] HEX5;
	output rate_clk;
	input reset, spdUp, spdDown;
	input CLOCK_50;
	
	wire [3:0]speed;
	//.0625, .125, .25, .5, 1, 2, 4, 8, 16, 32
	//800M, 400M, 200M, 100M, 50M, 25M, 12.5M, 6.25M, 3.125M, 1.5625M
	wire [30:0]count;
	
	always @(posedge CLOCK_50)
	begin
		if(reset)
		begin
			speed <= 1'h5; // 1Hz
			count <= 0;
		end
		else if (spdUp)
		begin
			speed <= speed + 1; // double speed
			count <= 0;
		end
		else if (spdDwn)
		begin
			speed <= speed - 1; // halve speed
			count <= 0;
		end
		case(speed) // use ternary
			4'b0001: 
			4'b0010:
			4'b0011:
			4'b0100:
			4'b0101:
			4'b0110:
			4'b0111:
			4'b1000:
			4'b1001:
			4'b1010:
			default: ;
		endcase
		if(rate_clk)
			count <= 0;
		else
			count <= count + 1;
	end
	
endmodule