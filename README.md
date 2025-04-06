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
## Firmware
### Boot
1. Ports, timer counter, oscillator, interrupts, etc. settings
2. Clear storage memory (0x2000 - 0x23b2)
3.  
4. Check whether 5V is available. If so, set 4s. FPGA status (0x215b <= 1) and timer (0x215c). Otherwise, set GPIOR0 bit 1.
5. Set attenuator timer (0x215e) to 2s.
6. Set ADT7311 configuration
7. Copy EEPROM settings to working memory
8. Set attenuator port (X36) output pins (PB0-3) according to EEPROM settings
9. Send "INR TCM control interface ready" to communication console

#### ADT7311 startup
At the very beginning the following data is sent to the temperature sensor:
1. CMD 0x08 (reg 0x1) -> VAL 0x50 (0b01010000):  
Set configuration register bits to:  
[1:0] -> 00 : 1 fault (default)  
[2] -> 0 : CT active low  
[3] -> 0 : INT active low  
[4] -> 1 : comparator mode  
[6:5] -> 10 : 1 SPS operation mode  
[7] -> 0 : 13-bit resolution mode  
2. CMD 0x20 (reg 0x4) -> VAL 0x00 0x23:  
Set temperature critical setpoint to 0x2300 (1120 * 0.0625 = 70)
3. CMD 0x30 (reg 0x6) -> VAL 0x00 0x1E:  
Set temperature high setpoint to 0x1E00 (960 * 0.0625 = 60)

#### Attenuator startup
Attenuator port (X36) apart from having Tx/Rx capabilities, also has some 4 additional pins.  
Their current (saved in EEPROM) configuration is:
- DD46A set to LOW
- DD46B set to LOW
- DD46C set to LOW
- DD46D set to LOW

#### Si5338 startup


#### FPGA startup
FPGA status is stored at 0x215b with starting value equal zero.
0. Do nothing
1. If 5V is present, then enable (EN_PSU) 2x LM21212AMHX-1 & 1x LD49150PT10R, delay 2s.
2. Check whether TPS3700 are ok, set USART_D0 status to 0x1f, initialize Si5338 communication
3. Set FPGA init pin, clear FPGA program pin then set, delay 2,5s.
4. Wait for FPGA done pin, then set 0x2157 4-th bit, send mcu_ts and ip_addr
5. If xmega_PB7 is set (FPGA_RST) -> proceed sending FPGA settings.

---
## Hardware 
Some details about the peripherals the MCU ATxmega128a3 is communicating with.

| PIN 	| LABEL 	| PORT	| MODE			| PERIPHERAL 	| COMMENTS 	|
|:---:	|:---:  	|:---:	| :---:			|:---:   	| :---	   	|	
|63  	|DA27_SCLK	|PA1 	| SPI CLK		|**ADT7311WTRZ Temperature Sensor**| |
|64	|DA27_DOUT	|PA2 	| SPI MISO		|		| |
|1	|DA27_DIN	|PA3  	| SPI MOSI		| 		| |
|2	|DA27_CS	|PA4	| SPI CS		| 		| |
|62	|		|PA0 	| OUT LED VD8 (red)	|**LEDS**	| |
|3	|		|PA5 	| OUT LED VD12 (blue)	|		| |
|4	|		|PA6 	| OUT LED VD13 (red)	|		| |
|5	|		|PA7 	| OUT LED VD14 (green)	|		| |
|6	|DD46A_AB	|PB0	|			|**X36 Connector**	| |
|7	|DD46B_AB	|PB1	|			|		| |
|8	|DD46C_AB	|PB2	|			|		| |
|9	|DD46D_AB	|PB3	|			|		| |
|28	|DD45_ROUT	|PD2 	|			|		| |
|29	|DD45_TIN	|PD3	|			|		| |
|10	|Xmega_PB4	|PB4	| ???			|**X35**	| |
|16	|DD15_SDA	|PC0	| I2C SDA		|**Si5338 (x2)**| |
|17	|DD15_SCL	|PC1	| I2C SCL		|		| |
|18	|DD17_INTR	|PC2	| INT0 Si5338 (2) int.	| 		| |
|19	|DD15_INTR	|PC3	| INT0 Si5338 (1) int.	|		| |
|20	|DD16_CLK_SEL	|PC4	| OUT (clk_sel)		|**Si55301**	| |
|50	|DD16_LOS1	|PF4	| INT1 (CLK1 input clock not present | 	| |
|51	|DD16_LOS0	|PF5	| INT1 (CLK0 input clock not present |	| |
|36 	|Xmega_PE0	|PE0 	| INT 			|**FPGA**	| |
|21 	|Xmega_PC5	|PC5 	| SPI MOSI		|		| |
|22 	|Xmega_PC6	|PC6 	| SPI MISO 		|		| |
|23 	|Xmega_PC7	|PC7 	| SPI SCK		|		| |
|26 	|Xmega_PD0	|PD0 	| SPI CS 		|		| |
|27 	|Xmega_PD1	|PD1 	| OUT (program) 	|		| |
|30	|Xmega_PD4	|PD4	| (init)		|		| |
|31	|DD13C_AB	|PD5 	| INT0 (done)		|		| |
|13	|Xmega_PB7	|PB7	| ???			|		| |
|37	|DA21_RST_N	|PE1	| INT (nrst)		|**LTC2906ITS8**| |
|38	|DD11A_A	|PE2	| OUT (enable)		|**2x LM21215AMHX-1 & 1x LD49150PT10R**	| |
|39	|DA2_OUT	|PE3	| IN  (outa & outb)	|**TPS3700DSER Voltage monitor** 	| |
|40	|DD9_S  	|PE4	| SPI CS		|**N25Q032A11EF840 Serial Flash Memory**|  |
|41	|DD9_DQ0	|PE5	| SPI MOSI		|		| |
|42	|DD9_DQ1	|PE6	| SPI MISO		|		| |
|43	|DD9_C	|PE7	| SPI CLK		|		| |
|46	|DD7_T2IN	|PF0	| UART CTS		|**RJ45 Connector**| |
|47	|DD7_R2OUT	|PF1	| UART RTS (INT0)	|		| |
|48	|DD7_R1OUT	|PF2	| UART Rx 		|		| |
|49	|DD7_T1IN	|PF3	| UART Tx		|		| |
|11	|NC		|PB5	| ---			|		| |
|12	|NC		|PB6	| ---			|		| |
|32	|NC		|PD6	| ---			|		| |
|33	|NC		|PD7	| ---			|		| |
|54	|NC		|PF6	| ---			|		| |
|55	|NC		|PF7	| ---			|		| |

### Si5338
Switch flow:  

| MEM 	| Stream| Substream	| CODE	| LABEL		| START	| Msg		|
| :---	| :---	| :---		| :---	|:---		| :---	| :---		|
| 0x25a6| 00	| 00		| 0x0117|caseD_0	| YES	| Reg 6 SEL	|
| 0x25a8| 00	| 01		| 0x0122|caseD_2	| 	| Reg 6 WR 0xc	|
| 0x25aa| 00	| 02		| 0x0145|caseD_4	|	| Switch to other dev |
| 0x25ac| 00	| 03		| 0x014b|caseD_6	| 	| PORTF_INTFLAGS = 0b00000010; PORTF_INTCTRL = 0b00001010 	|
| 0x25ae| 01	| 00		| 0x0153|caseD_8	| YES	| Reg 235 SEL (FCAL) |
| 0x25b0| 01	| 01		| 0x0159|caseD_a	| 	| Set slave RD 	|
| 0x25b2| 01	| 02		| 0x0166|caseD_c	| 	| Reg 235 RD	|
| 0x25b4| 01	| 03		| 0x016f|caseD_e	| 	| Reg 236 RD 	|
| 0x25b6| 01	| 04		| 0x0174|caseD_10	| 	| Reg 237 RD	|
| 0x25b8| 01	| 05		| 0x0183|caseD_12	| 	| Reg 45 SEL	|
| 0x25ba| 01	| 06		| 0x0189|caseD_14	| 	| Reg 45 WR	|
| 0x25bc| 01	| 07		| 0x018c|caseD_16	| 	| Reg 46 WR	|
| 0x25be| 01	| 08		| 0x018f|caseD_18	| 	| Reg 47 WR	|
| 0x25c0| 01	| 09		| 0x0194|caseD_1a	| 	| 		|
| 0x25c2| 01	| 0a		| 0x019a|caseD_1c	| 	| Reg 49 SEL	|
| 0x25c4| 01	| 0b		| 0x01a0|caseD_1e	| 	| Reg 49 WR 0x80 or 0x90 |
| 0x25c6| 01	| 0c		| 0x01a9|caseD_20	| 	| Reg 
| 0x25c8| 02	| 00		| 0x01bd|caseD_22	| YES	|
| 0x25ca| 02	| 01		| 0x01cd|caseD_24	| 	|
| 0x25cc| 02	| 02		| 0x01b3|caseD_26	| 	|
| 0x25ce| 03	| 00		| 0x01d7|caseD_28	| YES	| Reg 241 SEL
| 0x25d0| 03	| 01		| 0x01dd|caseD_2a	| 	|
| 0x25d2| 03	| 02		| 0x01e5|caseD_2c	| 	|
| 0x25d4| 03	| 03		| 0x01eb|caseD_2e	| 	|
| 0x25d6| 03	| 04		| 0x01f6|caseD_30	| 	|
| 0x25d8| 03	| 05		| 0x0207|caseD_32	| 	|
| 0x25da| 03	| 06		| 0x020d|caseD_34	| 	|
| 0x25dc| 03	| 07		| 0x0213|caseD_36	| 	|
| 0x25de| 03	| 08		| 0x0220|caseD_38	| 	|
| 0x25e0| 03	| 09		| 0x0226|caseD_3a	| 	|
| 0x25e2| 03	| 0a		| 0x022c|caseD_3c	| 	|
| 0x25e4| 03	| 0b		| 0x0235|caseD_3e	| 	|
| 0x25e6| 03	| 0c		| 0x023b|caseD_40	| 	|
| 0x25e8| 03	| 0d		| 0x0241|caseD_42	| 	|
| 0x25ea| 03	| 0e		| 0x024a|caseD_44	| 	|
| 0x25ec| 03	| 0f		| 0x0250|caseD_46	| 	|
| 0x25ee| 03	| 10		| 0x0256|caseD_48	| 	|
| 0x25f0| 03	| 11		| 0x025f|caseD_4a	| 	|
| 0x25f2| 03	| 12		| 0x0265|caseD_4c	| YES 	|
| 0x25f4| 03	| 13		| 0x026b|caseD_4e	| 	|
| 0x25f6| 03	| 14		| 0x0203|caseD_50	| 	|
| 0x25f8| 04	| 00		| 0x0285|caseD_52	| YES	| Reg = 241
| 0x25fa| 04	| 01		| 0x028b|caseD_54	| 	| Val = 0x65
| 0x25fc| 04	| 02		| 0x0291|caseD_56	| 	| ?

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
| 0x2159| 	| 1	| Timer Si5338 status 	|
| 0x215a| 	| 1	| Timer Si5338 value	|
| 0x215b| 	| 1	| Timer FPGA status	| 
| 0x215c| 	| 2	| Timer FPGA value 	| 
| 0x215e| 	| 2	| Timer Attenuator 	| 
| 0x2160| 	| 1	| ?? 	| 
| 0x2161| 	| 1 	| clock source settings |
| 0x2162| 	| 1 	| 16#18# settings |
| 0x2163| 	| 2 	| Si5338 current msg stream |
| 0x2165| 	| 2	| Si5338 msg to send (addr)	|
| 0x2167|	| 1	| 	|
| 0x2168|	| 1	| Current slave addr. (0xE0 or 0xE2)	|
| 	| 	| 	| 	|
| 0x216d|	| 6	| Copy of 0x2193 to 0x2198 data 	|
| 0x2173| 	| 16	| USART_D0 tx buffer 	|
| 0x2183| 	| 2	| USART_D0 tx buffer head & tail pointers  |
| 0x2185| 	| 1	| USART_D0 status	|
| 0x2186| 	| 2	| Attenuator steps settings, initial value 0xFFFF	|
| 0x2188|	| 1	| ??	|
| --- 	| ---	| ---	| ---			|
| 0x2189|0x1000	| 4	| IP addr 		|
| 0x218d|0x1004	| 6	| MAC addr 		|
| 0x2193|0x100A	| 2	| A-side phase (delay) 	|
| 0x2195|0x100C	| 2	| C-side phase (delay) 	|
| 0x2197|0x100E	| 2	| Laser phase (delay) 	|
| 0x2199|0x1010	| 2	| Attenuator settings	|
| 0x219b|0x1012	| 1 	| Port B settings (PB0-3)	|
| 0x219c|0x1015	| 1	| [UNUSED]	|
| 0x219d|0x1013	| 2	| Vertex time low threshold	|
| 0x219f|0x1016	| 2	| Vertex time high threshold	|
| 0x21a1|0x1018	| 2	| SemiCentral level A 	|
| 0x21a3|0x101A	| 2	| SemiCentral level C 	|
| 0x21a5|0x101C	| 2	| Central level A 	|
| 0x21a7|0x101E	| 2	| Central level C 	|
| 0x21a9|0x1020	| 1	| Trigger mode 		|
| 0x21aa|0x1021	| 1 	| [UNUSED] 	|
| 0x21ab|0x1022	| 2	| Board S/N (4x4bit)	|
| 0x21ad|0x1023	| 1	| 	|
| ---	| ---	| ---	| ---	|
| 	| 	| 	| 	|
| 0x23ae| 	| 4	| 	|
| 0x25a6|	| 88	| Si5338 comm. func. references (0x25a6 - 0x25fd) |
|	|	|	|			|
| 0x29ba|	|	|			|
| 0x2b74| 	| 8 	| Programming lock [0x78,0x56,0x34,0x12,0x98,0xBA,0xDC,0xFE ] |
| 0x2b7c|	| 4	| Flash timestamp	|
| 0x3ffd| 	| 1	| Program status 	|

---  
## UART F0 commands
| CMD 		| DESC |
|:---: 		|:---: |
| AC\rxxx 	| Send xxx msg to UART_D0, till ESC is present |
| CA\r		| Clear alarms|
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
| SS 		| Set switches (port B settings)|
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
- PORTA_OUTSET 0x80 has some connection with PORTB_OUTCLR = 0x80
- PORTA_OUTSET 0xC0 has some connection with PORTB_OUTSET = 0x10
