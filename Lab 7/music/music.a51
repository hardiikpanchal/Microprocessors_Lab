; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable
	
ORG 0H
LJMP MAIN
ORG 30H
MAIN:
CALL music
here: sjmp here

;-------------------------------------
ORG 001BH
	
LJMP 400H

;-------------------------
ORG 60H
	
MUSIC:

	MOV TMOD, #11H
	MOV IE, #88H		;ENABLING INTERRUPTS FROM TIMER1
	MOV TH1, #3CH		; Load THL for 25 miliseconds
	MOV TL1, #0AFH
	SETB TR1			;STARTING TIMER1
	CLR A
	MOV R5, A			;STORING 0 TO R5 AT START
	MOV R6, A			;STORING 0 TO R6 AT START
	
	ACALL DISPLAY
	
	SJMP DECIDE
	
	DECIDE: CLR C
			MOV A, #00H
			SUBB A, R6
			JZ NOTE1
		 
			CLR C
			MOV A, #01H
			SUBB A, R6
			JZ NOTE2
			
			CLR C
			MOV A, #02H
			SUBB A, R6
			JZ NOTE3
			
			CLR C
			MOV A, #03H
			SUBB A, R6
			JZ NOTE4
			
			CLR C
			MOV A, #04H
			SUBB A, R6
			JZ NOTE5
			
			CLR C
			MOV A, #05H
			SUBB A, R6
			JZ NOTE6
			
			CLR C
			MOV A, #06H
			SUBB A, R6
			JZ NOTE7
			
			CLR C
			MOV A, #07H
			SUBB A, R6
			JZ NOTE8
			
			SJMP MUSIC
	
;-----------------------------------------

	NOTE1: ACALL N1
		   CPL P0.7
		   SJMP DECIDE
		   
	NOTE2: ACALL N2
		   CPL P0.7
		   SJMP DECIDE

	NOTE3: ACALL N3
		   CPL P0.7
		   SJMP DECIDE
		  
	NOTE4: ACALL N2
		   CPL P0.7
		   SJMP DECIDE
		   
	NOTE5: ACALL N4
		   CPL P0.7
		   SJMP DECIDE
		   
	NOTE6: ACALL SILENCE
		   SJMP DECIDE	

	NOTE7: ACALL N4
		   CPL P0.7
		   SJMP DECIDE
		   
	NOTE8: ACALL N5
		   CPL P0.7
		   SJMP DECIDE
		   
;-----------------------------
	N1:
	MOV TH0, #0EEH
	MOV TL0, #3EH
	SETB TR0
	
	REPEAT1: JNB TF0, REPEAT1
			 CLR TR0
			 CLR TF0
			 RET
;----------------------------------
	N2:
	MOV TH0, #0F0H
	MOV TL0, #2FH
	SETB TR0
	
	REPEAT2: JNB TF0, REPEAT2
			 CLR TR0
			 CLR TF0
			 RET
;---------------------------------
	N3:
	MOV TH0, #0F2H
	MOV TL0, #0BFH
	SETB TR0
	
	REPEAT3: JNB TF0, REPEAT3
			 CLR TR0
			 CLR TF0
			 RET
;---------------------------------
	N4:
	MOV TH0, #0F5H
	MOV TL0, #70H
	SETB TR0
	
	REPEAT4: JNB TF0, REPEAT4
			 CLR TR0
			 CLR TF0
			 RET
;----------------------------------
	N5:
	MOV TH0, #0F4H
	MOV TL0, #29H
	SETB TR0
	
	REPEAT5: JNB TF0, REPEAT5
			 CLR TR0
			 CLR TF0
			 RET
;----------------------------------
	SILENCE:
	CLR P0.7
	
	MOV TH0, #0EEH
	MOV TL0, #3EH
	SETB TR0
	
	REPEATS: JNB TF0, REPEATS
			 CLR TR0
			 CLR TF0
			 RET
;----------------------------------	
	
	display:
	mov P2,#00h
    mov P1,#00h
	;initial delay for lcd power up

	;here1:setb p1.0
    acall delay
	;clr p1.0
	acall delay
	;sjmp here1
	  acall lcd_init      ;initialise LCD
	
	  acall delay
	  acall delay
	  acall delay
	  mov a,#82h		 ;Put cursor on first row,5 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  ret
;------------------------LCD Initialisation routine----------------------------------------------------
lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine

;-----------------------command sending routine-------------------------------------
 lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
;-----------------------data sending routine-------------------------------------		     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine

;-----------------------text strings sending routine-------------------------------------
lcd_sendstring:
	push 0e0h
	lcd_sendstring_loop:
	 	 clr   a                 ;clear Accumulator for any previous data
	         movc  a,@a+dptr         ;load the first character in accumulator
	         jz    exit              ;go to exit if zero
	         acall lcd_senddata      ;send first char
	         inc   dptr              ;increment data pointer
	         sjmp  LCD_sendstring_loop    ;jump back to send the next character
exit:    pop 0e0h
         ret                     ;End of routine

;----------------------delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loop1:	 djnz r1, loop1
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret

;------------- ROM text strings---------------------------------------------------------------
org 300h
my_string1:
         DB   "ROLLING TIME", 00H			 
;-------------------------------------
ORG 400H
	
			CLR C
			MOV A, #00H
			SUBB A, R6
			JZ ONETOFOUR1
		 
			CLR C
			MOV A, #01H
			SUBB A, R6
			JZ ONETOFOUR1
			
			CLR C
			MOV A, #02H
			SUBB A, R6
			JZ ONETOFOUR1
			
			CLR C
			MOV A, #03H
			SUBB A, R6
			JZ ONETOFOUR1
			
			CLR C
			MOV A, #04H
			SUBB A, R6
			JZ FIVESEVENEIGHT
			
			CLR C
			MOV A, #05H
			SUBB A, R6
			JZ SIX
			
			CLR C
			MOV A, #06H
			SUBB A, R6
			JZ FIVESEVENEIGHT
			
			CLR C
			MOV A, #07H
			SUBB A, R6
			JZ FIVESEVENEIGHT
		
ONETOFOUR1:
INC R5
CJNE R5, #1EH, ONETOFOUR2
CLR A
MOV R5, A
SJMP INCR

FIVESEVENEIGHT:
INC R5
CJNE R5, #28H, ONETOFOUR2
CLR A
MOV R5, A
SJMP INCR

SIX:
INC R5
CJNE R5, #14H, ONETOFOUR2
CLR A
MOV R5, A
SJMP INCR

INCR:
INC R6
RETI 

ONETOFOUR2:
	MOV TH1, #3CH						; Load THL for 25 miliseconds
	MOV TL1, #0AFH
	SETB TR1
	RETI
	
;--------------------------------
end