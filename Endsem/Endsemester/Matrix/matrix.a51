ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL MATRIX
HERE: SJMP HERE
ORG 130H
// *****************
MATRIX:

MOV A, 30H
MOV B, 30H

MUL AB  ;R5 HAS N^2
MOV R5, A

MOV R1, #30H ; R1 HAS 30H

MOV 4H, 5H	;R4 HAS COUNT OF LOOP
INC R4

LOOP:
DJNZ R4, CONTINUE
SJMP HERE

CONTINUE:
ACALL UPDATE 
MOV R0, A
MOV A, @R0
ADD A, @R1
MOV 0H, 7H
MOV @R0, A
LJMP LOOP


UPDATE:
INC R1
MOV A, R1
ADD A, R5 ;A HAS ELEMENT OF OTHER MATRIX CORRESPONDING TO FIRST MATRIX'S ELEMENT
MOV R6, A
ADD A, R5
MOV R7, A; R7 HAS THE LOCATION OF SUM FOR THAT PARTICULAR ENTRY
MOV A, R6
RET

RET

END

