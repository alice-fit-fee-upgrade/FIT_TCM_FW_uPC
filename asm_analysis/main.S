#include "ATxmega128A3Udef.inc"

.section .text

;************************************************************************************************
;*                                       INTERRUPT VECTOR                                       *
;************************************************************************************************

.org 0x0000
	rjmp    main                        ; 0 RESET                        
              
.org (PORTC_INT0_vect << 1)
    rjmp    PORTC_INT0_vect_isr         ; 2 External Interrupt 0
    
.org (TWIC_TWIM_vect << 1)
    rjmp    TWIC_TWIM_vect_isr 		    ; 13 TWI Master Interrupt
   
.org (TCC0_OVF_vect << 1)
    rjmp    TCC0_OVF_vect_isr           ; 14 Overflow Interrupt

.org (PORTE_INT0_vect << 1)
    rjmp    PORTE_INT0_vect_isr         ; 43 External Interrupt 0

.org (PORTE_INT1_vect << 1)
    rjmp    PORTE_INT1_vect_isr       	; 44 External Interrupt 1

.org (PORTD_INT0_vect << 1)
    rjmp    PORTD_INT0_vect_isr 		; 64 External Interrupt 0

.org (USARTD0_RXC_vect << 1)
    rjmp    USARTD0_RXC_vect_isr        ; 88 Reception Complete Interrupt

.org (USARTD0_DRE_vect << 1)
    rjmp    USARTD0_DRE_vect_isr        ; 89 Data Register Empty Interrupt        
           
.org (PORTF_INT0_vect << 1)
    rjmp    PORTF_INT0_vect_isr 	    ; 104 PORTF External Interrupt 0                  

.org (PORTF_INT1_vect << 1)
    rjmp 	PORTF_INT1_vect_isr		    ; 105 PORTF External Interrupt 1
    
.org (USARTF0_RXC_vect << 1)
    rjmp    USARTF0_RXC_vect_isr  	    ; 119 USARTF0_DATA Reception Complete Interrupt

.org (USARTF0_DRE_vect << 1)
    rjmp    USARTF0_DRE_vect_isr 	    ; 120 USARTF0_DATA Data Register Empty Interrupt

	
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 twim_int(void)
.org (0x00f1 << 1)
TWIC_TWIM_vect_isr:
    push        ZH                                      
    in          ZH,CPU_SREG                                
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        YL                                     
    push        YH                                     
    push        ZL                                     
    push        ZH                                     
    ldi         YL,0x63                                
    ldi         YH,0x21                                
    ld          R16,Y                                   
    eor         R17,R17                                 
    cpi         R16,0x5                                 
    brbs        CPU_C_bp, LAB_code_000101
    rjmp        caseD_26           
LAB_code_000101:              
    ldi         ZL,0x9c                                
    ldi         ZH,0x25                                
    add         R16,R16                                 
    add         ZL,R16                                 
    adc         ZH,R17                                 
    lpm         R17,Z+                                  
    lpm         R18,Z                                   
    ldd         R16,Y+0x1                               
    cp          R16,R18                                 
    brbs        CPU_C_bp, LAB_code_00010c
    rjmp        caseD_26           
LAB_code_00010c:              
    add         R16,R17                                 
    add         R16,R16                                 
    eor         R17,R17                                 
    ldi         ZL,0xa6                                
    ldi         ZH,0x25                                
    add         ZL,R16                                 
    adc         ZH,R17                                 
    lpm         R16,Z+                                  
    lpm         R17,Z                                   
    movw        Z,R16                                
switch:                       
switchD:                      
    ijmp                                                
case_0:                       
caseD_0:                      
    ldd         ZL,Y+0x2                               
    ldd         ZH,Y+0x3                               
    lpm         R16,Z+                                  
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    std         Y+0x4,R16                               
    std         Y+0x3,ZH                               
    std         Y+0x2,ZL                               
    ldi         R16,0x1                                 
    std         Y+0x1,R16                               
    rjmp        LAB_code_00029e                         
case_1:                       
caseD_2:                      
    ldd         ZL,Y+0x2                               
    ldd         ZH,Y+0x3                               
    lpm         R16,Z+                                  
    sts         TWIC_MASTER_DATA,R16                    ;= ??
    ldd         R17,Y+0x4                               
    cpi         R16,0x0                                 
    brbc        CPU_Z_bp, LAB_code_000139                   
    cpi         R17,0xff                                
    brbc        CPU_Z_bp, LAB_code_000139                    
    ldd         R16,Y+0x5                               
    cpi         R16,0xe2                                
    brbs        CPU_Z_bp, LAB_code_000136                    
    ldi         R16,0x2                                 
    std         Y+0x1,R16                               
    std         Y+0x2,ZL                               
    std         Y+0x3,ZH                               
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
    brbc        CPU_Z_bp, LAB_code_000142                    
    adiw        Z,0x1                                   
    std         Y+0x4,R16                               
LAB_code_00013f:              
    std         Y+0x3,ZH                               
    std         Y+0x2,ZL                               
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
    rjmp        caseD_26           
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
    brbs        CPU_Z_bp, caseD_26      
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
    brbc        CPU_N_bp, LAB_code_0001c1                    
    neg         R16                                     
LAB_code_0001c1:              
    ldi         R17,0x3f                                
    dec         R16                                     
    brbs        CPU_Z_bp, LAB_code_0001c8                    
    ldi         R17,0x4a                                
    dec         R16                                     
    brbs        CPU_Z_bp, LAB_code_0001c8                    
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
    brbc        CPU_N_bp, LAB_code_0001d2                    
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
    brbs        CPU_Z_bp, LAB_code_0001f1                    
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
    brbs        CPU_Z_bp, LAB_code_0001fc                    
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
    brbs        CPU_Z_bp, LAB_code_00021a                    
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
    brbs        CPU_Z_bp, LAB_code_000275                    
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
    brbc        CPU_Z_bp, LAB_code_000297                    
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
    pop         ZH                                     
    pop         ZL                                     
    pop         YH                                     
    pop         YL                                     
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 timer_overflow_int(void)
TCC0_OVF_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        ZH                                     
    push        ZL                                     
    push        YH                                     
    push        YL                                     
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
    ldi         ZL,0x59                                
    ldi         ZH,0x21                                
    ld          R16,Z                                   
    and         R16,R16                                 
    brbc        CPU_Z_bp, LAB_code_0002be                    
    rjmp        LAB_code_000363                         
LAB_code_0002be:              
    dec         R16                                     
    brbc        CPU_Z_bp, LAB_code_0002c1                    
    rjmp        LAB_code_00035c                         
LAB_code_0002c1:              
    dec         R16                                     
    brbs        CPU_Z_bp, LAB_code_0002cb                    
    dec         R16                                     
    brbs        CPU_Z_bp, LAB_code_0002e6                    
    dec         R16                                     
    brbs        CPU_Z_bp, LAB_code_0002f7                    
    dec         R16                                     
    brbs        CPU_Z_bp, LAB_code_0002ca                    
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
    brbc        CPU_Z_bp, LAB_code_0002e3                    
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
    brbs        CPU_Z_bp, LAB_code_0002ea                    
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
    bset        CPU_I_bp                                    
    eor         R18,R18                                 
    andi        R17,0xc                                 
    brbc        CPU_Z_bp, LAB_code_000314                    
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
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000363                         
LAB_code_00031f:              
    ldd         R17,Z+0x1                               
    dec         R17                                     
    brbs        CPU_Z_bp, LAB_code_000323                    
    rjmp        LAB_code_000362                         
LAB_code_000323:              
    lds         R16,PORTD_IN                            ;= ??
    sbrs        R16,0x5                                 
    rjmp        LAB_code_000363                         
    ldd         R16,Z+0x2                               
    and         R16,R16                                 
    brbs        CPU_Z_bp, LAB_code_00032f                    
    cpi         R16,0x5                                 
    brbc        CPU_Z_bp, LAB_code_000334                    
    ldd         R16,Z+0x3                               
    and         R16,R16                                 
    brbc        CPU_Z_bp, LAB_code_000334                    
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
    bset        CPU_I_bp                                    
    andi        R16,0xf                                 
    cpi         R16,0x3                                 
    brbc        CPU_Z_bp, LAB_code_00034f                    
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
    bset        CPU_I_bp                                    
    ldi         R16,0x80                                
    rjmp        LAB_code_000357                         
LAB_code_00034f:              
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    ori         R16,0x80                                
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    bset        CPU_I_bp                                    
    ldi         R16,0x40                                
LAB_code_000357:              
    sts         PORTA_OUTCLR,R16                        ;= ??
    eor         R16,R16                                 
    st          Z,R16                                   
    rjmp        LAB_code_000363                         
LAB_code_00035c:              
    ldd         R17,Z+0x1                               
    dec         R17                                     
    brbc        CPU_Z_bp, LAB_code_000362                    
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
    brbs        CPU_Z_bp, LAB_code_0003a4                    
    cpi         R16,0x1                                 
    brbc        CPU_Z_bp, LAB_code_000384                    
    sbiw        R24,0x1                              
    brbc        CPU_Z_bp, LAB_code_0003a2                    
    lds         R16,DAT_mem_21ad                        ;= ??
    and         R16,R16                                 
    brbs        CPU_Z_bp, LAB_code_0003a4                    
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    andi        R16,0x7                                 
    cpi         R16,0x1                                 
    brbc        CPU_Z_bp, LAB_code_000380                    
    ldi         R16,0x4                                 
    sts         PORTE_OUTSET,R16                        ;= ??
    bset        CPU_I_bp                                    
    ldi         R24,0xe8                                
    ldi         R25,0x3                                 
    ldi         R16,0x2                                 
    st          Z,R16                                   
    rjmp        LAB_code_0003a2                         
LAB_code_000380:              
    bset        CPU_I_bp                                    
    eor         R16,R16                                 
    st          Z,R16                                   
    rjmp        LAB_code_0003a2                         
LAB_code_000384:              
    cpi         R16,0x2                                 
    brbc        CPU_Z_bp, LAB_code_0003a5                    
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    sbrc        R16,0x3                                 
    rjmp        LAB_code_000396                         
    sbiw        R24,0x1                              
    brbc        CPU_Z_bp, LAB_code_0003a2                    
    ldi         R16,0x4                                 
    cli                                                 
    sts         PORTE_OUTCLR,R16                        ;= ??
LAB_code_000390:              
    sbi         GPIO_GPIOR0,0x1                         
    rcall       set_status_and_set_VD8_led              ;undefined set_status_and_set_VD8_led...
    bset        CPU_I_bp                                    
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
    brbc        CPU_Z_bp, LAB_code_0003b7                    
    sbiw        R24,0x1                              
    brbc        CPU_Z_bp, LAB_code_0003a2                    
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
    brbc        CPU_Z_bp, LAB_code_0003da                    
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
    bset        CPU_I_bp                                    
    rjmp        LAB_code_0003eb                         
LAB_code_0003d5:              
    sbiw        R24,0x1                              
    brbs        CPU_Z_bp, LAB_code_0003d8                    
    rjmp        LAB_code_0003a2                         
LAB_code_0003d8:              
    cli                                                 
    rjmp        LAB_code_000390                         
LAB_code_0003da:              
    cpi         R16,0x5                                 
    brbc        CPU_Z_bp, LAB_code_0003eb                    
    ldd         R24,Z+0x3                               
    ldd         R25,Z+0x4                               
    sbiw        R24,0x1                              
    brbs        CPU_Z_bp, LAB_code_0003e1                    
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
    brbc        CPU_Z_bp, LAB_code_0003fd                    
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
    bset        CPU_I_bp                                    
LAB_code_0003fd:              
    sbiw        R24,0x1                              
    brbs        CPU_Z_bp, LAB_code_000400                    
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
    bset        CPU_I_bp                                    
    lds         R16,DAT_mem_2185                        ;= ??
    sbrs        R16,0x4                                 
    rjmp        LAB_code_00043b                         
    cpi         R16,0x90                                
    brbs        CPU_C_bp, LAB_code_000429                    
    brbc        CPU_Z_bp, LAB_code_000418                    
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
    bset        CPU_I_bp                                    
    ldi         R16,0x80                                
    rjmp        LAB_code_000439                         
LAB_code_000429:              
    dec         R16                                     
    cpi         R16,0x11                                
    brbs        CPU_Z_bp, LAB_code_000433                    
    cpi         R16,0x10                                
    brbc        CPU_Z_bp, LAB_code_000439                    
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
    brbs        CPU_Z_bp, LAB_code_000467                    
    andi        R16,0xf9                                
    or          R16,R17                                 
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    sbic        GPIO_GPIOR0,0x1                         
    rjmp        LAB_code_000466                         
    cpi         R17,0x6                                 
    brbc        CPU_Z_bp, LAB_code_000461                    
    sbi         GPIO_GPIOR0,0x1                         
    rjmp        LAB_code_000465                         
LAB_code_000461:              
    and         R17,R17                                 
    brbs        CPU_Z_bp, LAB_code_000465                    
    sbi         GPIO_GPIOR0,0x0                         
    rjmp        LAB_code_000466                         
LAB_code_000465:              
    rcall       set_status_and_set_VD8_led              ;undefined set_status_and_set_VD8_led...
LAB_code_000466:              
    bset        CPU_I_bp                                    
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
    brbs        CPU_Z_bp, LAB_code_00047f                    
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
    bset        CPU_I_bp                                    
LAB_code_00047f:              
    std         Z+0x3,R24                               
    std         Z+0x4,R25                               
    sbis        GPIO_GPIOR0,0x5                         
    rjmp        LAB_code_0004c2                         
    lds         R16,DAT_clk_frs                         ;= ??
    andi        R16,0x1                                 
    brbc        CPU_Z_bp, LAB_code_000488                    
    rjmp        LAB_code_0004c2                         
LAB_code_000488:              
    ldi         YL,0x93                                
    ldi         YH,0x21                                
    ldi         ZL,0x6d                                
    ldi         ZH,0x21                                
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
    brbc        CPU_Z_bp, LAB_code_000499                    
    cpi         R18,0x3                                 
    brbs        CPU_C_bp, LAB_code_00048e                    
    rjmp        LAB_code_0004c0                         
LAB_code_000499:              
    brbc        CPU_N_bp, LAB_code_00049b                    
    neg         R18                                     
LAB_code_00049b:              
    lds         R16,TWIC_MASTER_CTRLA                   ;= ??
    andi        R16,0x30                                
    brbc        CPU_Z_bp, LAB_code_0004c1                    
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
    brbc        CPU_N_bp, LAB_code_0004be                    
    sbiw        R24,0x1                              
LAB_code_0004b0:              
    st          -Z,R25                                  
    st          -Z,R24                                  
    rcall       FUN_code_0004d3                         ;undefined FUN_code_0004d3(void)
    lds         R17,DAT_mem_2188                        ;= ??
    cp          R16,R17                                 
    brbs        CPU_Z_bp, LAB_code_0004c1                    
    sts         DAT_mem_2188,R16                        ;= ??
    eor         R17,R17                                 
    ldi         R18,0x18                                
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    rjmp        LAB_code_0004c1                         
LAB_code_0004be:              
    adiw        R24,0x1                              
    rjmp        LAB_code_0004b0                         
LAB_code_0004c0:              
    cbi         GPIO_GPIOR0,0x5                         
LAB_code_0004c1:              
    bset        CPU_I_bp                                    
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
    pop         YL                                     
    pop         YH                                     
    pop         ZL                                     
    pop         ZH                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0004d3(void)
    ldi         ZL,0x6d                                
    ldi         ZH,0x21                                
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
    push        YL                                     
    push        YH                                     
    push        ZL                                     
    ldi         R18,0x10                                
    ldi         YL,0x93                                
    ldi         YH,0x21                                
LAB_code_0004e9:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    cpi         R18,0x13                                
    brbc        CPU_Z_bp, LAB_code_0004f5                    
    lds         ZL,DAT_mem_2185                        ;= ??
    sbrc        ZL,0x4                                 
    rjmp        LAB_code_0004f4                         
    andi        ZL,0xc0                                
    or          R17,ZL                                 
    rjmp        LAB_code_0004f5                         
LAB_code_0004f4:              
    ori         R17,0x40                                
LAB_code_0004f5:              
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    inc         R18                                     
    cpi         R18,0x15                                
    brbc        CPU_Z_bp, LAB_code_0004e9                    
    eor         R18,R18                                 
LAB_code_0004fd:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        CPU_Z_bp, LAB_code_0004fd                    
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    ldi         R18,0x17                                
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    lds         R16,DAT_mem_2160                        ;= ??
    lds         R17,DAT_mem_2161                        ;= ??
    ldi         R18,0x15                                
    cli                                                 
    call        fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    pop         ZL                                     
    pop         YH                                     
    pop         YL                                     
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_done_int(void)
PORTD_INT0_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        R16                                     
    lds         R16,PORTD_IN                            ;= ??
    bst         R16,0b0000000000000101                   
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    bld         R16,0x4                                 
    sts         DAT_b_porte_1_5v_present,R16            ;= ??
    bset        CPU_I_bp                                    
    brbc        CPU_T_bp, LAB_code_00053c
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
    bset        CPU_I_bp                                    
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
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*  @brief PORTF4..5 interrupt routine                                                          *
;*                                                                                              *
;*  This function is triggered then at least one of                                             *
;*  the Si53301 input clocks is not present                                                     *
;************************************************************************************************
;undefined si53301_clk_not_present(void)
PORTF_INT1_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        R16                                     
    rcall       reset_system                            ;undefined reset_system(void)
    pop         R16                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
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
    push        YL                                     
    push        YH                                     
    push        ZL                                     
    push        ZH                                     
    ldi         YL,0x93                                
    ldi         YH,0x21                                
    ldi         ZL,0x6d                                
    ldi         ZH,0x21                                
LAB_code_00057d:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    st          Z+,R16                                  
    st          Z+,R17                                  
    cpi         YL,0x99                                
    brbc        CPU_Z_bp, LAB_code_00057d                    
    subi        YL,0x6                                 
    ldi         ZL,0x67                                
    ldi         ZH,0x21                                
LAB_code_000586:              
    ld          R16,Y+                                  
    ld          R17,Y+                                  
    cpi         YL,0x99                                
    brbc        CPU_Z_bp, LAB_code_00058b                    
    inc         R17                                     
LAB_code_00058b:              
    add         R16,R16                                 
    adc         R17,R17                                 
    add         R16,R16                                 
    adc         R17,R17                                 
    st          Z+,R16                                  
    st          Z+,R17                                  
    cpi         YL,0x99                                
    brbc        CPU_Z_bp, LAB_code_000586                    
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
    brbc        CPU_Z_bp, LAB_code_0005b3                    
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
    pop         ZH                                     
    pop         ZL                                     
    pop         YH                                     
    pop         YL                                     
    pop         R19                                     
    pop         R18                                     
    pop         R1                                      
    pop         R0                                      
    ret                                                 
;************************************************************************************************
;*                                @brief Catch Si5338 LOS or LOL                                *
;************************************************************************************************
;undefined si5338_int(void)
PORTC_INT0_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        R19                                     
    push        R20                                     
    lds         R16,PORTC_IN                            ;= ??
    eor         R19,R19                                 
    andi        R16,0b000000000000000000001100
    brbs        CPU_Z_bp, LAB_code_0005d7                    
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
    brbc        CPU_Z_bp, LAB_code_0005f7                    
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
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined 5V_present_or_Si53301_v_fault(void)
PORTE_INT0_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
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
    rjmp        caseD_66           
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
    brbc        CPU_T_bp, LAB_code_000637
    sbi         GPIO_GPIOR0,0x1                         
LAB_code_000636:              
    rcall       set_status_and_set_VD8_led              ;undefined set_status_and_set_VD8_led...
LAB_code_000637:              
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;void fpga_comm_request_int(void)
PORTE_INT1_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
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
    out         CPU_SREG,ZH                                
    pop         ZH                                     
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
    push        YL                                     
    push        YH                                     
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
    ldi         YL,0x63                                
    ldi         YH,0x21                                
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
    pop         YH                                     
    pop         YL                                     
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
PORTF_INT0_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        ZH                                     
    push        ZL                                     
    push        YH                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         ZL,0x4                                 
    ldi         ZH,0x20                                
    eor         YH,YH                                 
    lds         R16,PORTF_IN                            ;= ??
    sbrc        R16,0x1                                 
    rjmp        LAB_code_000716                         
    inc         YH                                     
    ld          R17,-Z                                  
    ld          R16,-Z                                  
    cp          R16,R17                                 
    brbs        CPU_Z_bp, LAB_code_000715                    
    lds         R18,USARTF0_STATUS                      ;= ??
    sbrs        R18,0x5                                 
    rjmp        LAB_code_000710                         
    eor         R17,R17                                 
    inc         R16                                     
    ldi         ZL,0x47                                
    ldi         ZH,0x20                                
    add         ZL,R16                                 
    adc         ZH,R17                                 
    ld          R17,Z                                   
    sts         USARTF0,R17                             ;= ??
    ldi         ZL,0x2                                 
    ldi         ZH,0x20                                
    st          Z,R16                                   
LAB_code_000710:              
    lds         R18,USARTF0_CTRLA                       ;= ??
    ori         R18,0x2                                 
    sts         USARTF0_CTRLA,R18                       ;= ??
LAB_code_000715:              
    adiw        Z,0x2                                   
LAB_code_000716:              
    st          Z,YH                                   
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         YH                                     
    pop         ZL                                     
    pop         ZH                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*                       @brief Send next byte to attenuator via USART D0                       *
;************************************************************************************************
;undefined USARTD0_DRE(void)
USARTD0_DRE_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        ZH                                     
    push        ZL                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         ZL,0x83                                
    ldi         ZH,0x21                                
    ld          R16,Z+                                  
    ld          R17,Z                                   
    cp          R16,R17                                 
    brbc        CPU_Z_bp, LAB_code_000734                    
    lds         R19,USARTD0_CTRLA                       ;= ??
    andi        R19,0xfc                                
    sts         USARTD0_CTRLA,R19                       ;= ??
caseD_80:                     
    rjmp        LAB_code_000741                         
LAB_code_000734:              
    inc         R16                                     
    andi        R16,0xf                                 
    eor         R17,R17                                 
    ldi         ZL,0x73                                
    ldi         ZH,0x21                                
    add         ZL,R16                                 
    adc         ZH,R17                                 
    ld          R17,Z                                   
    sts         USARTD0,R17                             ;= ??
    ldi         ZL,0x83                                
    ldi         ZH,0x21                                
    st          Z,R16                                   
LAB_code_000741:              
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         ZL                                     
    pop         ZH                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usartd0_rx_int(void)
USARTD0_RXC_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        ZH                                     
    push        ZL                                     
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
    brbs        CPU_C_bp, LAB_code_000792                    
    andi        R19,0xf                                 
    brbs        CPU_Z_bp, LAB_code_000792                    
    eor         R17,R17                                 
    ldi         ZL,0x36                                
    ldi         ZH,0x2b                                
    sub         ZL,R19                                 
    sbc         ZH,R17                                 
    lpm         R17,Z                                   
    cp          R16,R17                                 
    brbs        CPU_Z_bp, LAB_code_00076c                    
    ldi         R19,0x8                                 
    rjmp        LAB_code_00078e                         
LAB_code_00076c:              
    dec         R19                                     
    brbc        CPU_Z_bp, LAB_code_00078e                    
    cpi         R18,0x91                                
    brbc        CPU_Z_bp, LAB_code_000772                    
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
    brbc        CPU_Z_bp, LAB_code_000785                    
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    eor         R19,R19                                 
    rjmp        LAB_code_000790                         
LAB_code_000785:              
    sts         DAT_mem_2186,R16                        ;= ??
    sts         DAT_mem_2187,R17                        ;= ??
    bset        CPU_I_bp                                    
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
    pop         ZL                                     
    pop         ZH                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*  @brief USARTF0 data ready int.                                                              *
;*                                                                                              *
;*  Send bytes when ready                                                                       *
;************************************************************************************************
;undefined usart_f0_dre_int(void)
USARTF0_DRE_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        ZH                                     
    push        ZL                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         ZL,0x2                                 
    ldi         ZH,0x20                                
    ld          R16,Z+                                  
    ld          R17,Z+                                  
    ld          R18,Z                                   
    and         R18,R18                                 
    brbs        CPU_Z_bp, LAB_code_0007ac                    
    cp          R16,R17                                 
    brbc        CPU_Z_bp, LAB_code_0007b2                    
LAB_code_0007ac:              
    lds         R19,USARTF0_CTRLA                       ;= ??
    andi        R19,0xfc                                
    sts         USARTF0_CTRLA,R19                       ;= ??
    rjmp        LAB_code_0007be                         
LAB_code_0007b2:              
    inc         R16                                     
    eor         R17,R17                                 
    ldi         ZL,0x47                                
    ldi         ZH,0x20                                
    add         ZL,R16                                 
    adc         ZH,R17                                 
    ld          R17,Z                                   
    sts         USARTF0,R17                             ;= ??
    ldi         ZL,0x2                                 
    ldi         ZH,0x20                                
    st          Z,R16                                   
LAB_code_0007be:              
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         ZL                                     
    pop         ZH                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
    reti                                                
;************************************************************************************************
;*  @brief USARTF0 RX int                                                                       *
;*                                                                                              *
;*  Store incoming bytes from USARTF0                                                           *
;************************************************************************************************
;undefined usart_f0_rx_int(void)
USARTF0_RXC_vect_isr:
    push        ZH                                     
    in          ZH,CPU_SREG                                
    push        ZH                                     
    push        ZL                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    ldi         ZL,0x0                                 
    ldi         ZH,0x20                                
    ld          R16,Z+                                  
    ld          R17,Z                                   
    inc         R17                                     
    andi        R17,0x3f                                
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cp          R18,R16                                 
    brbc        CPU_Z_bp, usart_f0_rx_buffer_full_endif      
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
    brbs        CPU_Z_bp, usart_f0_rx_ferr_endif             
    st          Z,R17                                   
    ldi         ZL,0x7                                 
    ldi         ZH,0x20                                
    eor         R16,R16                                 
    add         ZL,R17                                 
    adc         ZH,R16                                 
    st          Z,R18                                   
    cpi         R18,0xd                                 
    brbc        CPU_Z_bp, usart_f0_rx_ferr_endif             
    lds         R16,DAT_usart_f0_new_line               ;= ??
    inc         R16                                     
    sts         DAT_usart_f0_new_line,R16               ;= ??
usart_f0_rx_ferr_endif:       
    pop         R16                                     
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         ZL                                     
    pop         ZH                                     
    out         CPU_SREG,ZH                                
    pop         ZH                                     
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
    ldi         R16,0b000000000000000011111011
    sts         PORTA_DIRSET,R16                        ;= ??
    ldi         R16,0b000000000000000011110011          
    sts         PORTA_OUTSET,R16                        ;= ??
    ldi         R16,0x18                                
    sts         PORTA_PIN2CTRL,R16                      ;= ??
    ldi         R16,0x80                                
    sts         PORTA_PIN1CTRL,R16                      ;= ??
    sts         PORTA_PIN3CTRL,R16                      ;= ??
    sts         PORTA_PIN4CTRL,R16                      ;= ??
    ldi         R16,0b000000000000000000011111
    sts         PORTB_DIRSET,R16                        ;= ??
    ldi         R16,0b000000000000000000010000          
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
    ldi         R16,0b000000000000000000000010
    sts         PORTD_OUTSET,R16                        ;= ??
    ldi         R16,0b000000000000000000010010
    sts         PORTD_DIRSET,R16                        ;= ??
    ldi         R16,0x0                                 
    sts         PORTD_PIN5CTRL,R16                      ;= ??
    ldi         R16,0x10                                
    sts         PORTD_PIN6CTRL,R16                      ;= ??
    sts         PORTD_PIN7CTRL,R16                      ;= ??
    ldi         R16,0b000000000000000000000100
    sts         PORTE_DIRSET,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         PORTE_PIN0CTRL,R16                      ;= ??
    ldi         R16,0x0                                 
    sts         PORTE_PIN1CTRL,R16                      ;= ??
    ldi         R16,0x80                                
    sts         PORTE_PIN2CTRL,R16                      ;= ??
    ldi         R16,0x0                                 
    sts         PORTE_PIN3CTRL,R16                      ;= ??
    ldi         R16,0b000000000000000000001010
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
    ldi         R16,0b000000000000000000110000
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
    ldi         R16,0b000000000000000000000110
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
    ldi         R16,0b000000000000000000001000
    sts         NVM_CTRLB,R16                           ;= ??
    eor         R25,R25                                 
    out         GPIO_GPIOR0,R25                         
;Clear 0x2000 - 0x23b2 (some bigger struct)
    ldi         ZL,0x0                                 
    ldi         ZH,0x20                                
    ldi         YL,0xb2                                
    ldi         YH,0x23                                
LAB_code_0008cc:              
    st          Z+,R25                                  
    cp          ZL,YL                                 
    cpc         ZH,YH                                 
    brbc        CPU_Z_bp, LAB_code_0008cc                    
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
    brbs        CPU_T_bp, LAB_code_0008e3
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
    ldi         ZL,0x89                                
    ldi         ZH,0x21                                
    ldi         YL,0x0                                 
    ldi         YH,0x10                                
    ldi         R17,0x21                                
LAB_code_00090c:              
    ld          R16,Y+                                  
    st          Z+,R16                                  
    cpi         ZL,0xae                                
    cpc         ZH,R17                                 
    brbc        CPU_Z_bp, LAB_code_00090c                    
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
    bset        CPU_I_bp                                    
;; USART send "INR TCM control interface ready"
    ldi         ZL,0x96                                
    ldi         ZH,0x29                                
    call        usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         R16,0x1                                 
    sts         PORTF_OUTCLR,R16                        ;= ??
LAB_code_000927:              
    lds         R16,DAT_fpga_comm_request               ;= ??
    and         R16,R16                                 
    brbs        CPU_Z_bp, LAB_code_00092c                    
    rcall       fpga_exchange_data                      ;undefined fpga_exchange_data(void)
LAB_code_00092c:              
    lds         R16,DAT_usart_f0_new_line               ;= ??
    and         R16,R16                                 
    brbs        CPU_Z_bp, LAB_code_000927                    
    rcall       usart_f0_parse_prompt                   ;undefined usart_f0_parse_prompt(void)
    rjmp        LAB_code_000927                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_exchange_data(void)
    eor         R16,R16                                 
    cli                                                 
    sts         DAT_fpga_comm_request,R16               ;= ??
    ldi         YL,0x93                                
    ldi         YH,0x21                                
    ldi         R18,0xf8                                
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrc        R15,0x3                                 
    rjmp        LAB_code_00093f                         
LAB_code_00093d:              
    bset        CPU_I_bp                                    
    ret                                                 
LAB_code_00093f:              
    rcall       fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        CPU_I_bp                                    
    ldi         R18,0x10                                
    mov         R15,R16                                 
LAB_code_000943:              
    lsr         R15                                     
    brbs        CPU_C_bp, AB_code_000947                    
    adiw        Y,0x2                                   
    rjmp        LAB_code_0009b0                         
LAB_code_000947:              
    cli                                                 
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        CPU_I_bp                                    
    cpi         R18,0x13                                
    brbs        CPU_Z_bp, LAB_code_00096c                    
    brbs        CPU_C_bp, LAB_code_000952                    
    rjmp        LAB_code_000995                         
LAB_code_000952:              
    ldi         R24,0x4                                 
    cpi         R16,0x1                                 
    cpc         R17,R24                                 
    brbc        CPU_S_bp, LAB_code_00095d                    
    ldi         R24,0xfc                                
    cpi         R16,0x0                                 
    cpc         R17,R24                                 
    brbc        CPU_S_bp, LAB_code_000966                    
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
    bset        CPU_I_bp                                    
LAB_code_000966:              
    cli                                                 
    st          Y+,R16                                  
    st          Y+,R17                                  
    sbi         GPIO_GPIOR0,0x5                         
    bset        CPU_I_bp                                    
    rjmp        LAB_code_0009b0                         
LAB_code_00096c:              
    ldi         R24,0x2e                                
    cpi         R16,0xe1                                
    cpc         R17,R24                                 
    brbs        CPU_C_bp, LAB_code_000972                    
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
    brbc        CPU_Z_bp, LAB_code_00098a                    
    cp          R16,R20                                 
    cpc         R17,R21                                 
    brbs        CPU_Z_bp, LAB_code_000993                    
    sts         DAT_mem_2186,R16                        ;= ??
    sts         DAT_mem_2187,R17                        ;= ??
    bset        CPU_I_bp                                    
    call        attenuator_set_steps                    ;undefined attenuator_set_steps(void)
    ori         R24,0x48                                
    sts         DAT_mem_2185,R24                        ;= ??
    rjmp        LAB_code_00098d                         
LAB_code_00098a:              
    brbc        CPU_N_bp, LAB_code_00098d                    
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
    bset        CPU_I_bp                                    
    rjmp        LAB_code_0009b0                         
LAB_code_000995:              
    cpi         R16,0x10                                
    brbc        CPU_C_bp, LAB_code_000999                    
    and         R17,R17                                 
    brbs        CPU_Z_bp, LAB_code_0009a2                    
LAB_code_000999:              
    eor         R17,R17                                 
    andi        R16,0xf                                 
    cli                                                 
    lds         R15,PORTE_INTCTRL                       ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
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
    bset        CPU_I_bp                                    
LAB_code_0009b0:              
    inc         R18                                     
    cpi         R18,0x15                                
    brbs        CPU_Z_bp, LAB_code_0009b4                    
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
    brbc        CPU_Z_bp, LAB_code_0009c1                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x43                                
    brbc        CPU_Z_bp, LAB_code_0009ec                    
    rjmp        LAB_code_000a88                         
LAB_code_0009c1:              
    cpi         R16,0x43                                
    brbc        CPU_Z_bp, LAB_code_0009ce                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        CPU_Z_bp, LAB_code_0009c8                    
    rjmp        resolve_ca_msg                          ;undefined resolve_ca_msg(void)
LAB_code_0009c8:              
    cpi         R16,0x4c                                
    brbc        CPU_Z_bp, LAB_code_0009cb                    
    rjmp        LAB_code_000ab6                         
LAB_code_0009cb:              
    cpi         R16,0x50                                
    brbc        CPU_Z_bp, LAB_code_0009ec                    
    rjmp        LAB_code_000aa2                         
LAB_code_0009ce:              
    cpi         R16,0x4f                                
    brbc        CPU_Z_bp, LAB_code_0009d8                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x4e                                
    brbc        CPU_Z_bp, LAB_code_0009d5                    
    rjmp        LAB_code_000a37                         
LAB_code_0009d5:              
    cpi         R16,0x46                                
    brbc        CPU_Z_bp, LAB_code_0009ec                    
    rjmp        LAB_code_000a85                         
LAB_code_0009d8:              
    cpi         R16,0x50                                
    brbc        CPU_Z_bp, LAB_code_0009e2                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        CPU_Z_bp, LAB_code_0009df                    
    rjmp        LAB_code_000aeb                         
LAB_code_0009df:              
    cpi         R16,0x46                                
    brbc        CPU_Z_bp, LAB_code_0009ec                    
    rjmp        fpga_firmware_update                    ;undefined fpga_firmware_update(void)
LAB_code_0009e2:              
    cpi         R16,0x52                                
    brbc        CPU_Z_bp, LAB_code_0009ed                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x50                                
    brbc        CPU_Z_bp, LAB_code_0009e9                    
    rjmp        usart_f0_send_system_params             ;undefined usart_f0_send_system_param...
LAB_code_0009e9:              
    cpi         R16,0x53                                
    brbc        CPU_Z_bp, LAB_code_0009ec                    
    rjmp        usart_f0_send_system_status             ;undefined usart_f0_send_system_statu...
LAB_code_0009ec:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_0009ed:              
    cpi         R16,0x53                                
    brbc        CPU_Z_bp, LAB_code_000a15                    
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        CPU_Z_bp, LAB_code_0009f4                    
    rjmp        fpga_set_a_side_phase                   ;undefined fpga_set_a_side_phase(void)
LAB_code_0009f4:              
    cpi         R16,0x43                                
    brbc        CPU_Z_bp, LAB_code_0009f7                    
    rjmp        fpga_set_c_side_phase                   ;undefined fpga_set_c_side_phase(void)
LAB_code_0009f7:              
    cpi         R16,0x49                                
    brbc        CPU_Z_bp, LAB_code_0009fa                    
    rjmp        fpga_set_IP_addr                        ;undefined fpga_set_IP_addr(void)
LAB_code_0009fa:              
    cpi         R16,0x4c                                
    brbc        CPU_Z_bp, LAB_code_0009fd                    
    rjmp        fpga_set_laser_phase                    ;undefined fpga_set_laser_phase(void)
LAB_code_0009fd:              
    cpi         R16,0x4d                                
    brbc        CPU_Z_bp, LAB_code_000a00                    
    rjmp        fpga_set_mac_addr                       ;undefined fpga_set_mac_addr(void)
LAB_code_000a00:              
    cpi         R16,0x53                                
    brbc        CPU_Z_bp, LAB_code_000a03                    
    rjmp        fpga_set_switches                       ;undefined fpga_set_switches(void)
LAB_code_000a03:              
    cpi         R16,0x54                                
    brbc        CPU_Z_bp, LAB_code_000a0f                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x48                                
    brbc        CPU_Z_bp, LAB_code_000a09                    
    rjmp        fpga_set_vertex_time_high_th            ;undefined fpga_set_vertex_time_high_...
LAB_code_000a09:              
    cpi         R16,0x4c                                
    brbc        CPU_Z_bp, LAB_code_000a0c                    
    rjmp        fpga_set_vertex_time_low_th             ;undefined fpga_set_vertex_time_low_t...
LAB_code_000a0c:              
    cpi         R16,0x4d                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rjmp        fpga_set_trigger_mode                   ;undefined fpga_set_trigger_mode(void)
LAB_code_000a0f:              
    cpi         R16,0x56                                
    brbc        CPU_Z_bp, LAB_code_000a12                    
    rjmp        LAB_code_000ad7                         
LAB_code_000a12:              
    cpi         R16,0x57                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rjmp        set_attenuator_steps                    ;undefined set_attenuator_steps(void)
LAB_code_000a15:              
    cpi         R16,0x54                                
    brbc        CPU_Z_bp, LAB_code_000a2a                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x48                                
    brbc        CPU_Z_bp, LAB_code_000a21                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        CPU_Z_bp, LAB_code_000a1e                    
    rjmp        fpga_set_central_lvl_a                  ;undefined fpga_set_central_lvl_a(void)
LAB_code_000a1e:              
    cpi         R16,0x43                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rjmp        fpga_set_central_lvl_c                  ;undefined fpga_set_central_lvl_c(void)
LAB_code_000a21:              
    cpi         R16,0x4d                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x41                                
    brbc        CPU_Z_bp, LAB_code_000a27                    
    rjmp        fpga_set_semicentral_lvl_a              ;undefined fpga_set_semicentral_lvl_a...
LAB_code_000a27:              
    cpi         R16,0x43                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rjmp        fpga_set_semicentral_lvl_c              ;undefined fpga_set_semicentral_lvl_c...
LAB_code_000a2a:              
    cpi         R16,0x57                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x52                                
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    rjmp        save_settings_to_eeprom                 ;undefined save_settings_to_eeprom(void)
usart_f0_collect_msg_line:    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
usart_f0_collect_msg_line_2:  
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, usart_f0_collect_msg_line          
;; Send "Syntax error"
    ldi         ZL,0xbe                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000a37:              
    ldi         R20,0x1                                 
LAB_code_000a38:              
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, usart_f0_collect_msg_line_2        
    lds         R16,DAT_mem_21ad                        ;= ??
    cp          R16,R20                                 
    brbc        CPU_Z_bp, LAB_code_000a41                    
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
    bset        CPU_I_bp                                    
LAB_code_000a52:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a52                         
    ldi         YL,0x24                                
    ldi         YH,0x10                                
    st          Y,R20                                   
    ldi         R16,0x35                                
    sts         NVM_CMD,R16                             ;= ??
    sts         NVM,YL                                 ;= ??
    sts         NVM_ADDR1,YH                           ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        CPU_I_bp                                    
LAB_code_000a68:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a68                         
    and         R20,R20                                 
    brbc        CPU_Z_bp, LAB_code_000a84                    
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
    bset        CPU_I_bp                                    
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
    brbc        CPU_Z_bp, LAB_code_000a87                    
    cli                                                 
    lds         R16,DAT_mem_2185                        ;= ??
    ori         R16,0x20                                
    sts         DAT_mem_2185,R16                        ;= ??
    bset        CPU_I_bp                                    
usart_f0_parse_prompt_while_not_esc:
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x1b                                
    brbs        CPU_Z_bp, usart_f0_parse_prompt_while_not_esc_end             
    call        USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    rjmp        usart_f0_parse_prompt_while_not_esc     
usart_f0_parse_prompt_while_not_esc_end:
    cli                                                 
    lds         R16,DAT_mem_2185                        ;= ??
    andi        R16,0xdf                                
    sts         DAT_mem_2185,R16                        ;= ??
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
LAB_code_000aa2:              
    call        usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000ad6                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000aa9                    
    ret                                                 
LAB_code_000aa9:              
    eor         R18,R18                                 
    ldi         YL,0x9d                                
    ldi         YH,0x21                                
LAB_code_000aac:              
    cli                                                 
    call        fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        CPU_I_bp                                    
    st          Y+,R16                                  
    st          Y+,R17                                  
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        CPU_Z_bp, LAB_code_000aac                    
    rjmp        LAB_code_000efe                         
LAB_code_000ab6:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000ad6                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    mov         R20,R16                                 
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000ad6                    
    lds         R16,DAT_clk_frs                         ;= ??
    cpi         R20,0x31                                
    brbs        CPU_Z_bp, LAB_code_000aca                    
    cpi         R20,0x30                                
    brbc        CPU_Z_bp, LAB_code_000ad6                    
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
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
LAB_code_000ad6:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_000ad7:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000ad6                    
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        CPU_C_bp, LAB_code_000ad6                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000ad6                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000ae1                    
    ret                                                 
LAB_code_000ae1:              
    sts         DAT_mem_21ab,R20                      ;= ??
    sts         DAT_mem_21ac,R21                   
    ldi         R18,0x17                                
    movw        R16,R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
LAB_code_000aeb:              
    rcall       unlock_programming                      ;undefined unlock_programming(void)
    brbs        CPU_C_bp, LAB_code_000ad6                    
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         ZL,R16                                 
    mov         R20,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         ZH,R16                                 
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
    brbc        CPU_S_bp, LAB_code_000ad6                    
    cp          R3,ZL                                  
    cpc         R4,ZH                                  
    cpc         R5,R22                                  
    brbs        CPU_C_bp, LAB_code_000ad6                    
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
    bset        CPU_I_bp                                    
    jmp         xmega_firmware_update                   ;undefined xmega_firmware_update(void)
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined unlock_programming(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000b2f                    
    ldi         ZL,0x74                                
    ldi         ZH,0x2b                                
LAB_code_000b24:              
    lpm         R17,Z+                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    cp          R16,R17                                 
    brbc        CPU_Z_bp, LAB_code_000b2f                    
    cpi         ZL,0x7c                                
    brbc        CPU_Z_bp, LAB_code_000b24                    
    ldi         ZL,0xce                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    clc                                                 
    ret                                                 
LAB_code_000b2f:              
    bset        CPU_C_bp                                    
    ret                                                 
LAB_code_000b31:              
    rjmp        usart_f0_collect_msg_line_2             
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_firmware_update(void)
    rcall       unlock_programming                      ;undefined unlock_programming(void)
    brbs        CPU_C_bp, LAB_code_000b31                    
    ldi         R16,0x2                                 
    sts         PORTD_OUTCLR,R16                        ;= ??
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    ldi         R16,0xb0                                
    sts         PORTE_DIRSET,R16                        ;= ??
    ldi         R16,0x50                                
    sts         SPIE,R16                                ;= ??
    eor         R16,R16                                 
    ldi         XL,0xae                                
    ldi         XH,0x23                                
    st          X+,R16                                  
    st          X+,R16                                  
    st          X+,R16                                  
    st          X,R16                                   
    rcall       fpga_get_fl_type_and_code_size          ;undefined fpga_get_fl_type_and_code_...
    eor         R17,R17                                 
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    movw        R16,R18                           
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    rcall       usart_f0_send_cr                        ;undefined usart_f0_send_cr(void)
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         YL,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         YH,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         ZL,R16                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R0,R16                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R1,R16                                  
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    mov         R2,R16                                  
    movw        R20,Y                                
    mov         R22,ZL                                 
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
    brbs        CPU_Z_bp, LAB_code_000b6a                    
    eor         R17,R17                                 
LAB_code_000b6a:              
    lds         R24,DAT_mem_23ae                        ;= ??
    lds         R25,DAT_mem_23af                        ;= ??
LAB_code_000b6e:              
    ldi         XL,0xae                                
    ldi         XH,0x21                                
    add         XL,R24                                 
    adc         XH,R25                                 
    rcall       uart_f0_get_next_byte                   ;undefined uart_f0_get_next_byte(void)
    st          X,R16                                   
    adiw        R24,0x1                              
    andi        R25,0x1                                 
    dec         R17                                     
    brbc        CPU_Z_bp, LAB_code_000b6e                    
    sts         DAT_mem_23ae,R24                        ;= ??
    sts         DAT_mem_23af,R25                        ;= ??
    rcall       FUN_code_000be7                         ;undefined FUN_code_000be7(void)
    rcall       FUN_code_000ba3                         ;undefined FUN_code_000ba3(void)
    brbs        CPU_C_bp, LAB_code_000b83                    
    and         R21,R21                                 
    brbc        CPU_Z_bp, LAB_code_000b5c                    
    rcall       FUN_code_000be7                         ;undefined FUN_code_000be7(void)
    rjmp        LAB_code_000b5b                         
LAB_code_000b83:              
    rcall       FUN_code_000be7                         ;undefined FUN_code_000be7(void)
    rcall       FUN_code_000c03                         ;undefined FUN_code_000c03(undefined2...
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    movw        R16,R18                           
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
    bset        CPU_I_bp                                    
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
    ldi         XL,0xae                                
    ldi         XH,0x21                                
    add         XL,R24                                 
    adc         XH,R25                                 
    ld          R16,X                                   
    adiw        R24,0x1                              
    andi        R25,0x1                                 
    sts         SPIE_DATA,R16                           ;= ??
LAB_code_000bb3:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bb3                         
    cp          R0,R20                                  
    cpc         R1,R21                                  
    cpc         R2,R22                                  
    brbc        CPU_Z_bp, LAB_code_000bc4                    
    sts         DAT_mem_23b0,R24                        ;= ??
    sts         DAT_mem_23b1,R25                        ;= ??
    ldi         R16,0x10                                
    sts         PORTE_OUTSET,R16                        ;= ??
    bset        CPU_C_bp                                    
    ret                                                 
LAB_code_000bc4:              
    subi        R20,0xff                                
    sbci        R21,0xff                                
    sbci        R22,0xff                                
    and         R20,R20                                 
    brbc        CPU_Z_bp, LAB_code_000baa                    
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
    sbiw        R24,0x1                              
    brbc        CPU_Z_bp, LAB_code_000be9                    
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
    sts         SPIE_DATA,ZL                           ;= ??
LAB_code_000c10:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c10                         
    sts         SPIE_DATA,YH                           ;= ??
LAB_code_000c16:              
    lds         R19,SPIE_STATUS                         ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c16                         
    sts         SPIE_DATA,YL                           ;= ??
    ser         R16                                     
    ser         R17                                     
    ser         R18                                     
    ser         R19                                     
    ldi         R23,0xb7                            
    ldi         R24,0x1d                            
    ldi         R25,0xc1                            
    ldi         XL,0x4                                 
LAB_code_000c24:              
    lds         R22,SPIE_STATUS                     ;= ??
    sbrs        R22,0x7                             
    rjmp        LAB_code_000c24                         
OFF_code_000c28:              
    sts         SPIE_DATA,R10                           ;= ??
LAB_code_000c2a:              
    lds         R22,SPIE_STATUS                     ;= ??
    sbrs        R22,0x7                             
    rjmp        LAB_code_000c2a                         
    lds         R22,SPIE_DATA                       ;= ??
    cp          R0,YL                                  
    cpc         R1,YH                                  
    cpc         R2,ZL                                  
    brbs        CPU_Z_bp, LAB_code_000c3a                    
    sts         SPIE_DATA,R10                           ;= ??
    rcall       FUN_code_000c3c                         ;undefined FUN_code_000c3c(undefined2...
    adiw        Y,0x1                                   
    adc         ZL,R10                                 
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
    ldi         R20,0x8                             
LAB_code_000c3d:              
    add         R18,R18
    adc         R19,R19
    adc         R16,R16
    adc         R17,R17
    brbc        CPU_C_bp, LAB_code_000c45                    
    lsr         R22                                 
    brbs        CPU_C_bp, LAB_code_000c4b                    
    rjmp        LAB_code_000c47                         
LAB_code_000c45:              
    lsr         R22
    brbc        CPU_C_bp, LAB_code_000c4b                    
LAB_code_000c47:              
    eor         R18,R23
    eor         R19,R24
    eor         R16,R25
    eor         R17,XL                             
LAB_code_000c4b:              
    dec         R20                                 
    brbc        CPU_Z_bp, LAB_code_000c3d                    
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
    sts         SPIE_DATA,R16                     ;= ??
LAB_code_000c53:              
    lds         R19,SPIE_STATUS                     ;= ??
    sbrs        R19,0x7                             
    rjmp        LAB_code_000c53                         
    sts         SPIE_DATA,R22                       ;= ??
LAB_code_000c59:              
    lds         R19,SPIE_STATUS                     ;= ??
    sbrs        R19,0x7                             
    rjmp        LAB_code_000c59                         
    sts         SPIE_DATA,R21                       ;= ??
LAB_code_000c5f:              
    lds         R19,SPIE_STATUS                     ;= ??
    sbrs        R19,0x7                             
    rjmp        LAB_code_000c5f                         
    sts         SPIE_DATA,R20                       ;= ??
LAB_code_000c65:              
    lds         R19,SPIE_STATUS                     ;= ??
    sbrs        R19,0x7                             
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
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_system_params(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000c91                    
    ldi         YL,0x93                                
    ldi         YH,0x21                                
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
    ldi         YL,0xa1                                
    ldi         YH,0x21                                
    ldi         R18,0x2                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_semicentral_lvl_c(void)
    ldi         YL,0xa3                                
    ldi         YH,0x21                                
    ldi         R18,0x3                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_central_lvl_a(void)
    ldi         YL,0xa5                                
    ldi         YH,0x21                                
    ldi         R18,0x4                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_central_lvl_c(void)
    ldi         YL,0xa7                                
    ldi         YH,0x21                                
    ldi         R18,0x5                                 
LAB_code_000ce2:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000d13                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000d13                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000d13                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000cec                    
    ret                                                 
LAB_code_000cec:              
    st          Y+,R20                                  
    st          Y+,R21                                  
    movw        R16,R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_vertex_time_high_th(void)
    ldi         YL,0x9f                                
    ldi         YH,0x21                                
    ldi         R18,0x1                                 
    rjmp        LAB_code_000cfa                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_vertex_time_low_th(void)
    ldi         YL,0x9d                                
    ldi         YH,0x21                                
    ldi         R18,0x0                                 
LAB_code_000cfa:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000d13                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000d13                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000d13                    
    ldi         R17,0xfe                                
    cpi         R20,0x0                                 
    cpc         R21,R17                                 
    brbs        CPU_S_bp, LAB_code_000d13                    
    ldi         R17,0x2                                 
    cpi         R20,0x0                                 
    cpc         R21,R17                                 
    brbc        CPU_S_bp, LAB_code_000d13                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000d0c                    
    ret                                                 
LAB_code_000d0c:              
    st          Y+,R20                                  
    st          Y+,R21                                  
    movw        R16,R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
LAB_code_000d13:              
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined save_settings_to_eeprom(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000d13                    
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
    bset        CPU_I_bp                                    
    ldi         ZL,0x89                                
    ldi         ZH,0x21                                
    ser         YL                                     
    ldi         YH,0xf                                 
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
    brbs        CPU_Z_bp, LAB_code_000d37                    
    st          Y,R16                                   
    ldi         R19,0x1                                 
LAB_code_000d37:              
    cpi         ZL,0xae                                
    cpc         ZH,R20                                 
    brbs        CPU_Z_bp, LAB_code_000d40                    
    mov         R18,YL                                 
    andi        R18,0x1f                                
    cpi         R18,0x1f                                
    brbc        CPU_Z_bp, LAB_code_000d30                    
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
    brbs        CPU_Z_bp, LAB_code_000d58                    
    ldi         R16,0x35                                
    sts         NVM_CMD,R16                             ;= ??
    sts         NVM,YL                                 ;= ??
    sts         NVM_ADDR1,YH                           ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         CPU_CCP,R17                             ;= ??
    sts         NVM_CTRLA,R16                           ;= ??
    bset        CPU_I_bp                                    
LAB_code_000d53:              
    lds         R16,NVM_STATUS                          ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d53                         
    eor         R19,R19                                 
LAB_code_000d58:              
    ret                                                 
LAB_code_000d59:              
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_system_status(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000d59                    
    ldi         ZL,0x54                                
    ldi         ZH,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    lds         R16,DAT_mem_21ab                      ;= ??
    lds         R17,DAT_mem_21ac                   
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    ldi         ZL,0x60                                
    ldi         ZH,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x7c                                
    ldi         ZH,0x2b                                
    lpm         R18,Z+                                  
    lpm         R19,Z+                                  
    lpm         R16,Z+                                  
    lpm         R17,Z+                                  
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    movw        R16,R18                           
    rcall       usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    ldi         ZL,0xdc                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    cli                                                 
    lds         R18,DAT_b_porte_1_5v_present            ;= ??
    lds         R16,DAT_mem_2160                        ;= ??
    lds         R17,DAT_mem_2161                        ;= ??
    lds         R20,PORTE_IN                            ;= ??
    bset        CPU_I_bp                                    
    ldi         ZL,0xce                                
    ldi         ZH,0x29                                
    sbrc        R18,0x0                                 
    rjmp        LAB_code_000d84                         
    ldi         ZL,0xd4                                
    ldi         ZH,0x29                                
LAB_code_000d84:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    mov         R19,R18                                 
    ldi         ZL,0xf6                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rcall       uartf0_send_temperature                 ;undefined uartf0_send_temperature(void)
    ldi         ZL,0x4                                 
    ldi         ZH,0x2a                                
    andi        R19,0x6                                 
    brbs        CPU_Z_bp, LAB_code_000d98                    
    ldi         ZL,0x18                                
    ldi         ZH,0x2a                                
    cpi         R19,0x6                                 
    brbs        CPU_Z_bp, LAB_code_000d98                    
    ldi         ZL,0x12                                
    ldi         ZH,0x2a                                
    andi        R19,0x4                                 
    brbc        CPU_Z_bp, LAB_code_000d98                    
    ldi         ZL,0xc                                 
    ldi         ZH,0x2a                                
LAB_code_000d98:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x22                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    sbrc        R20,0x2                                 
    rjmp        LAB_code_000da2                         
    ldi         ZL,0x38                                
    ldi         ZH,0x2a                                
LAB_code_000da0:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000da2:              
    ldi         ZL,0x32                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0xce                                
    ldi         ZH,0x29                                
    sbrc        R18,0x3                                 
    rjmp        LAB_code_000dae                         
    ldi         ZL,0xd4                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    sbrs        R18,0x6                                 
    ret                                                 
LAB_code_000dae:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x5e                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    lds         R19,DAT_clk_frs                         ;= ??
    ldi         ZL,0x6c                                
    ldi         ZH,0x2a                                
    sbrc        R19,0x1                                 
    rjmp        LAB_code_000dc3                         
    ldi         ZL,0x74                                
    ldi         ZH,0x2a                                
    sbrc        R19,0x2                                 
    rjmp        LAB_code_000dc3                         
    ldi         ZL,0x7e                                
    ldi         ZH,0x2a                                
    sbrs        R19,0x3                                 
    rjmp        LAB_code_000dc3                         
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x88                                
    ldi         ZH,0x2a                                
LAB_code_000dc3:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x92                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x9a                                
    ldi         ZH,0x2a                                
    sbrs        R19,0x0                                 
    rjmp        LAB_code_000dcd                         
    ldi         ZL,0x9e                                
    ldi         ZH,0x2a                                
LAB_code_000dcd:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0xba                                
    ldi         ZH,0x2a                                
    sbrc        R18,0x4                                 
    rjmp        LAB_code_000dd5                         
    ldi         ZL,0xa8                                
    ldi         ZH,0x2a                                
    rjmp        LAB_code_000da0                         
LAB_code_000dd5:              
    lds         R20,DAT_mem_2158                        ;= ??
    ldi         ZL,0xd0                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0xe2                                
    ldi         ZH,0x2a                                
    sbrc        R20,0x2                                 
    rjmp        LAB_code_000de0                         
    ldi         ZL,0x38                                
    ldi         ZH,0x2a                                
LAB_code_000de0:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0xea                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x38                                
    ldi         ZH,0x2a                                
    sbrc        R20,0x0                                 
    rjmp        LAB_code_000dea                         
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_000df4                         
LAB_code_000dea:              
    ldi         ZL,0x32                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0xf4                                
    ldi         ZH,0x2a                                
    sbrs        R20,0x1                                 
    rjmp        LAB_code_000df3                         
    ldi         ZL,0x2                                 
    ldi         ZH,0x2b                                
LAB_code_000df3:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
LAB_code_000df4:              
    ldi         ZL,0x10                                
    ldi         ZH,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x89                                
    ldi         ZH,0x21                                
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
    ldi         ZL,0x1e                                
    ldi         ZH,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         ZL,0x93                                
    ldi         ZH,0x21                                
LAB_code_000e0c:              
    ld          R16,-Z                                  
    ld          R17,-Z                                  
    call        usart_f0_send_32bit_hex_value           ;undefined usart_f0_send_32bit_hex_va...
    cpi         ZL,0x8d                                
    brbs        CPU_Z_bp, LAB_code_000e15                    
    ldi         R16,0x3a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_000e0c                         
LAB_code_000e15:              
    ldi         ZL,0xba                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000e19:              
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined resolve_ca_msg(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000e19                    
    cli                                                 
    lds         R16,DAT_b_porte_1_5v_present            ;= ??
    in          R17,GPIO_GPIOR0                         
    andi        R17,0x3                                 
    brbc        CPU_Z_bp, LAB_code_000e2c                    
    lds         R16,DAT_mem_2158                        ;= ??
    andi        R16,0xfd                                
    sts         DAT_mem_2158,R16                        ;= ??
    bset        CPU_I_bp                                    
    ldi         ZL,0x3e                                
    ldi         ZH,0x2a                                
    rjmp        LAB_code_000e4f                         
LAB_code_000e2c:              
    andi        R16,0x7                                 
    cpi         R16,0x1                                 
    brbs        CPU_Z_bp, LAB_code_000e33                    
    bset        CPU_I_bp                                    
    ldi         ZL,0xd4                                
    ldi         ZH,0x29                                
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
    ldi         R16,0b000000000000000000000100
    sts         PORTE_OUTCLR,R16                        ;= ??
    ldi         R16,0xd0                                
    sts         DAT_mem_215c,R16                        ;= ??
    ldi         R16,0x7                                 
    sts         DAT_mem_215d,R16                        ;= ??
    cbi         GPIO_GPIOR0,0x1                         
    ldi         R16,0b000000000000000001000001
    sts         PORTA_OUTSET,R16                        ;= ??
    bset        CPU_I_bp                                    
;; Send "OK"
    ldi         ZL,0xce                                
    ldi         ZH,0x29                                
LAB_code_000e4f:              
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000e51:              
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_IP_addr(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000e51                    
    and         R21,R21                                 
    brbc        CPU_Z_bp, LAB_code_000e51                    
    cpi         R16,0x2e                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    mov         R0,R20                                  
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000e51                    
    and         R21,R21                                 
    brbc        CPU_Z_bp, LAB_code_000e51                    
    cpi         R16,0x2e                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    mov         R1,R20                                  
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000e51                    
    and         R21,R21                                 
    brbc        CPU_Z_bp, LAB_code_000e51                    
    cpi         R16,0x2e                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    mov         R2,R20                                  
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000e51                    
    and         R21,R21                                 
    brbc        CPU_Z_bp, LAB_code_000e51                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000e51                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000e73                    
    ret                                                 
LAB_code_000e73:              
    ldi         ZL,0x89                                
    ldi         ZH,0x21                                
    st          Z+,R2                                   
    st          Z+,R20                                  
    st          Z+,R0                                   
    st          Z,R1                                    
    cli                                                 
    rcall       fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_mac_addr(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        CPU_C_bp, LAB_code_000e51                    
    cpi         R16,0x3a                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    movw        R0,R20                             
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        CPU_C_bp, LAB_code_000e9d                    
    cpi         R16,0x3a                                
    brbc        CPU_Z_bp, LAB_code_000e51                    
    movw        R2,R20                             
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        CPU_C_bp, LAB_code_000e51                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000e9d                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000e91                    
    ret                                                 
LAB_code_000e91:              
    ldi         ZL,0x8d                                
    ldi         ZH,0x21                                
    st          Z+,R21                                  
    st          Z+,R20                                  
    st          Z+,R3                                   
    st          Z+,R2                                   
    st          Z+,R1                                   
    st          Z+,R0                                   
    cli                                                 
    rcall       fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
LAB_code_000e9d:              
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_trigger_mode(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000e9d                    
    rcall       usart_f0_get_next_hex_value             ;undefined usart_f0_get_next_hex_valu...
    brbs        CPU_C_bp, LAB_code_000e9d                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000e9d                    
    and         R21,R21                                 
    brbc        CPU_Z_bp, LAB_code_000e9d                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000eaa                    
    ret                                                 
LAB_code_000eaa:              
    sts         DAT_mem_21a9,R20                        ;= ??
    mov         R16,R20                                 
    ldi         R18,0x6                                 
    eor         R17,R17                                 
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_switches(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000ed9                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x30                                
    brbs        CPU_C_bp, LAB_code_000ed9                    
    cpi         R16,0x3a                                
    brbs        CPU_C_bp, LAB_code_000ec0                    
    cpi         R16,0x41                                
    brbs        CPU_C_bp, LAB_code_000ed9                    
    cpi         R16,0x47                                
    brbc        CPU_C_bp, LAB_code_000ed9                    
    subi        R16,0x7                                 
LAB_code_000ec0:              
    subi        R16,0x30                                
    mov         R20,R16                                 
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000ed9                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000ec8                    
    ret                                                 
LAB_code_000ec8:              
    sts         DAT_portb_setup,R20                     ;= ??
    mov         R16,R20                                 
    cli                                                 
    lds         R17,PORTB_OUT                           ;= ??
    andi        R17,0x90                                
    or          R20,R17                                 
    sts         PORTB_OUT,R20                           ;= ??
    bset        CPU_I_bp                                    
    ldi         R18,0x14                                
    eor         R17,R17                                 
    cli                                                 
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    rjmp        LAB_code_000efe                         
LAB_code_000ed9:              
    rjmp        usart_f0_collect_msg_line_2
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_laser_phase(void)
    ldi         YL,0x97                                
    ldi         YH,0x21                                
    ldi         R18,0x12                                
    rjmp        LAB_code_000ee5                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_c_side_phase(void)
    ldi         YL,0x95                                
    ldi         YH,0x21                                
    ldi         R18,0x11                                
    rjmp        LAB_code_000ee5                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_set_a_side_phase(void)
    ldi         YL,0x93                                
    ldi         YH,0x21                                
    ldi         R18,0x10                                
LAB_code_000ee5:              
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000f02                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000f02                    
    cpi         R16,0xd                                 
    ldi         R17,0xfc                                
    cpi         R20,0x0                                 
    cpc         R21,R17                                 
    brbs        CPU_S_bp, LAB_code_000f02                    
    ldi         R17,0x4                                 
    cpi         R20,0x1                                 
    cpc         R21,R17                                 
    brbc        CPU_S_bp, LAB_code_000f02                    
    brbc        CPU_Z_bp, LAB_code_000f02                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000ef7                    
    ret                                                 
LAB_code_000ef7:              
    cli                                                 
    st          Y+,R20                                  
    st          Y+,R21                                  
    sbi         GPIO_GPIOR0,0x5                         
    movw        R16,R20                           
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
;; Send "OK"
LAB_code_000efe:              
    ldi         ZL,0xce                                
    ldi         ZH,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000f02:              
    rjmp        usart_f0_collect_msg_line_2
LAB_code_000f03:              
    rjmp        usart_f0_collect_msg_line_2             
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined set_attenuator_steps(void)
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
    cpi         R16,0x20                                
    brbc        CPU_Z_bp, LAB_code_000f02                    
    rcall       usart_f0_get_integer                    ;undefined5 usart_f0_get_integer(unde...
    brbs        CPU_C_bp, LAB_code_000f02                    
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_000f02                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        CPU_C_bp, LAB_code_000f0e                    
    ret                                                 
LAB_code_000f0e:              
    ldi         R17,0x2e                                
    cpi         R20,0xe1                                
    cpc         R21,R17                                 
    brbc        CPU_C_bp, LAB_code_000f03                    
    ldi         YL,0x99                                
    ldi         YH,0x21                                
    cli                                                 
    ld          R16,Y                                   
    ldd         R17,Y+0x1                               
    cp          R16,R20                                 
    cpc         R17,R21                                 
    brbs        CPU_Z_bp, LAB_code_000f37                    
    st          Y,R20                                   
    std         Y+0x1,R21                               
    movw        R16,R20                           
    lds         R18,DAT_mem_2185                        ;= ??
    and         R18,R18                                 
    brbs        CPU_Z_bp, LAB_code_000f2a                    
    brbc        CPU_N_bp, LAB_code_000f2e                    
    ori         R17,0x80                                
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;void fpga_send_msg_t2(undefined para...
    bset        CPU_I_bp                                    
    ldi         ZL,0x38                                
    ldi         ZH,0x2b                                
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
    bset        CPU_I_bp                                    
    mov         R17,R21                                 
    rcall       attenuator_set_steps                    ;undefined attenuator_set_steps(void)
    ldi         R16,0x48                                
    sts         DAT_mem_2185,R16                        ;= ??
LAB_code_000f37:              
    bset        CPU_I_bp                                    
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
    ldi         ZL,0xa8                                
    ldi         ZH,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    bset        CPU_C_bp                                    
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
    ldi         YL,0x89                                
    ldi         YH,0x21                                
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
    cpi         YL,0x93                                
    brbc        CPU_Z_bp, LAB_code_000fdc                    
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
    push        ZL                                     
    push        ZH                                     
    ldi         ZL,0x7c                                
    ldi         ZH,0x2b                                
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
    cpi         ZL,0x80                                
    brbc        CPU_Z_bp, LAB_code_001007                    
    ldi         R22,0x1                                 
    sts         PORTD_OUTSET,R22                        ;= ??
    pop         ZH                                     
    pop         ZL                                     
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
    brbc        CPU_Z_bp, LAB_code_001059                    
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
    brbs        CPU_S_bp, LAB_code_00108d                    
    cpi         R16,0x3a                                
    brbc        CPU_S_bp, LAB_code_00108d                    
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
    brbc        CPU_Z_bp, LAB_code_001091                    
    add         R21,R0                                  
    brbc        CPU_C_bp, LAB_code_001078                    
    rjmp        LAB_code_001091                         
LAB_code_00108d:              
    cpi         R18,0x1                                 
    brbs        CPU_Z_bp, LAB_code_001091                    
    clc                                                 
    rjmp        LAB_code_001092                         
LAB_code_001091:              
    bset        CPU_C_bp                                    
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
    brbc        CPU_Z_bp, LAB_code_0010ab                    
    cpi         unaff_R16,0x2d                          
    brbc       CPU_Z_bp,  LAB_code_0010ab                    
    inc         param_4                                 
    inc         param_4                                 
    rjmp        LAB_code_0010a3                         
LAB_code_0010ab:              
    inc         param_4                                 
    cpi         unaff_R16,0x30                          
    brbs        CPU_S_bp, LAB_code_0010bf                    
    cpi         unaff_R16,0x3a                          
    brbc        CPU_S_bp, LAB_code_0010bf                    
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
    brbc        CPU_Z_bp, LAB_code_0010cc                    
    add         param_3,R0                              
    brbc        CPU_C_bp, LAB_code_0010a3                    
    rjmp        LAB_code_0010cc                         
LAB_code_0010bf:              
    cpi         param_4,0x1                             
    brbs        CPU_Z_bp, LAB_code_0010cc                    
    and         param_4,param_4                         
    brbs        CPU_Z_bp, LAB_code_0010ca                    
    cpi         param_4,0x2                             
    brbs        CPU_Z_bp, LAB_code_0010cc                    
    eor         param_4,param_4                         
    neg         param_3                                 
    adc         param_3,param_4                         
    neg         param_3                                 
    brbc        CPU_N_bp, LAB_code_0010cc                    
LAB_code_0010ca:              
    clc                                                 
    rjmp        LAB_code_0010cd                         
LAB_code_0010cc:              
    bset        CPU_C_bp                                    
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
    brbs        CPU_C_bp, LAB_code_0010f2                    
    cpi         R16,0x3a                                
    brbs        CPU_C_bp, LAB_code_0010e4                    
    cpi         R16,0x41                                
    brbs        CPU_C_bp, LAB_code_0010f2                    
    cpi         R16,0x47                                
    brbc        CPU_C_bp, LAB_code_0010f2                    
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
    brbc        CPU_Z_bp, LAB_code_0010d9                    
    rcall       usart_f0_get_next_byte_with_5f          ;undefined usart_f0_get_next_byte_wit...
LAB_code_0010f2:              
    and         R18,R18                                 
    brbs        CPU_Z_bp, LAB_code_0010f6                    
    clc                                                 
    rjmp        LAB_code_0010f7                         
LAB_code_0010f6:              
    bset        CPU_C_bp                                    
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
    brbs        CPU_C_bp, LAB_code_001113                    
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
    bset        CPU_C_bp                                    
    rjmp        LAB_code_001128                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined uartf0_send_temperature(void)
    push        R20                                     
    ldi         R20,0x1                                 
    bset        CPU_C_bp                                    
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
    bset        CPU_C_bp                                    
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
    push        ZL                                     
    push        ZH                                     
    eor         R15,R15                                 
    brbc        CPU_C_bp, LAB_code_00113b                    
    inc         R15                                     
    and         R17,R17                                 
    brbc        CPU_N_bp, LAB_code_00113b                    
    neg         R15                                     
    neg         R16                                     
    brbc        CPU_C_bp, LAB_code_00113a                    
    inc         R17                                     
LAB_code_00113a:              
    neg         R17                                     
LAB_code_00113b:              
    ldi         ZL,0x56                                
    ldi         ZH,0x21                                
    eor         R19,R19                                 
    st          Z,R19                                   
LAB_code_00113f:              
    ldi         R18,0xd                                 
    eor         R14,R14                                 
LAB_code_001141:              
    subi        R17,0xa0                                
    sbrs        R14,0x0                                 
    brbs        CPU_C_bp, LAB_code_001146                    
    bset        CPU_C_bp                                    
    rjmp        LAB_code_001148                         
LAB_code_001146:              
    subi        R17,0x60                                
    clc                                                 
LAB_code_001148:              
    adc         R16,R16                                 
    adc         R17,R17                                 
    adc         R14,R14                                 
    dec         R18                                     
    brbc        CPU_Z_bp, LAB_code_001141                    
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
    brbc        CPU_Z_bp, LAB_code_00115a                    
    ldi         R18,0x2e                                
    st          -Z,R18                                  
LAB_code_00115a:              
    and         R17,R17                                 
    brbc        CPU_Z_bp, LAB_code_00113f                    
    and         R16,R16                                 
    brbc        CPU_Z_bp, LAB_code_00113f                    
    cp          R20,R19                                 
    brbs        CPU_S_bp, LAB_code_00116c                    
    ldi         R18,0x30                                
    st          -Z,R18                                  
    brbs        CPU_Z_bp, LAB_code_00116c                    
LAB_code_001163:              
    inc         R19                                     
    cp          R19,R20                                 
    brbs        CPU_Z_bp, LAB_code_001168                    
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
    brbs        CPU_Z_bp, LAB_code_001170                    
    dec         R17                                     
LAB_code_001170:              
    ldi         R16,0x20                                
    and         R15,R15                                 
    brbs        CPU_Z_bp, LAB_code_001178                    
    brbc        CPU_N_bp, LAB_code_001175                    
    ldi         R16,0x2d                                
LAB_code_001175:              
    st          -Z,R16                                  
    ldi         R16,0x20                                
    dec         R17                                     
LAB_code_001178:              
    cp          ZL,R17                                 
    brbs        CPU_Z_bp, LAB_code_00117c                    
    st          -Z,R16                                  
    rjmp        LAB_code_001178                         
LAB_code_00117c:              
    adiw        Z,0x1                                   
LAB_code_00117d:              
    ld          R16,Z+                                  
    and         R16,R16                                 
    brbs        CPU_Z_bp, LAB_code_001182                    
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_00117d                         
LAB_code_001182:              
    pop         ZH                                     
    pop         ZL                                     
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
    push        ZL                                     
    push        ZH                                     
    ldi         ZL,0x4f                                
    ldi         ZH,0x21                                
    ldi         R18,0xd                                 
    st          Z,R18                                   
    eor         R19,R19                                 
LAB_code_00119b:              
    ldi         R18,0xd                                 
    eor         R14,R14                                 
LAB_code_00119d:              
    subi        R17,0xa0                                
    sbrs        R14,0x0                                 
    brbs        CPU_C_bp, LAB_code_0011a2                    
    bset        CPU_C_bp                                    
    rjmp        LAB_code_0011a4                         
LAB_code_0011a2:              
    subi        R17,0x60                                
    clc                                                 
LAB_code_0011a4:              
    adc         R16,R16                                 
    adc         R17,R17                                 
    adc         R14,R14                                 
    dec         R18                                     
    brbc        CPU_Z_bp, LAB_code_00119d                    
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
    brbc        CPU_Z_bp, LAB_code_00119b                    
    and         R16,R16                                 
    brbc        CPU_Z_bp, LAB_code_00119b                    
    ldi         R16,0x53                                
    st          -Z,R16                                  
LAB_code_0011b8:              
    ld          R16,Z+                                  
    rcall       USARTD0_send_msg                        ;undefined USARTD0_send_msg(void)
    cpi         R16,0xd                                 
    brbc        CPU_Z_bp, LAB_code_0011b8                    
    pop         ZH                                     
    pop         ZL                                     
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
    push        ZL                                     
    push        ZH                                     
    ldi         ZL,0x56                                
    ldi         ZH,0x21                                
    eor         R14,R14                                 
    st          Z,R14                                   
LAB_code_0011cf:              
    ldi         R18,0x5                                 
    eor         R14,R14                                 
LAB_code_0011d1:              
    subi        R16,0xa0                                
    sbrs        R14,0x0                                 
    brbs        CPU_C_bp, LAB_code_0011d6                    
    bset        CPU_C_bp                                    
    rjmp        LAB_code_0011d8                         
LAB_code_0011d6:              
    subi        R16,0x60                                
    clc                                                 
LAB_code_0011d8:              
    adc         R16,R16                                 
    adc         R14,R14                                 
    dec         R18                                     
    brbc        CPU_Z_bp, LAB_code_0011d1                    
    mov         R18,R16                                 
    ror         R14                                     
    ror         R18                                     
    andi        R16,0x1f                                
    swap        R18                                     
    andi        R18,0xf                                 
    subi        R18,0xd0                                
    st          -Z,R18                                  
    and         R16,R16                                 
    brbc        CPU_Z_bp, LAB_code_0011cf                    
LAB_code_0011e6:              
    ld          R16,Z+                                  
    and         R16,R16                                 
    brbs        CPU_Z_bp, LAB_code_0011eb                    
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    rjmp        LAB_code_0011e6                         
LAB_code_0011eb:              
    pop         ZH                                     
    pop         ZL                                     
    pop         R18                                     
    pop         R16                                     
    pop         R14                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_cr(void)
    ldi         ZL,0xba                                
    ldi         ZH,0x29                                
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
    brbs        CPU_Z_bp, LAB_code_0011fb                    
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
    push        ZL                                     
    push        ZH                                     
    ldi         ZL,0x0                                 
    ldi         ZH,0x20                                
usart_f0_get_next_byte_wait:  
    cli                                                 
    ld          R17,Z                                   
    ldd         R16,Z+0x1                               
    bset        CPU_I_bp                                    
    cp          R16,R17                                 
    brbs        CPU_Z_bp, usart_f0_get_next_byte_wait        
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
    ldi         ZL,0x7                                 
    ldi         ZH,0x20                                
    add         ZL,R17                                 
    adc         ZH,R18                                 
    ld          R18,Z                                   
    sts         DAT_mem_2000,R17                        ;= ??
    cpi         R18,0xd                                 
    brbc        CPU_Z_bp, LAB_code_00122b                    
    lds         R17,DAT_usart_f0_new_line               ;= ??
    dec         R17                                     
    sts         DAT_usart_f0_new_line,R17               ;= ??
LAB_code_00122b:              
    cpi         R18,0x60                                
    brbs        CPU_S_bp, usart_f0_get_next_byte_exit        
    brbs        CPU_Z_bp, usart_f0_get_next_byte_exit        
    sbrs        R19,0x0                                 
    andi        R18,0x5f                                
usart_f0_get_next_byte_exit:  
    mov         R16,R18                                 
    pop         ZH                                     
    pop         ZL                                     
    pop         R20                                     
    pop         R18                                     
    pop         R17                                     
    pop         R19                                     
    ret                                                 
;************************************************************************************************
;*                       @brief Send buffered message to USARTF0 console                        *
;************************************************************************************************
;undefined usartf0_send_msg_2(void)
    push        ZH                                     
    push        ZL                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         ZL,0x2                                 
    ldi         ZH,0x20                                
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        CPU_Z_bp, LAB_code_001251                    
    inc         R18                                     
    cp          R17,R18                                 
    brbs        CPU_Z_bp, LAB_code_001260                    
LAB_code_001247:              
    ldi         ZL,0x47                                
    ldi         ZH,0x20                                
    eor         R17,R17                                 
    add         ZL,R18                                 
    adc         ZH,R17                                 
    st          Z,R16                                   
    ldi         ZL,0x3                                 
    ldi         ZH,0x20                                
    st          Z,R18                                   
    rjmp        LAB_code_001260                         
LAB_code_001251:              
    inc         R18                                     
    ld          R19,Z                                   
    and         R19,R19                                 
    brbs        CPU_Z_bp, LAB_code_001247                    
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
    pop         ZL                                     
    pop         ZH                                     
    ret                                                 
;************************************************************************************************
;*                       @brief Send buffered message to USARTF0 console                        *
;************************************************************************************************
;undefined usart_f0_send_msg(void)
    push        ZH                                     
    push        ZL                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         ZL,0x2                                 
    ldi         ZH,0x20                                
LAB_code_00126f:              
    cli                                                 
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        CPU_Z_bp, LAB_code_001285                    
    inc         R18                                     
    cp          R17,R18                                 
    brbc        CPU_Z_bp, LAB_code_00127a                    
    bset        CPU_I_bp                                    
    sbiw        Z,0x2                                   
    rjmp        LAB_code_00126f                         
LAB_code_00127a:              
    ldi         ZL,0x47                                
    ldi         ZH,0x20                                
    eor         R17,R17                                 
    add         ZL,R18                                 
    adc         ZH,R17                                 
    st          Z,R16                                   
    ldi         ZL,0x3                                 
    ldi         ZH,0x20                                
    st          Z,R18                                   
    bset        CPU_I_bp                                    
    rjmp        LAB_code_001295                         
LAB_code_001285:              
    inc         R18                                     
    ld          R19,Z                                   
    and         R19,R19                                 
    brbs        CPU_Z_bp, LAB_code_00127a                    
    lds         R20,USARTF0_STATUS                      ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_00127a                         
    sts         USARTF0,R16                             ;= ??
    lds         R20,USARTF0_CTRLA                       ;= ??
    ori         R20,0x2                                 
    sts         USARTF0_CTRLA,R20                       ;= ??
    bset        CPU_I_bp                                    
LAB_code_001295:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         ZL                                     
    pop         ZH                                     
    ret                                                 
;************************************************************************************************
;*                           @brieg Send buffered attenuator message                            *
;************************************************************************************************
;undefined USARTD0_send_msg(void)
    push        ZH                                     
    push        ZL                                     
    push        R20                                     
    push        R18                                     
    push        R17                                     
    ldi         ZL,0x83                                
    ldi         ZH,0x21                                
LAB_code_0012a3:              
    cli                                                 
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        CPU_Z_bp, LAB_code_0012ba                    
    inc         R18                                     
    andi        R18,0xf                                 
    cp          R17,R18                                 
    brbc        CPU_Z_bp, LAB_code_0012af                    
    bset        CPU_I_bp                                    
    sbiw        Z,0x2                                   
    rjmp        LAB_code_0012a3                         
LAB_code_0012af:              
    ldi         ZL,0x73                                
    ldi         ZH,0x21                                
    eor         R17,R17                                 
    add         ZL,R18                                 
    adc         ZH,R17                                 
    st          Z,R16                                   
    ldi         ZL,0x84                                
    ldi         ZH,0x21                                
    st          Z,R18                                   
    bset        CPU_I_bp                                    
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
    bset        CPU_I_bp                                    
LAB_code_0012c8:              
    pop         R17                                     
    pop         R18                                     
    pop         R20                                     
    pop         ZL                                     
    pop         ZH                                     
    ret                                                 
                                   
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined xmega_firmware_update(void)
    bset        CPU_I_bp                                    
LAB_code_010185:              
    mov         XL,R3                                  
    mov         XH,R4                                  
    mov         YL,R5                                  
    ldi         R16,0x1                                 
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
    lds         R6,RAMPZ                                
    sub         XL,ZL                                 
    sbc         XH,ZH                                 
    sbc         YL,R6                                  
    subi        XL,0xff                                
    sbci        XH,0xff                                
    sbci        YL,0xff                                
    and         YL,YL                                 
    brbc        CPU_Z_bp, LAB_code_010196                    
    cpi         XH,0x2                                 
    brbs        CPU_C_bp, LAB_code_010198                    
LAB_code_010196:              
    eor         XL,XL                                 
    ldi         XH,0x2                                 
LAB_code_010198:              
    ldi         YL,0xae                                
    ldi         YH,0x21                                
LAB_code_01019a:              
    rcall       FUN_code_010215                         ;undefined FUN_code_010215(void)
    st          Y+,R16                                  
    sbiw        X,0x1                                   
    brbc        CPU_Z_bp, LAB_code_01019a                    
    ldi         YL,0xae                                
    ldi         YH,0x21                                
    rcall       FUN_code_0101eb                         ;undefined FUN_code_0101eb(void)
    ldi         R16,0x23                                
    sts         NVM_CMD,R16                             ;= ??
    rjmp        LAB_code_0101ac                         
LAB_code_0101a5:              
    spm         Z+                                      
    lds         R6,RAMPZ                                
    cp          ZL,R3                                  
    cpc         ZH,R4                                  
    cpc         R6,R5                                   
    brbc        CPU_C_bp, LAB_code_0101b5                    
LAB_code_0101ac:              
    ld          R0,Y+                                   
    ld          R1,Y+                                   
    sbrs        ZH,0x0                                 
    rjmp        LAB_code_0101a5                         
    cpi         ZL,0xfe                                
    brbc        CPU_Z_bp, LAB_code_0101a5                    
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
    bset        CPU_I_bp                                    
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
    brbc        CPU_Z_bp, LAB_code_0101dc                    
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
    bset        CPU_I_bp                                    
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
    brbs        CPU_C_bp, LAB_code_010213                    
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
    push        ZL                                     
    push        ZH                                     
    ldi         ZL,0x0                                 
    ldi         ZH,0x20                                
LAB_code_01021c:              
    cli                                                 
    ld          R17,Z                                   
    ldd         R16,Z+0x1                               
    bset        CPU_I_bp                                    
    cp          R16,R17                                 
    brbs        CPU_Z_bp, LAB_code_01021c                    
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
    ldi         ZL,0x7                                 
    ldi         ZH,0x20                                
    add         ZL,R17                                 
    adc         ZH,R18                                 
    ld          R18,Z                                   
    sts         DAT_mem_2000,R17                        ;= ??
    mov         R16,R18                                 
    pop         ZH                                     
    pop         ZL                                     
    pop         R20                                     
    pop         R18                                     
    pop         R17                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_01023e(void)
    push        ZH                                     
    push        ZL                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         ZL,0x2                                 
    ldi         ZH,0x20                                
LAB_code_010246:              
    cli                                                 
    ld          R17,Z+                                  
    ld          R18,Z+                                  
    cp          R17,R18                                 
    brbs        CPU_Z_bp, LAB_code_01025c                    
    inc         R18                                     
    cp          R17,R18                                 
    brbc        CPU_Z_bp, LAB_code_010251                    
    bset        CPU_I_bp                                    
    sbiw        Z,0x2                                   
    rjmp        LAB_code_010246                         
LAB_code_010251:              
    ldi         ZL,0x47                                
    ldi         ZH,0x20                                
    eor         R17,R17                                 
    add         ZL,R18                                 
    adc         ZH,R17                                 
    st          Z,R16                                   
    ldi         ZL,0x3                                 
    ldi         ZH,0x20                                
    st          Z,R18                                   
    bset        CPU_I_bp                                    
    rjmp        LAB_code_01026c                         
LAB_code_01025c:              
    inc         R18                                     
    ld          R19,Z                                   
    and         R19,R19                                 
    brbs        CPU_Z_bp, LAB_code_010251                    
    lds         R20,USARTF0_STATUS                      ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_010251                         
    sts         USARTF0,R16                             ;= ??
    lds         R20,USARTF0_CTRLA                       ;= ??
    ori         R20,0x2                                 
    sts         USARTF0_CTRLA,R20                       ;= ??
    bset        CPU_I_bp                                    
LAB_code_01026c:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         ZL                                     
    pop         ZH                                     
    ret                                                 

