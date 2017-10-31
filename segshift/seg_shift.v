/*
 * inputs:
 * 	KEY0		reset
 * 	KEY1		x2 the speed of shifting
 * 	KEY2		/2 the speed of shifting
 * 	SW[0]		enables shifting to the right
 * 	SW[1]		enables shifting to the left; SW[0] overrides SW[1]
 * 	SW[2]		shifts additional 1's into the HEX displays and LEDR
 * 	SW[3]		shifts additional 0's into the HEX displays and LEDR
 *
 * outputs:
 * 	LEDR		shifting lights
 * 	HEX3-0	shifting pattern
 *		HEX5		current shifting speed
*/
module seg_shift (	CLOCK_50, KEY, SW, HEX3, HEX2, HEX1,
					HEX0, LEDR, HEX5  );
	
	/*****************************************************************************
 	*                  Module Parameters, Inputs and Outputs                     *
 	*****************************************************************************/
				
	input CLOCK_50;
	input [2:0] KEY;
	input [3:0] SW; 
	output [6:0] HEX3, HEX2, HEX1, HEX0, HEX5;
	output [9:0] LEDR;

 	/*****************************************************************************
 	*                  Your implementation										           *
 	*****************************************************************************/
	
	wire reset = KEY[0];
	wire spdUp = KEY[1];
	wire spdDown = KEY[2];
	
	rateDivider clk_divider(HEX5, reset, spdUp, spdDown, CLOCK_50, rate_clk);
	
	
	/*
2 Shifting Pattern
The circuit you will design is a shifting pattern across the segments of the 7-segment displays and another
pattern across LEDR lights. The patterns can move at 10 different speeds, the speed is controlled using
pushbuttons.

2.1 LEDR pattern (A)
You should use 10 red LEDs to shift a 10-bit pattern. LEDR[9] is the MSB, and LEDR[0] is the LSB.

2.2 7-segment display pattern (B)
You should use 20 segments across four 7-segment displays (HEX3,2,1,0) to shift a 20-bit pattern. When all
pattern bits are 1's, the 20 segments represent 2525 (red segments as depicted in Figure 1). Note that the
other segments are not used (black segments), they are always ff. The MSB is on the top-left segment, and
the LSB on the top right segment. The blue arrows denote adjacent bits in the pattern. Figure 2 shows an
example custom pattern that can be displayed. In the left figure, the pattern is shown before shifting one
segment (one bit) to the right. The right figure shows the pattern after the shift.

2.3 Shifting
You must initialize both patterns A and B on reset (KEY[0]) with some constant. Use SW[0] to enable
shifting to the right, and SW[1] to enable shifting to the left. If both are off the pattern should stall. SW[0]
should override SW[1]. Use SW[2] to shift additional 1's into the pattern. Similarly, use SW[3] to shift
additional 0's to the pattern. For example, the new bits should be added on the left side if shifting to the
right is enabled.
If both SW[2] and S[3] are off (no new bits) and SW[1] is on, then the pattern is shifted circularly to the
left by MSB assuming the position of LSB. Other bits are shifted to the left. A circular shift to the right
should be implemented if SW[2],S[3] are off and S[0] is on.

2.4 Changing speed
Your circuit should support 10 speeds. Use HEX5 to display the speed (from 1 to A). Speed(N) is twice
as fast as Speed(N+1). Speed(1) should be approximately one shift per second. Use KEY[1] to change one
speed up (double the speed), and KEY[2] to move one speed down (halve the speed).
	*/
	
	
endmodule


