ORG 0H
LJMP MAIN
ORG 30H
MAIN:
CALL DIP
HERE: SJMP HERE
ORG 30H
// *****************
DIP:
// ADD YOUR CODE HERE
; This subroutine writes characters on the LCD
		LCD_data equ P2    ;LCD Data port
		LCD_rs   equ P0.0  ;LCD Register Select
		LCD_rw   equ P0.1  ;LCD Read/Write
		LCD_en   equ P0.2  ;LCD Enable
			
		mov P2,#00h
		mov P1,#00h
		;initial delay for lcd power up
		;here1:setb p1.0
      	acall delay
		;clr p1.0
		acall delay
		;sjmp here1
		acall lcd_init      ;initialise LCD
		
STATE0:	acall delay
		acall delay
		acall delay
		mov a,#82h		 ;Put cursor on first row,5 column
		acall lcd_command	 ;send command to LCD
		acall delay
		mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
		acall lcd_sendstring	   ;call text strings sending routine
		acall delay

		mov a,#0C3h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string2
		acall lcd_sendstring
		
		
		CLR A
		ADD A, #0f0h
		MOV P1, A
		
		CALL delay_1s
		mov p1, #00H
		LJMP STATE1

state1: acall delay
		acall delay
		acall delay
		mov a,#81h		 ;Put cursor on first row,5 column
		acall lcd_command	 ;send command to LCD
		acall delay
		mov   dptr,#my_string3   ;Load DPTR with sring1 Addr
		acall lcd_sendstring	   ;call text strings sending routine
		acall delay

		mov a,#0C3h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string2
		acall lcd_sendstring
		
		mov p1, #8fh
		call delay_1s
		call delay_1s
		mov a, p1
		anl a, #0fh
		swap a
		mov r1, a
		ljmp state2
		
		
state2: mov p1, #4fh
		call delay_1s
		call delay_1s
		mov a, p1
		anl a, #0fh
		add a, r1
		mov 30h, a
		ljmp state3	
		
		
state3: mov p1, #2fh
		call delay_1s
		call delay_1s
		mov a, p1
		anl a, #0fh 
		swap a
		mov r1, a
		ljmp state4

state4: mov p1, #1fh
		call delay_1s
		call delay_1s
		mov a, p1
		anl a, #0fh
		add a, r1
		mov 31h, a
		ljmp state5
		
state5: mov a, 30h
		mov b, 31h
		
		mul AB
		mov 50h, a
		mov 51h, b
		
		;-----------------------
		acall delay
		acall delay
		acall delay
		mov a,#80h		 ;Put cursor on first row,5 column
		acall lcd_command	 ;send command to LCD
		acall delay
		mov   dptr,#my_string4   ;Load DPTR with sring1 Addr
		acall lcd_sendstring	   ;call text strings sending routine
		
		
		;-----------------------
		
		mov a, 30h
		call ASCII
				
		mov a,#0C0h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string5
		acall lcd_sendstring
		
		mov a,#0C5h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov a, 60h
		acall lcd_senddata
		mov a, 61h
		acall lcd_senddata
		
		mov a,#0C7h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string6
		acall lcd_sendstring
		
		mov a, 31h
		call ASCII
		
		mov a,#0CEh		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov a, 60h
		acall lcd_senddata
		mov a, 61h
		acall lcd_senddata
		
		call delay_1s
		call delay_1s
		
		
		ljmp state6
		
state6:	acall delay
		acall delay
		acall delay
		
		mov a,#80h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string9
		acall lcd_sendstring
		acall delay
		
		mov a,#81h		 ;Put cursor on first row,5 column
		acall lcd_command	 ;send command to LCD
		acall delay
		mov   dptr,#my_string7   ;Load DPTR with sring1 Addr
		acall lcd_sendstring	   ;call text strings sending routine
		acall delay
		
		mov a, 51h
		call ASCII
		
		mov a,#8Ah		 ;Put cursor on first row,5 column
		acall lcd_command	 ;send command to LCD
		acall delay
		mov a, 60h
		acall lcd_senddata	   ;call text strings sending routine
		mov a, 61h
		acall lcd_senddata	   ;call text strings sending routine
		acall delay
		
		mov a, 50h
		call ASCII
		
		mov a,#8Ch		 ;Put cursor on first row,5 column
		acall lcd_command	 ;send command to LCD
		acall delay
		mov a, 60h
		acall lcd_senddata	   ;call text strings sending routine
		mov a, 61h
		acall lcd_senddata	   ;call text strings sending routine
			
		mov a,#8Eh		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string8
		acall lcd_sendstring
		acall delay
		
;----------------------------------------
		mov a, 30h
		call ASCII
				
		mov a,#0C0h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string5
		acall lcd_sendstring
		
		mov a,#0C5h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov a, 60h
		acall lcd_senddata
		mov a, 61h
		acall lcd_senddata
		
		mov a,#0C7h		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov   dptr,#my_string6
		acall lcd_sendstring
		
		mov a, 31h
		call ASCII
		
		mov a,#0CEh		  ;Put cursor on second row,3 column
		acall lcd_command
		acall delay
		mov a, 60h
		acall lcd_senddata
		mov a, 61h
		acall lcd_senddata
		
		call delay_1s
		call delay_1s
		

;-------------------------------------------------------------
delay_1s:
push 00h
mov r0, #100
h3: acall delay_10ms
djnz r0, h3
pop 00h
ret

delay_10ms:
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
         DB   "Enter Inputs", 00H
my_string2:
		 DB   "EE337-2022", 00H
my_string3:
		 DB   "Reading Inputs", 00H
my_string4:
		 DB   "Computing Results", 00H
my_string5:
		 DB   "Num1:", 00H
my_string6:
		 DB   ", Num2:", 00H
my_string7:
		 DB   "Result = ", 00H
my_string8:
		 DB   "  ", 00H
my_string9:
		 DB   " ", 00H
;---------------------------------------------------------------------------------------------

ASCII:
// ADD YOUR CODE HERE

MOV R7, A
ANL A, #0FH
MOV R1, A

MOV A, R7
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
		 ret
////////////////////////

END