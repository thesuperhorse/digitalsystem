; Program to test LDIND
	ori 	1    ; load 1 into r1
	add	r2,r1
	add	r2,r1    ; r2 = 2
	store r2,(r1) ; store 2 into MEM[1], overwriting instruction memory
	add r1,r2	 ; r1 = 3
	add r1,r1	 ; r1 = 6
	store r1,(r2) ; store 6 into MEM[2], overwriting instruction memory
	sub r1,r1	 ; r1 = 0
	ori		1	 ; load 1 into r1
	
	; ldind r2,(r1), r2 = MEM[MEM[r1]] = MEM[MEM[1]] = MEM[2] = 6
	db %10010001