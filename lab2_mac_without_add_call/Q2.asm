// -- DO NOT CHANGE ANYTHING UNTIL THE **** LINE--//
ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL MAC
HERE: SJMP HERE
ORG 130H
// *****************
MAC:
// MAC OPERATION, CALL THE ADDITION SUBROUTINE USING "CALL ADD16"
MOV A, 70h
MOV B, 73h

MUL AB

MOV R0, A
MOV R1, B


/////
MOV A, 71h
MOV B, 74h

MUL AB

MOV R2, A
MOV R3, B


////
MOV A, 72h
MOV B, 75h

MUL AB

MOV R4, A
MOV R5, B

//////////////////////////////////

CLR A
MOV R6, A
CLR C

MOV A, R0  
ADD A, R2  
MOV R0 ,A  

MOV A, R1  
ADDC A, R3 

JNC SKIP1
INC R6
SKIP1: MOV R1, A
	   MOV 52h, R6
	  
////////////////////////

CLR A
MOV R7, A
CLR C

MOV A, R0  
ADD A, R4  
MOV 52h ,A  

MOV A, R1  
ADDC A, R5 

JNC SKIP2
INC R7
SKIP2: MOV 51h, A
	   CLR A
	   MOV A, R7
	   ADD A, R6
	   MOV 50h, A
	  
////////////////////////
RET

END