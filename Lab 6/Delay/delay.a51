ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL DELAY
HERE: SJMP HERE
ORG 130H
// *****************

DELAY:

MOV TMOD, #01H
MOV TH0, #063H
MOV TL0, #0C0H
SETB TR0

LOOP: JNB TF0,LOOP // Loops here until TF0 is set (ie;until roll over)
      CLR TR0 // Stops Timer 0
      CLR TF0 // Clears TF0 flag
	  RET
	  
RET
END
