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
/////

CALL ADD16
MOV R4, 49h

/////////
MOV A, 72h
MOV B, 75h

MUL AB
MOV R2, A
MOV R3, B

//////
CALL ADD16

MOV 50h, R6
MOV 51h, R1
MOV 52h, R0

RET

ADD16:

MOV A, R0  
ADD A, R2  
MOV R0 ,A  

MOV A, R1  
ADDC A, R3 
MOV R1, A

JNC SKIP
INC R6

SKIP:

RET


END