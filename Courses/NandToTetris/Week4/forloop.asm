; for (i=0; i<n; i++){
; 	arr[i]=-1 }

; suppose that arr=100, n=10

; first we set the variables
; arr = 100
	@100
	D=A
	@arr
	M=D

; n = 10
	@10
	D=A
	@n
	M=D

; i = 0
	@i
	M=0

(LOOP)
; if i==n goto END
; access i, access n, if d is equal 0 goes to end
	@i
	D=M
	@n
	D=D-M
	@END
	D;JEQ

; set the value of the current array position to -1
; RAM[arr+i] = -1
	@arr
	D=M
	@i
	A=D+M
	M=-1

; i++
	@i
	M=M+1

@LOOP
	O;JMP

(END)
	@END
	0;JMP
