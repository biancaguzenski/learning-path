; Program: sum1ton.asm
; Computes RAM[1] = 1+2...+n
; Usage: put a number in RAM[0]

@R0
D=M
@n
m=d
@i
M=1
@sum
M=0
(LOOP)
@i
D=M
@n
D=D-M
@STOP
D;JGT

@sum
D=M
@i
D=D+M
@sum
M=D
@i
M=M+1
@LOOP
0;JMP

(STOP)
@sum
D=M
@R1
M=D

(END)
@END
0;JMP
