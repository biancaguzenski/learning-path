// Program: Signum.asm
// Computes if R0>0
//		R1=1
//	    else
//		R1=0
// Usage: put a value in R0

@R0
D=M       // D=RAM[0]

@8        // "opens" instruction in line 8
D;JGT     // JGT sees if d==0, then goto line 8

@R1
M=0       // RAM[1]=0
@10
0;JMP     // end of program

@R1
M=1       // R1=1

@10
0;JMP
