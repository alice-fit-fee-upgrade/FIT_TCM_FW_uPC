.include "iox128a3.inc"
.include "macros.inc"

.section .text
	rjmp BOOT        			; Reset

; OSC interrupt vectors
		rjmp OSC_XOSCF_ISR       ;1   	; External Oscillator Failure Interrupt (NMI)

; PORTC interrupt vectors
		rjmp PORTC_INT0_ISR      ;2   ; External Interrupt 0
		rjmp PORTC_INT1_ISR      ;3   ; External Interrupt 1

; PORTR interrupt vectors
		rjmp PORTR_INT0_ISR      ;4   ; External Interrupt 0
		rjmp PORTR_INT1_ISR      ;5   ; External Interrupt 1

; DMA interrupt vectors
		rjmp DMA_CH0_ISR         ;6   ; Channel 0 Interrupt
		rjmp DMA_CH1_ISR         ;7   ; Channel 1 Interrupt
		rjmp DMA_CH2_ISR         ;8   ; Channel 2 Interrupt
		rjmp DMA_CH3_ISR         ;9   ; Channel 3 Interrupt

; RTC interrupt vectors
		rjmp RTC_OVF_ISR         ;10  ; Overflow Interrupt
		rjmp RTC_COMP_ISR        ;11  ; Compare Interrupt

; TWIC interrupt vectors
		rjmp TWIC_TWIS_ISR       ;12  ; TWI Slave Interrupt
		rjmp TWIC_TWIM_ISR       ;13  ; TWI Master Interrupt

; TCC0 interrupt vectors
		rjmp TCC0_OVF_ISR        ;14  ; Overflow Interrupt
		rjmp TCC0_ERR_ISR        ;15  ; Error Interrupt
		rjmp TCC0_CCA_ISR        ;16  ; Compare or Capture A Interrupt
		rjmp TCC0_CCB_ISR        ;17  ; Compare or Capture B Interrupt
		rjmp TCC0_CCC_ISR        ;18  ; Compare or Capture C Interrupt
		rjmp TCC0_CCD_ISR        ;19  ; Compare or Capture D Interrupt

; TCC1 interrupt vectors
		rjmp TCC1_OVF_ISR        ;20  ; Overflow Interrupt
		rjmp TCC1_ERR_ISR        ;21  ; Error Interrupt
		rjmp TCC1_CCA_ISR        ;22  ; Compare or Capture A Interrupt
		rjmp TCC1_CCB_ISR        ;23  ; Compare or Capture B Interrupt

; SPIC interrupt vectors
		rjmp SPIC_INT_ISR        ;24  ; SPI Interrupt

; USARTC0 interrupt vectors
		rjmp USARTC0_RXC_ISR     ;25  ; Reception Complete Interrupt
		rjmp USARTC0_DRE_ISR     ;26  ; Data Register Empty Interrupt
		rjmp USARTC0_TXC_ISR     ;27  ; Transmission Complete Interrupt

; USARTC1 interrupt vectors
		rjmp USARTC1_RXC_ISR     ;28  ; Reception Complete Interrupt
		rjmp USARTC1_DRE_ISR     ;29  ; Data Register Empty Interrupt
		rjmp USARTC1_TXC_ISR     ;30  ; Transmission Complete Interrupt

; AES interrupt vectors
		rjmp AES_INT_ISR         ;31  ; AES Interrupt

; NVM interrupt vectors
		rjmp NVM_EE_ISR          ;32  ; EE Interrupt
		rjmp NVM_SPM_ISR         ;33  ; SPM Interrupt

; PORTB interrupt vectors
		rjmp PORTB_INT0_ISR      ;34  ; External Interrupt 0
		rjmp PORTB_INT1_ISR      ;35  ; External Interrupt 1

; ACB interrupt vectors
		rjmp ACB_AC0_ISR         ;36  ; AC0 Interrupt
		rjmp ACB_AC1_ISR         ;37  ; AC1 Interrupt
		rjmp ACB_ACW_ISR         ;38  ; ACW Window Mode Interrupt

; ADCB interrupt vectors
		rjmp ADCB_CH0_ISR        ;39  ; Interrupt 0
		rjmp ADCB_CH1_ISR        ;40  ; Interrupt 1
		rjmp ADCB_CH2_ISR        ;41  ; Interrupt 2
		rjmp ADCB_CH3_ISR        ;42  ; Interrupt 3

; PORTE interrupt vectors
		rjmp PORTE_INT0_ISR      ;43  ; External Interrupt 0
		rjmp PORTE_INT1_ISR      ;44  ; External Interrupt 1

; TWIE interrupt vectors
		rjmp TWIE_TWIS_ISR       ;45  ; TWI Slave Interrupt
		rjmp TWIE_TWIM_ISR       ;46  ; TWI Master Interrupt

; TCE0 interrupt vectors
		rjmp TCE0_OVF_ISR        ;47  ; Overflow Interrupt
		rjmp TCE0_ERR_ISR        ;48  ; Error Interrupt
		rjmp TCE0_CCA_ISR        ;49  ; Compare or Capture A Interrupt
		rjmp TCE0_CCB_ISR        ;50  ; Compare or Capture B Interrupt
		rjmp TCE0_CCC_ISR        ;51  ; Compare or Capture C Interrupt
		rjmp TCE0_CCD_ISR        ;52  ; Compare or Capture D Interrupt

; TCE1 interrupt vectors
		rjmp TCE1_OVF_ISR        ;53  ; Overflow Interrupt
		rjmp TCE1_ERR_ISR        ;54  ; Error Interrupt
		rjmp TCE1_CCA_ISR        ;55  ; Compare or Capture A Interrupt
		rjmp TCE1_CCB_ISR        ;56  ; Compare or Capture B Interrupt

; SPIE interrupt vectors
		rjmp SPIE_INT_ISR        ;57  ; SPI Interrupt

; USARTE0 interrupt vectors
		rjmp USARTE0_RXC_ISR     ;58  ; Reception Complete Interrupt
		rjmp USARTE0_DRE_ISR     ;59  ; Data Register Empty Interrupt
		rjmp USARTE0_TXC_ISR     ;60  ; Transmission Complete Interrupt

; USARTE1 interrupt vectors
		rjmp USARTE1_RXC_ISR     ;61  ; Reception Complete Interrupt
		rjmp USARTE1_DRE_ISR     ;62  ; Data Register Empty Interrupt
		rjmp USARTE1_TXC_ISR     ;63  ; Transmission Complete Interrupt

; PORTD interrupt vectors
		rjmp PORTD_INT0_ISR      ;64  ; External Interrupt 0
		rjmp PORTD_INT1_ISR      ;65  ; External Interrupt 1

; PORTA interrupt vectors
		rjmp PORTA_INT0_ISR      ;66  ; External Interrupt 0
		rjmp PORTA_INT1_ISR      ;67  ; External Interrupt 1

; ACA interrupt vectors
		rjmp ACA_AC0_ISR         ;68  ; AC0 Interrupt
		rjmp ACA_AC1_ISR         ;69  ; AC1 Interrupt
		rjmp ACA_ACW_ISR         ;70  ; ACW Window Mode Interrupt

; ADCA interrupt vectors
		rjmp ADCA_CH0_ISR        ;71  ; Interrupt 0
		rjmp ADCA_CH1_ISR        ;72  ; Interrupt 1
		rjmp ADCA_CH2_ISR        ;73  ; Interrupt 2
		rjmp ADCA_CH3_ISR        ;74  ; Interrupt 3

; TWID interrupt vectors
		rjmp TWID_TWIS_ISR       ;75  ; TWI Slave Interrupt
		rjmp TWID_TWIM_ISR       ;76  ; TWI Master Interrupt

; TCD0 interrupt vectors
		rjmp TCD0_OVF_ISR        ;77  ; Overflow Interrupt
		rjmp TCD0_ERR_ISR        ;78  ; Error Interrupt
		rjmp TCD0_CCA_ISR        ;79  ; Compare or Capture A Interrupt
		rjmp TCD0_CCB_ISR        ;80  ; Compare or Capture B Interrupt
		rjmp TCD0_CCC_ISR        ;81  ; Compare or Capture C Interrupt
		rjmp TCD0_CCD_ISR        ;82  ; Compare or Capture D Interrupt

; TCD1 interrupt vectors
		rjmp TCD1_OVF_ISR        ;83  ; Overflow Interrupt
		rjmp TCD1_ERR_ISR        ;84  ; Error Interrupt
		rjmp TCD1_CCA_ISR        ;85  ; Compare or Capture A Interrupt
		rjmp TCD1_CCB_ISR        ;86  ; Compare or Capture B Interrupt

; SPID interrupt vectors
		rjmp SPID_INT_ISR        ;87  ; SPI Interrupt

; USARTD0 interrupt vectors
		rjmp USARTD0_RXC_ISR     ;88  ; Reception Complete Interrupt
		rjmp USARTD0_DRE_ISR     ;89  ; Data Register Empty Interrupt
		rjmp USARTD0_TXC_ISR     ;90  ; Transmission Complete Interrupt

; USARTD1 interrupt vectors
		rjmp USARTD1_RXC_ISR     ;91  ; Reception Complete Interrupt
		rjmp USARTD1_DRE_ISR     ;92  ; Data Register Empty Interrupt
		rjmp USARTD1_TXC_ISR     ;93  ; Transmission Complete Interrupt

; PORTQ interrupt vectors
		rjmp PORTQ_INT0_ISR      ;94  ; External Interrupt 0
		rjmp PORTQ_INT1_ISR      ;95  ; External Interrupt 1

; PORTH interrupt vectors
		rjmp PORTH_INT0_ISR      ;96  ; External Interrupt 0
		rjmp PORTH_INT1_ISR      ;97  ; External Interrupt 1

; PORTJ interrupt vectors
		rjmp PORTJ_INT0_ISR      ;98  ; External Interrupt 0
		rjmp PORTJ_INT1_ISR      ;99  ; External Interrupt 1

; PORTK interrupt vectors
		rjmp PORTK_INT0_ISR      ;100 ; External Interrupt 0
		rjmp PORTK_INT1_ISR      ;101 ; External Interrupt 1

; PORTF interrupt vectors
		rjmp PORTF_INT0_ISR      ;104 ; External Interrupt 0
		rjmp PORTF_INT1_ISR      ;105 ; External Interrupt 1

; TWIF interrupt vectors
		rjmp TWIF_TWIS_ISR       ;106 ; TWI Slave Interrupt
		rjmp TWIF_TWIM_ISR       ;107 ; TWI Master Interrupt

; TCF0 interrupt vectors
		rjmp TCF0_OVF_ISR        ;108 ; Overflow Interrupt
		rjmp TCF0_ERR_ISR        ;109 ; Error Interrupt
		rjmp TCF0_CCA_ISR        ;110 ; Compare or Capture A Interrupt
		rjmp TCF0_CCB_ISR        ;111 ; Compare or Capture B Interrupt
		rjmp TCF0_CCC_ISR        ;112 ; Compare or Capture C Interrupt
		rjmp TCF0_CCD_ISR        ;113 ; Compare or Capture D Interrupt

; TCF1 interrupt vectors
		rjmp TCF1_OVF_ISR        ;114 ; Overflow Interrupt
		rjmp TCF1_ERR_ISR        ;115 ; Error Interrupt
		rjmp TCF1_CCA_ISR        ;116 ; Compare or Capture A Interrupt
		rjmp TCF1_CCB_ISR        ;117 ; Compare or Capture B Interrupt

; SPIF interrupt vectors
		rjmp SPIF_INT_ISR        ;118 ; SPI Interrupt

; USARTF0 interrupt vectors
		rjmp USARTF0_RXC_ISR     ;119 ; Reception Complete Interrupt
		rjmp USARTF0_DRE_ISR     ;120 ; Data Register Empty Interrupt
		rjmp USARTF0_TXC_ISR     ;121 ; Transmission Complete Interrupt

; USARTF1 interrupt vectors
		rjmp USARTF1_RXC_ISR     ;122 ; Reception Complete Interrupt
		rjmp USARTF1_DRE_ISR     ;123 ; Data Register Empty Interrupt
		rjmp USARTF1_TXC_ISR     ;124 ; Transmission Complete Interrupt



;========================
; OSC interrupt vectors
OSC_XOSCF_ISR: 		;1   ; External Oscillator Failure Interrupt (NMI

; PORTC interrupt vectors
PORTC_INT0_ISR: 	    ;2   ; External Interrupt 0
PORTC_INT1_ISR: 	    ;3   ; External Interrupt 1

; PORTR interrupt vectors
PORTR_INT0_ISR: 	    ;4   ; External Interrupt 0
PORTR_INT1_ISR: 	    ;5   ; External Interrupt 1

; DMA interrupt vectors
DMA_CH0_ISR: 		    ;6   ; Channel 0 Interrupt
DMA_CH1_ISR: 		    ;7   ; Channel 1 Interrupt
DMA_CH2_ISR: 		    ;8   ; Channel 2 Interrupt
DMA_CH3_ISR: 		    ;9   ; Channel 3 Interrupt

; RTC interrupt vectors
RTC_OVF_ISR: 		    ;10  ; Overflow Interrupt
RTC_COMP_ISR: 		;11  ; Compare Interrupt

; TWIC interrupt vectors
TWIC_TWIS_ISR: 		;12  ; TWI Slave Interrupt
TWIC_TWIM_ISR: 		;13  ; TWI Master Interrupt

; TCC0 interrupt vectors
TCC0_OVF_ISR: 		;14  ; Overflow Interrupt
TCC0_ERR_ISR: 		;15  ; Error Interrupt
TCC0_CCA_ISR: 		;16  ; Compare or Capture A Interrupt
TCC0_CCB_ISR: 		;17  ; Compare or Capture B Interrupt
TCC0_CCC_ISR: 		;18  ; Compare or Capture C Interrupt
TCC0_CCD_ISR: 		;19  ; Compare or Capture D Interrupt

; TCC1 interrupt vectors
TCC1_OVF_ISR: 		;20  ; Overflow Interrupt
TCC1_ERR_ISR: 		;21  ; Error Interrupt
TCC1_CCA_ISR: 		;22  ; Compare or Capture A Interrupt
TCC1_CCB_ISR: 		;23  ; Compare or Capture B Interrupt

; SPIC interrupt vectors
SPIC_INT_ISR: 		;24  ; SPI Interrupt

; USARTC0 interrupt vectors
USARTC0_RXC_ISR: 	    ;25  ; Reception Complete Interrupt
USARTC0_DRE_ISR: 	    ;26  ; Data Register Empty Interrupt
USARTC0_TXC_ISR: 	    ;27  ; Transmission Complete Interrupt

; USARTC1 interrupt vectors
USARTC1_RXC_ISR: 	    ;28  ; Reception Complete Interrupt
USARTC1_DRE_ISR: 	    ;29  ; Data Register Empty Interrupt
USARTC1_TXC_ISR: 	    ;30  ; Transmission Complete Interrupt

; AES interrupt vectors
AES_INT_ISR: 		    ;31  ; AES Interrupt

; NVM interrupt vectors
NVM_EE_ISR: 		    ;32  ; EE Interrupt
NVM_SPM_ISR: 		    ;33  ; SPM Interrupt

; PORTB interrupt vectors
PORTB_INT0_ISR: 	    ;34  ; External Interrupt 0
PORTB_INT1_ISR: 	    ;35  ; External Interrupt 1

; ACB interrupt vectors
ACB_AC0_ISR: 		    ;36  ; AC0 Interrupt
ACB_AC1_ISR: 		    ;37  ; AC1 Interrupt
ACB_ACW_ISR: 		    ;38  ; ACW Window Mode Interrupt

; ADCB interrupt vectors
ADCB_CH0_ISR: 		;39  ; Interrupt 0
ADCB_CH1_ISR: 		;40  ; Interrupt 1
ADCB_CH2_ISR: 		;41  ; Interrupt 2
ADCB_CH3_ISR: 		;42  ; Interrupt 3

; PORTE interrupt vectors
PORTE_INT0_ISR: 	    ;43  ; External Interrupt 0
PORTE_INT1_ISR: 	    ;44  ; External Interrupt 1

; TWIE interrupt vectors
TWIE_TWIS_ISR: 		;45  ; TWI Slave Interrupt
TWIE_TWIM_ISR: 		;46  ; TWI Master Interrupt

; TCE0 interrupt vectors
TCE0_OVF_ISR: 		;47  ; Overflow Interrupt
TCE0_ERR_ISR: 		;48  ; Error Interrupt
TCE0_CCA_ISR: 		;49  ; Compare or Capture A Interrupt
TCE0_CCB_ISR: 		;50  ; Compare or Capture B Interrupt
TCE0_CCC_ISR: 		;51  ; Compare or Capture C Interrupt
TCE0_CCD_ISR: 		;52  ; Compare or Capture D Interrupt

; TCE1 interrupt vectors
TCE1_OVF_ISR: 		;53  ; Overflow Interrupt
TCE1_ERR_ISR: 		;54  ; Error Interrupt
TCE1_CCA_ISR: 		;55  ; Compare or Capture A Interrupt
TCE1_CCB_ISR: 		;56  ; Compare or Capture B Interrupt

; SPIE interrupt vectors
SPIE_INT_ISR: 		;57  ; SPI Interrupt

; USARTE0 interrupt vectors
USARTE0_RXC_ISR: 	    ;58  ; Reception Complete Interrupt
USARTE0_DRE_ISR: 	    ;59  ; Data Register Empty Interrupt
USARTE0_TXC_ISR: 	    ;60  ; Transmission Complete Interrupt

; USARTE1 interrupt vectors
USARTE1_RXC_ISR: 	    ;61  ; Reception Complete Interrupt
USARTE1_DRE_ISR: 	    ;62  ; Data Register Empty Interrupt
USARTE1_TXC_ISR: 	    ;63  ; Transmission Complete Interrupt

; PORTD interrupt vectors
PORTD_INT0_ISR: 	    ;64  ; External Interrupt 0
PORTD_INT1_ISR: 	    ;65  ; External Interrupt 1

; PORTA interrupt vectors
PORTA_INT0_ISR: 	    ;66  ; External Interrupt 0
PORTA_INT1_ISR: 	    ;67  ; External Interrupt 1

; ACA interrupt vectors
ACA_AC0_ISR: 		    ;68  ; AC0 Interrupt
ACA_AC1_ISR: 		    ;69  ; AC1 Interrupt
ACA_ACW_ISR: 		    ;70  ; ACW Window Mode Interrupt

; ADCA interrupt vectors
ADCA_CH0_ISR: 		;71  ; Interrupt 0
ADCA_CH1_ISR: 		;72  ; Interrupt 1
ADCA_CH2_ISR: 		;73  ; Interrupt 2
ADCA_CH3_ISR: 		;74  ; Interrupt 3

; TWID interrupt vectors
TWID_TWIS_ISR: 		;75  ; TWI Slave Interrupt
TWID_TWIM_ISR: 		;76  ; TWI Master Interrupt

; TCD0 interrupt vectors
TCD0_OVF_ISR: 		;77  ; Overflow Interrupt
TCD0_ERR_ISR: 		;78  ; Error Interrupt
TCD0_CCA_ISR: 		;79  ; Compare or Capture A Interrupt
TCD0_CCB_ISR: 		;80  ; Compare or Capture B Interrupt
TCD0_CCC_ISR: 		;81  ; Compare or Capture C Interrupt
TCD0_CCD_ISR: 		;82  ; Compare or Capture D Interrupt

; TCD1 interrupt vectors
TCD1_OVF_ISR: 		;83  ; Overflow Interrupt
TCD1_ERR_ISR: 		;84  ; Error Interrupt
TCD1_CCA_ISR: 		;85  ; Compare or Capture A Interrupt
TCD1_CCB_ISR: 		;86  ; Compare or Capture B Interrupt

; SPID interrupt vectors
SPID_INT_ISR: 		;87  ; SPI Interrupt

; USARTD0 interrupt vectors
USARTD0_RXC_ISR: 	    ;88  ; Reception Complete Interrupt
USARTD0_DRE_ISR: 	    ;89  ; Data Register Empty Interrupt
USARTD0_TXC_ISR: 	    ;90  ; Transmission Complete Interrupt

; USARTD1 interrupt vectors
USARTD1_RXC_ISR: 	    ;91  ; Reception Complete Interrupt
USARTD1_DRE_ISR: 	    ;92  ; Data Register Empty Interrupt
USARTD1_TXC_ISR: 	    ;93  ; Transmission Complete Interrupt

; PORTQ interrupt vectors
PORTQ_INT0_ISR: 	    ;94  ; External Interrupt 0
PORTQ_INT1_ISR: 	    ;95  ; External Interrupt 1

; PORTH interrupt vectors
PORTH_INT0_ISR: 	    ;96  ; External Interrupt 0
PORTH_INT1_ISR: 	    ;97  ; External Interrupt 1

; PORTJ interrupt vectors
PORTJ_INT0_ISR: 	    ;98  ; External Interrupt 0
PORTJ_INT1_ISR: 	    ;99  ; External Interrupt 1

; PORTK interrupt vectors
PORTK_INT0_ISR: 	    ;100 ; External Interrupt 0
PORTK_INT1_ISR: 	    ;101 ; External Interrupt 1

; PORTF interrupt vectors
PORTF_INT0_ISR: 	    ;104 ; External Interrupt 0
PORTF_INT1_ISR: 	    ;105 ; External Interrupt 1

; TWIF interrupt vectors
TWIF_TWIS_ISR: 		;106 ; TWI Slave Interrupt
TWIF_TWIM_ISR: 		;107 ; TWI Master Interrupt

; TCF0 interrupt vectors
TCF0_OVF_ISR: 		;108 ; Overflow Interrupt
TCF0_ERR_ISR: 		;109 ; Error Interrupt
TCF0_CCA_ISR: 		;110 ; Compare or Capture A Interrupt
TCF0_CCB_ISR: 		;111 ; Compare or Capture B Interrupt
TCF0_CCC_ISR: 		;112 ; Compare or Capture C Interrupt
TCF0_CCD_ISR: 		;113 ; Compare or Capture D Interrupt

; TCF1 interrupt vectors
TCF1_OVF_ISR: 		;114 ; Overflow Interrupt
TCF1_ERR_ISR: 		;115 ; Error Interrupt
TCF1_CCA_ISR: 		;116 ; Compare or Capture A Interrupt
TCF1_CCB_ISR: 		;117 ; Compare or Capture B Interrupt

; SPIF interrupt vectors
SPIF_INT_ISR: 		;118 ; SPI Interrupt

; USARTF0 interrupt vectors
USARTF0_RXC_ISR: 	    ;119 ; Reception Complete Interrupt
USARTF0_DRE_ISR: 	    ;120 ; Data Register Empty Interrupt
USARTF0_TXC_ISR: 	    ;121 ; Transmission Complete Interrupt

; USARTF1 interrupt vectors
USARTF1_RXC_ISR:	    ;122 ; Reception Complete Interrupt
USARTF1_DRE_ISR: 	    ;123 ; Data Register Empty Interrupt
USARTF1_TXC_ISR: 	    ;124 ; Transmission Complete Interrupt

		reti

;-----------------------------------------------------------------------------
; BOOT 
; main function
; 
;-----------------------------------------------------------------------------
BOOT:
    ldi         R16,0xcb                                
    sts         OSC_XOSCCTRL,R16                        
    ldi         R16,0x9                                 
    sts         OSC,R16                                 
boot_while_osc_status_1:
    lds         R17,OSC_STATUS                          
    sbrs        R17,0x3                                 
    rjmp        boot_while_osc_status_1
    ldi         R16,0xc2                                
    sts         OSC_PLLCTRL,R16                         
    ldi         R16,0x19                                
    sts         OSC,R16                                 
boot_while_osc_status_2:
    lds         R17,OSC_STATUS                          
    sbrs        R17,0x4                                 
    rjmp        boot_while_osc_status_2
    ldi         R17,0xd8                                
    ldi         R16,0x4                                 
    sts         CPU_CCP,R17                             
    sts         CLK,R16                                 
    ldi         R16,0x18                                
    sts         OSC,R16                                 
    ser         R25                                     
    out         SPL,R25                                 
    ldi         R25,0x3f                                
    out         SPH,R25                                 
    ldi         R16,0xfb                                
    sts         PORTA_DIRSET,R16                        
    ldi         R16,0xf3                                
    sts         PORTA_OUTSET,R16                        
    ldi         R16,0x18                                
    sts         PORTA_PIN2CTRL,R16                      
    ldi         R16,0x80                                
    sts         PORTA_PIN1CTRL,R16                      
    sts         PORTA_PIN3CTRL,R16                      
    sts         PORTA_PIN4CTRL,R16                      
    ldi         R16,0x1f                                
    sts         PORTB_DIRSET,R16                        
    ldi         R16,0x10                                
    sts         PORTB_OUTSET,R16                        
    ldi         R16,0x10                                
    sts         PORTB_PIN5CTRL,R16                      
    sts         PORTB_PIN6CTRL,R16                      
    ldi         R16,0x28                                
    sts         PORTC_PIN0CTRL,R16                      
    sts         PORTC_PIN1CTRL,R16                      
    ldi         R16,0x0                                 
    sts         PORTC_PIN3CTRL,R16                      
    sts         PORTC_PIN4CTRL,R16                      
    ldi         R16,0x28                                
    sts         PORTD_PIN1CTRL,R16                      
    sts         PORTD_PIN4CTRL,R16                      
    ldi         R16,0x10                                
    sts         PORTD_OUTCLR,R16                        
    ldi         R16,0x2                                 
    sts         PORTD_OUTSET,R16                        
    ldi         R16,0x12                                
    sts         PORTD_DIRSET,R16                        
    ldi         R16,0x0                                 
    sts         PORTD_PIN5CTRL,R16                      
    ldi         R16,0x10                                
    sts         PORTD_PIN6CTRL,R16                      
    sts         PORTD_PIN7CTRL,R16                      
    ldi         R16,0x4                                 
    sts         PORTE_DIRSET,R16                        
    ldi         R16,0x1                                 
    sts         PORTE_PIN0CTRL,R16                      
    ldi         R16,0x0                                 
    sts         PORTE_PIN1CTRL,R16                      
    ldi         R16,0x80                                
    sts         PORTE_PIN2CTRL,R16                      
    ldi         R16,0x0                                 
    sts         PORTE_PIN3CTRL,R16                      
    ldi         R16,0xa                                 
    sts         PORTE_INT0MASK,R16                      
    ldi         R16,0x1                                 
    sts         PORTE_INT1MASK,R16                      
    ldi         R16,0x9                                 
    sts         PORTF_DIRSET,R16                        
    ldi         R16,0x0                                 
    sts         PORTF_PIN1CTRL,R16                      
    sts         PORTF_PIN4CTRL,R16                      
    sts         PORTF_PIN5CTRL,R16                      
    ldi         R16,0x10                                
    sts         PORTF_PIN6CTRL,R16                      
    sts         PORTF_PIN7CTRL,R16                      
    ldi         R16,0xc                                 
    sts         PORTC_INT0MASK,R16                      
    ldi         R16,0x20                                
    sts         PORTD_INT0MASK,R16                      
    ldi         R16,0x2                                 
    sts         PORTF_INT0MASK,R16                      
    ldi         R16,0x30                                
    sts         PORTF_INT1MASK,R16                      
    ldi         R16,0x1                                 
    sts         PORTF_OUTSET,R16                        
    ldi         R16,0x23                                
    sts         TWIC_MASTER_BAUD,R16                    
    ldi         R16,0x48                                
    sts         TWIC_MASTER_CTRLA,R16                   
    ldi         R16,0x1                                 
    sts         TWIC_MASTER_STATUS,R16                  
    ldi         R16,0x40                                
    sts         USARTD0_BAUDCTRLB,R16                   
    ldi         R16,0xc                                 
    sts         USARTD0_BAUDCTRLA,R16                   
    ldi         R16,0x3                                 
    sts         USARTD0_CTRLC,R16                       
    ldi         R16,0xd0                                
    sts         USARTF0_BAUDCTRLB,R16                   
    ldi         R16,0x83                                
    sts         USARTF0_BAUDCTRLA,R16                   
    ldi         R16,0x3                                 
    sts         USARTF0_CTRLC,R16                       
    ldi         R16,0x18                                
    sts         USARTF0_CTRLB,R16                       
    ldi         R16,0x10                                
    sts         USARTF0_CTRLA,R16                       
    ldi         R16,0x6                                 
    sts         TCC0,R16                                
    ldi         R16,0x7d                                
    sts         TCC0_PER,R16                            
    ldi         R16,0x0                                 
    sts         DAT_mem_0827,R16                        
    ldi         R16,0x0                                 
    sts         TCC0_CTRLB,R16                          
    ldi         R16,0x0                                 
    sts         TCC0_CTRLE,R16                          
    ldi         R16,0x1                                 
    sts         TCC0_INTCTRLA,R16                       
    ldi         R16,0x8                                 
    sts         NVM_CTRLB,R16                           
    eor         R25,R25                                 
    out         GPIO_GPIOR0,R25                         
    ldi         Zlo,0x0                                 
    ldi         Zhi,0x20                                
    ldi         Ylo,0xb2                                
    ldi         Yhi,0x23                                
boot_clear_msg_buffer:                           ;mem:2000,mem:2001
    st          Z+=>DAT_mem_2000,R25                    
    cp          Zlo,Ylo                                 
    cpc         Zhi,Yhi                                 
    brbc        boot_clear_msg_buffer,Zflg                    
    lds         R16,PORTF_IN                            
    sbrs        R16,0x1                                 
    inc         R25                                     
    sts         DAT_mem_2004,R25                        
    lds         R16,PORTE_IN                            
    bst         R16,0x1                                 
    eor         R16,R16                                 
    bld         R16,0x0                                 
    sts         DAT_mem_2157,R16                        
    brbs        boot_cond_1_else,Tflg                    
    sbi         GPIO_GPIOR0,0x1                         
    ldi         R16,0x1                                 
    sts         PORTA_OUTCLR,R16                        
    rjmp        boot_cond_1_endif
boot_cond_1_else:              
    ldi         R16,0x1                                 
    sts         DAT_mem_215b,R16                        
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        
boot_cond_1_endif:              
    ldi         R16,0xe8                                
    sts         DAT_mem_215e,R16                        
    ldi         R16,0x3                                 
    sts         DAT_mem_215f,R16                        
    ldi         R16,0x1                                 
    sts         PORTE_INTCTRL,R16                       
    ldi         R16,0x2                                 
    sts         PORTF_INTCTRL,R16                       
    ldi         R16,0x3                                 
    sts         PMIC_CTRL,R16                           
                                           ;code:001049,mem:3ffd
    rcall       FUN_code_001049                         
    ldi         R16,0x8                                 
    ldi         R17,0x50                                
                                           ;code:001020,mem:3ffd
    rcall       FUN_code_001020                         
    ldi         R16,0x20                                
    ldi         R17,0x0                                 
    ldi         R18,0x23                                
                                           ;code:001033,mem:0903,mem:3ffd
    rcall       FUN_code_001033                         
    ldi         R16,0x30                                
    ldi         R17,0x0                                 
    ldi         R18,0x1e                                
                                           ;code:001033,mem:0907,mem:3ffd
    rcall       FUN_code_001033                         
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    ldi         Ylo,0x0                                 
    ldi         Yhi,0x10                                
    ldi         R17,0x21                                
boot_clear_msg_buffer:                           ;mem:1000,mem:1001
    ld          R16,Y+=>DAT_mem_1000                    
                                           ;mem:2189,mem:218a
    st          Z+=>DAT_mem_2189,R16                    
    cpi         Zlo,0xae                                
    cpc         Zhi,R17                                 
    brbc        boot_clear_msg_buffer,Zflg                    
    ser         R16                                     
    sts         DAT_mem_2186,R16                        
    sts         DAT_mem_2187,R16                        
    lds         R16,DAT_mem_219b                        
    andi        R16,0xf                                 
    lds         R17,PORTB_OUT                           
    andi        R17,0x90                                
    or          R16,R17                                 
    sts         PORTB_OUT,R16                           
    bset        Iflg                                    
    ldi         Zlo,0x96                                
    ldi         Zhi,0x29                                
                                           ;code:0011f5,mem:3ffd
    call        FUN_code_0011f5                         
    ldi         R16,0x1                                 
    sts         PORTF_OUTCLR,R16                        
boot_main_loop:              
    lds         R16,DAT_mem_2006                        
    and         R16,R16                                 
    brbs        boot_cond_2_endif,Zflg                    
                                           ;code:000932,mem:3ffd
    rcall       FUN_code_000932                         
boot_cond_2_endif:              
    lds         R16,DAT_mem_2005                        
    and         R16,R16                                 
    brbs        boot_main_loop,Zflg                    
                                           ;code:0009b5,mem:3ffd
    rcall       PARSE_MSG
    rjmp        boot_main_loop     

;-----------------------------------------------------------------------------
; PARSE_MSG
; 
; 
;-----------------------------------------------------------------------------
PARSE_MSG:
    andi        R16,0x7f                                
    sts         DAT_mem_2005,R16                        
    call        FUN_code_001200                         
    cpi         R16,0x41                                
    brbc        LAB_code_0009c1,Zflg                    
    call        FUN_code_001200                         
    cpi         R16,0x43                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        LAB_code_000a88                         
LAB_code_0009c1:              
    cpi         R16,0x43                                
    brbc        LAB_code_0009ce,Zflg                    
    call        FUN_code_001200                         
    cpi         R16,0x41                                
    brbc        LAB_code_0009c8,Zflg                    
    rjmp        FUN_code_000e1a                         
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
    call        FUN_code_001200                         
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
    call        FUN_code_001200                         
    cpi         R16,0x41                                
    brbc        LAB_code_0009df,Zflg                    
    rjmp        LAB_code_000aeb                         
LAB_code_0009df:              
    cpi         R16,0x46                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        FUN_code_000b32                         
LAB_code_0009e2:              
    cpi         R16,0x52                                
    brbc        LAB_code_0009ed,Zflg                    
    call        FUN_code_001200                         
    cpi         R16,0x50                                
    brbc        LAB_code_0009e9,Zflg                    
    rjmp        FUN_code_000c92                         
LAB_code_0009e9:              
    cpi         R16,0x53                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        FUN_code_000d5a                         
LAB_code_0009ec:              
    rjmp        LAB_code_000a31                         
LAB_code_0009ed:              
    cpi         R16,0x53                                
    brbc        LAB_code_000a15,Zflg                    
    call        FUN_code_001200                         
    cpi         R16,0x41                                
    brbc        LAB_code_0009f4,Zflg                    
    rjmp        FUN_code_000ee2                         
LAB_code_0009f4:              
    cpi         R16,0x43                                
    brbc        LAB_code_0009f7,Zflg                    
    rjmp        FUN_code_000ede                         
LAB_code_0009f7:              
    cpi         R16,0x49                                
    brbc        LAB_code_0009fa,Zflg                    
    rjmp        FUN_code_000e52                         
LAB_code_0009fa:              
    cpi         R16,0x4c                                
    brbc        LAB_code_0009fd,Zflg                    
    rjmp        FUN_code_000eda                         
LAB_code_0009fd:              
    cpi         R16,0x4d                                
    brbc        LAB_code_000a00,Zflg                    
    rjmp        FUN_code_000e7d                         
LAB_code_000a00:              
    cpi         R16,0x53                                
    brbc        LAB_code_000a03,Zflg                    
    rjmp        FUN_code_000eb3                         
LAB_code_000a03:              
    cpi         R16,0x54                                
    brbc        LAB_code_000a0f,Zflg                    
                                           ;code:001200,mem:0a06
    rcall       FUN_code_001200                         
    cpi         R16,0x48                                
    brbc        LAB_code_000a09,Zflg                    
    rjmp        FUN_code_000cf3                         
LAB_code_000a09:              
    cpi         R16,0x4c                                
    brbc        LAB_code_000a0c,Zflg                    
    rjmp        FUN_code_000cf7                         
LAB_code_000a0c:              
    cpi         R16,0x4d                                
    brbc        LAB_code_000a31,Zflg                    
    rjmp        FUN_code_000e9e                         
LAB_code_000a0f:              
    cpi         R16,0x56                                
    brbc        LAB_code_000a12,Zflg                    
    rjmp        LAB_code_000ad7                         
LAB_code_000a12:              
    cpi         R16,0x57                                
    brbc        LAB_code_000a31,Zflg                    
    rjmp        FUN_code_000f04                         
LAB_code_000a15:              
    cpi         R16,0x54                                
    brbc        LAB_code_000a2a,Zflg                    
    rcall       FUN_code_001200                         
    cpi         R16,0x48                                
    brbc        LAB_code_000a21,Zflg                    
    rcall       FUN_code_001200                         
    cpi         R16,0x41                                
    brbc        LAB_code_000a1e,Zflg                    
    rjmp        FUN_code_000cdb                         
LAB_code_000a1e:              
    cpi         R16,0x43                                
    brbc        LAB_code_000a31,Zflg                    
    rjmp        FUN_code_000cdf                         
LAB_code_000a21:              
    cpi         R16,0x4d                                
    brbc        LAB_code_000a31,Zflg                    
    rcall       FUN_code_001200                         
    cpi         R16,0x41                                
    brbc        LAB_code_000a27,Zflg                    
    rjmp        FUN_code_000cd3                         
LAB_code_000a27:              
    cpi         R16,0x43                                
    brbc        LAB_code_000a31,Zflg                    
    rjmp        FUN_code_000cd7                         
LAB_code_000a2a:              
    cpi         R16,0x57                                
    brbc        LAB_code_000a31,Zflg                    
                                           ;code:001200,mem:0a2d
    rcall       FUN_code_001200                         
    cpi         R16,0x52                                
    brbc        LAB_code_000a31,Zflg                    
    rjmp        FUN_code_000d14                         
LAB_code_000a30:              
    rcall       FUN_code_001200                         
LAB_code_000a31:              
    cpi         R16,0xd                                 
    brbc        LAB_code_000a30,Zflg                    
    ldi         Zlo,0xbe                                
    ldi         Zhi,0x29                                
                                           ;code:0011f5,mem:0a36
    rcall       FUN_code_0011f5                         
    ret                                                 
LAB_code_000a37:              
    ldi         R20,0x1                                 
LAB_code_000a38:                           ;code:001200,mem:0a3a
    call        FUN_code_001200                         
    cpi         R16,0xd                                 
    brbc        LAB_code_000a31,Zflg                    
    lds         R16,DAT_mem_21ad                        
    cp          R16,R20                                 
    brbc        LAB_code_000a41,Zflg                    
    rjmp        LAB_code_000efe                         
LAB_code_000a41:              
    sts         DAT_mem_21ad,R20                        
    lds         R16,NVM_STATUS                          
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a41                         
    ldi         R16,0x36                                
    sts         NVM_CMD,R16                             
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             
    sts         NVM_CTRLA,R16                           
    bset        Iflg                                    
LAB_code_000a52:              
    lds         R16,NVM_STATUS                          
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a52                         
    ldi         Ylo,0x24                                
    ldi         Yhi,0x10                                
    st          Y=>DAT_mem_1024,R20                     
    ldi         R16,0x35                                
    sts         NVM_CMD,R16                             
    sts         NVM,Ylo                                 
    sts         NVM_ADDR1,Yhi                           
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             
    sts         NVM_CTRLA,R16                           
    bset        Iflg                                    
LAB_code_000a68:              
    lds         R16,NVM_STATUS                          
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a68                         
    and         R20,R20                                 
    brbc        LAB_code_000a84,Zflg                    
    ldi         R16,0x4                                 
    sts         PORTE_OUTCLR,R16                        
LAB_code_000a71:              
    lds         R16,DAT_mem_2157                        
    sbrc        R16,0x3                                 
    rjmp        LAB_code_000a71                         
    cli                                                 
    ldi         R16,0x1                                 
    sts         DAT_mem_215b,R16                        
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        
    cbi         GPIO_GPIOR0,0x1                         
    ldi         R16,0x41                                
    sts         PORTA_OUTSET,R16                        
    bset        Iflg                                    
LAB_code_000a84:              
    rjmp        LAB_code_000efe                         
LAB_code_000a85:              
    eor         R20,R20                                 
    rjmp        LAB_code_000a38                         
LAB_code_000a87:              
    rjmp        LAB_code_000a31                         
LAB_code_000a88:                           ;code:001200,mem:0a8a
    call        FUN_code_001200                         
    cpi         R16,0xd                                 
    brbc        LAB_code_000a87,Zflg                    
    cli                                                 
    lds         R16,DAT_mem_2185                        
    ori         R16,0x20                                
    sts         DAT_mem_2185,R16                        
    bset        Iflg                                    
LAB_code_000a93:              
    call        FUN_code_001200                         
    cpi         R16,0x1b                                
    brbs        LAB_code_000a9a,Zflg                    
    call        FUN_code_00129c                         
    rjmp        LAB_code_000a93                         
LAB_code_000a9a:              
    cli                                                 
    lds         R16,DAT_mem_2185                        
    andi        R16,0xdf                                
    sts         DAT_mem_2185,R16                        
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000aa2:                           ;code:001200,mem:0aa4
    call        FUN_code_001200                         
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
                                           ;code:000f39,mem:0aa7
    rcall       FUN_code_000f39                         
    brbc        LAB_code_000aa9,Cflg                    
    ret                                                 
LAB_code_000aa9:              
    eor         R18,R18                                 
    ldi         Ylo,0x9d                                
    ldi         Yhi,0x21                                
LAB_code_000aac:              
    cli                                                 
    call        FUN_code_000f92                         
    bset        Iflg                                    
    st          Y+=>DAT_mem_219d,R16                    
    st          Y+=>DAT_mem_219e,R17                    
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        LAB_code_000aac,Zflg                    
    rjmp        LAB_code_000efe                         
LAB_code_000ab6:                           ;code:001200,mem:0ab7
    rcall       FUN_code_001200                         
    cpi         R16,0x20                                
    brbc        LAB_code_000ad6,Zflg                    
    rcall       FUN_code_001200                         
    mov         R20,R16                                 
    rcall       FUN_code_001200                         
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    lds         R16,DAT_mem_2162                        
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
    sts         PORTF_INTCTRL,R16                       
    sts         DAT_mem_2162,R17                        
    rcall       FUN_code_000559                         
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000ad6:              
    rjmp        LAB_code_000a31                         
LAB_code_000ad7:              
    rcall       FUN_code_001200                         
    cpi         R16,0x20                                
    brbc        LAB_code_000ad6,Zflg                    
    rcall       FUN_code_0010d4                         
    brbs        LAB_code_000ad6,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    rcall       FUN_code_000f39                         
    brbc        LAB_code_000ae1,Cflg                    
    ret                                                 
LAB_code_000ae1:              
    sts         DAT_mem_21ab,R20                        
    sts         DAT_mem_21ac,R21                        
    ldi         R18,0x17                                
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       FUN_code_000f65                         
    bset        Iflg                                    
    rjmp        LAB_code_000efe                         
LAB_code_000aeb:              
    rcall       FUN_code_000b1f                         
    brbs        LAB_code_000ad6,Cflg                    
    rcall       FUN_code_0011fd                         
    mov         Zlo,R16                                 
    mov         R20,R16                                 
    rcall       FUN_code_0011fd                         
    mov         Zhi,R16                                 
    mov         R21,R16                                 
    rcall       FUN_code_0011fd                         
    mov         R22,R16                                 
    rcall       FUN_code_0011fd                         
    mov         R3,R16                                  
    rcall       FUN_code_0011fd                         
    mov         R4,R16                                  
    rcall       FUN_code_0011fd                         
    mov         R5,R16                                  
    cpi         R22,0x2                                 
    brbc        LAB_code_000ad6,Sflg                    
    cp          R3,Zlo                                  
    cpc         R4,Zhi                                  
    cpc         R5,R22                                  
    brbs        LAB_code_000ad6,Cflg                    
    cli                                                 
    sts         RAMPZ,R22                               
    rcall       FUN_code_000675                         
    eor         R16,R16                                 
    sts         PORTE_INTCTRL,R16                       
    sts         TCC0_INTCTRLA,R16                       
    ldi         R16,0x4                                 
    sts         PORTE_OUTCLR,R16                        
    ldi         R16,0x43                                
    ldi         R17,0xd8                                
    sts         CPU_CCP,R17                             
    sts         PMIC_CTRL,R16                           
    ldi         R16,0x26                                
    sts         NVM_CMD,R16                             
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    sts         CPU_CCP,R17                             
    sts         NVM_CTRLA,R16                           
    bset        Iflg                                    
    jmp         FUN_code_010184      

