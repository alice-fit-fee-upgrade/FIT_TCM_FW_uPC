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
|47	|DD7_R2OUT		|PF1	||
|48	|DD7_R1OUT		|PF2	||
|49	|DD7_T1IN		|PF3	||
|21 	|Xmega_PC5		|PC5 	|**Some SPI Device**|
|22 	|Xmega_PC6		|PC6 	||
|23 	|Xmega_PC7		|PC7 	||
|26 	|Xmega_PD0		|PD0 	||

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

0x2000 - 0x23b2 : Some bigger struct(?)  

0x215b - 0x215f : some vadj related settings  
0x2161 : Clock source settings
0x2189 [4B] : IP ADDR  
0x2193 - 
0x219a [1B] : PORT B[0:3] settings  
0x21aa [2B] : Board S/N  



## UART commands

| CMD 	| DESC |
|:--- 	|:--- |
| RP 	| Send system status |
| RS 	| Send system params|
| SA 	| |
| SC | |
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
