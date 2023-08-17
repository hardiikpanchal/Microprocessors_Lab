#include <at89c5131.h>
#include "lcd.h"				//Header file with LCD interfacing functions
#include "MorseCode.h"	//Header file for Morse Code 

sbit LED=P1^7;

sbit a = P1^0;
sbit b = P1^1;
sbit c = P1^2;
sbit d = P1^3;
	

/*
Port P0.7 is used for the audio signal output
*/	
//Main function

void main(void)
{
		
	//Call initialization functions
	lcd_init();
	lcd_cmd(0x80);
	// Read input nibble here
	P1 = 0x0F;
	
	// Insert Priority Logic
	if(a == 1){
		lcd_write_string("A");
		morse_a();		
	}
	else if(b == 1){
		lcd_write_string("B");
		morse_b();
	}
	else if(c == 1){
		lcd_write_string("C");		
		morse_c();
	}
	else if(d == 1){
		lcd_write_string("D");				
		morse_d();
	}
	else{
		lcd_write_string("E");
		morse_e();
	}
	// Inside each condition, call the functions from MorseCode.h. Fill functions in MorseCode.h
	// Write to LCD using function lcd_write_string() in side the condition as well
	// 
	
	while(1){		
		msdelay(1);
	}
	
}
