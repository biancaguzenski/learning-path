// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

@status
    M=-1        ; status = all black
    D=0         
    @SETSCREEN
    0;JMP

(LOOP)
    @KBD
    D=M         
    @SETSCREEN
    D;JEQ       ; if no key pressed, goto setscreen
    D=-1        ; if key pressed, black screen
    
(SETSCREEN)
    @ARG
    M=D         ; arg saves current state
    @status     ; status of entire screen
    D=D-M       ; new status
    @LOOP       ; cme back to loop
    D;JEQ       ; do nothing if no change
    
    @ARG
    D=M
    @status
    M=D         ; set current status
    
    @SCREEN
    D=A         ; screen address
    @8192
    D=D+A
    @i
    M=D
    
(SETLOOP)    
    @i
    D=M-1
    M=D         
    @LOOP
    D;JLT       
    
    @status
    D=M         
    @i
    A=M         
    M=D         
    @SETLOOP
    0;JMP
