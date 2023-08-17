; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable
	
ORG 0H
LJMP MAIN
ORG 30H
MAIN:
CALL reaction
here: sjmp here
ORG 60H
	
reaction:
		
		mov p2,#00h
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
		
	  mov a,#83h		 ;Put cursor on first row,5 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  
	  mov a,#0C2h		 ;Put cursor on first row,5 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#my_string2   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay
	  
	  setb p1.0		;making p1.0 as input port
	  
	  acall delay_1s
	  acall delay_1s
	  
	  ;delay of 2 seconds
	  
	  mov IE, #82H		;interrupts enabled	  
	  
	  MOV TH0, #0F8H
	  MOV TL0, #2FH
	  MOV TMOD, #11H ;timer0 initialization
	  
	  setb p1.4			;led p1.4 started glowing
	  
	  mov r1, #00H
	  mov r2, #00H
	  mov r3, #00H
	  mov r4, #00H
	   
	  SETB TR0		 ;timer started
	  	   
	 
	  repeat: JB P1.0, toggle
			  sjmp repeat
			
	  toggle: clr TR0
			  clr TF0
			  
			  clr p1.4		;turning off led p1.4			  
			  sjmp display
			  
	display: mov a,#82h		 ;Put cursor on first row,5 column
			acall lcd_command	 ;send command to LCD
			acall delay
			mov   dptr,#my_string3   ;Load DPTR with sring1 Addr
			acall lcd_sendstring	   ;call text strings sending routine
			acall delay
			
			mov a,#0C5h		 ;Put cursor on first row,5 column
			acall lcd_command	 ;send command to LCD
			acall delay
			mov   dptr,#my_string4   ;Load DPTR with sring1 Addr
			acall lcd_sendstring	   ;call text strings sending routine
			acall delay
			
			mov a, #0c0h
			acall lcd_command
			acall delay
			mov a, r4
			add a, #30h
			acall lcd_senddata
			
			mov a, r3
			add a, #30h
			acall lcd_senddata
			
			mov a, r2
			add a, #30h
			acall lcd_senddata
			
			mov a, r1
			add a, #30h
			acall lcd_senddata
			
			acall delay_1s
			acall delay_1s
			acall delay_1s
			acall delay_1s
			acall delay_1s
			
			ljmp reaction	
			
;-----------------------------
org 000bh

ljmp overflow

;-----------------------------
org 400h
	
overflow:
	  clr TR0
	  
	  cjne r1, #09H, incr1
	  mov r1, #00H
	  
	  cjne r2, #09H, incr2
	  mov r2, #00H
	  
	  cjne r3, #09H, incr3
	  mov r3, #00H
	  
	  cjne r4, #09H, incr4 
	  sjmp update
	  
	  incr1: INC r1
		     sjmp update
			 
	  incr2: INC r2
		     sjmp update
			 
	  incr3: INC r3
		     sjmp update
			 
	  incr4: INC r4
		     sjmp update
	   
	  update:
	  MOV TH0, #0F8H
	  MOV TL0, #2FH
	  MOV TMOD, #11H ;initialization
	  SETB TR0		 ;timer started
	  reti

;---------------------------
delay_1s:
	mov r2, #32h
	h1: acall delay_20ms
	djnz r2, h1
	ret
;------------------------------
delay_20ms:

MOV TMOD, #11H
MOV TH1, #063H
MOV TL1, #0C0H
SETB TR1

LOOP: JNB TF1,LOOP // Loops here until TF1 is set (ie;until roll over)
      CLR TR1 // Stops Timer 1
      CLR TF1 // Clears TF1 flag
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
         DB   "Toggle SW1", 00H
my_string2:
         DB   "if LED glows", 00H
my_string3:
         DB   "Reaction Time", 00H
my_string4:
		 DB   "miliseconds", 00H
			 
;-------------------------------------
end