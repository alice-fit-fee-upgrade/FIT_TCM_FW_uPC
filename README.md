# FIT_TCM_FW_uPC

## Firmware timestamp & version
The build timestamp (32-bit) is located at the very end of the application code (e.g.: 0x2b7c), not far from the " Flash TImestamp:" string.  
The timestamp can be easily translated to firmware version YMD.Hm using the following rule:  
- Y: years, counting from 2020, so 2021 is 1,
- M: month
- D: day
- H: hour
- m: minutes
All the values are coded using the following alphabet:  
> 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvw

---
## Hardware 
Some details about the peripherals the MCU ATxmega128a3 is communicating with.

| PIN 	| LABEL 	| PORT	| MODE			| PERIPHERAL 	|
|:---:	|:---:  	|:---:	| :---:			|:---:        	
|63  	|DA27_SCLK	|PA1 	| SPI CLK		|**ADT7311WTRZ Temperature Sensor**| 
|64	|DA27_DOUT	|PA2 	| SPI MISO		|		| 
|1	|DA27_DIN	|PA3  	| SPI MOSI		| 		|
|2	|DA27_CS	|PA4	| SPI CS		| 		|
|62	|		|PA0 	| OUT LED VD8 (red)	|**LEDS**	|
|3	|		|PA5 	| OUT LED VD12 (blue)	|		|
|4	|		|PA6 	| OUT LED VD13 (red)	|		|
|5	|		|PA7 	| OUT LED VD14 (green)	|		|
|6	|DD46A_AB	|PB0	|			|**X36 Connector**		|
|7	|DD46B_AB	|PB1	|			|		|
|8	|DD46C_AB	|PB2	|			|		|
|9	|DD46D_AB	|PB3	|			|		|
|28	|DD45_ROUT	|PD1 	|			|		|
|29	|DD45_TIN	|PD2	|			|		|
|6	|Xmega_PB4	|PB4	| ???			|**X35**	|		
|16	|DD15_SDA	|PC0	| I2C SDA		|**Si5338 (x2)**|
|17	|DD15_SCL	|PC1	| I2C SCL		|		|
|18	|DD17_INTR	|PC2	| INT0 Si5338 (2) int.	| 		|
|19	|DD15_INTR	|PC3	| INT0 Si5338 (1) int.	|		|
|20	|DD16_CLK_SEL	|PC4	| OUT (clk_sel)		|**Si55301**	|
|50	|DD16_LOS1	|PF4	| INT1 (CLK1 input clock not present | 	|
|51	|DD16_LOS0	|PF5	| INT1 (CLK0 input clock not present |	|
|36 	|Xmega_PE0	|PE0 	| INT 			|**FPGA**	|
|21 	|Xmega_PC5	|PC5 	| SPI MOSI		|		|
|22 	|Xmega_PC6	|PC6 	| SPI MISO 		|		|
|23 	|Xmega_PC7	|PC7 	| SPI SCK		|		|
|26 	|Xmega_PD0	|PD0 	| SPI CS 		|		|
|27 	|Xmega_PD1	|PD1 	| OUT (program) 	|		|
|30	|Xmega_PD4	|PD4	| (init)		|		|
|31	|DD13C_AB	|PD5 	| INT0 (done)		|		|
|9	|Xmega_PB7	|PB7	| ???			|		|
|37	|DA21_RST_N	|PE1	| INT (nrst)		|**LTC2906ITS8**|
|38	|DD11A_A	|PE2	| OUT (enable)		|**2x LM21215AMHX-1 & 1x LD49150PT10R**	|
|39	|DA2_OUT	|PE3	| IN  (outa & outb)	|**TPS3700DSER Voltage monitor** 	|
|40	|DD9_S  	|PE4	| SPI CS		|**N25Q032A11EF840 Serial Flash Memory**| 
|41	|DD9_DQ0	|PE5	| SPI MOSI		|		|
|42	|DD9_DQ1	|PE6	| SPI MISO		|		|
|43	|DD9_C		|PE7	| SPI CLK		|		|
|46	|DD7_T2IN	|PF0	| UART CTS		|**RJ45 Connector**|
|47	|DD7_R2OUT	|PF1	| UART RTS (INT0)	|		|
|48	|DD7_R1OUT	|PF2	| UART Rx 		|		|
|49	|DD7_T1IN	|PF3	| UART Tx		|		|
|7	|NC		|PB5	| ---			|		|
|8	|NC		|PB6	| ---			|		|
|32	|NC		|PD6	| ---			|		|
|33	|NC		|PD7	| ---			|		|
|54	|NC		|PF6	| ---			|		|
|55	|NC		|PF7	| ---			|		|

### ADT7311
Configuration:  
- 0x50 = 0b01010000  
- Fault queue: 00 = 1 fault (default)  
- CT pin polarity: 0 = active low  
- INT pin polarity: 0 = active low  
- INT/CT mode: 1 = comparator mode  
- Operation mode: 01 = one shot (240ms conversion)  
- Resolution: 0 = 13 bit, sign bit + 12 bits  

---
## Memory layout
0x1000 - 0x1023 : EEPROM, configuration. Copied at boot to: 0x2189 - 0x21ad  
  
| MEM 	| EEPROM| Bytes | Value 		|
| :--- 	| :---	| :---	| :---			|
| 0x2000|	| 2	| USART_F0 rx buffer head & tail pointers	|
| 0x2002|	| 2	| USART_F0 tx buffer head & tail pointers  	|
| 0x2005|	| 1	| USART_F0 status  	|
| 0x2006|	| 1	| FPGA communication request   	|
| 0x2007|	| 64	| USART_F0 rx buffer, 64 bytes     	|
| 0x2047|	| xx	| USART_F0 tx buffer, xx bytes       	|
|	|	|	|	|
| 0x214f|	| ?	| Some attenuator msg bufffer (ending here)	|
| 0x2156|	| ?	| Some usart f0 msg buffer (ending here)       	|
| 0x2157| 	| 1	| 5V on PORTE.1 present |
|	|	|	|	|
| 0x215b|	| 5	| some vadj related settings  |
| 0x2158| 	| 1	| FPGA 0x7F status 	|
| 0x2159| 	| 1	| 	|
| 0x2160| 	| 1	| ?? 	| 
| 0x2161| 	| 1 	| clock source settings |
| 0x2162| 	| 1 	| 16#18# settings |
| 0x2163| 	| 4 	| ?? |
| 	| 	| 	| 	|
| 	| 	| 	| 	|
| 0x2173| 	| 16	| USART_D0 tx buffer 	|
| 0x2183| 	| 2	| USART_D0 tx buffer head & tail pointers  |
| 0x2185| 	| 1	| USART_D0 status	|
| 0x2186| 	| 2	| ??	|
| 0x2187|	| 1	| ??	|
| --- 	| ---	| ---	| ---			|
| 0x2189|0x1000	| 4	| IP addr 		|
| 0x218d|0x1004	| 6	| MAC addr 		|
| 0x2193|0x100A	| 2	| A-side phase (delay) 	|
| 0x2195|0x100C	| 2	| C-side phase (delay) 	|
| 0x2197|0x100E	| 2	| Laser phase (delay) 	|
| 0x2199|0x1010	| 2	| Attenuator settings	|
| 0x219b|0x1012	| 1 	| Port B settings (PB4+PB7)	|
| 0x219d|0x1013	| 2	| Vertex time low threshold	|
| 0x219c|0x1015	| 1	| [UNUSED]	|
| 0x219f|0x1016	| 2	| Vertex time high threshold	|
| 0x21a1|0x1018	| 2	| SemiCentral level A 	|
| 0x21a3|0x101A	| 2	| SemiCentral level C 	|
| 0x21a5|0x101C	| 2	| Central level A 	|
| 0x21a7|0x101E	| 2	| Central level C 	|
| 0x21a9|0x1020	| 1	| Trigger mode 		|
| 0x21aa|0x1021	| 1 	| [UNUSED] 	|
| 0x21ab|0x1022	| 2	| Board S/N (4x4bit)	|
| ---	| ---	| ---	| ---	|
| 0x23ae| 	| 4	| 	|
| 0x29ba|
| 0x2b74| 	| 8 	| Programming lock [0x78,0x56,0x34,0x12,0x98,0xBA,0xDC,0xFE ] |
| 0x2b7c|	| 4	| Flash timestamp	|
| 0x3ffd| 	| 1	| Program status 	|

---  
## UART F0 commands
| CMD 		| DESC |
|:---: 		|:---: |
| AC\rxxx 	| Send xxx msg to UART_D0, till ESC is present |
| CA\r		| |
| CL x\r 	| x=0 or x=1,  setting PORTF interrupt behavior |
| CP\r		| get PMA0..7 link status |
| ON or OF	| EEPROM erase? |
| PA		| Flash ATxmega with new firmware |
| PF		| Flash FPGA with new firmware |
| RP 		| Read params |
| RS 		| Read status |
| SA 		| Set A-side phase (delay) |
| SC 		| Set C-side phase (delay) |
| SI 		| Set IP address |
| SL 		| Set Laser phase (delay) |
| SM 		| Set MAC address|
| SS 		| Set switches (port B settings)	|
| STH 		| Set vertex time high threshold |
| STL 		| Set vertex time low threshold |
| STM 		| Set trigger mode |
| SV 		| Set board S/N	|
| SW 		| Set attenuator steps	|
| THA 		| Set Central level A|
| THC 		| Set Central level C|
| TMA 		| Set SemiCentral level A|
| TMC 		| Set SemiCentral level C|
| WR 		| Write settings to EEPROM|

---
## NOTES
PORTA_OUTSET 0x80 has some connection with PORTB_OUTCLR = 0x80
PORTA_OUTSET 0xC0 has some connection with PORTB_OUTSET = 0x10
