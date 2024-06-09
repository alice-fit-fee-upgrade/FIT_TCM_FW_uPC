# FIT_TCM_FW_uPC

## Hardware 
Some details about the peripherals the MCU ATxmega128a3 is communicating with.

| PIN 	| LABEL 		| PORT 	| PERIPHERAL |
|:--- 	|:---:  		|:---: 	|:---        |
|63  	|DA27_SCLK		|PA1 	|**ADT7311WTRZ Temperature Sensor**| 
|64	|DA27_DOUT		|PA2 	|| 
|1	|DA27_DIN		|PA3  	|| 
|2	|DA27_CS		|PA4	|| 
|40	|DD9_S  		|PE4	|**N25Q032A11EF840 Serial Flash Memory**| 
|41	|DD9_DQ0		|PE5	||
|42	|DD9_DQ1		|PE6	||
|43	|DD9_C			|PE6	||
|28	|DD45_ROUT		|PD1 	|**X36 Connector**|
|29	|DD45_TIN		|PD2	||
|6	|DD46A_AB		|PB0	||
|7	|DD46B_AB		|PB1	||
|8	|DD46C_AB		|PB2	||
|9	|DD46D_AB		|PB3	||
|46	|DD7_T2IN		|PF0	|**RJ45 Connector**|
|47	|DD7_R2OUT		|PF1	| RTS ? |
|48	|DD7_R1OUT		|PF2	||
|49	|DD7_T1IN		|PF3	||
|16	|DD15_SDA		|PC0	|**Si5338 (x2)**|
|17	|DD15_SCL		|PC1	||
|18	|DD17_INTR		|PC2	|Si5338 dev.2 interrupt|
|19	|DD15_INTR		|PC3	|Si5338 dev.2 interrupt|
|20	|DD16_CLK_SEL		|PC4	|**Si55301 CLK BUFFER**|
|21 	|Xmega_PC5		|PC5 	|**FPGA**|
|22 	|Xmega_PC6		|PC6 	||
|23 	|Xmega_PC7		|PC7 	||
|26 	|Xmega_PD0		|PD0 	||
|36 	|Xmega_PE0		|PE0 	||

### ADT7311
Configuration:  
; 0x50 = 0b01010000  
; Fault queue: 00 = 1 fault (default)  
; CT pin polarity: 0 = active low  
; INT pin polarity: 0 = active low  
; INT/CT mode: 1 = comparator mode  
; Operation mode: 01 = one shot (240ms conversion)  
; Resolution: 0 = 13 bit, sign bit + 12 bits  

## Memory layout

0x1000 - 0x1023 : EEPROM, configuration. Copied at boot to: 0x2189 - 0x21ad  
  
0x2000 [2B] : USART_F0 rx buffer head & tail pointers  
0x2002 [2B] : USART_F0 tx buffer head & tail pointers  
0x2005 [1B] : USART_F0  
0x2006 [1B] : FPGA communication request  
0x2007 [64B] : USART_F0 rx buffer, 64 bytes  
0x2047 [xx] : USART_F0 tx buffer, xx bytes  
0x215b - 0x215f : some vadj related settings  
0x2161 : Clock source settings  
0x2173 [16B] : USART_D0 tx buffer  
0x2183 [2B] : USART_D0 tx buffer head & tail pointers  
0x2185 [1B] : USART_D0 status  
0x2186 - 0x2187 : ???  
---  
0x2189 [4B] : IP ADDR  

0x2193 -  
0x219a [1B] : PORT B[0:3] settings  
0x219d [] :  
0x21ab [2B] : Board S/N (4 x 4bit)  
---  
0x2b7c [4B] : Flash timestamp  
0x3ffd [1B] : program status  


## UART F0 commands

| CMD 		| DESC |
|:--- 		|:--- |
| AC\rxxx 	| Send xxx msg to UART_D0, till ESC is present |
| CA\r		| 
| CP		|
| L x\r 	| x=0 or x=1
| O
| P
| RP 		| Send system status |
| RS 		| Send system params|
| SA 		| |
| SC 		| |
| SI | |
| SL | |
| SM | |
| SS | |
| STH | |
| STL | |
| STM | |
| SV.. | |
| SWR | |
| THA | |
| THC | |
| TMA | |
| TMC | |
| WR ||
