.include "macros.inc"
.include "atxmega128a3u.asm"

.section .text

;************************************************************************************************
;*                                       INTERRUPT VECTOR                                       *
;************************************************************************************************

; Vector 0 is the reset vector
    jmp         main 				; 0 RESET                          

; OSC interrupt vectors
    rjmp 	BAD_ISR				; 1 Oscillator Failure Interrupt (NMI)
                          
; PORTC interrupt vectors
    rjmp        si5338_int 			; 2 External Interrupt 0
    rjmp 	BAD_ISR				; 3 External Interrupt 1

; PORTR interrupt vectors
    rjmp 	BAD_ISR				; 4 External Interrupt 0
    rjmp 	BAD_ISR				; 5 External Interrupt 1

; DMA interrupt vectors
    rjmp 	BAD_ISR				; 6 Channel 0 Interrupt
    rjmp 	BAD_ISR				; 7 Channel 1 Interrupt
    rjmp 	BAD_ISR				; 8 Channel 2 Interrupt
    rjmp 	BAD_ISR				; 9 Channel 3 Interrupt

; RTC interrupt vectors
    rjmp 	BAD_ISR				; 10 Overflow Interrupt
    rjmp 	BAD_ISR				; 11 Compare Interrupt

; TWIC interrupt vectors
    rjmp 	BAD_ISR				; 12 TWI Slave Interrupt
    rjmp 	twim_int 			; 13 TWI Master Interrupt
   
; TCC0 interrupt vectors
    rjmp        timer_overflow_int 		; 14 Overflow Interrupt
    rjmp 	BAD_ISR				; 15 Error Interrupt
    rjmp 	BAD_ISR				; 16 Compare or Capture A Interrupt
    rjmp 	BAD_ISR				; 17 Compare or Capture B Interrupt
    rjmp 	BAD_ISR				; 18 Compare or Capture C Interrupt
    rjmp 	BAD_ISR				; 19 Compare or Capture D Interrupt

; TCC1 interrupt vectors
    rjmp 	BAD_ISR				; 20 Overflow Interrupt
    rjmp 	BAD_ISR				; 21 Error Interrupt
    rjmp 	BAD_ISR				; 22 Compare or Capture A Interrupt
    rjmp 	BAD_ISR				; 23 Compare or Capture B Interrupt

; SPIC interrupt vectors
    rjmp 	BAD_ISR				; 24 SPI Interrupt

; USARTC0 interrupt vectors
    rjmp 	BAD_ISR				; 25 Reception Complete Interrupt
    rjmp 	BAD_ISR				; 26 Data Register Empty Interrupt
    rjmp 	BAD_ISR				; 27 Transmission Complete Interrupt

; USARTC1 interrupt vectors
    rjmp 	BAD_ISR				; 28 Reception Complete Interrupt
    rjmp 	BAD_ISR				; 29 Data Register Empty Interrupt
    rjmp 	BAD_ISR				; 30 Transmission Complete Interrupt

; AES interrupt vectors
    rjmp 	BAD_ISR				; 31 AES Interrupt

; NVM interrupt vectors
    rjmp 	BAD_ISR				; 32 EE Interrupt
    rjmp 	BAD_ISR				; 33 SPM Interrupt

; PORTB interrupt vectors
    rjmp 	BAD_ISR				; 34 External Interrupt 0
    rjmp 	BAD_ISR				; 35 External Interrupt 1

; ACB interrupt vectors
    rjmp 	BAD_ISR				; 36 AC0 Interrupt
    rjmp 	BAD_ISR				; 37 AC1 Interrupt
    rjmp 	BAD_ISR				; 38 ACW Window Mode Interrupt

; ADCB interrupt vectors
    rjmp 	BAD_ISR				; 39 Interrupt 0
    rjmp 	BAD_ISR				; 40 Interrupt 1
    rjmp 	BAD_ISR				; 41 Interrupt 2
    rjmp 	BAD_ISR				; 42 Interrupt 3

; PORTE interrupt vectors
    rjmp        5V_present_or_Si53301_v_fault 	; 43 External Interrupt 0
    rjmp        fpga_comm_request_int		; 44 External Interrupt 1

; TWIE interrupt vectors
    rjmp 	BAD_ISR				; 45 TWI Slave Interrupt
    rjmp 	BAD_ISR				; 46 TWI Master Interrupt

; TCE0 interrupt vectors
    rjmp 	BAD_ISR				; 47 Overflow Interrupt
    rjmp 	BAD_ISR				; 48 Error Interrupt
    rjmp 	BAD_ISR				; 49 Compare or Capture A Interrupt
    rjmp 	BAD_ISR				; 50 Compare or Capture B Interrupt
    rjmp 	BAD_ISR				; 51 Compare or Capture C Interrupt
    rjmp 	BAD_ISR				; 52 Compare or Capture D Interrupt

; TCE1 interrupt vectors
    rjmp 	BAD_ISR				; 53 Overflow Interrupt
    rjmp 	BAD_ISR				; 54 Error Interrupt
    rjmp 	BAD_ISR				; 55 Compare or Capture A Interrupt
    rjmp 	BAD_ISR				; 56 Compare or Capture B Interrupt

; SPIE interrupt vectors
    rjmp 	BAD_ISR				; 57 SPI Interrupt

; USARTE0 interrupt vectors
    rjmp 	BAD_ISR				; 58 Reception Complete Interrupt
    rjmp 	BAD_ISR				; 59 Data Register Empty Interrupt
    rjmp 	BAD_ISR				; 60 Transmission Complete Interrupt

; USARTE1 interrupt vectors
    rjmp 	BAD_ISR				; 61 Reception Complete Interrupt
    rjmp 	BAD_ISR				; 62 Data Register Empty Interrupt
    rjmp 	BAD_ISR				; 63 Transmission Complete Interrupt

; PORTD interrupt vectors
    rjmp        fpga_done_int 			; 64 External Interrupt 0
    rjmp 	BAD_ISR				; 65 External Interrupt 1

; PORTA interrupt vectors
    rjmp 	BAD_ISR				; 66 External Interrupt 0
    rjmp 	BAD_ISR				; 67 External Interrupt 1

; ACA interrupt vectors
    rjmp 	BAD_ISR				; 68 AC0 Interrupt
    rjmp 	BAD_ISR				; 69 AC1 Interrupt
    rjmp 	BAD_ISR				; 70 ACW Window Mode Interrupt

; ADCA interrupt vectors
    rjmp 	BAD_ISR				; 71 Interrupt 0
    rjmp 	BAD_ISR				; 72 Interrupt 1
    rjmp 	BAD_ISR				; 73 Interrupt 2
    rjmp 	BAD_ISR				; 74 Interrupt 3
    
    rjmp 	BAD_ISR 			; 75
    rjmp 	BAD_ISR 			; 76

; TCD0 interrupt vectors
    rjmp 	BAD_ISR				; 77 Overflow Interrupt
    rjmp 	BAD_ISR				; 78 Error Interrupt
    rjmp 	BAD_ISR				; 79 Compare or Capture A Interrupt
    rjmp 	BAD_ISR				; 80 Compare or Capture B Interrupt
    rjmp 	BAD_ISR				; 81 Compare or Capture C Interrupt
    rjmp 	BAD_ISR				; 82 Compare or Capture D Interrupt

; TCD1 interrupt vectors
    rjmp 	BAD_ISR				; 83 Overflow Interrupt
    rjmp 	BAD_ISR				; 84 Error Interrupt
    rjmp 	BAD_ISR				; 85 Compare or Capture A Interrupt
    rjmp 	BAD_ISR				; 86 Compare or Capture B Interrupt

; SPID interrupt vectors
    rjmp 	BAD_ISR				; 87 SPI Interrupt

; USARTD0 interrupt vectors
    rjmp        usartd0_rx_int			; 88 Reception Complete Interrupt
    rjmp        USARTD0_DRE                     ; 89 Data Register Empty Interrupt        
    rjmp 	BAD_ISR				; 90 Transmission Complete Interrupt

; USARTD1 interrupt vectors
    rjmp 	BAD_ISR				; 91 Reception Complete Interrupt
    rjmp 	BAD_ISR				; 92 Data Register Empty Interrupt
    rjmp 	BAD_ISR				; 93 Transmission Complete Interrupt
    
    rjmp 	BAD_ISR 			; 94
    rjmp 	BAD_ISR 			; 95
    rjmp 	BAD_ISR 			; 96
    rjmp 	BAD_ISR 			; 97
    rjmp 	BAD_ISR 			; 98
    rjmp 	BAD_ISR 			; 99
    rjmp 	BAD_ISR 			; 100
    rjmp 	BAD_ISR 			; 101
    rjmp 	BAD_ISR 			; 102
    rjmp 	BAD_ISR 			; 103
           
; PORTF interrupt vectors 
    rjmp        usartf0_cts_int       		; 104 External Interrupt 0                  
    rjmp 	si53301_clk_not_present		; 105 External Interrupt 1
    
    rjmp 	BAD_ISR 			; 106
    rjmp 	BAD_ISR 			; 107
    
; TCF0 interrupt vectors
    rjmp 	BAD_ISR 			; 108 Overflow Interrupt
    rjmp 	BAD_ISR 			; 109 Error Interrupt
    rjmp 	BAD_ISR 			; 110 Compare or Capture A Interrupt
    rjmp 	BAD_ISR 			; 111 Compare or Capture B Interrupt
    rjmp 	BAD_ISR 			; 112 Compare or Capture C Interrupt
    rjmp 	BAD_ISR 			; 113 Compare or Capture D Interrupt
    
    rjmp 	BAD_ISR 			; 114
    rjmp 	BAD_ISR 			; 115
    rjmp 	BAD_ISR 			; 116
    rjmp 	BAD_ISR 			; 117
    rjmp 	BAD_ISR 			; 118

; USARTF0 interrupt vectors
    rjmp        usart_f0_rx_int 		; 119 Reception Complete Interrupt
    rjmp        usart_f0_dre_int 		; 120 Data Register Empty Interrupt
    rjmp 	BAD_ISR 			; 121 Transmission Complete Interrupt
    
    rjmp 	BAD_ISR 			; 122
    rjmp 	BAD_ISR 			; 123
    rjmp 	BAD_ISR 			; 124

; USB interrupt vectors
    rjmp 	BAD_ISR 			; 125 SOF, suspend, resume, reset bus event interrupts, crc, underflow, overflow and stall error interrupts
    rjmp 	BAD_ISR 			; 126 Transaction complete interrupt

;************************************************************************************************
;* @brief unknown isr, do the reset                                                             *
;************************************************************************************************
BAD_ISR:
    jmp 	0
	
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 twim_int(void)
    push        Zhi                                     
USARTF0_TXC:                  
    in          Zhi,SREG                                
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        Ylo                                     
    push        Yhi                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Ylo,0x63                                
    ldi         Yhi,0x21                                
    ld          R16,Y                                   
    eor         R17,R17                                 
    cpi         R16,0x5                                 
    brbs        LAB_code_000101,Cflg                    
    rjmp        switchD_code:000116::caseD_26           
LAB_code_000101:              
    ldi         Zlo,0x9c                                
    ldi         Zhi,0x25                                
    add         R16,R16                                 
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    lpm         R17,Z+                                  
    lpm         R18,Z                                   
    ldd         R16,Y+0x1                               
    cp          R16,R18                                 
    brbs        LAB_code_00010c,Cflg                    
    rjmp        switchD_code:000116::caseD_26           
LAB_code_00010c:              
    add         R16,R17                                 
    add         R16,R16                                 
    eor         R17,R17                                 
    ldi         Zlo,0xa6                                
    ldi         Zhi,0x25                                
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    lpm         R16,Z+                                  
    lpm         R17,Z                                   
    movw        Z,R17R16                                
switch:                       
switchD:                      
    ijmp                                                
case_0:                       
caseD_0:                      
    ldd         Zlo,Y+0x2                               
    ldd         Zhi,Y+0x3                               
    lpm         R16,Z+                                  
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    std         Y+0x4,R16                               
    std         Y+0x3,Zhi                               
    std         Y+0x2,Zlo                               
    ldi         R16,0x1                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_1:                       
caseD_2:                      
    ldd         Zlo,Y+0x2                               
    ldd         Zhi,Y+0x3                               
    lpm         R16,Z+                                  
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldd         R17,Y+0x4                               
    cpi         R16,0x0                                 
    brbc        LAB_code_000139,Zflg                    
    cpi         R17,0xff                                
    brbc        LAB_code_000139,Zflg                    
    ldd         R16,Y+0x5                               
    cpi         R16,0xe2                                
    brbs        LAB_code_000136,Zflg                    
    ldi         R16,0x2                                 
    std         Y+0x1,R16                               
    std         Y+0x2,Zlo                               
    std         Y+0x3,Zhi                               
    ldi         R16,0xe2                                
    std         Y+0x5,R16                               
    rjmp        LAB_code_00029e                         
LAB_code_000136:              
    ldi         R16,0x3                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
LAB_code_000139:              
    lpm         R16,Z                                   
    inc         R17                                     
case_44:                      
caseD_90:                     
    cp          R17,R16                                 
    brbc        LAB_code_000142,Zflg                    
    adiw        Z,0x1                                   
    std         Y+0x4,R16                               
LAB_code_00013f:              
    std         Y+0x3,Zhi                               
    std         Y+0x2,Zlo                               
    rjmp        LAB_code_00029e                         
LAB_code_000142:              
    ldi         R17,0x2                                 
    std         Y+0x1,R17                               
    rjmp        LAB_code_00013f                         
case_2:                       
caseD_4:                      
    ldd         R16,Y+0x5                               
case_45:                      
caseD_a6:                     
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldi         R16,0x0                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_3:                       
caseD_6:                      
    ldi         R16,0x2                                 
    sts         PORTF_INTFLAGS,R16                      ;= ??
    ldi         R16,0xa                                 
    sts         PORTF_INTCTRL,R16                       ;= ??
case_46:                      
caseD_bc:                     
    rcall       reset_system                            ;undefined reset_system(void)
    rjmp        switchD_code:000116::caseD_26           
case_4:                       
caseD_8:                      
    ldi         R16,0xeb                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0x1                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_5:                       
caseD_a:                      
    ldi         R16,0x0                                 
    sts         TWIC_MASTER_CTRLC,R16                   ;= ??
case_47:                      
caseD_d2:                     
    ldd         R16,Y+0x2                               
    inc         R16                                     
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldi         R16,0x68                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ldi         R16,0x2                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_6:                       
caseD_c:                      
    lds         R16,TWIC_MASTER_DATA                    ;= ??
    std         Y+0x4,R16                               
    ldi         R16,0x3                                 
LAB_code_00016a:              
    ldi         R17,0x2                                 
    sts         TWIC_MASTER_CTRLC,R17                   ;= ??
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_7:                       
caseD_e:                      
    lds         R16,TWIC_MASTER_DATA                    ;= ??
    std         Y+0x5,R16                               
    ldi         R16,0x4                                 
    rjmp        LAB_code_00016a                         
case_8:                       
caseD_10:                     
    lds         R16,TWIC_MASTER_DATA                    ;= ??
    std         Y+0x6,R16                               
    ldi         R16,0x4                                 
    sts         TWIC_MASTER_CTRLC,R16                   ;= ??
    ldd         R16,Y+0x2                               
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldi         R16,0x58                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_9:                       
caseD_12:                     
    ldi         R17,0x2d                                
    ldi         R16,0x6                                 
LAB_code_000185:              
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_10:                      
caseD_14:                     
    ldd         R17,Y+0x4                               
    ldi         R16,0x7                                 
    rjmp        LAB_code_000185                         
case_11:                      
caseD_16:                     
    ldd         R17,Y+0x5                               
    ldi         R16,0x8                                 
    rjmp        LAB_code_000185                         
case_12:                      
caseD_18:                     
    ldd         R17,Y+0x6                               
    andi        R17,0x3                                 
    ori         R17,0x14                                
    ldi         R16,0x9                                 
    rjmp        LAB_code_000185                         
case_13:                      
caseD_1a:                     
    ldd         R16,Y+0x2                               
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldi         R16,0xa                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_14:                      
caseD_1c:                     
    ldi         R16,0x31                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0xb                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_15:                      
caseD_1e:                     
    ldi         R16,0x80                                
    ldd         R17,Y+0x2                               
    sbrc        R17,0x1                                 
    ldi         R16,0x90                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0xc                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_16:                      
caseD_20:                     
    ldd         R16,Y+0x2                               
    cpi         R16,0xe2                                
    brbs        switchD_code:000116::caseD_26,Zflg      
    ldi         R16,0xe2                                
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    std         Y+0x2,R16                               
    eor         R16,R16                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_19:                      
caseD_26:                     
    eor         R16,R16                                 
    st          Y,R16                                   
    std         Y+0x1,R16                               
    ldi         R16,0x48                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ldi         R16,0x3                                 
    sts         TWIC_MASTER_CTRLC,R16                   ;= ??
    rjmp        LAB_code_00029e                         
case_17:                      
caseD_22:                     
    ldd         R16,Y+0x2                               
    and         R16,R16                                 
    brbc        LAB_code_0001c1,Nflg                    
    neg         R16                                     
LAB_code_0001c1:              
    ldi         R17,0x3f                                
    dec         R16                                     
    brbs        LAB_code_0001c8,Zflg                    
    ldi         R17,0x4a                                
    dec         R16                                     
    brbs        LAB_code_0001c8,Zflg                    
    ldi         R17,0x34                                
LAB_code_0001c8:              
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x1                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_18:                      
caseD_24:                     
    ldd         R16,Y+0x2                               
    ldi         R17,0x12                                
    and         R16,R16                                 
    brbc        LAB_code_0001d2,Nflg                    
    inc         R17                                     
LAB_code_0001d2:              
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x2                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_20:                      
caseD_28:                     
    ldi         R16,0xf1                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0x1                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_21:                      
caseD_2a:                     
    ldi         R16,0xe5                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    ldi         R16,0x2                                 
    std         Y+0x3,R16                               
    rjmp        LAB_code_00029e                         
case_22:                      
caseD_2c:                     
    ldi         R16,0x1c                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0x3                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_23:                      
caseD_2e:                     
    lds         R16,DAT_clk_frs                         ;= ??
    ldi         R17,0xb                                 
    andi        R16,0x6                                 
    brbs        LAB_code_0001f1,Zflg                    
    ldi         R17,0x3                                 
LAB_code_0001f1:              
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x4                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_24:                      
caseD_30:                     
    lds         R16,DAT_clk_frs                         ;= ??
    ldi         R17,0x8                                 
    andi        R16,0x6                                 
    brbs        LAB_code_0001fc,Zflg                    
    ldi         R17,0x0                                 
LAB_code_0001fc:              
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    ldi         R16,0x6                                 
    std         Y+0x3,R16                               
    rjmp        LAB_code_00029e                         
case_40:                      
caseD_50:                     
    ldi         R16,0x4                                 
    sts         TWIC_MASTER_CTRLC,R16                   ;= ??
    ldi         R16,0x58                                
case_25:                      
caseD_32:                     
    ldd         R16,Y+0x2                               
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldd         R16,Y+0x3                               
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_26:                      
caseD_34:                     
    ldi         R17,0x31                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x7                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_27:                      
caseD_36:                     
    ldd         R18,Y+0x2                               
    ldi         R17,0x10                                
    ldi         R16,0xf                                 
    cpi         R18,0xe2                                
    brbs        LAB_code_00021a,Zflg                    
    ldi         R16,0x8                                 
    ldi         R17,0x0                                 
LAB_code_00021a:              
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    std         Y+0x3,R16                               
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_28:                      
caseD_38:                     
    ldi         R17,0x6b                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x9                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_29:                      
caseD_3a:                     
    ldd         R17,Y+0x8                               
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0xa                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_30:                      
caseD_3c:                     
    ldd         R17,Y+0x9                               
    andi        R17,0x7f                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0xb                                 
    std         Y+0x3,R16                               
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_31:                      
caseD_3e:                     
    ldi         R17,0x6f                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0xc                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_32:                      
caseD_40:                     
    ldd         R17,Y+0x4                               
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0xd                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_33:                      
caseD_42:                     
    ldd         R17,Y+0x5                               
    andi        R17,0x7f                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0xe                                 
    std         Y+0x3,R16                               
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_34:                      
caseD_44:                     
    ldi         R17,0x73                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0xf                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_35:                      
caseD_46:                     
    ldd         R17,Y+0x6                               
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x10                                
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_36:                      
caseD_48:                     
    ldd         R17,Y+0x7                               
    ori         R17,0x80                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x11                                
    std         Y+0x3,R16                               
    ldi         R16,0x5                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_37:                      
caseD_4a:                     
    ldi         R17,0xf6                                
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x12                                
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_38:                      
caseD_4c:                     
    ldi         R17,0x2                                 
    sts         TWIC_MASTER_DATA,R17                    ;= ??
    ldi         R16,0x13                                
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_39:                      
caseD_4e:                     
    ldd         R16,Y+0x2                               
    cpi         R16,0xe2                                
    brbs        LAB_code_000275,Zflg                    
    ldi         R16,0xe2                                
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    std         Y+0x2,R16                               
    eor         R16,R16                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
LAB_code_000275:              
    ldi         R16,0x3                                 
    ldi         R17,0x19                                
LAB_code_000277:              
    sts         DAT_mem_2159,R16                        ;= ??
    sts         DAT_mem_215a,R17                        ;= ??
    ldi         R16,0x48                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ldi         R16,0x3                                 
    sts         TWIC_MASTER_CTRLC,R16                   ;= ??
    eor         R16,R16                                 
    st          Y,R16                                   
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_41:                      
caseD_52:                     
    ldi         R16,0xf1                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0x1                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_42:                      
caseD_54:                     
    ldi         R16,0x65                                
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldi         R16,0x2                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_43:                      
caseD_56:                     
    ldd         R16,Y+0x2                               
    cpi         R16,0xe2                                
    brbc        LAB_code_000297,Zflg                    
    ldi         R16,0x4                                 
    eor         R17,R17                                 
    rjmp        LAB_code_000277                         
LAB_code_000297:              
    ldi         R16,0xe2                                
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    std         Y+0x2,R16                               
    eor         R16,R16                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
LAB_code_00029e:              
    pop         Zhi                                     
    pop         Zlo                                     
    pop         Yhi                                     
    pop         Ylo                                     
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 timer_overflow_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        Yhi                                     
    push        Ylo                                     
    push        R25                                     
    push        R24                                     
    push        R21                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    push        R1                                      
    push        R0                                      
    ldi         Zlo,0x59                                
    ldi         Zhi,0x21                                
    ld          R16,Z                                   
    and         R16,R16                                 
    brbc        LAB_code_0002be,Zflg                    
    rjmp        LAB_code_000363                         
LAB_code_0002be:              
    dec         R16                                     
    brbc        LAB_code_0002c1,Zflg                    
    rjmp        LAB_code_00035c                         
LAB_code_0002c1:              
    dec         R16                                     
    brbs        LAB_code_0002cb,Zflg                    
    dec         R16                                     
    brbs        LAB_code_0002e6,Zflg                    
    dec         R16                                     
    brbs        LAB_code_0002f7,Zflg                    
    dec         R16                                     
    brbs        LAB_code_0002ca,Zflg                    
    rjmp        LAB_code_000335                         
LAB_code_0002ca:              
    rjmp        LAB_code_00031f                         
LAB_code_0002cb:              
    eor         R16,R16                                 
    st          Z,R16                                   
    rcall       FUN_code_000571                         ;undefined FUN_code_000571(void)
    lds         R17,DAT_mem_2163                        ;= ??
    ldi         R16,0x3                                 
    sts         DAT_mem_2163,R16                        ;= ??
    ldi         R16,0xe0                                
    sts         DAT_mem_2165,R16                        ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2166,R16                        ;= ??
    ldi         R16,0x12                                
    and         R17,R17                                 
    brbc        LAB_code_0002e3,Zflg                    
    eor         R16,R16                                 
    ldi         R17,0xe0                                
    sts         TWIC_MASTER_ADDR,R17                    ;= ??
    ldi         R17,0x58                                
    sts         TWIC_MASTER_CTRLA,R17                   ;= ??
LAB_code_0002e3:              
    sts         DAT_mem_2164,R16                        ;= ??
    rjmp        LAB_code_000363                         
LAB_code_0002e6:              
    ldd         R17,Z+0x1                               
    dec         R17                                     
    brbs        LAB_code_0002ea,Zflg                    
    rjmp        LAB_code_000362                         
LAB_code_0002ea:              
    eor         R16,R16                                 
    st          Z,R16                                   
    ldi         R16,0x4                                 
    sts         DAT_mem_2163,R16                        ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2164,R16                        ;= ??
    ldi         R16,0xe0                                
    sts         DAT_mem_2165,R16                        ;= ??
    rcall       si5338_twic_master_ctrla_setup          ;undefined si5338_twic_master_ctrla_s...
    rjmp        LAB_code_000363                         
LAB_code_0002f7:              
    cli                                                 
    lds         R17,PORTC_IN                            ;= ??
    ldi         R16,0x1                                 
    sts         PORTC_INTFLAGS,R16                      ;= ??
    ldi         R16,0x2                                 
    sts         PORTC_INTCTRL,R16                       ;= ??
    bset        Iflg                                    
    eor         R18,R18                                 
    andi        R17,0xc                                 
    brbc        LAB_code_000314,Zflg                    
    ldi         R18,0x1                                 
    ldi         R16,0x1                                 
    sts         DAT_mem_2163,R16                        ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2164,R16                        ;= ??
    ldi         R16,0xe0                                
    sts         DAT_mem_2165,R16                        ;= ??
    rcall       si5338_twic_master_ctrla_setup          ;undefined si5338_twic_master_ctrla_s...
    cbi         GPIO_GPIOR0,0x3                         
    ldi         R16,0x4b                                
    std         Z+0x1,R16                               
    ldi         R16,0x5                                 
    rjmp        LAB_code_000315                         
LAB_code_000314:              
    eor         R16,R16                                 
LAB_code_000315:              
    st          Z,R16                                   
    cli                                                 
    lds         R16,DAT_clk_frs                         ;= ??
    andi        R16,0xe                                 
    or          R16,R18                                 
    sts         DAT_clk_frs,R16                         ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_000363                         
LAB_code_00031f:              
    ldd         R17,Z+0x1                               
    dec         R17                                     
    brbs        LAB_code_000323,Zflg                    
    rjmp        LAB_code_000362                         
LAB_code_000323:              
    lds         R16,PORTD_IN                            ;= ??
    sbrs        R16,0x5                                 
    rjmp        LAB_code_000363                         
    ldd         R16,Z+0x2                               
    and         R16,R16                                 
    brbs        LAB_code_00032f,Zflg                    
    cpi         R16,0x5                                 
    brbc        LAB_code_000334,Zflg                    
    ldd         R16,Z+0x3                               
    and         R16,R16                                 
    brbc        LAB_code_000334,Zflg                    
LAB_code_00032f:              
    ldi         R16,0x80                                
    sts         PORTB_OUTSET,R16                        ;= ??
    ldi         R16,0x6                                 
    st          Z,R16                                   
LAB_code_000334:              
    rjmp        LAB_code_000363                         
LAB_code_000335:              
    ldi         R18,0x7f                                
    cli                                                 
    call        fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        Iflg                                    
    andi        R16,0xf                                 
    cpi         R16,0x3                                 
    brbc        LAB_code_00034f,Zflg                    
    ldi         R16,0x2                                 
    sts         PORTE_INTFLAGS,R16                      ;= ??
    ldi         R16,0x9                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R18,0x18                                
    lds         R17,DAT_clk_frs                         ;= ??
    ori         R17,0x10                                
    lds         R16,DAT_mem_2188                        ;= ??
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    ldi         R16,0x80                                
    rjmp        LAB_code_000357                         
LAB_code_00034f:              
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    ori         R16,0x80                                
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    bset        Iflg                                    
    ldi         R16,0x40                                
LAB_code_000357:              
    sts         PORTA_OUTCLR,R16                        ;= ??
    eor         R16,R16                                 
    st          Z,R16                                   
    rjmp        LAB_code_000363                         
LAB_code_00035c:              
    ldd         R17,Z+0x1                               
    dec         R17                                     
    brbc        LAB_code_000362,Zflg                    
    ldi         R16,0x2                                 
    st          Z,R16                                   
    rjmp        LAB_code_000363                         
LAB_code_000362:              
    std         Z+0x1,R17                               
LAB_code_000363:              
    adiw        Z,0x2                                   
    ld          R16,Z                                   
    ldd         R24,Z+0x1                               
    ldd         R25,Z+0x2                               
    and         R16,R16                                 
    brbs        LAB_code_0003a4,Zflg                    
    cpi         R16,0x1                                 
    brbc        LAB_code_000384,Zflg                    
    sbiw        R25R24,0x1                              
    brbc        LAB_code_0003a2,Zflg                    
    lds         R16,DAT_mem_21ad                        ;= ??
    and         R16,R16                                 
    brbs        LAB_code_0003a4,Zflg                    
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    andi        R16,0x7                                 
    cpi         R16,0x1                                 
    brbc        LAB_code_000380,Zflg                    
    ldi         R16,0x4                                 
    sts         PORTE_OUTSET,R16                        ;= ??
    bset        Iflg                                    
    ldi         R24,0xe8                                
    ldi         R25,0x3                                 
    ldi         R16,0x2                                 
    st          Z,R16                                   
    rjmp        LAB_code_0003a2                         
LAB_code_000380:              
    bset        Iflg                                    
    eor         R16,R16                                 
    st          Z,R16                                   
    rjmp        LAB_code_0003a2                         
LAB_code_000384:              
    cpi         R16,0x2                                 
    brbc        LAB_code_0003a5,Zflg                    
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    sbrc        R16,0x3                                 
    rjmp        LAB_code_000396                         
    sbiw        R25R24,0x1                              
    brbc        LAB_code_0003a2,Zflg                    
    ldi         R16,0x4                                 
    cli                                                 
    sts         PORTE_OUTCLR,R16                        ;= ??
LAB_code_000390:              
    sbi         GPIO_GPIOR0,0x1                         
    rcall       set_status_and_set_VD8_led              ;undefined set_status_and_set_VD8_led...
    bset        Iflg                                    
    eor         R16,R16                                 
    st          Z,R16                                   
    rjmp        LAB_code_0003a2                         
LAB_code_000396:              
    lds         R16,PORTE_IN                            ;= ??
    sbrs        R16,0x4                                 
    rjmp        LAB_code_000390                         
    ldi         R24,0xe8                                
    ldi         R25,0x3                                 
    rcall       FUN_code_0006b7                         ;undefined FUN_code_0006b7(void)
    ldi         R16,0x1f                                
    sts         DAT_mem_2185,R16                        ;= ??
    ldi         R16,0x3                                 
    st          Z,R16                                   
LAB_code_0003a2:              
    std         Z+0x1,R24                               
    std         Z+0x2,R25                               
LAB_code_0003a4:              
    rjmp        LAB_code_0003eb                         
LAB_code_0003a5:              
    cpi         R16,0x3                                 
    brbc        LAB_code_0003b7,Zflg                    
    sbiw        R25R24,0x1                              
    brbc        LAB_code_0003a2,Zflg                    
    ldi         R16,0x10                                
    sts         PORTD_OUTSET,R16                        ;= ??
    ldi         R16,0x2                                 
    sts         PORTD_OUTCLR,R16                        ;= ??
    ldi         R16,0x4                                 
    st          Z,R16                                   
    ldi         R24,0x88                                
    ldi         R25,0x13                                
    ldi         R16,0x2                                 
    sts         PORTD_OUTSET,R16                        ;= ??
    rjmp        LAB_code_0003a2                         
LAB_code_0003b7:              
    cpi         R16,0x4                                 
    brbc        LAB_code_0003da,Zflg                    
    lds         R16,PORTD_IN                            ;= ??
    sbrs        R16,0x5                                 
    rjmp        LAB_code_0003d5                         
    ldi         R16,0x1                                 
    sts         PORTD_INTFLAGS,R16                      ;= ??
    ldi         R16,0x2                                 
    sts         PORTD_INTCTRL,R16                       ;= ??
    ldi         R16,0x5                                 
    st          Z,R16                                   
    ldi         R16,0xa                                 
    std         Z+0x1,R16                               
    eor         R16,R16                                 
    std         Z+0x2,R16                               
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    ori         R16,0x10                                
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    call        fpga_send_mcu_ts                        ;undefined fpga_send_mcu_ts(void)
    call        fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        Iflg                                    
    rjmp        LAB_code_0003eb                         
LAB_code_0003d5:              
    sbiw        R25R24,0x1                              
    brbs        LAB_code_0003d8,Zflg                    
    rjmp        LAB_code_0003a2                         
LAB_code_0003d8:              
    cli                                                 
    rjmp        LAB_code_000390                         
LAB_code_0003da:              
    cpi         R16,0x5                                 
    brbc        LAB_code_0003eb,Zflg                    
    ldd         R24,Z+0x3                               
    ldd         R25,Z+0x4                               
    sbiw        R25R24,0x1                              
    brbs        LAB_code_0003e1,Zflg                    
    rjmp        LAB_code_0003a2                         
LAB_code_0003e1:              
    lds         R16,PORTB_OUT                           ;= ??
    sbrs        R16,0x7                                 
    rjmp        LAB_code_0003eb                         
    eor         R16,R16                                 
    st          Z,R16                                   
    rcall       FUN_code_0004e0                         ;undefined FUN_code_0004e0(void)
    ldi         R16,0x10                                
    sts         PORTB_OUTCLR,R16                        ;= ??
LAB_code_0003eb:              
    ldd         R24,Z+0x3                               
    ldd         R25,Z+0x4                               
    ldi         R16,0x1                                 
    cpi         R24,0xf4                                
    cpc         R25,R16                                 
    brbc        LAB_code_0003fd,Zflg                    
    cli                                                 
    sbis        GPIO_GPIOR0,0x0                         
    rjmp        LAB_code_0003f7                         
    ldi         R16,0x1                                 
    sts         PORTA_OUTTGL,R16                        ;= ??
LAB_code_0003f7:              
    sbis        GPIO_GPIOR0,0x2                         
    rjmp        LAB_code_0003fc                         
    ldi         R16,0x20                                
    sts         PORTA_OUTTGL,R16                        ;= ??
LAB_code_0003fc:              
    bset        Iflg                                    
LAB_code_0003fd:              
    sbiw        R25R24,0x1                              
    brbs        LAB_code_000400,Zflg                    
    rjmp        LAB_code_00047f                         
LAB_code_000400:              
    cli                                                 
    sbis        GPIO_GPIOR0,0x0                         
    rjmp        LAB_code_000406                         
    ldi         R16,0x1                                 
    sts         PORTA_OUTTGL,R16                        ;= ??
LAB_code_000406:              
    sbis        GPIO_GPIOR0,0x2                         
    rjmp        LAB_code_00040b                         
    ldi         R16,0x20                                
    sts         PORTA_OUTTGL,R16                        ;= ??
LAB_code_00040b:              
    bset        Iflg                                    
    lds         R16,DAT_mem_2185                        ;= ??
    sbrs        R16,0x4                                 
    rjmp        LAB_code_00043b                         
    cpi         R16,0x90                                
    brbs        LAB_code_000429,Cflg                    
    brbc        LAB_code_000418,Zflg                    
    ldi         R16,0x48                                
    call        USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    ldi         R16,0x48                                
    rjmp        LAB_code_000439                         
LAB_code_000418:              
    eor         R16,R16                                 
    sts         USARTD0_CTRLB,R16                       ;= ??
    sts         USARTD0_CTRLA,R16                       ;= ??
    lds         R16,DAT_mem_2199                        ;= ??
    lds         R17,DAT_mem_219a                        ;= ??
    ori         R17,0x80                                
    ldi         R18,0x13                                
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    ldi         R16,0x80                                
    rjmp        LAB_code_000439                         
LAB_code_000429:              
    dec         R16                                     
    cpi         R16,0x11                                
    brbs        LAB_code_000433,Zflg                    
    cpi         R16,0x10                                
    brbc        LAB_code_000439,Zflg                    
    ldi         R16,0x44                                
    call        USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    ldi         R16,0x98                                
    rjmp        LAB_code_000439                         
LAB_code_000433:              
    sts         DAT_mem_2185,R16                        ;= ??
    ldi         R16,0xd                                 
    call        USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    rjmp        LAB_code_00043b                         
LAB_code_000439:              
    sts         DAT_mem_2185,R16                        ;= ??
LAB_code_00043b:              
    ldi         R24,0xe8                                
    ldi         R25,0x3                                 
    ser         R17                                     
    ser         R18                                     
    ldi         R16,0x50                                
    ser         R17                                     
    ser         R18                                     
    call        adt7311_send_2_bytes                    ;undefined adt7311_send_2_bytes(void)
    eor         R17,R17                                 
    sbrs        R20,0x2                                 
    rjmp        LAB_code_000449                         
    ldi         R17,0x6                                 
    rjmp        LAB_code_000450                         
LAB_code_000449:              
    sbrs        R20,0x1                                 
    rjmp        LAB_code_00044d                         
    ldi         R17,0x4                                 
    rjmp        LAB_code_000450                         
LAB_code_00044d:              
    sbrs        R20,0x0                                 
    rjmp        LAB_code_000450                         
    ldi         R17,0x2                                 
LAB_code_000450:              
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    mov         R18,R16                                 
    andi        R18,0x6                                 
    eor         R18,R17                                 
    brbs        LAB_code_000467,Zflg                    
    andi        R16,0xf9                                
    or          R16,R17                                 
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    sbic        GPIO_GPIOR0,0x1                         
    rjmp        LAB_code_000466                         
    cpi         R17,0x6                                 
    brbc        LAB_code_000461,Zflg                    
    sbi         GPIO_GPIOR0,0x1                         
    rjmp        LAB_code_000465                         
LAB_code_000461:              
    and         R17,R17                                 
    brbs        LAB_code_000465,Zflg                    
    sbi         GPIO_GPIOR0,0x0                         
    rjmp        LAB_code_000466                         
LAB_code_000465:              
    rcall       set_status_and_set_VD8_led              ;undefined set_status_and_set_VD8_led...
LAB_code_000466:              
    bset        Iflg                                    
LAB_code_000467:              
    andi        R20,0xf8                                
    ldi         R18,0x14                                
    mul         R20,R18                                 
    mov         R16,R1                                  
    eor         R17,R17                                 
    mulsu       R21,R18                                 
caseD_ee:                     
    add         R16,R0                                  
    adc         R17,R1                                  
    ldd         R18,Z+0x5                               
    ldd         R19,Z+0x6                               
caseD_f2:                     
    cp          R16,R18                                 
    cpc         R17,R19                                 
    brbs        LAB_code_00047f,Zflg                    
    std         Z+0x5,R16                               
caseD_f6:                     
    std         Z+0x6,R17                               
    cli                                                 
    lds         R18,DAT_b_porte_1_5v_present            ;= ??
    sbrs        R18,0x4                                 
    rjmp        LAB_code_00047e                         
    ldi         R18,0x15                                
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
LAB_code_00047e:              
    bset        Iflg                                    
LAB_code_00047f:              
    std         Z+0x3,R24                               
    std         Z+0x4,R25                               
    sbis        GPIO_GPIOR0,0x5                         
    rjmp        LAB_code_0004c2                         
    lds         R16,DAT_clk_frs                         ;= ??
    andi        R16,0x1                                 
    brbc        LAB_code_000488,Zflg                    
    rjmp        LAB_code_0004c2                         
LAB_code_000488:              
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         Zlo,0x6d                                
    ldi         Zhi,0x21                                
    eor         R18,R18                                 
    cli                                                 
LAB_code_00048e:              
    inc         R18                                     
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    ld          R24,Z+                                  
    ld          R25,Z+                                  
    cp          R16,R24                                 
    cpc         R17,R25                                 
    brbc        LAB_code_000499,Zflg                    
    cpi         R18,0x3                                 
    brbs        LAB_code_00048e,Cflg                    
    rjmp        LAB_code_0004c0                         
LAB_code_000499:              
    brbc        LAB_code_00049b,Nflg                    
    neg         R18                                     
LAB_code_00049b:              
    lds         R16,TWIC_MASTER_CTRLA                   ;= ??
    andi        R16,0x30                                
    brbc        LAB_code_0004c1,Zflg                    
    ldi         R16,0x2                                 
    sts         DAT_mem_2163,R16                        ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2164,R16                        ;= ??
    sts         DAT_mem_2165,R18                        ;= ??
    ldi         R16,0xe0                                
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldi         R16,0x58                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    and         R18,R18                                 
    brbc        LAB_code_0004be,Nflg                    
    sbiw        R25R24,0x1                              
LAB_code_0004b0:              
    st          -Z,R25                                  
    st          -Z,R24                                  
    rcall       FUN_code_0004d3                         ;undefined FUN_code_0004d3(void)
    lds         R17,DAT_mem_2188                        ;= ??
    cp          R16,R17                                 
    brbs        LAB_code_0004c1,Zflg                    
    sts         DAT_mem_2188,R16                        ;= ??
    eor         R17,R17                                 
    ldi         R18,0x18                                
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    rjmp        LAB_code_0004c1                         
LAB_code_0004be:              
    adiw        R25R24,0x1                              
    rjmp        LAB_code_0004b0                         
LAB_code_0004c0:              
    cbi         GPIO_GPIOR0,0x5                         
LAB_code_0004c1:              
    bset        Iflg                                    
LAB_code_0004c2:              
    pop         R0                                      
    pop         R1                                      
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         R21                                     
    pop         R24                                     
    pop         R25                                     
    pop         Ylo                                     
    pop         Yhi                                     
    pop         Zlo                                     
    pop         Zhi                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0004d3(void)
    ldi         Zlo,0x6d                                
    ldi         Zhi,0x21                                
    ld          R19,Z                                   
    ldd         R18,Z+0x1                               
    ldd         R17,Z+0x4                               
    ldd         R16,Z+0x5                               
    sub         R17,R19                                 
    sbc         R16,R18                                 
    inc         R16                                     
    asr         R16                                     
    subi        R16,0xfb                                
    andi        R16,0xf                                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0004e0(void)
    push        R18                                     
    push        R17                                     
    push        R16                                     
    push        Ylo                                     
    push        Yhi                                     
    push        Zlo                                     
    ldi         R18,0x10                                
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
LAB_code_0004e9:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    cpi         R18,0x13                                
    brbc        LAB_code_0004f5,Zflg                    
    lds         Zlo,DAT_mem_2185                        ;= ??
    sbrc        Zlo,0x4                                 
    rjmp        LAB_code_0004f4                         
    andi        Zlo,0xc0                                
    or          R17,Zlo                                 
    rjmp        LAB_code_0004f5                         
LAB_code_0004f4:              
    ori         R17,0x40                                
LAB_code_0004f5:              
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    inc         R18                                     
    cpi         R18,0x15                                
    brbc        LAB_code_0004e9,Zflg                    
    eor         R18,R18                                 
LAB_code_0004fd:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        LAB_code_0004fd,Zflg                    
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    ldi         R18,0x17                                
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    lds         R16,DAT_mem_2160                        ;= ??
    lds         R17,DAT_mem_2161                        ;= ??
    ldi         R18,0x15                                
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    pop         Zlo                                     
    pop         Yhi                                     
    pop         Ylo                                     
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_done_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    lds         R16,PORTD_IN                            ;= ??
    bst         R16,0000000000000101b                   
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    bld         R16,0x4                                 
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    bset        Iflg                                    
    brbc        LAB_code_00053c,Tflg                    
    ldi         R16,0x80                                
    sts         PORTB_OUTCLR,R16                        ;= ??
    sbic        GPIO_GPIOR0,0x3                         
    rjmp        LAB_code_00054d                         
    cli                                                 
    ldi         R16,0x5                                 
    sts         DAT_mem_2159,R16                        ;= ??
    ldi         R16,0x64                                
    sts         DAT_mem_215a,R16                        ;= ??
    ldi         R16,0x4                                 
    sts         DAT_mem_215b,R16                        ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_00054d                         
LAB_code_00053c:              
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R16,0x10                                
    sts         PORTB_OUTSET,R16                        ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2158,R16                        ;= ??
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    andi        R16,0x7f                                
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    ldi         R16,0xc0                                
    sts         PORTA_OUTSET,R16                        ;= ??
LAB_code_00054d:              
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*  @brief PORTF4..5 interrupt routine                                                          *
;*                                                                                              *
;*  This function is triggered then at least one of                                             *
;*  the Si53301 input clocks is not present                                                     *
;************************************************************************************************
;undefined si53301_clk_not_present(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    rcall       reset_system                            ;undefined reset_system(void)
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined reset_system(void)
    sbi         GPIO_GPIOR0,0x3                         
    eor         R16,R16                                 
    sts         PORTC_INTCTRL,R16                       ;= ??
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R16,0x80                                
    sts         PORTA_OUTSET,R16                        ;= ??
    sts         PORTB_OUTCLR,R16                        ;= ??
    lds         R16,DAT_clk_frs                         ;= ??
    andi        R16,0xe                                 
    sts         DAT_clk_frs,R16                         ;= ??
    ldi         R16,0x64                                
    sts         DAT_mem_215a,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         DAT_mem_2159,R16                        ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000571(void)
    push        R0                                      
    push        R1                                      
    push        R18                                     
    push        R19                                     
    push        Ylo                                     
    push        Yhi                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         Zlo,0x6d                                
    ldi         Zhi,0x21                                
LAB_code_00057d:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    st          Z+,R16                                  
    st          Z+,R17                                  
    cpi         Ylo,0x99                                
    brbc        LAB_code_00057d,Zflg                    
    subi        Ylo,0x6                                 
    ldi         Zlo,0x67                                
    ldi         Zhi,0x21                                
LAB_code_000586:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    cpi         Ylo,0x99                                
    brbc        LAB_code_00058b,Zflg                    
    inc         R17                                     
LAB_code_00058b:              
    add         R16,R16                                 
    adc         R17,R17                                 
    add         R16,R16                                 
    adc         R17,R17                                 
    st          Z+,R16                                  
    st          Z+,R17                                  
    cpi         Ylo,0x99                                
    brbc        LAB_code_000586,Zflg                    
    rcall       FUN_code_0004d3                         ;undefined FUN_code_0004d3(void)
    sts         DAT_mem_2188,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x5                         
    lds         R16,DAT_clk_frs                         ;= ??
    sbrc        R16,0x3                                 
    rjmp        LAB_code_0005b3                         
    andi        R16,0x1                                 
    lds         R17,PORTF_IN                            ;= ??
    sbrc        R17,0x5                                 
    rjmp        LAB_code_0005a5                         
    ori         R16,0x2                                 
    ldi         R17,0x10                                
    sts         PORTC_OUTCLR,R17                        ;= ??
    rjmp        LAB_code_0005ab                         
LAB_code_0005a5:              
    sbrc        R17,0x4                                 
    rjmp        LAB_code_0005ab                         
    ori         R16,0x4                                 
    ldi         R17,0x10                                
    sts         PORTC_OUTSET,R17                        ;= ??
LAB_code_0005ab:              
    lds         R17,DAT_clk_frs                         ;= ??
    sts         DAT_clk_frs,R16                         ;= ??
    eor         R17,R16                                 
    andi        R17,0x6                                 
    brbc        LAB_code_0005b3,Zflg                    
    rjmp        LAB_code_0005c1                         
LAB_code_0005b3:              
    ldi         R17,0x20                                
    sbrs        R16,0x1                                 
    rjmp        LAB_code_0005ba                         
    sts         PORTA_OUTCLR,R17                        ;= ??
    cbi         GPIO_GPIOR0,0x2                         
    rjmp        LAB_code_0005c1                         
LAB_code_0005ba:              
    sbrs        R16,0x2                                 
    rjmp        LAB_code_0005be                         
    sbi         GPIO_GPIOR0,0x2                         
    rjmp        LAB_code_0005c1                         
LAB_code_0005be:              
    sts         PORTA_OUTSET,R17                        ;= ??
    cbi         GPIO_GPIOR0,0x2                         
LAB_code_0005c1:              
    pop         Zhi                                     
    pop         Zlo                                     
    pop         Yhi                                     
    pop         Ylo                                     
    pop         R19                                     
    pop         R18                                     
    pop         R1                                      
    pop         R0                                      
    ret                                                 
;************************************************************************************************
;*                                @brief Catch Si5338 LOS or LOL                                *
;************************************************************************************************
;undefined si5338_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        R19                                     
    push        R20                                     
    lds         R16,PORTC_IN                            ;= ??
    eor         R19,R19                                 
    andi        R16,000000000000000000001100b           
    brbs        LAB_code_0005d7,Zflg                    
    rjmp        LAB_code_0005e5                         
LAB_code_0005d7:              
    inc         R19                                     
    sbis        GPIO_GPIOR0,0x3                         
    rjmp        LAB_code_0005e5                         
    ldi         R16,0x1                                 
    sts         DAT_mem_2163,R16                        ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2164,R16                        ;= ??
    ldi         R16,0xe0                                
    sts         DAT_mem_2165,R16                        ;= ??
    rcall       si5338_twic_master_ctrla_setup          ;undefined si5338_twic_master_ctrla_s...
    cbi         GPIO_GPIOR0,0x3                         
LAB_code_0005e5:              
    lds         R16,DAT_clk_frs                         ;= ??
    andi        R16,0xe                                 
    or          R16,R19                                 
    sts         DAT_clk_frs,R16                         ;= ??
    ldi         R18,0x5                                 
    and         R19,R19                                 
    brbc        LAB_code_0005f7,Zflg                    
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R16,0x80                                
    sts         PORTA_OUTSET,R16                        ;= ??
    sts         PORTB_OUTCLR,R16                        ;= ??
    eor         R18,R18                                 
LAB_code_0005f7:              
    sts         DAT_mem_2159,R18                        ;= ??
    ldi         R16,0x64                                
    sts         DAT_mem_215a,R16                        ;= ??
    pop         R20                                     
    pop         R19                                     
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined 5V_present_or_Si53301_v_fault(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    cli                                                 
    push        R16                                     
    push        R17                                     
    push        R18                                     
    eor         R17,R17                                 
    lds         R16,PORTE_IN                            ;= ??
    bst         R16,0x1                                 
    bld         R17,0x0                                 
    bst         R16,0x3                                 
    bld         R17,0x3                                 
    bst         R16,0x2                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    mov         R18,R16                                 
    andi        R16,0xf6                                
    or          R16,R17                                 
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    eor         R18,R17                                 
    sbrs        R18,0x0                                 
    rjmp        LAB_code_00062f                         
    sbrc        R17,0x0                                 
    rjmp        switchD_code:000116::caseD_66           
    ldi         R16,0x4                                 
    sts         PORTE_OUTCLR,R16                        ;= ??
    sbi         GPIO_GPIOR0,0x1                         
    rcall       system_reset_2                          ;undefined system_reset_2(void)
    rjmp        LAB_code_000636                         
caseD_66:                     
    ldi         R16,0x1                                 
caseD_68:                     
    sts         DAT_mem_215b,R16                        ;= ??
caseD_6c:                     
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        ;= ??
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x1                         
    rjmp        LAB_code_000636                         
LAB_code_00062f:              
    sbrs        R18,0x3                                 
    rjmp        LAB_code_000637                         
    sbrc        R17,0x3                                 
    rjmp        LAB_code_000637                         
    rcall       system_reset_2                          ;undefined system_reset_2(void)
    brbc        LAB_code_000637,Tflg                    
    sbi         GPIO_GPIOR0,0x1                         
LAB_code_000636:              
    rcall       set_status_and_set_VD8_led              ;undefined set_status_and_set_VD8_led...
LAB_code_000637:              
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;void fpga_comm_request_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    push        R17                                     
    push        R18                                     
    ldi         R18,0x7f                                
    call        fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    sbrs        R17,0x3                                 
    rjmp        LAB_code_000654                         
    sbrc        R17,0x2                                 
    rjmp        LAB_code_00064c                         
    ldi         R16,0xa                                 
    eor         R17,R17                                 
    rjmp        LAB_code_00064e                         
LAB_code_00064c:              
    ldi         R16,0x2                                 
    ldi         R17,0x8                                 
LAB_code_00064e:              
    sts         PORTF_INTCTRL,R16                       ;= ??
    sts         DAT_clk_frs,R17                         ;= ??
    rcall       reset_system                            ;undefined reset_system(void)
    rjmp        LAB_code_000663                         
LAB_code_000654:              
    sbrs        R17,0x1                                 
    rjmp        LAB_code_00065b                         
    lds         R18,DAT_fpga_comm_request               ;= ??
    ori         R18,0x1                                 
    sts         DAT_fpga_comm_request,R18               ;= ??
LAB_code_00065b:              
    swap        R16                                     
    andi        R16,0x7                                 
    lds         R17,DAT_mem_2158                        ;= ??
    andi        R17,0xfa                                
    or          R16,R17                                 
    sts         DAT_mem_2158,R16                        ;= ??
LAB_code_000663:              
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                         @brief set GPIOR0 status and set/clr VD8 LED                         *
;************************************************************************************************
;undefined set_status_and_set_VD8_led(void)
    sbic        GPIO_GPIOR0,0x1                         
    rjmp        LAB_code_000670                         
    cbi         GPIO_GPIOR0,0x0                         
    ldi         R16,0x1                                 
    sts         PORTA_OUTSET,R16                        ;= ??
    ret                                                 
LAB_code_000670:              
    ldi         R16,0x1                                 
    sts         PORTA_OUTCLR,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x0                         
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined system_reset_2(void)
    eor         R16,R16                                 
    sts         DAT_mem_215c,R16                        ;= ??
    sts         DAT_mem_215d,R16                        ;= ??
    sts         DAT_mem_215b,R16                        ;= ??
    sts         DAT_fpga_comm_request,R16               ;= ??
    sts         DAT_mem_2185,R16                        ;= ??
    sts         DAT_mem_2159,R16                        ;= ??
    sts         DAT_clk_frs,R16                         ;= ??
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R16,0x2                                 
    sts         PORTF_INTCTRL,R16                       ;= ??
    eor         R16,R16                                 
    sts         PORTC_INTCTRL,R16                       ;= ??
    sts         PORTD_INTCTRL,R16                       ;= ??
    sts         USARTD0_CTRLB,R16                       ;= ??
    sts         USARTD0_CTRLA,R16                       ;= ??
    ldi         R16,0x80                                
    sts         PORTB_DIRCLR,R16                        ;= ??
    ldi         R16,0x10                                
    sts         PORTB_OUTSET,R16                        ;= ??
    eor         R16,R16                                 
    sts         SPIC,R16                                ;= ??
    ldi         R16,0xb0                                
    sts         PORTC_DIRCLR,R16                        ;= ??
    ldi         R16,0x9                                 
    sts         PORTD_DIRCLR,R16                        ;= ??
    ldi         R16,0x10                                
    sts         PORTD_OUTCLR,R16                        ;= ??
    ldi         R16,0x30                                
    sts         PORTF_DIRCLR,R16                        ;= ??
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    andi        R16,0xef                                
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    ldi         R16,0xa0                                
    sts         PORTA_OUTSET,R16                        ;= ??
    ldi         R16,0x48                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ldi         R16,0x1                                 
    sts         TWIC_MASTER_STATUS,R16                  ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0006b7(void)
    push        Ylo                                     
    push        Yhi                                     
    ldi         R16,0x80                                
    sts         PORTB_OUTSET,R16                        ;= ??
    ldi         R16,0x80                                
    sts         PORTB_DIRSET,R16                        ;= ??
    ldi         R16,0xb0                                
    sts         PORTC_DIRSET,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         PORTD_OUTSET,R16                        ;= ??
    ldi         R16,0x9                                 
    sts         PORTD_DIRSET,R16                        ;= ??
    ldi         R16,0x18                                
    sts         USARTD0_CTRLB,R16                       ;= ??
    ldi         R16,0x10                                
    sts         USARTD0_CTRLA,R16                       ;= ??
    ldi         R16,0xd1                                
    sts         SPIC,R16                                ;= ??
    ldi         R16,0x1                                 
    sts         TWIC_MASTER_STATUS,R16                  ;= ??
    eor         R16,R16                                 
    ldi         Ylo,0x63                                
    ldi         Yhi,0x21                                
    st          Y+,R16                                  
    st          Y+,R16                                  
    ldi         R16,0xfe                                
    st          Y+,R16                                  
    ldi         R16,0x25                                
    st          Y+,R16                                  
    in          R16,GPIO_GPIOR0                         
    andi        R16,0xc7                                
    out         GPIO_GPIOR0,R16                         
    ldi         R16,0xe0                                
    std         Y+0x1,R16                               
    rcall       si5338_twic_master_ctrla_setup          ;undefined si5338_twic_master_ctrla_s...
    pop         Yhi                                     
    pop         Ylo                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined si5338_twic_master_ctrla_setup(void)
    sts         TWIC_MASTER_ADDR,R16                    ;= ??
    ldi         R16,0x58                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ret                                                 
;************************************************************************************************
;*  @brief This is USARTF0 CTS interrupt routine                                                *
;*                                                                                              *
;*  This functions sends next byte from Tx buffer is                                            *
;*  any is present                                                                              *
;************************************************************************************************
;undefined usartf0_cts_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        Yhi                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         Zlo,0x4                                 
    ldi         Zhi,0x20                                
    eor         Yhi,Yhi                                 
    lds         R16,PORTF_IN                            ;= ??
    sbrc        R16,0x1                                 
    rjmp        LAB_code_000716                         
    inc         Yhi                                     
    ld          R17,-Z                                  
    ld          R16,-Z                                  
    cp          R16,R17                                 
    brbs        LAB_code_000715,Zflg                    
    lds         R18,USARTF0_STATUS                      ;= ??
    sbrs        R18,0x5                                 
    rjmp        LAB_code_000710                         
    eor         R17,R17                                 
    inc         R16                                     
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    ld          R17,Z                                   
    sts         USARTF0,R17                             ;= ??
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    st          Z,R16                                   
LAB_code_000710:              
    lds         R18,USARTF0_CTRLA                       ;= ??
    ori         R18,0x2                                 
    sts         USARTF0_CTRLA,R18                       ;= ??
LAB_code_000715:              
    adiw        Z,0x2                                   
LAB_code_000716:              
    st          Z,Yhi                                   
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         Yhi                                     
    pop         Zlo                                     
    pop         Zhi                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                       @brief Send next byte to attenuator via USART D0                       *
;************************************************************************************************
;undefined USARTD0_DRE(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         Zlo,0x83                                
    ldi         Zhi,0x21                                
    ld          R16,Z+                                  
    ld          R17,Z                                   
    cp          R16,R17                                 
    brbc        LAB_code_000734,Zflg                    
    lds         R19,USARTD0_CTRLA                       ;= ??
    andi        R19,0xfc                                
    sts         USARTD0_CTRLA,R19                       ;= ??
caseD_80:                     
    rjmp        LAB_code_000741                         
LAB_code_000734:              
    inc         R16                                     
    andi        R16,0xf                                 
    eor         R17,R17                                 
    ldi         Zlo,0x73                                
    ldi         Zhi,0x21                                
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    ld          R17,Z                                   
    sts         USARTD0,R17                             ;= ??
    ldi         Zlo,0x83                                
    ldi         Zhi,0x21                                
    st          Z,R16                                   
LAB_code_000741:              
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         Zlo                                     
    pop         Zhi                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usartd0_rx_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    lds         R19,USARTD0_STATUS                      ;= ??
    lds         R16,USARTD0                             ;= ??
    sbrc        R19,0x4                                 
    rjmp        LAB_code_000792                         
    lds         R19,DAT_mem_2185                        ;= ??
    sbrc        R19,0x5                                 
    call        usartf0_send_msg_2                      ;undefined usartf0_send_msg_2(void)
    mov         R18,R19                                 
    cpi         R19,0x40                                
    brbs        LAB_code_000792,Cflg                    
    andi        R19,0xf                                 
    brbs        LAB_code_000792,Zflg                    
    eor         R17,R17                                 
    ldi         Zlo,0x36                                
    ldi         Zhi,0x2b                                
    sub         Zlo,R19                                 
    sbc         Zhi,R17                                 
    lpm         R17,Z                                   
    cp          R16,R17                                 
    brbs        LAB_code_00076c,Zflg                    
    ldi         R19,0x8                                 
    rjmp        LAB_code_00078e                         
LAB_code_00076c:              
    dec         R19                                     
    brbc        LAB_code_00078e,Zflg                    
    cpi         R18,0x91                                
    brbc        LAB_code_000772,Zflg                    
    ldi         R19,0x90                                
    rjmp        LAB_code_000790                         
LAB_code_000772:              
    sbrc        R18,0x7                                 
    rjmp        LAB_code_000792                         
    cli                                                 
    lds         R16,DAT_mem_2199                        ;= ??
    lds         R17,DAT_mem_219a                        ;= ??
    lds         R18,DAT_mem_2186                        ;= ??
    lds         R19,DAT_mem_2187                        ;= ??
    cp          R16,R18                                 
    cpc         R17,R19                                 
    brbc        LAB_code_000785,Zflg                    
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    eor         R19,R19                                 
    rjmp        LAB_code_000790                         
LAB_code_000785:              
    sts         DAT_mem_2186,R16                        ;= ??
    sts         DAT_mem_2187,R17                        ;= ??
    bset        Iflg                                    
    call        attenuator_set_steps                    ;undefined attenuator_set_steps(void)
    ldi         R19,0x48                                
    rjmp        LAB_code_000790                         
LAB_code_00078e:              
    andi        R18,0xf0                                
    or          R19,R18                                 
LAB_code_000790:              
    sts         DAT_mem_2185,R19                        ;= ??
LAB_code_000792:              
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         Zlo                                     
    pop         Zhi                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*  @brief USARTF0 data ready int.                                                              *
;*                                                                                              *
;*  Send bytes when ready                                                                       *
;************************************************************************************************
;undefined usart_f0_dre_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    ld          R16,Z+                                  
    ld          R17,Z+                                  
    ld          R18,Z                                   
    and         R18,R18                                 
    brbs        LAB_code_0007ac,Zflg                    
    cp          R16,R17                                 
    brbc        LAB_code_0007b2,Zflg                    
LAB_code_0007ac:              
    lds         R19,USARTF0_CTRLA                       ;= ??
    andi        R19,0xfc                                
    sts         USARTF0_CTRLA,R19                       ;= ??
    rjmp        LAB_code_0007be                         
LAB_code_0007b2:              
    inc         R16                                     
    eor         R17,R17                                 
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    ld          R17,Z                                   
    sts         USARTF0,R17                             ;= ??
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    st          Z,R16                                   
LAB_code_0007be:              
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         Zlo                                     
    pop         Zhi                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*  @brief USARTF0 RX int                                                                       *
;*                                                                                              *
;*  Store incoming bytes from USARTF0                                                           *
;************************************************************************************************
;undefined usart_f0_rx_int(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         Zlo,0x0                                 
    ldi         Zhi,0x20                                
    ld          R16,Z+                                  
    ld          R17,Z                                   
    inc         R17                                     
    andi        R17,0x3f                                
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cp          R18,R16                                 
    brbc        usart_f0_rx_buffer_full_endif,Zflg      
    ldi         R18,0x1                                 
    sts         PORTF_OUTSET,R18                        ;= ??
    lds         R18,DAT_usart_f0_new_line               ;= ??
    ori         R18,0x80                                
    sts         DAT_usart_f0_new_line,R18               ;= ??
usart_f0_rx_buffer_full_endif:
    lds         R19,USARTF0_STATUS                      ;= ??
    lds         R18,USARTF0                             ;= ??
    sbrc        R19,0x4                                 
    rjmp        usart_f0_rx_ferr_endif                  
    cp          R16,R17                                 
    brbs        usart_f0_rx_ferr_endif,Zflg             
    st          Z,R17                                   
    ldi         Zlo,0x7                                 
    ldi         Zhi,0x20                                
    eor         R16,R16                                 
    add         Zlo,R17                                 
    adc         Zhi,R16                                 
    st          Z,R18                                   
    cpi         R18,0xd                                 
    brbc        usart_f0_rx_ferr_endif,Zflg             
    lds         R16,DAT_usart_f0_new_line               ;= ??
    inc         R16                                     
    sts         DAT_usart_f0_new_line,R16               ;= ??
usart_f0_rx_ferr_endif:       
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         Zlo                                     
    pop         Zhi                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*  @brief main program loop                                                                    *
;*                                                                                              *
;*  This function:                                                                              *
;*  1. configures the MCU (io, usart, twi, etc.),                                               *
;*  2. zeroes configuration structs and copies                                                  *
;*  3. Sets up ADT7311                                                                          *
;*  4. Loads configuration from EEPROM                                                          *
;*  5. Sends interface ready msg via USART                                                      *
;*  6. Starts main loop consisting of:                                                          *
;*    a. communicating with FPGA (on FPGA request)                                              *
;*    b. parsing incoming USART msgs                                                            *
;************************************************************************************************
;undefined main(void)
    ldi         R16,0xcb                                
    sts         OSC_XOSCCTRL,R16                        ;= ??
    ldi         R16,0x9                                 
    sts         OSC,R16                                 ;= ??
;wait for OSC
LAB_code_000807:              
    lds         R17,OSC_STATUS                          ;= ??
    sbrs        R17,0x3                                 
    rjmp        LAB_code_000807                         
    ldi         R16,0xc2                                
    sts         OSC_PLLCTRL,R16                         ;= ??
    ldi         R16,0x19                                
    sts         OSC,R16                                 ;= ??
;wait for OSC
LAB_code_000811:              
    lds         R17,OSC_STATUS                          ;= ??
    sbrs        R17,0x4                                 
    rjmp        LAB_code_000811                         
    ldi         R17,0xd8                                
    ldi         R16,0x4                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         CLK,R16                                 ;= ??
    ldi         R16,0x18                                
    sts         OSC,R16                                 ;= ??
    ser         R25                                     
    out         SPL,R25                                 
    ldi         R25,0x3f                                
    out         SPH,R25                                 
    ldi         R16,000000000000000011111011b           
    sts         PORTA_DIRSET,R16                        ;= ??
    ldi         R16,000000000000000011110011b           
    sts         PORTA_OUTSET,R16                        ;= ??
    ldi         R16,0x18                                
    sts         PORTA_PIN2CTRL,R16                      ;= ??
    ldi         R16,0x80                                
    sts         PORTA_PIN1CTRL,R16                      ;= ??
    sts         PORTA_PIN3CTRL,R16                      ;= ??
    sts         PORTA_PIN4CTRL,R16                      ;= ??
    ldi         R16,000000000000000000011111b           
    sts         PORTB_DIRSET,R16                        ;= ??
    ldi         R16,000000000000000000010000b           
    sts         PORTB_OUTSET,R16                        ;= ??
    ldi         R16,0x10                                
    sts         PORTB_PIN5CTRL,R16                      ;= ??
    sts         PORTB_PIN6CTRL,R16                      ;= ??
    ldi         R16,0x28                                
    sts         PORTC_PIN0CTRL,R16                      ;= ??
    sts         PORTC_PIN1CTRL,R16                      ;= ??
    ldi         R16,0x0                                 
    sts         PORTC_PIN3CTRL,R16                      ;= ??
    sts         PORTC_PIN4CTRL,R16                      ;= ??
    ldi         R16,0x28                                
    sts         PORTD_PIN1CTRL,R16                      ;= ??
    sts         PORTD_PIN4CTRL,R16                      ;= ??
    ldi         R16,0x10                                
    sts         PORTD_OUTCLR,R16                        ;= ??
    ldi         R16,000000000000000000000010b           
    sts         PORTD_OUTSET,R16                        ;= ??
    ldi         R16,000000000000000000010010b           
    sts         PORTD_DIRSET,R16                        ;= ??
    ldi         R16,0x0                                 
    sts         PORTD_PIN5CTRL,R16                      ;= ??
    ldi         R16,0x10                                
    sts         PORTD_PIN6CTRL,R16                      ;= ??
    sts         PORTD_PIN7CTRL,R16                      ;= ??
    ldi         R16,000000000000000000000100b           
    sts         PORTE_DIRSET,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         PORTE_PIN0CTRL,R16                      ;= ??
    ldi         R16,0x0                                 
    sts         PORTE_PIN1CTRL,R16                      ;= ??
    ldi         R16,0x80                                
    sts         PORTE_PIN2CTRL,R16                      ;= ??
    ldi         R16,0x0                                 
    sts         PORTE_PIN3CTRL,R16                      ;= ??
    ldi         R16,000000000000000000001010b           
    sts         PORTE_INT0MASK,R16                      ;= ??
    ldi         R16,0x1                                 
    sts         PORTE_INT1MASK,R16                      ;= ??
    ldi         R16,0x9                                 
    sts         PORTF_DIRSET,R16                        ;= ??
    ldi         R16,0x0                                 
    sts         PORTF_PIN1CTRL,R16                      ;= ??
    sts         PORTF_PIN4CTRL,R16                      ;= ??
    sts         PORTF_PIN5CTRL,R16                      ;= ??
    ldi         R16,0x10                                
    sts         PORTF_PIN6CTRL,R16                      ;= ??
    sts         PORTF_PIN7CTRL,R16                      ;= ??
    ldi         R16,0xc                                 
    sts         PORTC_INT0MASK,R16                      ;= ??
    ldi         R16,0x20                                
    sts         PORTD_INT0MASK,R16                      ;= ??
    ldi         R16,0x2                                 
    sts         PORTF_INT0MASK,R16                      ;= ??
    ldi         R16,000000000000000000110000b           
    sts         PORTF_INT1MASK,R16                      ;= ??
    ldi         R16,0x1                                 
    sts         PORTF_OUTSET,R16                        ;= ??
    ldi         R16,0x23                                
    sts         TWIC_MASTER_BAUD,R16                    ;= ??
    ldi         R16,0x48                                
    sts         TWIC_MASTER_CTRLA,R16                   ;= ??
    ldi         R16,0x1                                 
    sts         TWIC_MASTER_STATUS,R16                  ;= ??
    ldi         R16,0x40                                
    sts         USARTD0_BAUDCTRLB,R16                   ;= ??
    ldi         R16,0xc                                 
    sts         USARTD0_BAUDCTRLA,R16                   ;= ??
    ldi         R16,0x3                                 
    sts         USARTD0_CTRLC,R16                       ;= ??
    ldi         R16,0xd0                                
    sts         USARTF0_BAUDCTRLB,R16                   ;= ??
    ldi         R16,0x83                                
    sts         USARTF0_BAUDCTRLA,R16                   ;= ??
    ldi         R16,0x3                                 
    sts         USARTF0_CTRLC,R16                       ;= ??
    ldi         R16,0x18                                
    sts         USARTF0_CTRLB,R16                       ;= ??
    ldi         R16,0x10                                
    sts         USARTF0_CTRLA,R16                       ;= ??
    ldi         R16,000000000000000000000110b           
;Prescaler Clk/256
    sts         TCC0,R16                                ;= ??
    ldi         R16,0x7d                                
;Period 125
    sts         TCC0_PER,R16                            ;= ??
    ldi         R16,0x0                                 
    sts         DAT_mem_0827,R16                        ;= ??
    ldi         R16,0x0                                 
    sts         TCC0_CTRLB,R16                          ;= ??
    ldi         R16,0x0                                 
;Normal Mode
    sts         TCC0_CTRLE,R16                          ;= ??
    ldi         R16,0x1                                 
;Interrupt Enable
    sts         TCC0_INTCTRLA,R16                       ;= ??
    ldi         R16,000000000000000000001000b           
    sts         NVM_CTRLB,R16                           ;= ??
    eor         R25,R25                                 
    out         GPIO_GPIOR0,R25                         
;Clear 0x2000 - 0x23b2 (some bigger struct)
    ldi         Zlo,0x0                                 
    ldi         Zhi,0x20                                
    ldi         Ylo,0xb2                                
    ldi         Yhi,0x23                                
LAB_code_0008cc:              
    st          Z+,R25                                  
    cp          Zlo,Ylo                                 
    cpc         Zhi,Yhi                                 
    brbc        LAB_code_0008cc,Zflg                    
;check PF1 (DD7_R2OUT) status
    lds         R16,PORTF_IN                            ;= ??
    sbrs        R16,0x1                                 
    inc         R25                                     
    sts         DAT_b_portf_1_set,R25                   ;= ??
    lds         R16,PORTE_IN                            ;= ??
    bst         R16,0x1                                 
    eor         R16,R16                                 
    bld         R16,0x0                                 
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    brbs        LAB_code_0008e3,Tflg                    
    sbi         GPIO_GPIOR0,0x1                         
    ldi         R16,0x1                                 
    sts         PORTA_OUTCLR,R16                        ;= ??
    rjmp        LAB_code_0008ec                         
LAB_code_0008e3:              
    ldi         R16,0x1                                 
    sts         DAT_mem_215b,R16                        ;= ??
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        ;= ??
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        ;= ??
LAB_code_0008ec:              
    ldi         R16,0xe8                                
    sts         DAT_mem_215e,R16                        ;= ??
    ldi         R16,0x3                                 
    sts         DAT_mem_215f,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R16,0x2                                 
    sts         PORTF_INTCTRL,R16                       ;= ??
    ldi         R16,0x3                                 
    sts         PMIC_CTRL,R16                           ;= ??
;-- ADT7311 setup --
;0x50 = 0b01010000
;Fault queue: 00 = 1 fault (default)
;CT pin polarity: 0 = active low
;INT pin polarity: 0 = active low
;INT/CT mode: 1 = comparator mode
;Operation mode: 01 = one shot (240ms conversion)
;Resolution: 0 = 13 bit, sign bit + 12 bits */
    rcall       adt7311_clear_faults                    ;undefined adt7311_clear_faults(void)
    ldi         R16,0x8                                 
    ldi         R17,0x50                                
    rcall       adt7311_send_1_byte                     ;undefined adt7311_send_1_byte(void)
    ldi         R16,0x20                                
    ldi         R17,0x0                                 
    ldi         R18,0x23                                
    rcall       adt7311_send_2_bytes                    ;undefined adt7311_send_2_bytes(void)
    ldi         R16,0x30                                
    ldi         R17,0x0                                 
    ldi         R18,0x1e                                
    rcall       adt7311_send_2_bytes                    ;undefined adt7311_send_2_bytes(void)
;; EEPROM copy configuration: 0x2189 -> 0x21ae (37 bytes)
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    ldi         Ylo,0x0                                 
    ldi         Yhi,0x10                                
    ldi         R17,0x21                                
LAB_code_00090c:              
    ld          R16,Y+                                  
    st          Z+,R16                                  
    cpi         Zlo,0xae                                
    cpc         Zhi,R17                                 
    brbc        LAB_code_00090c,Zflg                    
    ser         R16                                     
    sts         DAT_mem_2186,R16                        ;= ??
    sts         DAT_mem_2187,R16                        ;= ??
    lds         R16,DAT_portb_setup                     ;= ??
    andi        R16,0xf                                 
;; Set PB0, PB3 according to EEPROM settings
    lds         R17,PORTB_OUT                           ;= ??
    andi        R17,0x90                                
    or          R16,R17                                 
    sts         PORTB_OUT,R16                           ;= ??
    bset        Iflg                                    
;; USART send "INR TCM control interface ready"
    ldi         Zlo,0x96                                
    ldi         Zhi,0x29                                
    call        usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         R16,0x1                                 
    sts         PORTF_OUTCLR,R16                        ;= ??
LAB_code_000927:              
    lds         R16,DAT_fpga_comm_request               ;= ??
    and         R16,R16                                 
    brbs        LAB_code_00092c,Zflg                    
    rcall       fpga_exchange_data                      ;undefined fpga_exchange_data(void)
LAB_code_00092c:              
    lds         R16,DAT_usart_f0_new_line               ;= ??
    and         R16,R16                                 
    brbs        LAB_code_000927,Zflg                    
    rcall       usart_f0_parse_prompt                   ;undefined usart_f0_parse_prompt(void)
    rjmp        LAB_code_000927                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_exchange_data(void)
    eor         R16,R16                                 
    cli                                                 
    sts         DAT_fpga_comm_request,R16               ;= ??
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         R18,0xf8                                
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrc        R15,0x3                                 
    rjmp        LAB_code_00093f                         
LAB_code_00093d:              
    bset        Iflg                                    
    ret                                                 
LAB_code_00093f:              
    rcall       fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        Iflg                                    
    ldi         R18,0x10                                
    mov         R15,R16                                 
LAB_code_000943:              
    lsr         R15                                     
    brbs        LAB_code_000947,Cflg                    
    adiw        Y,0x2                                   
    rjmp        LAB_code_0009b0                         
LAB_code_000947:              
    cli                                                 
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        Iflg                                    
    cpi         R18,0x13                                
    brbs        LAB_code_00096c,Zflg                    
    brbs        LAB_code_000952,Cflg                    
    rjmp        LAB_code_000995                         
LAB_code_000952:              
    ldi         R24,0x4                                 
    cpi         R16,0x1                                 
    cpc         R17,R24                                 
    brbc        LAB_code_00095d,Sflg                    
    ldi         R24,0xfc                                
    cpi         R16,0x0                                 
    cpc         R17,R24                                 
    brbc        LAB_code_000966,Sflg                    
    ldi         R16,0x0                                 
    ldi         R17,0xfc                                
    rjmp        LAB_code_00095f                         
LAB_code_00095d:              
    ldi         R16,0x0                                 
    ldi         R17,0x4                                 
LAB_code_00095f:              
    cli                                                 
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
LAB_code_000966:              
    cli                                                 
    st          Y+,R16                                  
    st          Y+,R17                                  
    sbi         GPIO_GPIOR0,0x5                         
    bset        Iflg                                    
    rjmp        LAB_code_0009b0                         
LAB_code_00096c:              
    ldi         R24,0x2e                                
    cpi         R16,0xe1                                
    cpc         R17,R24                                 
    brbs        LAB_code_000972,Cflg                    
    ldi         R16,0xe0                                
    ldi         R17,0x2e                                
LAB_code_000972:              
    cli                                                 
    ld          R20,Y                                   
    ldd         R21,Y+0x1                               
    st          Y+,R16                                  
    st          Y+,R17                                  
    lds         R24,DAT_mem_2185                        ;= ??
    ldi         R25,0xdf                                
    and         R25,R24                                 
    brbc        LAB_code_00098a,Zflg                    
    cp          R16,R20                                 
    cpc         R17,R21                                 
    brbs        LAB_code_000993,Zflg                    
    sts         DAT_mem_2186,R16                        ;= ??
    sts         DAT_mem_2187,R17                        ;= ??
    bset        Iflg                                    
    call        attenuator_set_steps                    ;undefined attenuator_set_steps(void)
    ori         R24,0x48                                
    sts         DAT_mem_2185,R24                        ;= ??
    rjmp        LAB_code_00098d                         
LAB_code_00098a:              
    brbc        LAB_code_00098d,Nflg                    
    ori         R17,0x80                                
    rjmp        LAB_code_00098e                         
LAB_code_00098d:              
    ori         R17,0x40                                
LAB_code_00098e:              
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
LAB_code_000993:              
    bset        Iflg                                    
    rjmp        LAB_code_0009b0                         
LAB_code_000995:              
    cpi         R16,0x10                                
    brbc        LAB_code_000999,Cflg                    
    and         R17,R17                                 
    brbs        LAB_code_0009a2,Zflg                    
LAB_code_000999:              
    eor         R17,R17                                 
    andi        R16,0xf                                 
    cli                                                 
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
LAB_code_0009a2:              
    st          Y+,R16                                  
    adiw        Y,0x1                                   
    cli                                                 
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    lds         R17,PORTB_OUT                           ;= ??
    andi        R17,0x90                                
    or          R16,R17                                 
    sts         PORTB_OUT,R16                           ;= ??
    bset        Iflg                                    
LAB_code_0009b0:              
    inc         R18                                     
    cpi         R18,0x15                                
    brbs        LAB_code_0009b4,Zflg                    
    rjmp        LAB_code_000943                         
LAB_code_0009b4:              
    ret                                                 
;************************************************************************************************
;*  @brief usart f0 command parser                                                              *
;*                                                                                              *
;*  This function parses incoming messages and                                                  *
;*  performs actions described in README.md,                                                    *
;*  section "USART F0 commands"                                                                 *
;************************************************************************************************
;undefined usart_f0_parse_prompt(void)
    andi        R16,0x7f                                
    sts         DAT_usart_f0_new_line,R16               ;= ??
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        LAB_code_0009c1,Zflg                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x43                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        LAB_code_000a88                         
LAB_code_0009c1:              
    cpi         R16,0x43                                
    brbc        LAB_code_0009ce,Zflg                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        LAB_code_0009c8,Zflg                    
    rjmp        resolve_ca_msg                          ;undefined resolve_ca_msg(void)
LAB_code_0009c8:              
    cpi         R16,0x4c                                
    brbc        LAB_code_0009cb,Zflg                    
    rjmp        LAB_code_000ab6                         
LAB_code_0009cb:              
    cpi         R16,0x50                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        LAB_code_000aa2                         
LAB_code_0009ce:              
    cpi         R16,0x4f                                
    brbc        LAB_code_0009d8,Zflg                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x4e                                
    brbc        LAB_code_0009d5,Zflg                    
    rjmp        LAB_code_000a37                         
LAB_code_0009d5:              
    cpi         R16,0x46                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        LAB_code_000a85                         
LAB_code_0009d8:              
    cpi         R16,0x50                                
    brbc        LAB_code_0009e2,Zflg                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        LAB_code_0009df,Zflg                    
    rjmp        LAB_code_000aeb                         
LAB_code_0009df:              
    cpi         R16,0x46                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        fpga_firmware_update                    ;undefined fpga_firmware_update(void)
LAB_code_0009e2:              
    cpi         R16,0x52                                
    brbc        LAB_code_0009ed,Zflg                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x50                                
    brbc        LAB_code_0009e9,Zflg                    
    rjmp        usart_f0_send_system_params             ;undefined usart_f0_send_system_param...
LAB_code_0009e9:              
    cpi         R16,0x53                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        usart_f0_send_system_status             ;undefined usart_f0_send_system_statu...
LAB_code_0009ec:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_0009ed:              
    cpi         R16,0x53                                
    brbc        LAB_code_000a15,Zflg                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        LAB_code_0009f4,Zflg                    
    rjmp        fpga_set_a_side_phase                   ;undefined fpga_set_a_side_phase(void)
LAB_code_0009f4:              
    cpi         R16,0x43                                
    brbc        LAB_code_0009f7,Zflg                    
    rjmp        fpga_set_c_side_phase                   ;undefined fpga_set_c_side_phase(void)
LAB_code_0009f7:              
    cpi         R16,0x49                                
    brbc        LAB_code_0009fa,Zflg                    
    rjmp        fpga_set_IP_addr                        ;undefined fpga_set_IP_addr(void)
LAB_code_0009fa:              
    cpi         R16,0x4c                                
    brbc        LAB_code_0009fd,Zflg                    
    rjmp        fpga_set_laser_phase                    ;undefined fpga_set_laser_phase(void)
LAB_code_0009fd:              
    cpi         R16,0x4d                                
    brbc        LAB_code_000a00,Zflg                    
    rjmp        fpga_set_mac_addr                       ;undefined fpga_set_mac_addr(void)
LAB_code_000a00:              
    cpi         R16,0x53                                
    brbc        LAB_code_000a03,Zflg                    
    rjmp        fpga_set_switches                       ;undefined fpga_set_switches(void)
LAB_code_000a03:              
    cpi         R16,0x54                                
    brbc        LAB_code_000a0f,Zflg                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x48                                
    brbc        LAB_code_000a09,Zflg                    
    rjmp        fpga_set_vertex_time_high_th            ;undefined fpga_set_vertex_time_high_...
LAB_code_000a09:              
    cpi         R16,0x4c                                
    brbc        LAB_code_000a0c,Zflg                    
    rjmp        fpga_set_vertex_time_low_th             ;undefined fpga_set_vertex_time_low_t...
LAB_code_000a0c:              
    cpi         R16,0x4d                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        fpga_set_trigger_mode                   ;undefined fpga_set_trigger_mode(void)
LAB_code_000a0f:              
    cpi         R16,0x56                                
    brbc        LAB_code_000a12,Zflg                    
    rjmp        LAB_code_000ad7                         
LAB_code_000a12:              
    cpi         R16,0x57                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        set_attenuator_steps                    ;undefined set_attenuator_steps(void)
LAB_code_000a15:              
    cpi         R16,0x54                                
    brbc        LAB_code_000a2a,Zflg                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x48                                
    brbc        LAB_code_000a21,Zflg                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        LAB_code_000a1e,Zflg                    
    rjmp        fpga_set_central_lvl_a                  ;undefined fpga_set_central_lvl_a(void)
LAB_code_000a1e:              
    cpi         R16,0x43                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        fpga_set_central_lvl_c                  ;undefined fpga_set_central_lvl_c(void)
LAB_code_000a21:              
    cpi         R16,0x4d                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        LAB_code_000a27,Zflg                    
    rjmp        fpga_set_semicentral_lvl_a              ;undefined fpga_set_semicentral_lvl_a...
LAB_code_000a27:              
    cpi         R16,0x43                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        fpga_set_semicentral_lvl_c              ;undefined fpga_set_semicentral_lvl_c...
LAB_code_000a2a:              
    cpi         R16,0x57                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x52                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        save_settings_to_eeprom                 ;undefined save_settings_to_eeprom(void)
usart_f0_collect_msg_line:    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
usart_f0_collect_msg_line_2:  
    cpi         R16,0xd                                 
    brbc        usart_f0_collect_msg_line,Zflg          
;; Send "Syntax error"
    ldi         Zlo,0xbe                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000a37:              
    ldi         R20,0x1                                 
LAB_code_000a38:              
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        usart_f0_collect_msg_line_2,Zflg        
    lds         R16,DAT_mem_21ad                        ;= ??
    cp          R16,R20                                 
    brbc        LAB_code_000a41,Zflg                    
    rjmp        LAB_code_000efe                         
LAB_code_000a41:              
    sts         DAT_mem_21ad,R20                        ;= ??
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a41                         
    ldi         R16,0x36                                
    sts         NVM_CMD,R16                             ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        Iflg                                    
LAB_code_000a52:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a52                         
    ldi         Ylo,0x24                                
    ldi         Yhi,0x10                                
    st          Y,R20                                   
    ldi         R16,0x35                                
    sts         NVM_CMD,R16                             ;= ??
    sts         NVM,Ylo                                 ;= ??
    sts         NVM_ADDR1,Yhi                           ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        Iflg                                    
LAB_code_000a68:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a68                         
    and         R20,R20                                 
    brbc        LAB_code_000a84,Zflg                    
    ldi         R16,0x4                                 
    sts         PORTE_OUTCLR,R16                        ;= ??
LAB_code_000a71:              
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    sbrc        R16,0x3                                 
    rjmp        LAB_code_000a71                         
    cli                                                 
    ldi         R16,0x1                                 
    sts         DAT_mem_215b,R16                        ;= ??
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        ;= ??
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x1                         
    ldi         R16,0x41                                
    sts         PORTA_OUTSET,R16                        ;= ??
    bset        Iflg                                    
LAB_code_000a84:              
    rjmp        LAB_code_000efe                         
LAB_code_000a85:              
    eor         R20,R20                                 
    rjmp        LAB_code_000a38                         
LAB_code_000a87:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_000a88:              
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000a87,Zflg                    
    cli                                                 
    lds         R16,DAT_mem_2185                        ;= ??
    ori         R16,0x20                                
    sts         DAT_mem_2185,R16                        ;= ??
    bset        Iflg                                    
usart_f0_parse_prompt_while...
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x1b                                
    brbs        usart_f0_parse_p...,Zflg                
    call        USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    rjmp        usart_f0_parse_prompt_while_not_esc     
usart_f0_parse_prompt_while...
    cli                                                 
    lds         R16,DAT_mem_2185                        ;= ??
    andi        R16,0xdf                                
    sts         DAT_mem_2185,R16                        ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000aa2:              
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000aa9,Cflg                    
    ret                                                 
LAB_code_000aa9:              
    eor         R18,R18                                 
    ldi         Ylo,0x9d                                
    ldi         Yhi,0x21                                
LAB_code_000aac:              
    cli                                                 
    call        fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        Iflg                                    
    st          Y+,R16                                  
    st          Y+,R17                                  
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        LAB_code_000aac,Zflg                    
    rjmp        LAB_code_000efe                         
LAB_code_000ab6:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000ad6,Zflg                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    mov         R20,R16                                 
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    lds         R16,DAT_clk_frs                         ;= ??
    cpi         R20,0x31                                
    brbs        LAB_code_000aca,Zflg                    
    cpi         R20,0x30                                
    brbc        LAB_code_000ad6,Zflg                    
    sbrs        R16,0x3                                 
    rjmp        LAB_code_000efe                         
    cli                                                 
    ldi         R16,0xa                                 
    eor         R17,R17                                 
    rjmp        LAB_code_000acf                         
LAB_code_000aca:              
    sbrc        R16,0x3                                 
    rjmp        LAB_code_000efe                         
    cli                                                 
    ldi         R16,0x2                                 
    ldi         R17,0x8                                 
LAB_code_000acf:              
    sts         PORTF_INTCTRL,R16                       ;= ??
    sts         DAT_clk_frs,R17                         ;= ??
    rcall       reset_system                            ;undefined reset_system(void)
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000ad6:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_000ad7:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000ad6,Zflg                    
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        LAB_code_000ad6,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000ae1,Cflg                    
    ret                                                 
LAB_code_000ae1:              
    sts         ARRAY_BOARD_SN,R20                      ;= ??
    sts         ARRAY_BOARD_SN[1],R21                   
    ldi         R18,0x17                                
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000aeb:              
    rcall       unlock_programming                      ;undefined unlock_programming(void)
    brbs        LAB_code_000ad6,Cflg                    
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         Zlo,R16                                 
    mov         R20,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         Zhi,R16                                 
    mov         R21,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R22,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R3,R16                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R4,R16                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R5,R16                                  
    cpi         R22,0x2                                 
    brbc        LAB_code_000ad6,Sflg                    
    cp          R3,Zlo                                  
    cpc         R4,Zhi                                  
    cpc         R5,R22                                  
    brbs        LAB_code_000ad6,Cflg                    
    cli                                                 
    sts         RAMPZ,R22                               
    rcall       system_reset_2                          ;undefined system_reset_2(void)
    eor         R16,R16                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    sts         TCC0_INTCTRLA,R16                       ;= ??
    ldi         R16,0x4                                 
    sts         PORTE_OUTCLR,R16                        ;= ??
    ldi         R16,0x43                                
    ldi         R17,0xd8                                
    sts         CPU_CCP,R17                             ;= ??
    sts         PMIC_CTRL,R16                           ;= ??
    ldi         R16,0x26                                
    sts         NVM_CMD,R16                             ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        Iflg                                    
    jmp         xmega_firmware_update                   ;undefined xmega_firmware_update(void)
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined unlock_programming(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000b2f,Zflg                    
    ldi         Zlo,0x74                                
    ldi         Zhi,0x2b                                
LAB_code_000b24:              
    lpm         R17,Z+                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    cp          R16,R17                                 
    brbc        LAB_code_000b2f,Zflg                    
    cpi         Zlo,0x7c                                
    brbc        LAB_code_000b24,Zflg                    
    ldi         Zlo,0xce                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    clc                                                 
    ret                                                 
LAB_code_000b2f:              
    bset        Cflg                                    
    ret                                                 
LAB_code_000b31:              
    rjmp        usart_f0_collect_msg_line_2             
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_firmware_update(void)
    rcall       unlock_programming                      ;undefined unlock_programming(void)
    brbs        LAB_code_000b31,Cflg                    
    ldi         R16,0x2                                 
    sts         PORTD_OUTCLR,R16                        ;= ??
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    ldi         R16,0xb0                                
    sts         PORTE_DIRSET,R16                        ;= ??
    ldi         R16,0x50                                
    sts         SPIE,R16                                ;= ??
    eor         R16,R16                                 
    ldi         Xlo,0xae                                
    ldi         Xhi,0x23                                
    st          X+,R16                                  
    st          X+,R16                                  
    st          X+,R16                                  
    st          X,R16                                   
    rcall       fpga_get_fl_type_and_code_size          ;undefined fpga_get_fl_type_and_code_...
    eor         R17,R17                                 
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    movw        R17R16,R19R18                           
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    rcall       usart_f0_send_cr                        ;undefined usart_f0_send_cr(void)
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         Ylo,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         Yhi,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         Zlo,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R0,R16                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R1,R16                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R2,R16                                  
    movw        R21R20,Y                                
    mov         R22,Zlo                                 
LAB_code_000b5b:              
    rcall       FUN_code_000bd2                         ;undefined FUN_code_000bd2(void)
LAB_code_000b5c:              
    mov         R17,R0                                  
    mov         R18,R1                                  
    mov         R19,R2                                  
    ldi         R16,0x1                                 
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    sub         R17,R20                                 
    sbc         R18,R21                                 
    sbc         R19,R22                                 
    subi        R17,0xff                                
    sbci        R18,0xff                                
    sbci        R19,0xff                                
    or          R18,R19                                 
    brbs        LAB_code_000b6a,Zflg                    
    eor         R17,R17                                 
LAB_code_000b6a:              
    lds         R24,DAT_mem_23ae                        ;= ??
    lds         R25,DAT_mem_23af                        ;= ??
LAB_code_000b6e:              
    ldi         Xlo,0xae                                
    ldi         Xhi,0x21                                
    add         Xlo,R24                                 
    adc         Xhi,R25                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    st          X,R16                                   
    adiw        R25R24,0x1                              
    andi        R25,0x1                                 
    dec         R17                                     
    brbc        LAB_code_000b6e,Zflg                    
    sts         DAT_mem_23ae,R24                        ;= ??
    sts         DAT_mem_23af,R25                        ;= ??
    rcall       FUN_code_000be7                         ;undefined FUN_code_000be7(void)
    rcall       FUN_code_000ba3                         ;undefined FUN_code_000ba3(void)
    brbs        LAB_code_000b83,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000b5c,Zflg                    
    rcall       FUN_code_000be7                         ;undefined FUN_code_000be7(void)
    rjmp        LAB_code_000b5b                         
LAB_code_000b83:              
    rcall       FUN_code_000be7                         ;undefined FUN_code_000be7(void)
    rcall       FUN_code_000c03                         ;undefined FUN_code_000c03(undefined2...
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    movw        R17R16,R19R18                           
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    rcall       usart_f0_send_cr                        ;undefined usart_f0_send_cr(void)
    cli                                                 
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       ;= ??
    ldi         R16,0x2                                 
    sts         PORTF_INTCTRL,R16                       ;= ??
    eor         R16,R16                                 
    sts         PORTC_INTCTRL,R16                       ;= ??
    sts         PORTD_INTCTRL,R16                       ;= ??
    sts         SPIE,R16                                ;= ??
    ldi         R16,0xb0                                
    sts         PORTE_DIRCLR,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x1                         
    ldi         R16,0x1                                 
    sts         PORTA_OUTSET,R16                        ;= ??
    ldi         R16,0x2                                 
    sts         DAT_mem_215b,R16                        ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000ba3(void)
    rcall       fpga_set_write_mode                     ;undefined fpga_set_write_mode(void)
    ldi         R16,0x2                                 
    rcall       fpga_write_mem                          ;undefined fpga_write_mem(undefined2 ...
    lds         R24,DAT_mem_23b0                        ;= ??
    lds         R25,DAT_mem_23b1                        ;= ??
LAB_code_000baa:              
    ldi         Xlo,0xae                                
    ldi         Xhi,0x21                                
    add         Xlo,R24                                 
    adc         Xhi,R25                                 
    ld          R16,X                                   
    adiw        R25R24,0x1                              
    andi        R25,0x1                                 
    sts         SPIE_DATA,R16                           ;= ??
LAB_code_000bb3:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bb3                         
    cp          R0,R20                                  
    cpc         R1,R21                                  
    cpc         R2,R22                                  
    brbc        LAB_code_000bc4,Zflg                    
    sts         DAT_mem_23b0,R24                        ;= ??
    sts         DAT_mem_23b1,R25                        ;= ??
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    bset        Cflg                                    
    ret                                                 
LAB_code_000bc4:              
    subi        R20,0xff                                
    sbci        R21,0xff                                
    sbci        R22,0xff                                
    and         R20,R20                                 
    brbc        LAB_code_000baa,Zflg                    
    sts         DAT_mem_23b0,R24                        ;= ??
    sts         DAT_mem_23b1,R25                        ;= ??
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    clc                                                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000bd2(void)
    rcall       fpga_set_write_mode                     ;undefined fpga_set_write_mode(void)
    ldi         R16,0xd8                                
    rcall       fpga_write_mem                          ;undefined fpga_write_mem(undefined2 ...
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_write_mode(void)
    ldi         R16,0x10                                
    sts         PORTE_OUTCLR,R16                        ;= ??
    ldi         R16,0x6                                 
    sts         SPIE_DATA,R16                           ;= ??
LAB_code_000bdf:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bdf                         
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000be7(void)
    ldi         R24,0x40                                
    ldi         R25,0x6                                 
LAB_code_000be9:              
    sbiw        R25R24,0x1                              
    brbc        LAB_code_000be9,Zflg                    
    ldi         R16,0x10                                
    sts         PORTE_OUTCLR,R16                        ;= ??
    ldi         R16,0x5                                 
    sts         SPIE_DATA,R16                           ;= ??
LAB_code_000bf1:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bf1                         
    sts         SPIE_DATA,R24                           ;= ??
LAB_code_000bf7:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bf7                         
    lds         R24,SPIE_DATA                           ;= ??
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    sbrc        R24,0x0                                 
    rjmp        FUN_code_000be7                         
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000c03(undefined2 param_1, undefined2 param_2, undefined2 param_3)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
    ldi         R16,0x10                                
    sts         PORTE_OUTCLR,R16                        ;= ??
caseD_58:                     
    ldi         R16,0x3                                 
    sts         SPIE_DATA,R16                           ;= ??
    eor         R10,R10                                 
LAB_code_000c0a:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c0a                         
    sts         SPIE_DATA,Zlo                           ;= ??
LAB_code_000c10:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c10                         
    sts         SPIE_DATA,Yhi                           ;= ??
LAB_code_000c16:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c16                         
    sts         SPIE_DATA,Ylo                           ;= ??
    ser         R16                                     
    ser         R17                                     
    ser         R18                                     
    ser         R19                                     
    ldi         param_2,0xb7                            
    ldi         param_1,0x1d                            
    ldi         param_1,0xc1                            
    ldi         Xlo,0x4                                 
LAB_code_000c24:              
    lds         param_2,SPIE_STATUS                     ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000c24                         
OFF_code_000c28:              
    sts         SPIE_DATA,R10                           ;= ??
LAB_code_000c2a:              
    lds         param_2,SPIE_STATUS                     ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000c2a                         
    lds         param_2,SPIE_DATA                       ;= ??
    cp          R0,Ylo                                  
    cpc         R1,Yhi                                  
    cpc         R2,Zlo                                  
    brbs        LAB_code_000c3a,Zflg                    
    sts         SPIE_DATA,R10                           ;= ??
    rcall       FUN_code_000c3c                         ;undefined FUN_code_000c3c(undefined2...
    adiw        Y,0x1                                   
    adc         Zlo,R10                                 
    rjmp        LAB_code_000c2a                         
LAB_code_000c3a:              
    rcall       FUN_code_000c3c                         ;undefined FUN_code_000c3c(undefined2...
    rjmp        LAB_code_000c8d                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000c3c(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, undefined2 param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       undefined2      R17R16                      
    ldi         param_3,0x8                             
LAB_code_000c3d:              
    add         param_4,param_4                         
    adc         param_4,param_4                         
    adc         param_5,param_5                         
    adc         param_5,param_5                         
    brbc        LAB_code_000c45,Cflg                    
    lsr         param_2                                 
    brbs        LAB_code_000c4b,Cflg                    
    rjmp        LAB_code_000c47                         
LAB_code_000c45:              
    lsr         param_2                                 
    brbc        LAB_code_000c4b,Cflg                    
LAB_code_000c47:              
    eor         param_4,param_2                         
    eor         param_4,param_1                         
    eor         param_5,param_1                         
    eor         param_5,Xlo                             
LAB_code_000c4b:              
    dec         param_3                                 
    brbc        LAB_code_000c3d,Zflg                    
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_write_mem(undefined2 param_1, undefined param_2, undefined2 param_3, undefined2 param_4, undefined unaff_R16)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined          R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;unaff_R16     undefined          R16                      
    ldi         R17,0x10                                
    sts         PORTE_OUTCLR,R17                        ;= ??
    sts         SPIE_DATA,unaff_R16                     ;= ??
LAB_code_000c53:              
    lds         param_4,SPIE_STATUS                     ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c53                         
    sts         SPIE_DATA,param_2                       ;= ??
LAB_code_000c59:              
    lds         param_4,SPIE_STATUS                     ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c59                         
    sts         SPIE_DATA,param_3                       ;= ??
LAB_code_000c5f:              
    lds         param_4,SPIE_STATUS                     ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c5f                         
    sts         SPIE_DATA,param_3                       ;= ??
LAB_code_000c65:              
    lds         param_4,SPIE_STATUS                     ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c65                         
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_get_fl_type_and_code_size(void)
    ldi         R16,0x10                                
    sts         PORTE_OUTCLR,R16                        ;= ??
    ldi         R16,0x9f                                
    sts         SPIE_DATA,R16                           ;= ??
    eor         R20,R20                                 
LAB_code_000c71:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c71                         
    sts         SPIE_DATA,R20                           ;= ??
LAB_code_000c77:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c77                         
    lds         R18,SPIE_DATA                           ;= ??
    sts         SPIE_DATA,R20                           ;= ??
LAB_code_000c7f:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c7f                         
    lds         R19,SPIE_DATA                           ;= ??
    sts         SPIE_DATA,R20                           ;= ??
LAB_code_000c87:              
    lds         R20,SPIE_STATUS                         ;= ??
    sbrs        R20,0x7                                 
    rjmp        LAB_code_000c87                         
    lds         R16,SPIE_DATA                           ;= ??
LAB_code_000c8d:              
    ldi         R20,0x10                                
    sts         PORTE_OUTSET,R20                        ;= ??
    ret                                                 
LAB_code_000c91:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_system_params(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000c91,Zflg                    
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_signed_16                  ;undefined usartf0_send_signed_16(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_signed_16                  ;undefined usartf0_send_signed_16(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_signed_16                  ;undefined usartf0_send_signed_16(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_attenuator_settings        ;undefined usartf0_send_attenuator_se...
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    eor         R17,R17                                 
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    rcall       usart_f0_send_cr                        ;undefined usart_f0_send_cr(void)
    adiw        Y,0x1                                   
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_signed_16                  ;undefined usartf0_send_signed_16(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_signed_16                  ;undefined usartf0_send_signed_16(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_unsigned_16                ;undefined usartf0_send_unsigned_16(v...
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_unsigned_16                ;undefined usartf0_send_unsigned_16(v...
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_unsigned_16                ;undefined usartf0_send_unsigned_16(v...
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    rcall       usartf0_send_unsigned_16                ;undefined usartf0_send_unsigned_16(v...
    ldi         R16,0x20                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Y+                                  
    eor         R17,R17                                 
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    rcall       usart_f0_send_cr                        ;undefined usart_f0_send_cr(void)
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_semicentral_lvl_a(void)
    ldi         Ylo,0xa1                                
    ldi         Yhi,0x21                                
    ldi         R18,0x2                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_semicentral_lvl_c(void)
    ldi         Ylo,0xa3                                
    ldi         Yhi,0x21                                
    ldi         R18,0x3                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_central_lvl_a(void)
    ldi         Ylo,0xa5                                
    ldi         Yhi,0x21                                
    ldi         R18,0x4                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_central_lvl_c(void)
    ldi         Ylo,0xa7                                
    ldi         Yhi,0x21                                
    ldi         R18,0x5                                 
LAB_code_000ce2:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000d13,Zflg                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000d13,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000d13,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000cec,Cflg                    
    ret                                                 
LAB_code_000cec:              
    st          Y+,R20                                  
    st          Y+,R21                                  
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_vertex_time_high_th(void)
    ldi         Ylo,0x9f                                
    ldi         Yhi,0x21                                
    ldi         R18,0x1                                 
    rjmp        LAB_code_000cfa                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_vertex_time_low_th(void)
    ldi         Ylo,0x9d                                
    ldi         Yhi,0x21                                
    ldi         R18,0x0                                 
LAB_code_000cfa:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000d13,Zflg                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000d13,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000d13,Zflg                    
    ldi         R17,0xfe                                
    cpi         R20,0x0                                 
    cpc         R21,R17                                 
    brbs        LAB_code_000d13,Sflg                    
    ldi         R17,0x2                                 
    cpi         R20,0x0                                 
    cpc         R21,R17                                 
    brbc        LAB_code_000d13,Sflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000d0c,Cflg                    
    ret                                                 
LAB_code_000d0c:              
    st          Y+,R20                                  
    st          Y+,R21                                  
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000d13:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined save_settings_to_eeprom(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000d13,Zflg                    
LAB_code_000d17:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d17                         
    ldi         R16,0x36                                
    sts         NVM_CMD,R16                             ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        Iflg                                    
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    ser         Ylo                                     
    ldi         Yhi,0xf                                 
    ldi         R20,0x21                                
LAB_code_000d2b:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d2b                         
    eor         R19,R19                                 
LAB_code_000d30:              
    adiw        Y,0x1                                   
    ld          R16,Z+                                  
    ld          R17,Y                                   
    eor         R17,R16                                 
    brbs        LAB_code_000d37,Zflg                    
    st          Y,R16                                   
    ldi         R19,0x1                                 
LAB_code_000d37:              
    cpi         Zlo,0xae                                
    cpc         Zhi,R20                                 
    brbs        LAB_code_000d40,Zflg                    
    mov         R18,Ylo                                 
    andi        R18,0x1f                                
    cpi         R18,0x1f                                
    brbc        LAB_code_000d30,Zflg                    
    rcall       FUN_code_000d42                         ;undefined FUN_code_000d42(void)
    rjmp        LAB_code_000d30                         
LAB_code_000d40:              
    rcall       FUN_code_000d42                         ;undefined FUN_code_000d42(void)
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000d42(void)
    and         R19,R19                                 
    brbs        LAB_code_000d58,Zflg                    
    ldi         R16,0x35                                
    sts         NVM_CMD,R16                             ;= ??
    sts         NVM,Ylo                                 ;= ??
    sts         NVM_ADDR1,Yhi                           ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        Iflg                                    
LAB_code_000d53:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d53                         
    eor         R19,R19                                 
LAB_code_000d58:              
    ret                                                 
LAB_code_000d59:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_system_status(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000d59,Zflg                    
    ldi         Zlo,0x54                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    lds         R16,ARRAY_BOARD_SN                      ;= ??
    lds         R17,ARRAY_BOARD_SN[1]                   
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    ldi         Zlo,0x60                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x7c                                
    ldi         Zhi,0x2b                                
    lpm         R18,Z+                                  
    lpm         R19,Z+                                  
    lpm         R16,Z+                                  
    lpm         R17,Z+                                  
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    movw        R17R16,R19R18                           
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    ldi         Zlo,0xdc                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    cli                                                 
    lds         R18,DAT_b_porte_1_5v_present            ;= ??
    lds         R16,DAT_mem_2160                        ;= ??
    lds         R17,DAT_mem_2161                        ;= ??
    lds         R20,PORTE_IN                            ;= ??
    bset        Iflg                                    
    ldi         Zlo,0xce                                
    ldi         Zhi,0x29                                
    sbrc        R18,0x0                                 
    rjmp        LAB_code_000d84                         
    ldi         Zlo,0xd4                                
    ldi         Zhi,0x29                                
LAB_code_000d84:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    mov         R19,R18                                 
    ldi         Zlo,0xf6                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rcall       uartf0_send_temperature                 ;undefined uartf0_send_temperature(void)
    ldi         Zlo,0x4                                 
    ldi         Zhi,0x2a                                
    andi        R19,0x6                                 
    brbs        LAB_code_000d98,Zflg                    
    ldi         Zlo,0x18                                
    ldi         Zhi,0x2a                                
    cpi         R19,0x6                                 
    brbs        LAB_code_000d98,Zflg                    
    ldi         Zlo,0x12                                
    ldi         Zhi,0x2a                                
    andi        R19,0x4                                 
    brbc        LAB_code_000d98,Zflg                    
    ldi         Zlo,0xc                                 
    ldi         Zhi,0x2a                                
LAB_code_000d98:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x22                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    sbrc        R20,0x2                                 
    rjmp        LAB_code_000da2                         
    ldi         Zlo,0x38                                
    ldi         Zhi,0x2a                                
LAB_code_000da0:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000da2:              
    ldi         Zlo,0x32                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0xce                                
    ldi         Zhi,0x29                                
    sbrc        R18,0x3                                 
    rjmp        LAB_code_000dae                         
    ldi         Zlo,0xd4                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    sbrs        R18,0x6                                 
    ret                                                 
LAB_code_000dae:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x5e                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    lds         R19,DAT_clk_frs                         ;= ??
    ldi         Zlo,0x6c                                
    ldi         Zhi,0x2a                                
    sbrc        R19,0x1                                 
    rjmp        LAB_code_000dc3                         
    ldi         Zlo,0x74                                
    ldi         Zhi,0x2a                                
    sbrc        R19,0x2                                 
    rjmp        LAB_code_000dc3                         
    ldi         Zlo,0x7e                                
    ldi         Zhi,0x2a                                
    sbrs        R19,0x3                                 
    rjmp        LAB_code_000dc3                         
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x88                                
    ldi         Zhi,0x2a                                
LAB_code_000dc3:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x92                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x9a                                
    ldi         Zhi,0x2a                                
    sbrs        R19,0x0                                 
    rjmp        LAB_code_000dcd                         
    ldi         Zlo,0x9e                                
    ldi         Zhi,0x2a                                
LAB_code_000dcd:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0xba                                
    ldi         Zhi,0x2a                                
    sbrc        R18,0x4                                 
    rjmp        LAB_code_000dd5                         
    ldi         Zlo,0xa8                                
    ldi         Zhi,0x2a                                
    rjmp        LAB_code_000da0                         
LAB_code_000dd5:              
    lds         R20,DAT_mem_2158                        ;= ??
    ldi         Zlo,0xd0                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0xe2                                
    ldi         Zhi,0x2a                                
    sbrc        R20,0x2                                 
    rjmp        LAB_code_000de0                         
    ldi         Zlo,0x38                                
    ldi         Zhi,0x2a                                
LAB_code_000de0:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0xea                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x38                                
    ldi         Zhi,0x2a                                
    sbrc        R20,0x0                                 
    rjmp        LAB_code_000dea                         
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_000df4                         
LAB_code_000dea:              
    ldi         Zlo,0x32                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0xf4                                
    ldi         Zhi,0x2a                                
    sbrs        R20,0x1                                 
    rjmp        LAB_code_000df3                         
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x2b                                
LAB_code_000df3:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
LAB_code_000df4:              
    ldi         Zlo,0x10                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    ldd         R16,Z+0x2                               
    rcall       send_usartf0_ipaddr_octet               ;undefined send_usartf0_ipaddr_octet(...
    ldi         R16,0x2e                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldd         R16,Z+0x3                               
    rcall       send_usartf0_ipaddr_octet               ;undefined send_usartf0_ipaddr_octet(...
    ldi         R16,0x2e                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ld          R16,Z                                   
    rcall       send_usartf0_ipaddr_octet               ;undefined send_usartf0_ipaddr_octet(...
    ldi         R16,0x2e                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldd         R16,Z+0x1                               
    rcall       send_usartf0_ipaddr_octet               ;undefined send_usartf0_ipaddr_octet(...
    ldi         Zlo,0x1e                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x93                                
    ldi         Zhi,0x21                                
LAB_code_000e0c:              
    ld          R16,-Z                                  
    ld          R17,-Z                                  
    call        usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    cpi         Zlo,0x8d                                
    brbs        LAB_code_000e15,Zflg                    
    ldi         R16,0x3a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_000e0c                         
LAB_code_000e15:              
    ldi         Zlo,0xba                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000e19:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined resolve_ca_msg(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000e19,Zflg                    
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    in          R17,GPIO_GPIOR0                         
    andi        R17,0x3                                 
    brbc        LAB_code_000e2c,Zflg                    
    lds         R16,DAT_mem_2158                        ;= ??
    andi        R16,0xfd                                
    sts         DAT_mem_2158,R16                        ;= ??
    bset        Iflg                                    
    ldi         Zlo,0x3e                                
    ldi         Zhi,0x2a                                
    rjmp        LAB_code_000e4f                         
LAB_code_000e2c:              
    andi        R16,0x7                                 
    cpi         R16,0x1                                 
    brbs        LAB_code_000e33,Zflg                    
    bset        Iflg                                    
    ldi         Zlo,0xd4                                
    ldi         Zhi,0x29                                
    rjmp        LAB_code_000e4f                         
LAB_code_000e33:              
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
caseD_86:                     
    andi        R16,0x1f                                
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    eor         R16,R16                                 
    sts         DAT_mem_2158,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         DAT_mem_215b,R16                        ;= ??
    ldi         R16,000000000000000000000100b           
    sts         PORTE_OUTCLR,R16                        ;= ??
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        ;= ??
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x1                         
    ldi         R16,000000000000000001000001b           
    sts         PORTA_OUTSET,R16                        ;= ??
    bset        Iflg                                    
;; Send "OK"
    ldi         Zlo,0xce                                
    ldi         Zhi,0x29                                
LAB_code_000e4f:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000e51:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_IP_addr(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000e51,Zflg                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0x2e                                
    brbc        LAB_code_000e51,Zflg                    
    mov         R0,R20                                  
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0x2e                                
    brbc        LAB_code_000e51,Zflg                    
    mov         R1,R20                                  
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0x2e                                
    brbc        LAB_code_000e51,Zflg                    
    mov         R2,R20                                  
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000e51,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000e73,Cflg                    
    ret                                                 
LAB_code_000e73:              
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    st          Z+,R2                                   
    st          Z+,R20                                  
    st          Z+,R0                                   
    st          Z,R1                                    
    cli                                                 
    rcall       fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_mac_addr(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000e51,Zflg                    
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        LAB_code_000e51,Cflg                    
    cpi         R16,0x3a                                
    brbc        LAB_code_000e51,Zflg                    
    movw        R1R0,R21R20                             
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        LAB_code_000e9d,Cflg                    
    cpi         R16,0x3a                                
    brbc        LAB_code_000e51,Zflg                    
    movw        R3R2,R21R20                             
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        LAB_code_000e51,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000e9d,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000e91,Cflg                    
    ret                                                 
LAB_code_000e91:              
    ldi         Zlo,0x8d                                
    ldi         Zhi,0x21                                
    st          Z+,R21                                  
    st          Z+,R20                                  
    st          Z+,R3                                   
    st          Z+,R2                                   
    st          Z+,R1                                   
    st          Z+,R0                                   
    cli                                                 
    rcall       fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000e9d:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_trigger_mode(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000e9d,Zflg                    
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        LAB_code_000e9d,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000e9d,Zflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e9d,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000eaa,Cflg                    
    ret                                                 
LAB_code_000eaa:              
    sts         DAT_mem_21a9,R20                        ;= ??
    mov         R16,R20                                 
    ldi         R18,0x6                                 
    eor         R17,R17                                 
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_switches(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000ed9,Zflg                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x30                                
    brbs        LAB_code_000ed9,Cflg                    
    cpi         R16,0x3a                                
    brbs        LAB_code_000ec0,Cflg                    
    cpi         R16,0x41                                
    brbs        LAB_code_000ed9,Cflg                    
    cpi         R16,0x47                                
    brbc        LAB_code_000ed9,Cflg                    
    subi        R16,0x7                                 
LAB_code_000ec0:              
    subi        R16,0x30                                
    mov         R20,R16                                 
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        LAB_code_000ed9,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000ec8,Cflg                    
    ret                                                 
LAB_code_000ec8:              
    sts         DAT_portb_setup,R20                     ;= ??
    mov         R16,R20                                 
    cli                                                 
    lds         R17,PORTB_OUT                           ;= ??
    andi        R17,0x90                                
    or          R20,R17                                 
    sts         PORTB_OUT,R20                           ;= ??
    bset        Iflg                                    
    ldi         R18,0x14                                
    eor         R17,R17                                 
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000ed9:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_laser_phase(void)
    ldi         Ylo,0x97                                
    ldi         Yhi,0x21                                
    ldi         R18,0x12                                
    rjmp        LAB_code_000ee5                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_c_side_phase(void)
    ldi         Ylo,0x95                                
    ldi         Yhi,0x21                                
    ldi         R18,0x11                                
    rjmp        LAB_code_000ee5                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_a_side_phase(void)
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         R18,0x10                                
LAB_code_000ee5:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000f02,Zflg                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000f02,Cflg                    
    cpi         R16,0xd                                 
    ldi         R17,0xfc                                
    cpi         R20,0x0                                 
    cpc         R21,R17                                 
    brbs        LAB_code_000f02,Sflg                    
    ldi         R17,0x4                                 
    cpi         R20,0x1                                 
    cpc         R21,R17                                 
    brbc        LAB_code_000f02,Sflg                    
    brbc        LAB_code_000f02,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000ef7,Cflg                    
    ret                                                 
LAB_code_000ef7:              
    cli                                                 
    st          Y+,R20                                  
    st          Y+,R21                                  
    sbi         GPIO_GPIOR0,0x5                         
    movw        R17R16,R21R20                           
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
;; Send "OK"
LAB_code_000efe:              
    ldi         Zlo,0xce                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000f02:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
LAB_code_000f03:              
    rjmp        usart_f0_collect_msg_line_2             
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined set_attenuator_steps(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        LAB_code_000f02,Zflg                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        LAB_code_000f02,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000f02,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000f0e,Cflg                    
    ret                                                 
LAB_code_000f0e:              
    ldi         R17,0x2e                                
    cpi         R20,0xe1                                
    cpc         R21,R17                                 
    brbc        LAB_code_000f03,Cflg                    
    ldi         Ylo,0x99                                
    ldi         Yhi,0x21                                
    cli                                                 
    ld          R16,Y                                   
    ldd         R17,Y+0x1                               
    cp          R16,R20                                 
    cpc         R17,R21                                 
    brbs        LAB_code_000f37,Zflg                    
    st          Y,R20                                   
    std         Y+0x1,R21                               
    movw        R17R16,R21R20                           
    lds         R18,DAT_mem_2185                        ;= ??
    and         R18,R18                                 
    brbs        LAB_code_000f2a,Zflg                    
    brbc        LAB_code_000f2e,Nflg                    
    ori         R17,0x80                                
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    ldi         Zlo,0x38                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000f2a:              
    sts         DAT_mem_2186,R20                        ;= ??
    sts         DAT_mem_2187,R21                        ;= ??
LAB_code_000f2e:              
    ori         R17,0x40                                
    ldi         R18,0x13                                
;Send attenuator busy
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        Iflg                                    
    mov         R17,R21                                 
    rcall       attenuator_set_steps                    ;undefined attenuator_set_steps(void)
    ldi         R16,0x48                                
    sts         DAT_mem_2185,R16                        ;= ??
LAB_code_000f37:              
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined is_fpga_ready(void)
    clc                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    sbrc        R16,0x4                                 
    ret                                                 
;; Send "FPGA not ready"
    ldi         Zlo,0xa8                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    bset        Cflg                                    
    ret                                                 
    align       align(1)                                
    ??          27h    '                                
    ??          24h    $                                
    ??          9Fh                                     
    ??          07h                                     
    ??          FCh                                     
    ??          13h                                     
    ??          94h                                     
    ??          01h                                     
    ??          2Dh    -                                
    ??          34h    4                                
    ??          9Fh                                     
    ??          00h                                     
    ??          0Dh                                     
    ??          11h                                     
    ??          1Dh                                     
    ??          52h    R                                
    ??          03h                                     
    ??          00h                                     
    ??          0Dh                                     
    ??          11h                                     
    ??          1Dh                                     
    ??          53h    S                                
    ??          03h                                     
    ??          10h                                     
    ??          0Dh                                     
    ??          08h                                     
    ??          95h                                     
    ??          11h                                     
    ??          27h    '                                
    ??          24h    $                                
    ??          9Fh                                     
    ??          07h                                     
    ??          FCh                                     
    ??          13h                                     
    ??          94h                                     
    ??          01h                                     
    ??          2Dh    -                                
    ??          34h    4                                
    ??          9Fh                                     
    ??          00h                                     
    ??          0Dh                                     
    ??          11h                                     
    ??          1Dh                                     
    ??          25h    %                                
    ??          9Fh                                     
    ??          00h                                     
    ??          0Dh                                     
    ??          11h                                     
    ??          1Dh                                     
    ??          35h    5                                
    ??          9Fh                                     
    ??          11h                                     
    ??          20h                                     
    ??          19h                                     
    ??          F4h                                     
    ??          10h                                     
    ??          0Dh                                     
    ??          08h                                     
    ??          F0h                                     
    ??          08h                                     
    ??          95h                                     
    ??          0Fh                                     
    ??          EFh                                     
    ??          1Fh                                     
    ??          EFh                                     
    ??          08h                                     
    ??          95h                                     
;************************************************************************************************
;*  @brief set fpga setting (type 2)                                                            *
;*                                                                                              *
;*  This function sends 2B of data to FPGA                                                      *
;*  without reading back                                                                        *
;************************************************************************************************
;void fpga_send_msg_t2(undefined param_1, undefined2 param_2)
          ;param_1       undefined          R18                      
          ;param_2       undefined2      R17R16                      
    push        param_1                                 
    push        R21                                     
    push        R22                                     
    ldi         R22,0xd1                                
    sts         SPIC,R22                                ;= ??
    eor         R21,R21                                 
    lsr         param_1                                 
    ror         R21                                     
    lsr         param_1                                 
    ror         R21                                     
    ldi         R22,0x1                                 
    sts         PORTD_OUTCLR,R22                        ;= ??
    sts         SPIC_DATA,param_1                       ;= ??
fpga_send_msg_t2_st_ready_1:  
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_1             
    sts         SPIC_DATA,R21                           ;= ??
fpga_send_msg_t2_st_ready_2:  
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_2             
    sts         SPIC_DATA,param_2                       ;= ??
fpga_send_msg_t2_st_ready_3:  
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_3             
    sts         SPIC_DATA,param_2                       ;= ??
fpga_send_msg_t2_st_ready_4:  
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_4             
    ldi         R22,0x1                                 
    sts         PORTD_OUTSET,R22                        ;= ??
    pop         R22                                     
    pop         R21                                     
    pop         param_1                                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_send_msg_t1(undefined2 param_1, undefined2 param_2, undefined2 param_3, byte param_4, undefined2 param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       byte               R18                      
          ;param_5       undefined2      R17R16                      
    push        param_4                                 
    push        param_3                                 
    push        param_2                                 
    ldi         param_2,0xd1                            
    sts         SPIC,param_2                            ;= ??
    ldi         param_2,0x1                             
    lsr         param_4                                 
    ror         param_3                                 
    lsr         param_4                                 
    ror         param_3                                 
    ori         param_4,0x80                            
    sts         PORTD_OUTCLR,param_2                    ;= ??
    sts         SPIC_DATA,param_4                       ;= ??
LAB_code_000fa2:              
    lds         param_2,SPIC_STATUS                     ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000fa2                         
    sts         SPIC_DATA,param_3                       ;= ??
LAB_code_000fa8:              
    lds         param_2,SPIC_STATUS                     ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000fa8                         
    sts         SPIC_DATA,param_5                       ;= ??
LAB_code_000fae:              
    lds         param_2,SPIC_STATUS                     ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000fae                         
    lds         param_5,SPIC_DATA                       ;= ??
    sts         SPIC_DATA,param_5                       ;= ??
LAB_code_000fb6:              
    lds         param_2,SPIC_STATUS                     ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000fb6                         
    lds         param_5,SPIC_DATA                       ;= ??
    ldi         param_2,0x1                             
    sts         PORTD_OUTSET,param_2                    ;= ??
    pop         param_2                                 
    pop         param_3                                 
    pop         param_4                                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_send_msg_t3(void)
    push        R18                                     
    push        R21                                     
    push        R22                                     
    ldi         Ylo,0x89                                
    ldi         Yhi,0x21                                
    ldi         R22,0xd1                                
    sts         SPIC,R22                                ;= ??
    ldi         R18,0x3c                                
    eor         R21,R21                                 
    ldi         R22,0x1                                 
    sts         PORTD_OUTCLR,R22                        ;= ??
    sts         SPIC_DATA,R18                           ;= ??
LAB_code_000fd2:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000fd2                         
    sts         SPIC_DATA,R21                           ;= ??
LAB_code_000fd8:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000fd8                         
LAB_code_000fdc:              
    ld          R18,Y+                                  
    sts         SPIC_DATA,R18                           ;= ??
LAB_code_000fdf:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000fdf                         
    cpi         Ylo,0x93                                
    brbc        LAB_code_000fdc,Zflg                    
    ldi         R22,0x1                                 
    sts         PORTD_OUTSET,R22                        ;= ??
    pop         R22                                     
    pop         R21                                     
    pop         R18                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_send_mcu_ts(void)
    push        R18                                     
    push        R21                                     
    push        R22                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Zlo,0x7c                                
    ldi         Zhi,0x2b                                
    ldi         R22,0xd1                                
    sts         SPIC,R22                                ;= ??
    ldi         R18,0x3d                                
    ldi         R21,0x40                                
    ldi         R22,0x1                                 
    sts         PORTD_OUTCLR,R22                        ;= ??
    sts         SPIC_DATA,R18                           ;= ??
LAB_code_000ffd:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000ffd                         
    sts         SPIC_DATA,R21                           ;= ??
LAB_code_001003:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_001003                         
LAB_code_001007:              
    lpm         R18,Z+                                  
    lpm         R21,Z+                                  
    sts         SPIC_DATA,R21                           ;= ??
LAB_code_00100b:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_00100b                         
    sts         SPIC_DATA,R18                           ;= ??
LAB_code_001011:              
    lds         R22,SPIC_STATUS                         ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_001011                         
    cpi         Zlo,0x80                                
    brbc        LAB_code_001007,Zflg                    
    ldi         R22,0x1                                 
    sts         PORTD_OUTSET,R22                        ;= ??
    pop         Zhi                                     
    pop         Zlo                                     
    pop         R22                                     
    pop         R21                                     
    pop         R18                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined adt7311_send_1_byte(void)
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        R19                                     
    ldi         R18,0x10                                
    sts         PORTA_OUTCLR,R18                        ;= ??
    mov         R19,R17                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    mov         R16,R19                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    ldi         R18,0x10                                
    sts         PORTA_OUTSET,R18                        ;= ??
    pop         R19                                     
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined adt7311_send_2_bytes(void)
    push        R16                                     
caseD_82:                     
    push        R17                                     
    push        R18                                     
    ldi         R20,0x10                                
    sts         PORTA_OUTCLR,R20                        ;= ??
    mov         R20,R17                                 
    mov         R21,R18                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    mov         R16,R21                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    mov         R21,R16                                 
caseD_98:                     
    mov         R16,R20                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    mov         R20,R16                                 
    ldi         R18,0x10                                
    sts         PORTA_OUTSET,R18                        ;= ??
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined adt7311_clear_faults(void)
    ldi         R16,0x10                                
caseD_ae:                     
    sts         PORTA_OUTCLR,R16                        ;= ??
    ser         R16                                     
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    ser         R16                                     
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    ser         R16                                     
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    ser         R16                                     
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    ldi         R16,0x10                                
caseD_c4:                     
    sts         PORTA_OUTSET,R16                        ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001058(void)
    ldi         R18,0x8                                 
LAB_code_001059:              
    ldi         R17,0x8                                 
    sbrc        R16,0x7                                 
    sts         PORTA_OUTSET,R17                        ;= ??
    sbrs        R16,0x7                                 
    sts         PORTA_OUTCLR,R17                        ;= ??
    ldi         R17,0x2                                 
    sts         PORTA_OUTCLR,R17                        ;= ??
    add         R16,R16                                 
    nop                                                 
    sts         PORTA_OUTSET,R17                        ;= ??
    lds         R17,PORTA_IN                            ;= ??
    bst         R17,0x2                                 
    bld         R16,0x0                                 
    dec         R18                                     
    brbc        LAB_code_001059,Zflg                    
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_00106e(void)
    push        R22                                     
    push        R17                                     
    push        R18                                     
    push        R1                                      
    push        R0                                      
    eor         R18,R18                                 
    ldi         R17,0xa                                 
    eor         R19,R19                                 
    eor         R20,R20                                 
    eor         R21,R21                                 
LAB_code_001078:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    inc         R18                                     
    cpi         R16,0x30                                
    brbs        LAB_code_00108d,Sflg                    
    cpi         R16,0x3a                                
    brbc        LAB_code_00108d,Sflg                    
    mov         R22,R16                                 
    subi        R22,0x30                                
    mul         R20,R17                                 
    add         R0,R22                                  
    eor         R22,R22                                 
    adc         R1,R22                                  
    mov         R22,R21                                 
    mov         R21,R1                                  
    mov         R20,R0                                  
    mul         R17,R22                                 
    and         R1,R1                                   
    brbc        LAB_code_001091,Zflg                    
    add         R21,R0                                  
    brbc        LAB_code_001078,Cflg                    
    rjmp        LAB_code_001091                         
LAB_code_00108d:              
    cpi         R18,0x1                                 
    brbs        LAB_code_001091,Zflg                    
    clc                                                 
    rjmp        LAB_code_001092                         
LAB_code_001091:              
    bset        Cflg                                    
LAB_code_001092:              
    pop         R0                                      
    pop         R1                                      
    pop         R18                                     
    pop         R17                                     
    pop         R22                                     
    ret                                                 
;************************************************************************************************
;*                        @brief Get integer value from USART F0 console                        *
;************************************************************************************************
;undefined5 usart_f0_get_integer(undefined2 param_1, undefined param_2, undefined2 param_3, undefined2 param_4, char unaff_R16)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined          R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;unaff_R16     char               R16                      
    push        param_2                                 
    push        R17                                     
    push        param_4                                 
    push        param_4                                 
    push        R1                                      
    push        R0                                      
    eor         param_4,param_4                         
    ldi         R17,0xa                                 
    eor         param_4,param_4                         
    eor         param_3,param_3                         
    eor         param_3,param_3                         
LAB_code_0010a3:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    and         param_4,param_4                         
    brbc        LAB_code_0010ab,Zflg                    
    cpi         unaff_R16,0x2d                          
    brbc        LAB_code_0010ab,Zflg                    
    inc         param_4                                 
    inc         param_4                                 
    rjmp        LAB_code_0010a3                         
LAB_code_0010ab:              
    inc         param_4                                 
    cpi         unaff_R16,0x30                          
    brbs        LAB_code_0010bf,Sflg                    
    cpi         unaff_R16,0x3a                          
    brbc        LAB_code_0010bf,Sflg                    
    mov         param_2,unaff_R16                       
    subi        param_2,0x30                            
    mul         param_3,R17                             
    add         R0,param_2                              
    eor         param_2,param_2                         
    adc         R1,param_2                              
    mov         param_2,param_3                         
    mov         param_3,R1                              
    mov         param_3,R0                              
    mul         R17,param_2                             
    and         R1,R1                                   
    brbc        LAB_code_0010cc,Zflg                    
    add         param_3,R0                              
    brbc        LAB_code_0010a3,Cflg                    
    rjmp        LAB_code_0010cc                         
LAB_code_0010bf:              
    cpi         param_4,0x1                             
    brbs        LAB_code_0010cc,Zflg                    
    and         param_4,param_4                         
    brbs        LAB_code_0010ca,Zflg                    
    cpi         param_4,0x2                             
    brbs        LAB_code_0010cc,Zflg                    
    eor         param_4,param_4                         
    neg         param_3                                 
    adc         param_3,param_4                         
    neg         param_3                                 
    brbc        LAB_code_0010cc,Nflg                    
LAB_code_0010ca:              
    clc                                                 
    rjmp        LAB_code_0010cd                         
LAB_code_0010cc:              
    bset        Cflg                                    
LAB_code_0010cd:              
    pop         R0                                      
    pop         R1                                      
    pop         param_4                                 
    pop         param_4                                 
    pop         R17                                     
    pop         param_2                                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_get_next_hex_value(void)
    push        R22                                     
    push        R18                                     
    eor         R18,R18                                 
    eor         R20,R20                                 
    eor         R21,R21                                 
LAB_code_0010d9:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    mov         R22,R16                                 
    cpi         R16,0x30                                
    brbs        LAB_code_0010f2,Cflg                    
    cpi         R16,0x3a                                
    brbs        LAB_code_0010e4,Cflg                    
    cpi         R16,0x41                                
    brbs        LAB_code_0010f2,Cflg                    
    cpi         R16,0x47                                
    brbc        LAB_code_0010f2,Cflg                    
    subi        R22,0x7                                 
LAB_code_0010e4:              
    subi        R22,0x30                                
    add         R20,R20                                 
    adc         R21,R21                                 
    add         R20,R20                                 
    adc         R21,R21                                 
    add         R20,R20                                 
    adc         R21,R21                                 
    add         R20,R20                                 
    adc         R21,R21                                 
    or          R20,R22                                 
    inc         R18                                     
    cpi         R18,0x4                                 
    brbc        LAB_code_0010d9,Zflg                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
LAB_code_0010f2:              
    and         R18,R18                                 
    brbs        LAB_code_0010f6,Zflg                    
    clc                                                 
    rjmp        LAB_code_0010f7                         
LAB_code_0010f6:              
    bset        Cflg                                    
LAB_code_0010f7:              
    pop         R18                                     
    pop         R22                                     
    ret                                                 
;************************************************************************************************
;*                             @brief USARTF0 send 32-bit hex value                             *
;************************************************************************************************
;undefined usart_f0_send_32bit_hex_value(void)
    push        R16                                     
    push        R17                                     
    push        R18                                     
    mov         R18,R16                                 
    swap        R17                                     
    mov         R16,R17                                 
    rcall       usart_f0_send_hex_digit                 ;undefined usart_f0_send_hex_digit(void)
    swap        R17                                     
    mov         R16,R17                                 
    rcall       usart_f0_send_hex_digit                 ;undefined usart_f0_send_hex_digit(void)
    swap        R18                                     
    mov         R16,R18                                 
    rcall       usart_f0_send_hex_digit                 ;undefined usart_f0_send_hex_digit(void)
    swap        R18                                     
    mov         R16,R18                                 
    rcall       usart_f0_send_hex_digit                 ;undefined usart_f0_send_hex_digit(void)
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*  @brief USARTF0 send hex digit                                                               *
;*                                                                                              *
;*  This function coverts value into ASCII hex equivalent                                       *
;*  and sends it. Only bits [3..0] are send.                                                    *
;************************************************************************************************
;undefined usart_f0_send_hex_digit(void)
    andi        R16,0xf                                 
    subi        R16,0xd0                                
    cpi         R16,0x3a                                
    brbs        LAB_code_001113,Cflg                    
    subi        R16,0xf9                                
LAB_code_001113:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usartf0_send_attenuator_settings(void)
    push        R20                                     
    ldi         R20,0x2                                 
    bset        Cflg                                    
    rjmp        LAB_code_001128                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined uartf0_send_temperature(void)
    push        R20                                     
    ldi         R20,0x1                                 
    bset        Cflg                                    
    rjmp        LAB_code_001128                         
    ??          4Fh    O                                
    ??          93h                                     
    ??          43h    C                                
    ??          E0h                                     
    ??          08h                                     
    ??          94h                                     
    ??          07h                                     
    ??          C0h                                     
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usartf0_send_signed_16(void)
    push        R20                                     
    eor         R20,R20                                 
    bset        Cflg                                    
    rjmp        LAB_code_001128                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usartf0_send_unsigned_16(void)
    push        R20                                     
    eor         R20,R20                                 
    clc                                                 
LAB_code_001128:              
    push        R14                                     
    push        R15                                     
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        R19                                     
    push        R25                                     
    push        Zlo                                     
    push        Zhi                                     
    eor         R15,R15                                 
    brbc        LAB_code_00113b,Cflg                    
    inc         R15                                     
    and         R17,R17                                 
    brbc        LAB_code_00113b,Nflg                    
    neg         R15                                     
    neg         R16                                     
    brbc        LAB_code_00113a,Cflg                    
    inc         R17                                     
LAB_code_00113a:              
    neg         R17                                     
LAB_code_00113b:              
    ldi         Zlo,0x56                                
    ldi         Zhi,0x21                                
    eor         R19,R19                                 
    st          Z,R19                                   
LAB_code_00113f:              
    ldi         R18,0xd                                 
    eor         R14,R14                                 
LAB_code_001141:              
    subi        R17,0xa0                                
    sbrs        R14,0x0                                 
    brbs        LAB_code_001146,Cflg                    
    bset        Cflg                                    
    rjmp        LAB_code_001148                         
LAB_code_001146:              
    subi        R17,0x60                                
    clc                                                 
LAB_code_001148:              
    adc         R16,R16                                 
    adc         R17,R17                                 
    adc         R14,R14                                 
    dec         R18                                     
    brbc        LAB_code_001141,Zflg                    
    mov         R18,R17                                 
    ror         R14                                     
    ror         R18                                     
    andi        R17,0x1f                                
    swap        R18                                     
    andi        R18,0xf                                 
    subi        R18,0xd0                                
    st          -Z,R18                                  
    inc         R19                                     
    cp          R20,R19                                 
    brbc        LAB_code_00115a,Zflg                    
    ldi         R18,0x2e                                
    st          -Z,R18                                  
LAB_code_00115a:              
    and         R17,R17                                 
    brbc        LAB_code_00113f,Zflg                    
    and         R16,R16                                 
    brbc        LAB_code_00113f,Zflg                    
    cp          R20,R19                                 
    brbs        LAB_code_00116c,Sflg                    
    ldi         R18,0x30                                
    st          -Z,R18                                  
    brbs        LAB_code_00116c,Zflg                    
LAB_code_001163:              
    inc         R19                                     
    cp          R19,R20                                 
    brbs        LAB_code_001168,Zflg                    
    st          -Z,R18                                  
    rjmp        LAB_code_001163                         
LAB_code_001168:              
    ldi         R18,0x2e                                
    st          -Z,R18                                  
    ldi         R18,0x30                                
    st          -Z,R18                                  
LAB_code_00116c:              
    ldi         R17,0x50                                
    and         R20,R20                                 
    brbs        LAB_code_001170,Zflg                    
    dec         R17                                     
LAB_code_001170:              
    ldi         R16,0x20                                
    and         R15,R15                                 
    brbs        LAB_code_001178,Zflg                    
    brbc        LAB_code_001175,Nflg                    
    ldi         R16,0x2d                                
LAB_code_001175:              
    st          -Z,R16                                  
    ldi         R16,0x20                                
    dec         R17                                     
LAB_code_001178:              
    cp          Zlo,R17                                 
    brbs        LAB_code_00117c,Zflg                    
    st          -Z,R16                                  
    rjmp        LAB_code_001178                         
LAB_code_00117c:              
    adiw        Z,0x1                                   
LAB_code_00117d:              
    ld          R16,Z+                                  
    and         R16,R16                                 
    brbs        LAB_code_001182,Zflg                    
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_00117d                         
LAB_code_001182:              
    pop         Zhi                                     
    pop         Zlo                                     
    pop         R25                                     
    pop         R19                                     
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    pop         R15                                     
    pop         R14                                     
    pop         R20                                     
    ret                                                 
;************************************************************************************************
;*                        @brief Set attenuator steps from HOME position                        *
;************************************************************************************************
;undefined attenuator_set_steps(void)
    push        R14                                     
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        R19                                     
    push        R20                                     
    push        R25                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Zlo,0x4f                                
    ldi         Zhi,0x21                                
    ldi         R18,0xd                                 
    st          Z,R18                                   
    eor         R19,R19                                 
LAB_code_00119b:              
    ldi         R18,0xd                                 
    eor         R14,R14                                 
LAB_code_00119d:              
    subi        R17,0xa0                                
    sbrs        R14,0x0                                 
    brbs        LAB_code_0011a2,Cflg                    
    bset        Cflg                                    
    rjmp        LAB_code_0011a4                         
LAB_code_0011a2:              
    subi        R17,0x60                                
    clc                                                 
LAB_code_0011a4:              
    adc         R16,R16                                 
    adc         R17,R17                                 
    adc         R14,R14                                 
    dec         R18                                     
    brbc        LAB_code_00119d,Zflg                    
    mov         R18,R17                                 
    ror         R14                                     
    ror         R18                                     
    andi        R17,0x1f                                
    swap        R18                                     
    andi        R18,0xf                                 
    subi        R18,0xd0                                
    st          -Z,R18                                  
    inc         R19                                     
    and         R17,R17                                 
    brbc        LAB_code_00119b,Zflg                    
    and         R16,R16                                 
    brbc        LAB_code_00119b,Zflg                    
    ldi         R16,0x53                                
    st          -Z,R16                                  
LAB_code_0011b8:              
    ld          R16,Z+                                  
    rcall       USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    cpi         R16,0xd                                 
    brbc        LAB_code_0011b8,Zflg                    
    pop         Zhi                                     
    pop         Zlo                                     
    pop         R25                                     
    pop         R20                                     
    pop         R19                                     
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    pop         R14                                     
    ret                                                 
;************************************************************************************************
;*                                 @brief Send IP address octet                                 *
;************************************************************************************************
;undefined send_usartf0_ipaddr_octet(void)
    push        R14                                     
    push        R16                                     
    push        R18                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Zlo,0x56                                
    ldi         Zhi,0x21                                
    eor         R14,R14                                 
    st          Z,R14                                   
LAB_code_0011cf:              
    ldi         R18,0x5                                 
    eor         R14,R14                                 
LAB_code_0011d1:              
    subi        R16,0xa0                                
    sbrs        R14,0x0                                 
    brbs        LAB_code_0011d6,Cflg                    
    bset        Cflg                                    
    rjmp        LAB_code_0011d8                         
LAB_code_0011d6:              
    subi        R16,0x60                                
    clc                                                 
LAB_code_0011d8:              
    adc         R16,R16                                 
    adc         R14,R14                                 
    dec         R18                                     
    brbc        LAB_code_0011d1,Zflg                    
    mov         R18,R16                                 
    ror         R14                                     
    ror         R18                                     
    andi        R16,0x1f                                
    swap        R18                                     
    andi        R18,0xf                                 
    subi        R18,0xd0                                
    st          -Z,R18                                  
    and         R16,R16                                 
    brbc        LAB_code_0011cf,Zflg                    
LAB_code_0011e6:              
    ld          R16,Z+                                  
    and         R16,R16                                 
    brbs        LAB_code_0011eb,Zflg                    
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_0011e6                         
LAB_code_0011eb:              
    pop         Zhi                                     
    pop         Zlo                                     
    pop         R18                                     
    pop         R16                                     
    pop         R14                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_cr(void)
    ldi         Zlo,0xba                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
;************************************************************************************************
;*  @brief print to uart                                                                        *
;*                                                                                              *
;*  This function sends string from mem. via USART_F0                                           *
;************************************************************************************************
;undefined usart_f0_send_msg(void)
    push        R16                                     
LAB_code_0011f6:              
    lpm         R16,Z+                                  
    and         R16,R16                                 
    brbs        LAB_code_0011fb,Zflg                    
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_0011f6                         
LAB_code_0011fb:              
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined uart_f0_get_next_byte(void)
    push        R19                                     
    ldi         R19,0x1                                 
    rjmp        usart_f0_get_next_byte_with_5f::usart...
;************************************************************************************************
;*                        @brief Read byte from USARTF0 console and 0x5F                        *
;************************************************************************************************
;undefined usart_f0_get_next_byte_with_5f(void)
    push        R19                                     
    eor         R19,R19                                 
usart_f0_get_next_byte_entry: 
    push        R17                                     
    push        R18                                     
    push        R20                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Zlo,0x0                                 
    ldi         Zhi,0x20                                
usart_f0_get_next_byte_wait:  
    cli                                                 
    ld          R17,Z                                   
    ldd         R16,Z+0x1                               
    bset        Iflg                                    
    cp          R16,R17                                 
    brbs        usart_f0_get_next_byte_wait,Zflg        
    inc         R17                                     
    andi        R17,0x3f                                
    lds         R20,PORTF_OUT                           ;= ??
    sbrs        R20,0x0                                 
    rjmp        LAB_code_00121c                         
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cpse        R16,R18                                 
    ldi         R20,0x1                                 
    sts         PORTF_OUTCLR,R20                        ;= ??
LAB_code_00121c:              
    eor         R18,R18                                 
    ldi         Zlo,0x7                                 
    ldi         Zhi,0x20                                
    add         Zlo,R17                                 
    adc         Zhi,R18                                 
    ld          R18,Z                                   
    sts         DAT_mem_2000,R17                        ;= ??
    cpi         R18,0xd                                 
    brbc        LAB_code_00122b,Zflg                    
    lds         R17,DAT_usart_f0_new_line               ;= ??
    dec         R17                                     
    sts         DAT_usart_f0_new_line,R17               ;= ??
LAB_code_00122b:              
    cpi         R18,0x60                                
    brbs        usart_f0_get_next_byte_exit,Sflg        
    brbs        usart_f0_get_next_byte_exit,Zflg        
    sbrs        R19,0x0                                 
    andi        R18,0x5f                                
usart_f0_get_next_byte_exit:  
    mov         R16,R18                                 
    pop         Zhi                                     
    pop         Zlo                                     
    pop         R20                                     
    pop         R18                                     
    pop         R17                                     
    pop         R19                                     
    ret                                                 
;************************************************************************************************
;*                       @brief Send buffered message to USARTF0 console                        *
;************************************************************************************************
;undefined usartf0_send_msg_2(void)
    push        Zhi                                     
    push        Zlo                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        LAB_code_001251,Zflg                    
    inc         R18                                     
    cp          R17,R18                                 
    brbs        LAB_code_001260,Zflg                    
LAB_code_001247:              
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    eor         R17,R17                                 
    add         Zlo,R18                                 
    adc         Zhi,R17                                 
    st          Z,R16                                   
    ldi         Zlo,0x3                                 
    ldi         Zhi,0x20                                
    st          Z,R18                                   
    rjmp        LAB_code_001260                         
LAB_code_001251:              
    inc         R18                                     
    ld          R19,Z                                   
    and         R19,R19                                 
    brbs        LAB_code_001247,Zflg                    
    lds         R20,USARTF0_STATUS                      ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_001247                         
    sts         USARTF0,R16                             ;= ??
    lds         R20,USARTF0_CTRLA                       ;= ??
    ori         R20,0x2                                 
    sts         USARTF0_CTRLA,R20                       ;= ??
LAB_code_001260:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         Zlo                                     
    pop         Zhi                                     
    ret                                                 
;************************************************************************************************
;*                       @brief Send buffered message to USARTF0 console                        *
;************************************************************************************************
;undefined usart_f0_send_msg(void)
    push        Zhi                                     
    push        Zlo                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
LAB_code_00126f:              
    cli                                                 
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        LAB_code_001285,Zflg                    
    inc         R18                                     
    cp          R17,R18                                 
    brbc        LAB_code_00127a,Zflg                    
    bset        Iflg                                    
    sbiw        Z,0x2                                   
    rjmp        LAB_code_00126f                         
LAB_code_00127a:              
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    eor         R17,R17                                 
    add         Zlo,R18                                 
    adc         Zhi,R17                                 
    st          Z,R16                                   
    ldi         Zlo,0x3                                 
    ldi         Zhi,0x20                                
    st          Z,R18                                   
    bset        Iflg                                    
    rjmp        LAB_code_001295                         
LAB_code_001285:              
    inc         R18                                     
    ld          R19,Z                                   
    and         R19,R19                                 
    brbs        LAB_code_00127a,Zflg                    
    lds         R20,USARTF0_STATUS                      ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_00127a                         
    sts         USARTF0,R16                             ;= ??
    lds         R20,USARTF0_CTRLA                       ;= ??
    ori         R20,0x2                                 
    sts         USARTF0_CTRLA,R20                       ;= ??
    bset        Iflg                                    
LAB_code_001295:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         Zlo                                     
    pop         Zhi                                     
    ret                                                 
;************************************************************************************************
;*                           @brieg Send buffered attenuator message                            *
;************************************************************************************************
;undefined USARTD0_send_msg(void)
    push        Zhi                                     
    push        Zlo                                     
    push        R20                                     
    push        R18                                     
    push        R17                                     
    ldi         Zlo,0x83                                
    ldi         Zhi,0x21                                
LAB_code_0012a3:              
    cli                                                 
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        LAB_code_0012ba,Zflg                    
    inc         R18                                     
    andi        R18,0xf                                 
    cp          R17,R18                                 
    brbc        LAB_code_0012af,Zflg                    
    bset        Iflg                                    
    sbiw        Z,0x2                                   
    rjmp        LAB_code_0012a3                         
LAB_code_0012af:              
    ldi         Zlo,0x73                                
    ldi         Zhi,0x21                                
    eor         R17,R17                                 
    add         Zlo,R18                                 
    adc         Zhi,R17                                 
    st          Z,R16                                   
    ldi         Zlo,0x84                                
    ldi         Zhi,0x21                                
    st          Z,R18                                   
    bset        Iflg                                    
    rjmp        LAB_code_0012c8                         
LAB_code_0012ba:              
    inc         R18                                     
    andi        R18,0xf                                 
    lds         R20,USARTD0_STATUS                      ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_0012af                         
    sts         USARTD0,R16                             ;= ??
    lds         R20,USARTD0_CTRLA                       ;= ??
    ori         R20,0x1                                 
    sts         USARTD0_CTRLA,R20                       ;= ??
    bset        Iflg                                    
LAB_code_0012c8:              
    pop         R17                                     
    pop         R18                                     
    pop         R20                                     
    pop         Zlo                                     
    pop         Zhi                                     
    ret                                                 
                                   
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined xmega_firmware_update(void)
    bset        Iflg                                    
LAB_code_010185:              
    mov         Xlo,R3                                  
    mov         Xhi,R4                                  
    mov         Ylo,R5                                  
    ldi         R16,0x1                                 
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
    lds         R6,RAMPZ                                
    sub         Xlo,Zlo                                 
    sbc         Xhi,Zhi                                 
    sbc         Ylo,R6                                  
    subi        Xlo,0xff                                
    sbci        Xhi,0xff                                
    sbci        Ylo,0xff                                
    and         Ylo,Ylo                                 
    brbc        LAB_code_010196,Zflg                    
    cpi         Xhi,0x2                                 
    brbs        LAB_code_010198,Cflg                    
LAB_code_010196:              
    eor         Xlo,Xlo                                 
    ldi         Xhi,0x2                                 
LAB_code_010198:              
    ldi         Ylo,0xae                                
    ldi         Yhi,0x21                                
LAB_code_01019a:              
    rcall       FUN_code_010215                         ;undefined FUN_code_010215(void)
    st          Y+,R16                                  
    sbiw        X,0x1                                   
    brbc        LAB_code_01019a,Zflg                    
    ldi         Ylo,0xae                                
    ldi         Yhi,0x21                                
    rcall       FUN_code_0101eb                         ;undefined FUN_code_0101eb(void)
    ldi         R16,0x23                                
    sts         NVM_CMD,R16                             ;= ??
    rjmp        LAB_code_0101ac                         
LAB_code_0101a5:              
    spm         Z+                                      
    lds         R6,RAMPZ                                
    cp          Zlo,R3                                  
    cpc         Zhi,R4                                  
    cpc         R6,R5                                   
    brbc        LAB_code_0101b5,Cflg                    
LAB_code_0101ac:              
    ld          R0,Y+                                   
    ld          R1,Y+                                   
    sbrs        Zhi,0x0                                 
    rjmp        LAB_code_0101a5                         
    cpi         Zlo,0xfe                                
    brbc        LAB_code_0101a5,Zflg                    
    spm         Z                                       
    rcall       FUN_code_0101f0                         ;undefined FUN_code_0101f0(void)
    rjmp        LAB_code_010185                         
LAB_code_0101b5:              
    rcall       FUN_code_0101f0                         ;undefined FUN_code_0101f0(void)
    rcall       FUN_code_0101eb                         ;undefined FUN_code_0101eb(void)
    sts         NVM,R20                                 ;= ??
    sts         NVM_ADDR1,R21                           ;= ??
    sts         NVM_ADDR2,R22                           ;= ??
    sts         NVM_DATA0,R3                            ;= ??
    sts         NVM_DATA1,R4                            ;= ??
    sts         NVM_DATA2,R5                            ;= ??
    ldi         R16,0x3a                                
    sts         NVM_CMD,R16                             ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        Iflg                                    
    rcall       FUN_code_0101eb                         ;undefined FUN_code_0101eb(void)
    lds         R16,NVM_DATA2                           ;= ??
    eor         R17,R17                                 
    rcall       FUN_code_0101fa                         ;undefined FUN_code_0101fa(void)
    lds         R16,NVM_DATA0                           ;= ??
    lds         R17,NVM_DATA1                           ;= ??
    rcall       FUN_code_0101fa                         ;undefined FUN_code_0101fa(void)
    ldi         R16,0xd                                 
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
    ldi         R16,0xa                                 
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
LAB_code_0101dc:              
    lds         R19,USARTF0_CTRLA                       ;= ??
    andi        R19,0x3                                 
    brbc        LAB_code_0101dc,Zflg                    
    cli                                                 
    ldi         R16,0x1                                 
    sts         SLEEP,R16                               ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    sts         CPU_CCP,R17                             ;= ??
    sts         RST_CTRL,R16                            ;= ??
    sleep                                               
;************************************************************************************************
;*                                    @brief Wait NVM status                                    *
;************************************************************************************************
;undefined FUN_code_0101eb(void)
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        FUN_code_0101eb                         
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0101f0(void)
    ldi         R16,0x25                                
    sts         NVM_CMD,R16                             ;= ??
    ldi         R16,0x9d                                
    cli                                                 
    sts         CPU_CCP,R16                             ;= ??
    spm         Z+                                      
    bset        Iflg                                    
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0101fa(void)
    push        R16                                     
    push        R17                                     
    push        R18                                     
    mov         R18,R16                                 
    swap        R17                                     
    mov         R16,R17                                 
    rcall       FUN_code_01020e                         ;undefined FUN_code_01020e(void)
    swap        R17                                     
    mov         R16,R17                                 
    rcall       FUN_code_01020e                         ;undefined FUN_code_01020e(void)
    swap        R18                                     
    mov         R16,R18                                 
    rcall       FUN_code_01020e                         ;undefined FUN_code_01020e(void)
    swap        R18                                     
    mov         R16,R18                                 
    rcall       FUN_code_01020e                         ;undefined FUN_code_01020e(void)
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_01020e(void)
    andi        R16,0xf                                 
    subi        R16,0xd0                                
    cpi         R16,0x3a                                
    brbs        LAB_code_010213,Cflg                    
    subi        R16,0xf9                                
LAB_code_010213:              
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_010215(void)
    push        R17                                     
    push        R18                                     
    push        R20                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Zlo,0x0                                 
    ldi         Zhi,0x20                                
LAB_code_01021c:              
    cli                                                 
    ld          R17,Z                                   
    ldd         R16,Z+0x1                               
    bset        Iflg                                    
    cp          R16,R17                                 
    brbs        LAB_code_01021c,Zflg                    
    inc         R17                                     
    andi        R17,0x3f                                
    lds         R20,PORTF_OUT                           ;= ??
    sbrs        R20,0x0                                 
    rjmp        LAB_code_01022f                         
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cpse        R16,R18                                 
    ldi         R20,0x1                                 
    sts         PORTF_OUTCLR,R20                        ;= ??
LAB_code_01022f:              
    eor         R18,R18                                 
    ldi         Zlo,0x7                                 
    ldi         Zhi,0x20                                
    add         Zlo,R17                                 
    adc         Zhi,R18                                 
    ld          R18,Z                                   
    sts         DAT_mem_2000,R17                        ;= ??
    mov         R16,R18                                 
    pop         Zhi                                     
    pop         Zlo                                     
    pop         R20                                     
    pop         R18                                     
    pop         R17                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_01023e(void)
    push        Zhi                                     
    push        Zlo                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
LAB_code_010246:              
    cli                                                 
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        LAB_code_01025c,Zflg                    
    inc         R18                                     
    cp          R17,R18                                 
    brbc        LAB_code_010251,Zflg                    
    bset        Iflg                                    
    sbiw        Z,0x2                                   
    rjmp        LAB_code_010246                         
LAB_code_010251:              
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    eor         R17,R17                                 
    add         Zlo,R18                                 
    adc         Zhi,R17                                 
    st          Z,R16                                   
    ldi         Zlo,0x3                                 
    ldi         Zhi,0x20                                
    st          Z,R18                                   
    bset        Iflg                                    
    rjmp        LAB_code_01026c                         
LAB_code_01025c:              
    inc         R18                                     
    ld          R19,Z                                   
    and         R19,R19                                 
    brbs        LAB_code_010251,Zflg                    
    lds         R20,USARTF0_STATUS                      ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_010251                         
    sts         USARTF0,R16                             ;= ??
    lds         R20,USARTF0_CTRLA                       ;= ??
    ori         R20,0x2                                 
    sts         USARTF0_CTRLA,R20                       ;= ??
    bset        Iflg                                    
LAB_code_01026c:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         Zlo                                     
    pop         Zhi                                     
    ret                                                 

