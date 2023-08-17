ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL SEARCH
HERE: SJMP HERE
ORG 130H
SEARCH:
// Add your code here.

	MOV R3, 30H
	MOV R2, 31H
	
// MOV R4, 32H		//KEY
// R3 will have the value of starting address of array(L)
// R2--->31H has the value of N(Length of an array)
// R5 will have the value of M	
		
	LOOP: SJMP BASE0
		
	BASE0: 	CLR C
			MOV A, R2
			CJNE A, #00H, BASE1
			MOV 33H, #0EH
			SJMP STOP
// Checking if N is zero or not.
// If it is zero then value 0EH will be stored in location 33H
			
	BASE1:  CLR C
			MOV A, R2
			CJNE A, #01H, SEARCH1
// Checking if N is ONE or not.
// If N is not 1 then go to SEARCH1 
// Otherwise continue below

			MOV A, R3
			MOV R1, A
		
			MOV A, @R1
			CJNE A, 32H, NOTFOUND  
			MOV 33H, R1
			SJMP STOP

	NOTFOUND: MOV 33H, #0EH
			  SJMP STOP

///////////////////////////////////////////

	SEARCH1:MOV A, R2
			MOV B, #2
			DIV AB
			
			//MOV R7, A
			//MOV A, R2
			//CLR C
			//SUBB A, R7
			//MOV R2, A
			
			ADD A, R3
			MOV R5, A			
			//Computation of M -------:: M = START + (N/2)
			
			MOV A, R5
			MOV R1, A
			MOV A, @R1
			CJNE A, 32H, SEARCH2
			
			MOV 33H, R1 //Storing key index at 33H
			SJMP STOP

//////////////////////////////////////////////
			
	SEARCH2:MOV A, R5
			MOV R1, A
			CLR C
			MOV A, 32H
			SUBB A, @R1
			JC SEARCH3
			
			MOV A, R5
			//MOV R6, A
			//INC R6			// ASSIGNING START TO M
			//MOV A, R6
			MOV R3, A
			
			CALL DIVN
			
			SJMP LOOP		// GOING TO MAIN LOOP
		
			
///////////////////////////////////			
			
	SEARCH3:CALL DIVN 
			
			SJMP LOOP		// GOING TO MAIN LOOP
			  
///////////////////////////////////	

	DIVN:
			MOV A, R2
			MOV B, #2		// MAKEING N ----> N - N/2
			DIV AB
			MOV R7, A
			MOV A, R2
			CLR C
			SUBB A, R7
			MOV R2, A
			RET
	
	STOP:SJMP STOP

RET
END