; Multiplies R0 and R1 and stores the result in R2.
; (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)


@sum
M=0
@i
M=1

(LOOP)
	@i
	D=M
	@R0
	D=D-M
	@STOP
	D;JGT	
	@R1
	D=M
	@sum
	M=M+D
	@i
	M=M+1
	@LOOP
	0;JMP
	
(STOP)
	@sum
	D=M
	@R2
	M=D
	@END
(END)
	@END
	0;JMP

