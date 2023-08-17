ORG 0H
LJMP MAIN
ORG 100H
MAIN:

CALL DATE

DATE:
// Add your code here.
MOV 50H, #25H

MOV 51H, #06H

MOV 52H, #19H

MOV 53H, #83H

// Stored dates.
///////////////////////

MOV A, 50H
MOV P1, A	//DISPLAYING 2

CALL delay_200ms

SWAP A
MOV P1, A   //DISPLAYING 5

CALL delay_200ms

MOV A, #15
SWAP A
MOV P1,A	//DISPLAYING F

CALL delay_200ms

MOV A, 51H
MOV P1, A	//DISPLAYING 0

CALL delay_200ms

SWAP A
MOV P1, A   //DISPLAYING 6

CALL delay_200ms

MOV A, #15
SWAP A
MOV P1,A	//DISPLAYING F

CALL delay_200ms

MOV A, 52H
MOV P1, A	//DISPLAYING 1

CALL delay_200ms

SWAP A
MOV P1, A   //DISPLAYING 9

CALL delay_200ms

MOV A, 53H
MOV P1, A	//DISPLAYING 8

CALL delay_200ms

SWAP A
MOV P1, A   //DISPLAYING 3

CALL delay_200ms

MOV A, #15
SWAP A
MOV P1,A	//DISPLAYING F

CALL delay_200ms

LJMP DATE

//////////////////////////////

delay_200ms:
push 00h
mov r0, #100
h3: acall delay_1ms
djnz r0, h3
pop 00h
ret

delay_1ms:
push 00h
mov r0, #40
h2: acall delay_250us
djnz r0, h2
pop 00h
ret

delay_250us:
push 00h
mov r0, #244
h1: djnz r0, h1
pop 00h
ret

RET
END