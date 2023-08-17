#include <at89c5131.h>
#include "endsem.h"

char S_str[6]= {0,0,0,0,0,0};   //String for Balance Sita
char G_str[6] = {0,0,0,0,0,0};  //String for Balance Gita
char n500_s[3]= {0,0,0};    // STRING FOR 500RS NOTE
char n100_s[3]= {0,0,0};    // STRING FOR 100RS NOTE

char password[5] = {0,0,0,0,0} ;   //PASSWORD ARRAY

//Main function

//-------------------------------------------------
void main(void)
{
		uart_init();            // Please finish this function in endsem.h 
	
    while (1)
    {
        unsigned char ch = 0;
				unsigned char amount1 = 0;
				unsigned char amount2 = 0;
				unsigned char password0 = 0;
				unsigned char password1 = 0;
				unsigned char password2 = 0;
				unsigned char password3 = 0;
				unsigned char password4 = 0;
	
			
				unsigned int balance_Sita = 10000;
				unsigned int balance_Gita = 10000;
			
				unsigned int msb = 0;
				unsigned int lsb = 0;
			
				
				unsigned int final_w_count = 0;
				unsigned int notes_500 = 0;
				unsigned int notes_100 = 0;
			
				int_to_string(balance_Sita, S_str);
				int_to_string(balance_Gita, G_str);
			
										
				transmit_string("Press A for Account display and W for withdrawing cash\r\n");
				//initial state 
			
				//Receive a character
				ch = receive_char();
		
			if(ch == 'a' || ch == 'A'){	//Account Display
				
				unsigned char acc_number = 0;
				transmit_string("Hello, Please enter Account Number\r\n");
				
				acc_number = receive_char();
				
				if(acc_number == '1'){
					
					transmit_string("Account Holder: Sita\r\n");
					transmit_string("Account Balance: ");
					transmit_string(S_str);
					transmit_string("\r\n");
					
				}
				else if(acc_number == '2'){
					
					transmit_string("Account Holder: Gita\r\n");
					transmit_string("Account Balance: ");
					transmit_string(G_str);
					transmit_string("\r\n");
					
				}
				else{
					transmit_string("No such account, please enter valid details\r\n");
					
				}			

			}//Account display state ends here
			
			
			else{//Withdraw cash
					
					unsigned char number_W = 0;
				
					transmit_string("Withdraw state, enter account number\r\n");
				
					number_W = receive_char();
				
				if(number_W == '1'){
					
					transmit_string("Account Holder: Sita\r\n");
					transmit_string("Account Balance: ");
					transmit_string(S_str);
					transmit_string("\r\n");
					
					transmit_string("Enter Amount, in hundreds\r\n");
				
					amount1 = receive_char();
					amount2 = receive_char();
				
					amount1 = amount1 - 0x30;
					amount2 = amount2 - 0x30;
				
					transmit_string("Please enter password\r\n");
					
					password0 = receive_char();
					password1 = receive_char();
					password2 = receive_char();
					password3 = receive_char();
					password4 = receive_char();
					
					if(password0 == 'E' && password1 == 'E' && password2 == '3' && password3 == '3' && password4 == '7'){
						
							
					msb = amount1;
					lsb = amount2;
				
					msb = msb*1000;
					lsb = lsb*100;
				
					final_w_count = msb + lsb;
				
					notes_500 = final_w_count/500;
					notes_100 = (final_w_count%500)/100;
				
					balance_Sita = balance_Sita - final_w_count;
					int_to_string(balance_Sita, S_str);
				
					int_to_string_2(notes_500, n500_s);
					int_to_string_2(notes_100, n100_s);
				
					transmit_string("Remaining Balance: ");
					transmit_string(S_str);
					transmit_string("\r\n");
				
				
					transmit_string("500 Notes: ");
					transmit_string(n500_s);
				
					transmit_string(", 100 Notes: ");
					transmit_string(n100_s);
							
					transmit_string("\r\n");
				}
					else{
						continue;
					}
					
					
				}
				else if(number_W == '2'){
					
					transmit_string("Account Holder: Gita\r\n");
					transmit_string("Account Balance: ");
					transmit_string(G_str);
					transmit_string("\r\n");
					
					transmit_string("Enter Amount, in hundreds\r\n");
				
				
					amount1 = receive_char();
					amount2 = receive_char();
				
					amount1 = amount1 - 0x30;
					amount2 = amount2 - 0x30;
					
					transmit_string("Please enter password\r\n");
					
					password0 = receive_char();
					password1 = receive_char();
					password2 = receive_char();
					password3 = receive_char();
					password4 = receive_char();
					
					if(password0 == 'U' && password1 == 'P' && password2 == 'L' && password3 == 'A' && password4 == 'B'){
				
					msb = amount1;
					lsb = amount2;
				
					msb = msb*1000;
					lsb = lsb*100;
				
					final_w_count = msb + lsb;
				
					notes_500 = final_w_count/500;
					notes_100 = (final_w_count%500)/100;
				
					balance_Gita = balance_Gita - final_w_count;
					int_to_string(balance_Gita, G_str);
				
					int_to_string_2(notes_500, n500_s);
					int_to_string_2(notes_100, n100_s);
				
					transmit_string("Remaining Balance: ");
					transmit_string(G_str);
					transmit_string("\r\n");
				
				
					transmit_string("500 Notes: ");
					transmit_string(n500_s);
				
					transmit_string(", 100 Notes: ");
					transmit_string(n100_s);
							
					transmit_string("\r\n");
					
				}
					else{
						continue;
					}
					
				}
				else{
					transmit_string("No such account, please enter valid details\r\n");
					
					continue;
					
				}
				
						
			}//Withdraw state ends here
				
				
			
    }//while loop ends here
		
}//main function ends here


