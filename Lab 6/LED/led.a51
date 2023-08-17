ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL LED
HERE: SJMP HERE
ORG 130H
// *****************

LED: mov 30h, #03h
	 mov p1, #0f0h
	 lcall delay_1s
	 mov p1, #00h
	 lcall delay_1s
	 
	 sjmp LED

;-----------------------------
delay_1s:
	mov a, 30h
	mov b, #32h
	mul ab
	mov r2, a
	
	h1: acall delay
	
	djnz r2, h1
	ret
	
;------------------------------

delay:

MOV TMOD, #01H
MOV TH0, #063H
MOV TL0, #0C0H
SETB TR0

LOOP: JNB TF0,LOOP // Loops here until TF0 is set (ie;until roll over)
      CLR TR0 // Stops Timer 0
      CLR TF0 // Clears TF0 flag
	  RET
	  
// ADD YOUR CODE HERE

;---------------------------------


RET

END
