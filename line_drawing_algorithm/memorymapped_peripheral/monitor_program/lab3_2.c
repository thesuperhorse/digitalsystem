/*
	Lab 3 Part 2
*/

volatile int *mode=(volatile short*)(0x3000);
volatile int *status=(volatile short*)(0x3004);
volatile int *go=(volatile short*)(0x3008);
volatile int *l_start=(volatile short*)(0x300C);
volatile int *l_end=(volatile short*)(0x3010);
volatile int *colour=(volatile short*)(0x3014);

int check_status() {
	if(*status & 0x01) {return 1;}
	else {return 0;}
}

// draw a horizontal line starting at (x0, y0) for length l with specified colour
void draw_hori_line(int x0, int y0, int x1, int y1, short color) {
	// stall mode: writing to line start, write to line end, write to colour, and then write to go
	y0 = y0 << 9;
	//while(!check_status());
	*l_start = y0 | x0;
	y1 = y1 << 9;
	while(!check_status());
	*l_end = y1 | x1;
	while(!check_status());
	*colour = color;
	while(!check_status());
	*go = 1;
}

// clear a drawn horizontal line at (x0, y0) with length l by overlaying a black line
/*void clear_hori_line(int x0, int y0, int x1, int y1) {
	y0 = y0 << 9;
	*l_start = y0 + x0;
	y1 = y1 << 9;
	*l_end = y1 + x1;
	*colour = 0;
	*go = 1;
}

void clear_screen() {
	;
}*/

int main(void) {
	int i;
	*mode = 1;
	
	while(1){
	int x0 = 120; int y0 = 0; int x1 = 160; int y1 = 100;
	draw_hori_line(x0, y0, x1, y1, 6);
	for (i = 0; i <10000; i++);
	}
	/*while(1) {
		if(i == 0) move_down = 1;
		else if(i == 239) move_down = 0;
		
		draw_hori_line(x0, y0+i, l, 65535);
		
		// wait for 1/60 sec
		*buf_addr = 1;
		while ((*status_reg)&0x01 != 0);
		
		clear_hori_line(x0, y0+i, l);
		
		// wait for 1/60 sec
		*buf_addr = 1;
		while ((*status_reg)&0x01 != 0);
		
		i = (move_down == 1) ? (i+1) : (i-1);
	}*/
}