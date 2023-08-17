ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL ASCII
ret

HERE: SJMP HERE
ORG 130H
// *****************
ASCII:
// ADD YOUR CODE HERE

MOV A, 30H
ANL A, #0FH
MOV R1, A

MOV A, 30H
ANL A, #0F0H
MOV R2, A

SJMP RIGHT
ret

///////////////////////

RIGHT:
CLR C
MOV A, R1
SUBB A, #0AH
JNC LETTER1

MOV A, R1
ADD A, #30H
MOV 61H, A
SJMP LEFT
ret	 

////////////////////////

LEFT:
CLR C
MOV A, R2
SUBB A, #0A0H
JNC LETTER2

MOV A, R2
SWAP A
ADD A, #30H
MOV 60H, A
ret

//////////////////////////

LETTER1: MOV A, R1
		 ADD A, #37H
		 MOV 61H, A
		 SJMP LEFT
		 ret
		 
///////////////////////

LETTER2: MOV A, R2
		 SWAP A	
		 ADD A, #37H
		 MOV 60H, A
		 SJMP HERE
		 ret
////////////////////////

END