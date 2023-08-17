; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0H
LJMP MAIN
ORG 00H
MAIN:
CALL pam
here: sjmp here
ORG 30H
// *****************

pam:	mov 70h, #0F3H
		mov 71h, #0B1H
		
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
		
	mov a, 70h
	mov r0, a
	anl a, #0fh
	swap a
	mov r3, a   ; r3 has level 1
	mov a, r0
	anl a, #0f0h
	mov r4, a   ; r4 has level 2
	
	mov a, 71h
	mov r0, a
	anl a, #0fh
	swap a
	mov r5, a   ; r5 has level 3
	mov a, r0
	anl a, #0f0h
	mov r6, a   ; r6 has level 4
	
	mov dptr, #my_string1
	call level1
	
	mov a, r4
	mov r3, a
	mov dptr, #my_string2
	call level1
	
	mov a, r5
	mov r3, a
	mov dptr, #my_string3
	call level1
	
	mov a, r6
	mov r3, a
	mov dptr, #my_string4
	call level1
	
	ljmp pam
;-------------------------------------------------	
    level1:
	mov a, r3
	mov p1, a
	  
	  mov a,#85h		 ;Put cursor on first row,5 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  ;mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  
	  mov a,#0C2h		 ;Put cursor on first row,5 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#my_string5   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  
	  mov a,#0C9h		  ;Put cursor on second row,3 column
	  acall lcd_command
	  acall delay
	  
	  sjmp digit13
	  
	  digit13: mov a, r3
			  clr c
			  rlc a
			  mov r3, a
	          jnc zero13
			  mov a, #31h
			  acall lcd_senddata
			  sjmp digit12
	  zero13: mov a, #30h
			  acall lcd_senddata
			  sjmp digit12
	  
	  digit12: mov a, r3
			  clr c
	          rlc a
			  mov r3, a
	          jnc zero12
			  mov a, #31h
			  acall lcd_senddata
			  sjmp digit11
	  zero12: mov a, #30h
			  acall lcd_senddata
			  sjmp digit11
	  
	  digit11: mov a, r3
			  clr c
	          rlc a
			  mov r3, a
	          jnc zero11
			  mov a, #31h
			  acall lcd_senddata
			  sjmp digit10
	  zero11: mov a, #30h
			  acall lcd_senddata
			  sjmp digit10
			
	  digit10: mov a, r3
			  clr c
	          rlc a
			  mov r3, a
	          jnc zero10
			  mov a, #31h
			  acall lcd_senddata
			  acall delay_1s
			  ret
	  zero10: mov a, #30h
			  acall lcd_senddata
			  acall delay_1s
			  ret 

;-------------------------------------------------	
	  
;---------------------------
delay_1s:
	mov r2, #32h
	h1: acall delay_20ms
	djnz r2, h1
	ret
;------------------------------
delay_20ms:

MOV TMOD, #01H
MOV TH0, #063H
MOV TL0, #0C0H
SETB TR0

LOOP: JNB TF0,LOOP // Loops here until TF0 is set (ie;until roll over)
      CLR TR0 // Stops Timer 0
      CLR TF0 // Clears TF0 flag
	  RET

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
         DB   "Level 1", 00H
my_string2:
         DB   "Level 2", 00H
my_string3:
         DB   "Level 3", 00H
my_string4:
         DB   "Level 4", 00H
my_string5:
		 DB   "Value: ", 00H
			 
;-------------------------------------
END
