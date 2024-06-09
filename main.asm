.include "iox128a3.inc"
.include "macros.inc"

.section .text
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;void BOOT(void)
    jmp         main                                    
OSC_XOSCF:                    
    align       align(4)                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined PORTC_INT0(void)
    rjmp        FUN_code_0005ca                         
OFF_code_000005:              
    align       align(42)                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 TWIC_TWIS(undefined2 param_1, undefined param_2, undefined param_3, undefined2 param_4, undefined2 param_5, undefined2 param_6, undefined2 param_7, char unaff_R10)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined          R22                      
          ;param_3       undefined          R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       undefined2      R17R16                      
          ;param_6       undefined2      R15R14                      
          ;param_7       undefined2      R13R12                      
          ;unaff_R10     char               R10                      
    rjmp        FUN_code_0000f1                         
TWIC_TWIM:                    
    align       align(2)                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 TCC0_OVF(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, undefined2 param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       undefined2      R17R16                      
    rjmp        FUN_code_0002a8                         
OFF_code_00001d:              
    align       align(114)                              
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined PORTE_INT0(void)
    rjmp        FUN_code_000604                         
    align       align(2)                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined PORTE_INT1(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, uint param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       uint            R17R16                      
    rjmp        fpga_int                                
caseD_cc:                     
    align       align(78)                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined PORTD_INT0(void)
    rjmp        FUN_code_00051d                         
OFF_code_000081:              
    align       align(94)                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined USARTD0_RXC(void)
    rjmp        FUN_code_00074a                         
    align       align(2)                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined USARTD0_DRE(void)
    rjmp        FUN_code_000720                         
OFF_code_0000b3:              
    align       align(58)                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined PORTF_INT0(void)
    rjmp        FUN_code_0006ec                         
    align       align(2)                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined PORTF_INT1(void)
    rjmp        FUN_code_000551                         
OFF_code_0000d3:              
    align       align(54)                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined USARTF0_RXC(void)
    rjmp        usart_f0_rx_int                         
    align       align(2)                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined USARTF0_DRE(void)
    rjmp        usart_f0_dre_int                        
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 FUN_code_0000f1(undefined2 param_1, undefined param_2, undefined param_3, undefined2 param_4, undefined2 param_5, undefined2 param_6, undefined2 param_7, char unaff_R10)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined          R22                      
          ;param_3       undefined          R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       undefined2      R17R16                      
          ;param_6       undefined2      R15R14                      
          ;param_7       undefined2      R13R12                      
          ;unaff_R10     char               R10                      
    push        Zhi                                     
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 USARTF0_TXC(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, undefined2 param_5, undefined2 param_6, undefined2 param_7, char unaff_R10)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       undefined2      R17R16                      
          ;param_6       undefined2      R15R14                      
          ;param_7       undefined2      R13R12                      
          ;unaff_R10     char               R10                      
    in          Zhi,SREG                                
    push        param_5                                 
    push        param_5                                 
    push        param_4                                 
    push        Ylo                                     
    push        Yhi                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Ylo,0x63                                
    ldi         Yhi,0x21                                
    ld          param_5,Y=>sram:DAT_mem_2163            ;= ??
    eor         param_5,param_5                         
    cpi         param_5,0x5                             
    brbs        LAB_code_000101,Cflg                    
    rjmp        switchD_code:000116::caseD_26           
LAB_code_000101:              
    ldi         Zlo,0x9c                                
    ldi         Zhi,0x25                                
    add         param_5,param_5                         
    add         Zlo,param_5                             
    adc         Zhi,param_5                             
    lpm         param_5,Z+                              
    lpm         param_4,Z                               
    ldd         param_5,Y+0x1=>sram:DAT_mem_2164        ;= ??
    cp          param_5,param_4                         
    brbs        LAB_code_00010c,Cflg                    
    rjmp        switchD_code:000116::caseD_26           
LAB_code_00010c:              
    add         param_5,param_5                         
    add         param_5,param_5                         
    eor         param_5,param_5                         
    ldi         Zlo,0xa6                                
    ldi         Zhi,0x25                                
    add         Zlo,param_5                             
    adc         Zhi,param_5                             
    lpm         param_5,Z+                              
    lpm         param_5,Z                               
    movw        Z,param_5                               
switchD:                      
    ijmp                                                
caseD_0:                      
    ldd         Zlo,Y+0x2=>sram:DAT_mem_2165            ;= ??
    ldd         Zhi,Y+0x3=>sram:DAT_mem_2166            ;= ??
    lpm         param_5,Z+                              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    std         Y+0x4=>sram:DAT_mem_2167,param_5        ;= ??
    std         Y+0x3=>sram:DAT_mem_2166,Zhi            ;= ??
    std         Y+0x2=>sram:DAT_mem_2165,Zlo            ;= ??
    ldi         param_5,0x1                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_2:                      
    ldd         Zlo,Y+0x2=>sram:DAT_mem_2165            ;= ??
    ldd         Zhi,Y+0x3=>sram:DAT_mem_2166            ;= ??
    lpm         param_5,Z+                              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldd         param_5,Y+0x4=>sram:DAT_mem_2167        ;= ??
    cpi         param_5,0x0                             
    brbc        LAB_code_000139,Zflg                    
    cpi         param_5,0xff                            
    brbc        LAB_code_000139,Zflg                    
    ldd         param_5,Y+0x5=>sram:DAT_mem_2168        ;= ??
    cpi         param_5,0xe2                            
    brbs        LAB_code_000136,Zflg                    
    ldi         param_5,0x2                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    std         Y+0x2=>sram:DAT_mem_2165,Zlo            ;= ??
    std         Y+0x3=>sram:DAT_mem_2166,Zhi            ;= ??
    ldi         param_5,0xe2                            
    std         Y+0x5=>sram:DAT_mem_2168,param_5        ;= ??
    rjmp        LAB_code_00029e                         
LAB_code_000136:              
    ldi         param_5,0x3                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
LAB_code_000139:              
    lpm         param_5,Z                               
    inc         param_5                                 
caseD_90:                     
    cp          param_5,param_5                         
    brbc        LAB_code_000142,Zflg                    
    adiw        Z,0x1                                   
    std         Y+0x4=>sram:DAT_mem_2167,param_5        ;= ??
LAB_code_00013f:              
    std         Y+0x3=>sram:DAT_mem_2166,Zhi            ;= ??
    std         Y+0x2=>sram:DAT_mem_2165,Zlo            ;= ??
    rjmp        LAB_code_00029e                         
LAB_code_000142:              
    ldi         param_5,0x2                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00013f                         
caseD_4:                      
    ldd         param_5,Y+0x5=>sram:DAT_mem_2168        ;= ??
caseD_a6:                     
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldi         param_5,0x0                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_6:                      
    ldi         param_5,0x2                             
    sts         iospace:PORTF_INTFLAGS,param_5          ;= ??
    ldi         param_5,0xa                             
    sts         iospace:PORTF_INTCTRL,param_5           ;= ??
caseD_bc:                     
    rcall       FUN_code_000559                         ;undefined FUN_code_000559(void)
    rjmp        switchD_code:000116::caseD_26           
caseD_8:                      
    ldi         param_5,0xeb                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x1                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_a:                      
    ldi         param_5,0x0                             
    sts         iospace:TWIC_MASTER_CTRLC,param_5       ;= ??
caseD_d2:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    inc         param_5                                 
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldi         param_5,0x68                            
    sts         iospace:TWIC_MASTER_CTRLA,param_5       ;= ??
    ldi         param_5,0x2                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_c:                      
    lds         param_5,iospace:TWIC_MASTER_DATA        ;= ??
    std         Y+0x4=>sram:DAT_mem_2167,param_5        ;= ??
    ldi         param_5,0x3                             
LAB_code_00016a:              
    ldi         param_5,0x2                             
    sts         iospace:TWIC_MASTER_CTRLC,param_5       ;= ??
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_e:                      
    lds         param_5,iospace:TWIC_MASTER_DATA        ;= ??
    std         Y+0x5=>sram:DAT_mem_2168,param_5        ;= ??
    ldi         param_5,0x4                             
    rjmp        LAB_code_00016a                         
caseD_10:                     
    lds         param_5,iospace:TWIC_MASTER_DATA        ;= ??
    std         Y+0x6=>sram:DAT_mem_2169,param_5        ;= ??
    ldi         param_5,0x4                             
    sts         iospace:TWIC_MASTER_CTRLC,param_5       ;= ??
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldi         param_5,0x58                            
    sts         iospace:TWIC_MASTER_CTRLA,param_5       ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_12:                     
    ldi         param_5,0x2d                            
    ldi         param_5,0x6                             
LAB_code_000185:              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_14:                     
    ldd         param_5,Y+0x4=>sram:DAT_mem_2167        ;= ??
    ldi         param_5,0x7                             
    rjmp        LAB_code_000185                         
caseD_16:                     
    ldd         param_5,Y+0x5=>sram:DAT_mem_2168        ;= ??
    ldi         param_5,0x8                             
    rjmp        LAB_code_000185                         
caseD_18:                     
    ldd         param_5,Y+0x6=>sram:DAT_mem_2169        ;= ??
    andi        param_5,0x3                             
    ori         param_5,0x14                            
    ldi         param_5,0x9                             
    rjmp        LAB_code_000185                         
caseD_1a:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldi         param_5,0xa                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_1c:                     
    ldi         param_5,0x31                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xb                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_1e:                     
    ldi         param_5,0x80                            
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    sbrc        param_5,0x1                             
    ldi         param_5,0x90                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xc                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_20:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    cpi         param_5,0xe2                            
    brbs        switchD_code:000116::caseD_26,Zflg      
    ldi         param_5,0xe2                            
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    std         Y+0x2=>sram:DAT_mem_2165,param_5        ;= ??
    eor         param_5,param_5                         
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_26:                     
    eor         param_5,param_5                         
    st          Y=>sram:DAT_mem_2163,param_5            ;= ??
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    ldi         param_5,0x48                            
    sts         iospace:TWIC_MASTER_CTRLA,param_5       ;= ??
    ldi         param_5,0x3                             
    sts         iospace:TWIC_MASTER_CTRLC,param_5       ;= ??
    rjmp        LAB_code_00029e                         
caseD_22:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    and         param_5,param_5                         
    brbc        LAB_code_0001c1,Nflg                    
    neg         param_5                                 
LAB_code_0001c1:              
    ldi         param_5,0x3f                            
    dec         param_5                                 
    brbs        LAB_code_0001c8,Zflg                    
    ldi         param_5,0x4a                            
    dec         param_5                                 
    brbs        LAB_code_0001c8,Zflg                    
    ldi         param_5,0x34                            
LAB_code_0001c8:              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x1                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_24:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    ldi         param_5,0x12                            
    and         param_5,param_5                         
    brbc        LAB_code_0001d2,Nflg                    
    inc         param_5                                 
LAB_code_0001d2:              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x2                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_28:                     
    ldi         param_5,0xf1                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x1                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_2a:                     
    ldi         param_5,0xe5                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    ldi         param_5,0x2                             
    std         Y+0x3=>sram:DAT_mem_2166,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_2c:                     
    ldi         param_5,0x1c                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x3                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_2e:                     
    lds         param_5,sram:DAT_mem_2162               ;= ??
    ldi         param_5,0xb                             
    andi        param_5,0x6                             
    brbs        LAB_code_0001f1,Zflg                    
    ldi         param_5,0x3                             
LAB_code_0001f1:              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x4                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_30:                     
    lds         param_5,sram:DAT_mem_2162               ;= ??
    ldi         param_5,0x8                             
    andi        param_5,0x6                             
    brbs        LAB_code_0001fc,Zflg                    
    ldi         param_5,0x0                             
LAB_code_0001fc:              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    ldi         param_5,0x6                             
    std         Y+0x3=>sram:DAT_mem_2166,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_50:                     
    ldi         param_5,0x4                             
    sts         iospace:TWIC_MASTER_CTRLC,param_5       ;= ??
    ldi         param_5,0x58                            
caseD_32:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldd         param_5,Y+0x3=>sram:DAT_mem_2166        ;= ??
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_34:                     
    ldi         param_5,0x31                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x7                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_36:                     
    ldd         param_4,Y+0x2=>sram:DAT_mem_2165        ;= ??
    ldi         param_5,0x10                            
    ldi         param_5,0xf                             
    cpi         param_4,0xe2                            
    brbs        LAB_code_00021a,Zflg                    
    ldi         param_5,0x8                             
    ldi         param_5,0x0                             
LAB_code_00021a:              
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    std         Y+0x3=>sram:DAT_mem_2166,param_5        ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_38:                     
    ldi         param_5,0x6b                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x9                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_3a:                     
    ldd         param_5,Y+0x8=>sram:DAT_mem_216b        ;= ??
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xa                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_3c:                     
    ldd         param_5,Y+0x9=>sram:DAT_mem_216c        ;= ??
    andi        param_5,0x7f                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xb                             
    std         Y+0x3=>sram:DAT_mem_2166,param_5        ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_3e:                     
    ldi         param_5,0x6f                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xc                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_40:                     
    ldd         param_5,Y+0x4=>sram:DAT_mem_2167        ;= ??
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xd                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_42:                     
    ldd         param_5,Y+0x5=>sram:DAT_mem_2168        ;= ??
    andi        param_5,0x7f                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xe                             
    std         Y+0x3=>sram:DAT_mem_2166,param_5        ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_44:                     
    ldi         param_5,0x73                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0xf                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_46:                     
    ldd         param_5,Y+0x6=>sram:DAT_mem_2169        ;= ??
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x10                            
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_48:                     
    ldd         param_5,Y+0x7=>sram:DAT_mem_216a        ;= ??
    ori         param_5,0x80                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x11                            
    std         Y+0x3=>sram:DAT_mem_2166,param_5        ;= ??
    ldi         param_5,0x5                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_4a:                     
    ldi         param_5,0xf6                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x12                            
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_4c:                     
    ldi         param_5,0x2                             
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x13                            
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_4e:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    cpi         param_5,0xe2                            
    brbs        LAB_code_000275,Zflg                    
    ldi         param_5,0xe2                            
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    std         Y+0x2=>sram:DAT_mem_2165,param_5        ;= ??
    eor         param_5,param_5                         
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
LAB_code_000275:              
    ldi         param_5,0x3                             
    ldi         param_5,0x19                            
LAB_code_000277:              
    sts         sram:DAT_mem_2159,param_5               ;= ??
    sts         sram:DAT_mem_215a,param_5               ;= ??
    ldi         param_5,0x48                            
    sts         iospace:TWIC_MASTER_CTRLA,param_5       ;= ??
    ldi         param_5,0x3                             
    sts         iospace:TWIC_MASTER_CTRLC,param_5       ;= ??
    eor         param_5,param_5                         
    st          Y=>sram:DAT_mem_2163,param_5            ;= ??
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_52:                     
    ldi         param_5,0xf1                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x1                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_54:                     
    ldi         param_5,0x65                            
    sts         iospace:TWIC_MASTER_DATA,param_5        ;= ??
    ldi         param_5,0x2                             
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
caseD_56:                     
    ldd         param_5,Y+0x2=>sram:DAT_mem_2165        ;= ??
    cpi         param_5,0xe2                            
    brbc        LAB_code_000297,Zflg                    
    ldi         param_5,0x4                             
    eor         param_5,param_5                         
    rjmp        LAB_code_000277                         
LAB_code_000297:              
    ldi         param_5,0xe2                            
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    std         Y+0x2=>sram:DAT_mem_2165,param_5        ;= ??
    eor         param_5,param_5                         
    std         Y+0x1=>sram:DAT_mem_2164,param_5        ;= ??
    rjmp        LAB_code_00029e                         
LAB_code_00029e:              
    pop         Zhi                                     
    pop         Zlo                                     
    pop         Yhi                                     
    pop         Ylo                                     
    pop         param_4                                 
    pop         param_5                                 
    pop         param_5                                 
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined2 FUN_code_0002a8(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, undefined2 param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       undefined2      R17R16                      
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        Yhi                                     
    push        Ylo                                     
    push        param_1                                 
    push        param_1                                 
    push        param_3                                 
    push        param_3                                 
    push        param_4                                 
    push        param_4                                 
    push        param_5                                 
    push        param_5                                 
    push        R1                                      
    push        R0                                      
    ldi         Zlo,0x59                                
    ldi         Zhi,0x21                                
    ld          param_5,Z=>sram:DAT_mem_2159            ;= ??
    and         param_5,param_5                         
    brbc        LAB_code_0002be,Zflg                    
    rjmp        LAB_code_000363                         
LAB_code_0002be:              
    dec         param_5                                 
    brbc        LAB_code_0002c1,Zflg                    
    rjmp        LAB_code_00035c                         
LAB_code_0002c1:              
    dec         param_5                                 
    brbs        LAB_code_0002cb,Zflg                    
    dec         param_5                                 
    brbs        LAB_code_0002e6,Zflg                    
    dec         param_5                                 
    brbs        LAB_code_0002f7,Zflg                    
    dec         param_5                                 
    brbs        LAB_code_0002ca,Zflg                    
    rjmp        LAB_code_000335                         
LAB_code_0002ca:              
    rjmp        LAB_code_00031f                         
LAB_code_0002cb:              
    eor         param_5,param_5                         
    st          Z=>sram:DAT_mem_2159,param_5            ;= ??
    rcall       FUN_code_000571                         ;undefined FUN_code_000571(void)
    lds         param_5,sram:DAT_mem_2163               ;= ??
    ldi         param_5,0x3                             
    sts         sram:DAT_mem_2163,param_5               ;= ??
    ldi         param_5,0xe0                            
    sts         sram:DAT_mem_2165,param_5               ;= ??
    eor         param_5,param_5                         
    sts         sram:DAT_mem_2166,param_5               ;= ??
    ldi         param_5,0x12                            
    and         param_5,param_5                         
    brbc        LAB_code_0002e3,Zflg                    
    eor         param_5,param_5                         
    ldi         param_5,0xe0                            
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldi         param_5,0x58                            
    sts         iospace:TWIC_MASTER_CTRLA,param_5       ;= ??
LAB_code_0002e3:              
    sts         sram:DAT_mem_2164,param_5               ;= ??
    rjmp        LAB_code_000363                         
LAB_code_0002e6:              
    ldd         param_5,Z+0x1=>sram:DAT_mem_215a        ;= ??
    dec         param_5                                 
    brbs        LAB_code_0002ea,Zflg                    
    rjmp        LAB_code_000362                         
LAB_code_0002ea:              
    eor         param_5,param_5                         
    st          Z=>sram:DAT_mem_2159,param_5            ;= ??
    ldi         param_5,0x4                             
    sts         sram:DAT_mem_2163,param_5               ;= ??
    eor         param_5,param_5                         
    sts         sram:DAT_mem_2164,param_5               ;= ??
    ldi         param_5,0xe0                            
    sts         sram:DAT_mem_2165,param_5               ;= ??
    rcall       FUN_code_0006e6                         ;undefined FUN_code_0006e6(void)
    rjmp        LAB_code_000363                         
LAB_code_0002f7:              
    cli                                                 
    lds         param_5,iospace:PORTC_IN                ;= ??
    ldi         param_5,0x1                             
    sts         iospace:PORTC_INTFLAGS,param_5          ;= ??
    ldi         param_5,0x2                             
    sts         iospace:PORTC_INTCTRL,param_5           ;= ??
    bset        Iflg                                    
    eor         param_4,param_4                         
    andi        param_5,0xc                             
    brbc        LAB_code_000314,Zflg                    
    ldi         param_4,0x1                             
    ldi         param_5,0x1                             
    sts         sram:DAT_mem_2163,param_5               ;= ??
    eor         param_5,param_5                         
    sts         sram:DAT_mem_2164,param_5               ;= ??
    ldi         param_5,0xe0                            
    sts         sram:DAT_mem_2165,param_5               ;= ??
    rcall       FUN_code_0006e6                         ;undefined FUN_code_0006e6(void)
    cbi         iospace:GPIO_GPIOR0,0x3                 
    ldi         param_5,0x4b                            
    std         Z+0x1,param_5                           
    ldi         param_5,0x5                             
    rjmp        LAB_code_000315                         
LAB_code_000314:              
    eor         param_5,param_5                         
LAB_code_000315:              
    st          Z=>sram:DAT_mem_2159,param_5            ;= ??
    cli                                                 
    lds         param_5,sram:DAT_mem_2162               ;= ??
    andi        param_5,0xe                             
    or          param_5,param_4                         
    sts         sram:DAT_mem_2162,param_5               ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_000363                         
LAB_code_00031f:              
    ldd         param_5,Z+0x1=>sram:DAT_mem_215a        ;= ??
    dec         param_5                                 
    brbs        LAB_code_000323,Zflg                    
    rjmp        LAB_code_000362                         
LAB_code_000323:              
    lds         param_5,iospace:PORTD_IN                ;= ??
    sbrs        param_5,0x5                             
    rjmp        LAB_code_000363                         
    ldd         param_5,Z+0x2=>sram:DAT_mem_215b        ;= ??
    and         param_5,param_5                         
    brbs        LAB_code_00032f,Zflg                    
    cpi         param_5,0x5                             
    brbc        LAB_code_000334,Zflg                    
    ldd         param_5,Z+0x3=>sram:DAT_mem_215c        ;= ??
    and         param_5,param_5                         
    brbc        LAB_code_000334,Zflg                    
LAB_code_00032f:              
    ldi         param_5,0x80                            
    sts         iospace:PORTB_OUTSET,param_5            ;= ??
    ldi         param_5,0x6                             
    st          Z=>sram:DAT_mem_2159,param_5            ;= ??
LAB_code_000334:              
    rjmp        LAB_code_000363                         
LAB_code_000335:              
    ldi         param_4,0x7f                            
    cli                                                 
    call        fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        Iflg                                    
    andi        param_5,0xf                             
    cpi         param_5,0x3                             
    brbc        LAB_code_00034f,Zflg                    
    ldi         param_5,0x2                             
    sts         iospace:PORTE_INTFLAGS,param_5          ;= ??
    ldi         param_5,0x9                             
    sts         iospace:PORTE_INTCTRL,param_5           ;= ??
    ldi         param_4,0x18                            
    lds         param_5,sram:DAT_mem_2162               ;= ??
    ori         param_5,0x10                            
    lds         param_5,sram:DAT_mem_2188               ;= ??
    cli                                                 
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    ldi         param_5,0x80                            
    rjmp        LAB_code_000357                         
LAB_code_00034f:              
    cli                                                 
    lds         param_5,sram:DAT_b_porte_1_set          ;= ??
    ori         param_5,0x80                            
    sts         sram:DAT_b_porte_1_set,param_5          ;= ??
    bset        Iflg                                    
    ldi         param_5,0x40                            
LAB_code_000357:              
    sts         iospace:PORTA_OUTCLR,param_5            ;= ??
    eor         param_5,param_5                         
    st          Z,param_5                               
    rjmp        LAB_code_000363                         
LAB_code_00035c:              
    ldd         param_5,Z+0x1=>sram:DAT_mem_215a        ;= ??
    dec         param_5                                 
    brbc        LAB_code_000362,Zflg                    
    ldi         param_5,0x2                             
    st          Z=>sram:DAT_mem_2159,param_5            ;= ??
    rjmp        LAB_code_000363                         
LAB_code_000362:              
    std         Z+0x1=>sram:DAT_mem_215a,param_5        ;= ??
LAB_code_000363:              
    adiw        Z,0x2                                   
    ld          param_5,Z=>sram:DAT_mem_215b            ;= ??
    ldd         param_1,Z+0x1=>sram:DAT_mem_215c        ;= ??
    ldd         param_1,Z+0x2=>sram:DAT_mem_215d        ;= ??
    and         param_5,param_5                         
    brbs        LAB_code_0003a4,Zflg                    
    cpi         param_5,0x1                             
    brbc        LAB_code_000384,Zflg                    
    sbiw        param_1,0x1                             
    brbc        LAB_code_0003a2,Zflg                    
    lds         param_5,sram:DAT_mem_21ad               ;= ??
    and         param_5,param_5                         
    brbs        LAB_code_0003a4,Zflg                    
    cli                                                 
    lds         param_5,sram:DAT_b_porte_1_set          ;= ??
    andi        param_5,0x7                             
    cpi         param_5,0x1                             
    brbc        LAB_code_000380,Zflg                    
    ldi         param_5,0x4                             
    sts         iospace:PORTE_OUTSET,param_5            ;= ??
    bset        Iflg                                    
    ldi         param_1,0xe8                            
    ldi         param_1,0x3                             
    ldi         param_5,0x2                             
    st          Z=>sram:DAT_mem_215b,param_5            ;= ??
    rjmp        LAB_code_0003a2                         
LAB_code_000380:              
    bset        Iflg                                    
    eor         param_5,param_5                         
    st          Z=>sram:DAT_mem_215b,param_5            ;= ??
    rjmp        LAB_code_0003a2                         
LAB_code_000384:              
    cpi         param_5,0x2                             
    brbc        LAB_code_0003a5,Zflg                    
    lds         param_5,sram:DAT_b_porte_1_set          ;= ??
    sbrc        param_5,0x3                             
    rjmp        LAB_code_000396                         
    sbiw        param_1,0x1                             
    brbc        LAB_code_0003a2,Zflg                    
    ldi         param_5,0x4                             
    cli                                                 
    sts         iospace:PORTE_OUTCLR,param_5            ;= ??
LAB_code_000390:              
    sbi         iospace:GPIO_GPIOR0,0x1                 
    rcall       FUN_code_000669                         ;undefined FUN_code_000669(void)
                                                        ;= ??
    bset        Iflg                                    
    eor         param_5,param_5                         
    st          Z,param_5                               
    rjmp        LAB_code_0003a2                         
LAB_code_000396:              
    lds         param_5,iospace:PORTE_IN                ;= ??
    sbrs        param_5,0x4                             
    rjmp        LAB_code_000390                         
    ldi         param_1,0xe8                            
    ldi         param_1,0x3                             
    rcall       FUN_code_0006b7                         ;undefined FUN_code_0006b7(void)
    ldi         param_5,0x1f                            
    sts         sram:DAT_mem_2185,param_5               ;= ??
    ldi         param_5,0x3                             
    st          Z,param_5                               
LAB_code_0003a2:              
    std         Z+0x1=>sram:DAT_mem_215c,param_1        ;= ??
    std         Z+0x2=>sram:DAT_mem_215d,param_1        ;= ??
LAB_code_0003a4:              
    rjmp        LAB_code_0003eb                         
LAB_code_0003a5:              
    cpi         param_5,0x3                             
    brbc        LAB_code_0003b7,Zflg                    
    sbiw        param_1,0x1                             
    brbc        LAB_code_0003a2,Zflg                    
    ldi         param_5,0x10                            
    sts         iospace:PORTD_OUTSET,param_5            ;= ??
    ldi         param_5,0x2                             
    sts         iospace:PORTD_OUTCLR,param_5            ;= ??
    ldi         param_5,0x4                             
    st          Z=>sram:DAT_mem_215b,param_5            ;= ??
    ldi         param_1,0x88                            
    ldi         param_1,0x13                            
    ldi         param_5,0x2                             
    sts         iospace:PORTD_OUTSET,param_5            ;= ??
    rjmp        LAB_code_0003a2                         
LAB_code_0003b7:              
    cpi         param_5,0x4                             
    brbc        LAB_code_0003da,Zflg                    
    lds         param_5,iospace:PORTD_IN                ;= ??
    sbrs        param_5,0x5                             
    rjmp        LAB_code_0003d5                         
    ldi         param_5,0x1                             
    sts         iospace:PORTD_INTFLAGS,param_5          ;= ??
    ldi         param_5,0x2                             
    sts         iospace:PORTD_INTCTRL,param_5           ;= ??
    ldi         param_5,0x5                             
    st          Z=>sram:DAT_mem_215b,param_5            ;= ??
    ldi         param_5,0xa                             
    std         Z+0x1=>sram:DAT_mem_215c,param_5        ;= ??
    eor         param_5,param_5                         
    std         Z+0x2=>sram:DAT_mem_215d,param_5        ;= ??
    cli                                                 
    lds         param_5,sram:DAT_b_porte_1_set          ;= ??
    ori         param_5,0x10                            
    sts         sram:DAT_b_porte_1_set,param_5          ;= ??
    call        fpga_send_mcu_ts                        ;undefined fpga_send_mcu_ts(void)
    call        fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        Iflg                                    
    rjmp        LAB_code_0003eb                         
LAB_code_0003d5:              
    sbiw        param_1,0x1                             
    brbs        LAB_code_0003d8,Zflg                    
    rjmp        LAB_code_0003a2                         
LAB_code_0003d8:              
    cli                                                 
    rjmp        LAB_code_000390                         
LAB_code_0003da:              
    cpi         param_5,0x5                             
    brbc        LAB_code_0003eb,Zflg                    
    ldd         param_1,Z+0x3=>sram:DAT_mem_215e        ;= ??
    ldd         param_1,Z+0x4=>sram:DAT_mem_215f        ;= ??
    sbiw        param_1,0x1                             
    brbs        LAB_code_0003e1,Zflg                    
    rjmp        LAB_code_0003a2                         
LAB_code_0003e1:              
    lds         param_5,iospace:PORTB_OUT               ;= ??
    sbrs        param_5,0x7                             
    rjmp        LAB_code_0003eb                         
    eor         param_5,param_5                         
    st          Z=>sram:DAT_mem_215b,param_5            ;= ??
    rcall       FUN_code_0004e0                         ;undefined FUN_code_0004e0(void)
    ldi         param_5,0x10                            
    sts         iospace:PORTB_OUTCLR,param_5            ;= ??
LAB_code_0003eb:              
    ldd         param_1,Z+0x3=>sram:DAT_mem_215e        ;= ??
    ldd         param_1,Z+0x4=>sram:DAT_mem_215f        ;= ??
    ldi         param_5,0x1                             
    cpi         param_1,0xf4                            
    cpc         param_1,param_5                         
    brbc        LAB_code_0003fd,Zflg                    
    cli                                                 
    sbis        iospace:GPIO_GPIOR0,0x0                 
    rjmp        LAB_code_0003f7                         
    ldi         param_5,0x1                             
    sts         iospace:PORTA_OUTTGL,param_5            ;= ??
LAB_code_0003f7:              
    sbis        iospace:GPIO_GPIOR0,0x2                 
    rjmp        LAB_code_0003fc                         
    ldi         param_5,0x20                            
    sts         iospace:PORTA_OUTTGL,param_5            ;= ??
LAB_code_0003fc:              
    bset        Iflg                                    
LAB_code_0003fd:              
    sbiw        param_1,0x1                             
    brbs        LAB_code_000400,Zflg                    
    rjmp        LAB_code_00047f                         
LAB_code_000400:              
    cli                                                 
    sbis        iospace:GPIO_GPIOR0,0x0                 
    rjmp        LAB_code_000406                         
    ldi         param_5,0x1                             
    sts         iospace:PORTA_OUTTGL,param_5            ;= ??
LAB_code_000406:              
    sbis        iospace:GPIO_GPIOR0,0x2                 
    rjmp        LAB_code_00040b                         
    ldi         param_5,0x20                            
    sts         iospace:PORTA_OUTTGL,param_5            ;= ??
LAB_code_00040b:              
    bset        Iflg                                    
    lds         param_5,sram:DAT_mem_2185               ;= ??
    sbrs        param_5,0x4                             
    rjmp        LAB_code_00043b                         
    cpi         param_5,0x90                            
    brbs        LAB_code_000429,Cflg                    
    brbc        LAB_code_000418,Zflg                    
    ldi         param_5,0x48                            
    call        FUN_code_00129c                         ;undefined FUN_code_00129c(void)
    ldi         param_5,0x48                            
    rjmp        LAB_code_000439                         
LAB_code_000418:              
    eor         param_5,param_5                         
    sts         iospace:USARTD0_CTRLB,param_5           ;= ??
    sts         iospace:USARTD0_CTRLA,param_5           ;= ??
    lds         param_5,sram:DAT_mem_2199               ;= ??
    lds         param_5,sram:DAT_mem_219a               ;= ??
    ori         param_5,0x80                            
    ldi         param_4,0x13                            
    cli                                                 
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    ldi         param_5,0x80                            
    rjmp        LAB_code_000439                         
LAB_code_000429:              
    dec         param_5                                 
    cpi         param_5,0x11                            
    brbs        LAB_code_000433,Zflg                    
    cpi         param_5,0x10                            
    brbc        LAB_code_000439,Zflg                    
    ldi         param_5,0x44                            
    call        FUN_code_00129c                         ;undefined FUN_code_00129c(void)
    ldi         param_5,0x98                            
    rjmp        LAB_code_000439                         
LAB_code_000433:              
    sts         sram:DAT_mem_2185,param_5               ;= ??
    ldi         param_5,0xd                             
    call        FUN_code_00129c                         ;undefined FUN_code_00129c(void)
    rjmp        LAB_code_00043b                         
LAB_code_000439:              
    sts         sram:DAT_mem_2185,param_5               ;= ??
LAB_code_00043b:              
    ldi         param_1,0xe8                            
    ldi         param_1,0x3                             
    ser         param_5                                 
    ser         param_4                                 
    ldi         param_5,0x50                            
    ser         param_5                                 
    ser         param_4                                 
    call        adt7311_send_2_bytes                    ;undefined adt7311_send_2_bytes(void)
                                                        ;= ??
    eor         param_5,param_5                         
    sbrs        param_3,0x2                             
    rjmp        LAB_code_000449                         
    ldi         param_5,0x6                             
    rjmp        LAB_code_000450                         
LAB_code_000449:              
    sbrs        param_3,0x1                             
    rjmp        LAB_code_00044d                         
    ldi         param_5,0x4                             
    rjmp        LAB_code_000450                         
LAB_code_00044d:              
    sbrs        param_3,0x0                             
    rjmp        LAB_code_000450                         
    ldi         param_5,0x2                             
LAB_code_000450:              
    cli                                                 
    lds         param_5,sram:DAT_b_porte_1_set          ;= ??
    mov         param_4,param_5                         
    andi        param_4,0x6                             
    eor         param_4,param_5                         
    brbs        LAB_code_000467,Zflg                    
    andi        param_5,0xf9                            
    or          param_5,param_5                         
    sts         sram:DAT_b_porte_1_set,param_5          ;= ??
    sbic        iospace:GPIO_GPIOR0,0x1                 
    rjmp        LAB_code_000466                         
    cpi         param_5,0x6                             
    brbc        LAB_code_000461,Zflg                    
    sbi         iospace:GPIO_GPIOR0,0x1                 
    rjmp        LAB_code_000465                         
LAB_code_000461:              
    and         param_5,param_5                         
    brbs        LAB_code_000465,Zflg                    
    sbi         iospace:GPIO_GPIOR0,0x0                 
    rjmp        LAB_code_000466                         
LAB_code_000465:              
    rcall       FUN_code_000669                         ;undefined FUN_code_000669(void)
LAB_code_000466:              
    bset        Iflg                                    
LAB_code_000467:              
    andi        param_3,0xf8                            
    ldi         param_4,0x14                            
    mul         param_3,param_4                         
    mov         param_5,R1                              
    eor         param_5,param_5                         
    mulsu       param_3,param_4                         
caseD_ee:                     
    add         param_5,R0                              
    adc         param_5,R1                              
    ldd         param_4,Z+0x5                           
    ldd         param_4,Z+0x6                           
caseD_f2:                     
    cp          param_5,param_4                         
    cpc         param_5,param_4                         
    brbs        LAB_code_00047f,Zflg                    
    std         Z+0x5,param_5                           
caseD_f6:                     
    std         Z+0x6,param_5                           
    cli                                                 
    lds         param_4,sram:DAT_b_porte_1_set          ;= ??
    sbrs        param_4,0x4                             
    rjmp        LAB_code_00047e                         
    ldi         param_4,0x15                            
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
LAB_code_00047e:              
    bset        Iflg                                    
LAB_code_00047f:              
    std         Z+0x3=>sram:DAT_mem_215e,param_1        ;= ??
    std         Z+0x4=>sram:DAT_mem_215f,param_1        ;= ??
    sbis        iospace:GPIO_GPIOR0,0x5                 
    rjmp        LAB_code_0004c2                         
    lds         param_5,sram:DAT_mem_2162               ;= ??
    andi        param_5,0x1                             
    brbc        LAB_code_000488,Zflg                    
    rjmp        LAB_code_0004c2                         
LAB_code_000488:              
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         Zlo,0x6d                                
    ldi         Zhi,0x21                                
    eor         param_4,param_4                         
    cli                                                 
LAB_code_00048e:              
    inc         param_4                                 
    ld          param_5,Y+=>sram:DAT_mem_2193           ;= ??
    ld          param_5,Y+=>sram:DAT_mem_2194           ;= ??
    ld          param_1,Z+=>sram:DAT_mem_216d           ;= ??
    ld          param_1,Z+=>sram:DAT_mem_216e           ;= ??
    cp          param_5,param_1                         
    cpc         param_5,param_1                         
    brbc        LAB_code_000499,Zflg                    
    cpi         param_4,0x3                             
    brbs        LAB_code_00048e,Cflg                    
    rjmp        LAB_code_0004c0                         
LAB_code_000499:              
    brbc        LAB_code_00049b,Nflg                    
    neg         param_4                                 
LAB_code_00049b:              
    lds         param_5,iospace:TWIC_MASTER_CTRLA       ;= ??
    andi        param_5,0x30                            
    brbc        LAB_code_0004c1,Zflg                    
    ldi         param_5,0x2                             
    sts         sram:DAT_mem_2163,param_5               ;= ??
    eor         param_5,param_5                         
    sts         sram:DAT_mem_2164,param_5               ;= ??
    sts         sram:DAT_mem_2165,param_4               ;= ??
    ldi         param_5,0xe0                            
    sts         iospace:TWIC_MASTER_ADDR,param_5        ;= ??
    ldi         param_5,0x58                            
    sts         iospace:TWIC_MASTER_CTRLA,param_5       ;= ??
    and         param_4,param_4                         
    brbc        LAB_code_0004be,Nflg                    
    sbiw        param_1,0x1                             
LAB_code_0004b0:              
    st          -Z=>sram:DAT_mem_216e,param_1           ;= ??
    st          -Z=>sram:DAT_mem_216d,param_1           ;= ??
    rcall       FUN_code_0004d3                         ;undefined FUN_code_0004d3(void)
    lds         param_5,sram:DAT_mem_2188               ;= ??
    cp          param_5,param_5                         
    brbs        LAB_code_0004c1,Zflg                    
    sts         sram:DAT_mem_2188,param_5               ;= ??
    eor         param_5,param_5                         
    ldi         param_4,0x18                            
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    rjmp        LAB_code_0004c1                         
LAB_code_0004be:              
    adiw        param_1,0x1                             
    rjmp        LAB_code_0004b0                         
LAB_code_0004c0:              
    cbi         iospace:GPIO_GPIOR0,0x5                 
LAB_code_0004c1:              
    bset        Iflg                                    
LAB_code_0004c2:              
    pop         R0                                      
    pop         R1                                      
    pop         param_5                                 
    pop         param_5                                 
    pop         param_4                                 
    pop         param_4                                 
    pop         param_3                                 
    pop         param_3                                 
    pop         param_1                                 
    pop         param_1                                 
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
    ld          R19,Z=>sram:DAT_mem_216d                ;= ??
    ldd         R18,Z+0x1=>sram:DAT_mem_216e            ;= ??
    ldd         R17,Z+0x4=>sram:DAT_mem_2171            ;= ??
    ldd         R16,Z+0x5=>sram:DAT_mem_2172            ;= ??
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
    ld          R16,Y+=>sram:DAT_mem_2193               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2194               ;= ??
    cpi         R18,0x13                                
    brbc        LAB_code_0004f5,Zflg                    
    lds         Zlo,sram:DAT_mem_2185                   ;= ??
    sbrc        Zlo,0x4                                 
    rjmp        LAB_code_0004f4                         
    andi        Zlo,0xc0                                
    or          R17,Zlo                                 
    rjmp        LAB_code_0004f5                         
LAB_code_0004f4:              
    ori         R17,0x40                                
LAB_code_0004f5:              
    cli                                                 
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    inc         R18                                     
    cpi         R18,0x15                                
    brbc        LAB_code_0004e9,Zflg                    
    eor         R18,R18                                 
LAB_code_0004fd:              
    ld          R16,Y+=>sram:DAT_mem_2195               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2196               ;= ??
    cli                                                 
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        LAB_code_0004fd,Zflg                    
    ld          R16,Y+=>sram:DAT_mem_2197               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2198               ;= ??
    ldi         R18,0x17                                
    cli                                                 
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    lds         R16,sram:DAT_mem_2160                   ;= ??
    lds         R17,sram:DAT_mem_2161                   ;= ??
    ldi         R18,0x15                                
    cli                                                 
    call        fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
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
;undefined FUN_code_00051d(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    lds         R16,iospace:PORTD_IN                    ;= ??
    bst         R16,0x5                                 
    cli                                                 
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    bld         R16,0x4                                 
    sts         sram:DAT_b_porte_1_set,R16              ;= ??
    bset        Iflg                                    
    brbc        LAB_code_00053c,Tflg                    
    ldi         R16,0x80                                
    sts         iospace:PORTB_OUTCLR,R16                ;= ??
    sbic        iospace:GPIO_GPIOR0,0x3                 
    rjmp        LAB_code_00054d                         
    cli                                                 
    ldi         R16,0x5                                 
    sts         sram:DAT_mem_2159,R16                   ;= ??
    ldi         R16,0x64                                
    sts         sram:DAT_mem_215a,R16                   ;= ??
    ldi         R16,0x4                                 
    sts         sram:DAT_mem_215b,R16                   ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_00054d                         
LAB_code_00053c:              
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTB_OUTSET,R16                ;= ??
    eor         R16,R16                                 
    sts         sram:DAT_mem_2158,R16                   ;= ??
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    andi        R16,0x7f                                
    sts         sram:DAT_b_porte_1_set,R16              ;= ??
    ldi         R16,0xc0                                
    sts         iospace:PORTA_OUTSET,R16                ;= ??
LAB_code_00054d:              
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000551(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    rcall       FUN_code_000559                         ;undefined FUN_code_000559(void)
    pop         R16                                     
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000559(void)
    sbi         iospace:GPIO_GPIOR0,0x3                 
    eor         R16,R16                                 
    sts         iospace:PORTC_INTCTRL,R16               ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    ldi         R16,0x80                                
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    sts         iospace:PORTB_OUTCLR,R16                ;= ??
    lds         R16,sram:DAT_mem_2162                   ;= ??
    andi        R16,0xe                                 
    sts         sram:DAT_mem_2162,R16                   ;= ??
    ldi         R16,0x64                                
    sts         sram:DAT_mem_215a,R16                   ;= ??
    ldi         R16,0x1                                 
    sts         sram:DAT_mem_2159,R16                   ;= ??
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
    ld          R16,Y+=>sram:DAT_mem_2193               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2194               ;= ??
    st          Z+=>sram:DAT_mem_216d,R16               ;= ??
    st          Z+=>sram:DAT_mem_216e,R17               ;= ??
    cpi         Ylo,0x99                                
    brbc        LAB_code_00057d,Zflg                    
    subi        Ylo,0x6                                 
    ldi         Zlo,0x67                                
    ldi         Zhi,0x21                                
LAB_code_000586:              
    ld          R16,Y+=>sram:DAT_mem_218f               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2190               ;= ??
    cpi         Ylo,0x99                                
    brbc        LAB_code_00058b,Zflg                    
    inc         R17                                     
LAB_code_00058b:              
    add         R16,R16                                 
    adc         R17,R17                                 
    add         R16,R16                                 
    adc         R17,R17                                 
    st          Z+=>sram:DAT_mem_2167,R16               ;= ??
    st          Z+=>sram:DAT_mem_2168,R17               ;= ??
    cpi         Ylo,0x99                                
    brbc        LAB_code_000586,Zflg                    
    rcall       FUN_code_0004d3                         ;undefined FUN_code_0004d3(void)
    sts         sram:DAT_mem_2188,R16                   ;= ??
    cbi         iospace:GPIO_GPIOR0,0x5                 
    lds         R16,sram:DAT_mem_2162                   ;= ??
    sbrc        R16,0x3                                 
    rjmp        LAB_code_0005b3                         
    andi        R16,0x1                                 
    lds         R17,iospace:PORTF_IN                    ;= ??
    sbrc        R17,0x5                                 
    rjmp        LAB_code_0005a5                         
    ori         R16,0x2                                 
    ldi         R17,0x10                                
    sts         iospace:PORTC_OUTCLR,R17                ;= ??
    rjmp        LAB_code_0005ab                         
LAB_code_0005a5:              
    sbrc        R17,0x4                                 
    rjmp        LAB_code_0005ab                         
    ori         R16,0x4                                 
    ldi         R17,0x10                                
    sts         iospace:PORTC_OUTSET,R17                ;= ??
LAB_code_0005ab:              
    lds         R17,sram:DAT_mem_2162                   ;= ??
    sts         sram:DAT_mem_2162,R16                   ;= ??
    eor         R17,R16                                 
    andi        R17,0x6                                 
    brbc        LAB_code_0005b3,Zflg                    
    rjmp        LAB_code_0005c1                         
LAB_code_0005b3:              
    ldi         R17,0x20                                
    sbrs        R16,0x1                                 
    rjmp        LAB_code_0005ba                         
    sts         iospace:PORTA_OUTCLR,R17                ;= ??
    cbi         iospace:GPIO_GPIOR0,0x2                 
    rjmp        LAB_code_0005c1                         
LAB_code_0005ba:              
    sbrs        R16,0x2                                 
    rjmp        LAB_code_0005be                         
    sbi         iospace:GPIO_GPIOR0,0x2                 
    rjmp        LAB_code_0005c1                         
LAB_code_0005be:              
    sts         iospace:PORTA_OUTSET,R17                ;= ??
    cbi         iospace:GPIO_GPIOR0,0x2                 
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0005ca(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        R16                                     
    push        R17                                     
    push        R18                                     
    push        R19                                     
    push        R20                                     
    lds         R16,iospace:PORTC_IN                    ;= ??
    eor         R19,R19                                 
    andi        R16,000000000000000000001100b           
    brbs        LAB_code_0005d7,Zflg                    
    rjmp        LAB_code_0005e5                         
LAB_code_0005d7:              
    inc         R19                                     
    sbis        iospace:GPIO_GPIOR0,0x3                 
    rjmp        LAB_code_0005e5                         
    ldi         R16,0x1                                 
    sts         sram:DAT_mem_2163,R16                   ;= ??
    eor         R16,R16                                 
    sts         sram:DAT_mem_2164,R16                   ;= ??
    ldi         R16,0xe0                                
    sts         sram:DAT_mem_2165,R16                   ;= ??
    rcall       FUN_code_0006e6                         ;undefined FUN_code_0006e6(void)
    cbi         iospace:GPIO_GPIOR0,0x3                 
LAB_code_0005e5:              
    lds         R16,sram:DAT_mem_2162                   ;= ??
    andi        R16,0xe                                 
    or          R16,R19                                 
    sts         sram:DAT_mem_2162,R16                   ;= ??
    ldi         R18,0x5                                 
    and         R19,R19                                 
    brbc        LAB_code_0005f7,Zflg                    
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    ldi         R16,0x80                                
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    sts         iospace:PORTB_OUTCLR,R16                ;= ??
    eor         R18,R18                                 
LAB_code_0005f7:              
    sts         sram:DAT_mem_2159,R18                   ;= ??
    ldi         R16,0x64                                
    sts         sram:DAT_mem_215a,R16                   ;= ??
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
;undefined FUN_code_000604(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    cli                                                 
    push        R16                                     
    push        R17                                     
    push        R18                                     
    eor         R17,R17                                 
    lds         R16,iospace:PORTE_IN                    ;= ??
    bst         R16,0x1                                 
    bld         R17,0x0                                 
    bst         R16,0x3                                 
    bld         R17,0x3                                 
    bst         R16,0x2                                 
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    mov         R18,R16                                 
    andi        R16,0xf6                                
    or          R16,R17                                 
    sts         sram:DAT_b_porte_1_set,R16              ;= ??
    eor         R18,R17                                 
    sbrs        R18,0x0                                 
    rjmp        LAB_code_00062f                         
    sbrc        R17,0x0                                 
    rjmp        switchD_code:000116::caseD_66           
    ldi         R16,0x4                                 
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
    sbi         iospace:GPIO_GPIOR0,0x1                 
    rcall       FUN_code_000675                         ;undefined FUN_code_000675(void)
                                                        ;= ??
    rjmp        LAB_code_000636                         
caseD_66:                     
    ldi         R16,0x1                                 
caseD_68:                     
    sts         sram:DAT_mem_215b,R16                   ;= ??
caseD_6c:                     
    ldi         R16,0xd0                                
    sts         sram:DAT_mem_215c,R16                   ;= ??
    ldi         R16,0x7                                 
    sts         sram:DAT_mem_215d,R16                   ;= ??
    cbi         iospace:GPIO_GPIOR0,0x1                 
    rjmp        LAB_code_000636                         
LAB_code_00062f:              
    sbrs        R18,0x3                                 
    rjmp        LAB_code_000637                         
    sbrc        R17,0x3                                 
    rjmp        LAB_code_000637                         
    rcall       FUN_code_000675                         ;undefined FUN_code_000675(void)
                                                        ;= ??
    brbc        LAB_code_000637,Tflg                    
    sbi         iospace:GPIO_GPIOR0,0x1                 
LAB_code_000636:              
    rcall       FUN_code_000669                         ;undefined FUN_code_000669(void)
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
;undefined fpga_int(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, uint param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       uint            R17R16                      
    push        Zhi                                     
    in          Zhi,SREG                                
    push        param_5                                 
    push        param_5                                 
    push        param_4                                 
    ldi         param_4,0x7f                            
    call        fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
                                                        ;= ??
    sbrs        param_5,0x3                             
    rjmp        LAB_code_000654                         
    sbrc        param_5,0x2                             
    rjmp        LAB_code_00064c                         
    ldi         param_5,0xa                             
    eor         param_5,param_5                         
    rjmp        LAB_code_00064e                         
LAB_code_00064c:              
    ldi         param_5,0x2                             
    ldi         param_5,0x8                             
LAB_code_00064e:              
    sts         iospace:PORTF_INTCTRL,param_5           ;= ??
    sts         sram:DAT_mem_2162,param_5               ;= ??
    rcall       FUN_code_000559                         ;undefined FUN_code_000559(void)
                                                        ;= ??
    rjmp        LAB_code_000663                         
LAB_code_000654:              
    sbrs        param_5,0x1                             
    rjmp        LAB_code_00065b                         
    lds         param_4,sram:DAT_fpga_comm_request      ;= ??
    ori         param_4,0x1                             
    sts         sram:DAT_fpga_comm_request,param_4      ;= ??
LAB_code_00065b:              
    swap        param_5                                 
    andi        param_5,0x7                             
    lds         param_5,sram:DAT_mem_2158               ;= ??
    andi        param_5,0xfa                            
    or          param_5,param_5                         
    sts         sram:DAT_mem_2158,param_5               ;= ??
LAB_code_000663:              
    pop         param_4                                 
    pop         param_5                                 
    pop         param_5                                 
    out         SREG,Zhi                                
    pop         Zhi                                     
    reti                                                
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000669(void)
    sbic        iospace:GPIO_GPIOR0,0x1                 
    rjmp        LAB_code_000670                         
    cbi         iospace:GPIO_GPIOR0,0x0                 
    ldi         R16,0x1                                 
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    ret                                                 
LAB_code_000670:              
    ldi         R16,0x1                                 
    sts         iospace:PORTA_OUTCLR,R16                ;= ??
    cbi         iospace:GPIO_GPIOR0,0x0                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000675(void)
    eor         R16,R16                                 
    sts         sram:DAT_mem_215c,R16                   ;= ??
    sts         sram:DAT_mem_215d,R16                   ;= ??
    sts         sram:DAT_mem_215b,R16                   ;= ??
    sts         sram:DAT_fpga_comm_request,R16          ;= ??
    sts         sram:DAT_mem_2185,R16                   ;= ??
    sts         sram:DAT_mem_2159,R16                   ;= ??
    sts         sram:DAT_mem_2162,R16                   ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    ldi         R16,0x2                                 
    sts         iospace:PORTF_INTCTRL,R16               ;= ??
    eor         R16,R16                                 
    sts         iospace:PORTC_INTCTRL,R16               ;= ??
    sts         iospace:PORTD_INTCTRL,R16               ;= ??
    sts         iospace:USARTD0_CTRLB,R16               ;= ??
    sts         iospace:USARTD0_CTRLA,R16               ;= ??
    ldi         R16,0x80                                
    sts         iospace:PORTB_DIRCLR,R16                ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTB_OUTSET,R16                ;= ??
    eor         R16,R16                                 
    sts         iospace:SPIC,R16                        ;= ??
    ldi         R16,0xb0                                
    sts         iospace:PORTC_DIRCLR,R16                ;= ??
    ldi         R16,0x9                                 
    sts         iospace:PORTD_DIRCLR,R16                ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTD_OUTCLR,R16                ;= ??
    ldi         R16,0x30                                
    sts         iospace:PORTF_DIRCLR,R16                ;= ??
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    andi        R16,0xef                                
    sts         sram:DAT_b_porte_1_set,R16              ;= ??
    ldi         R16,0xa0                                
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    ldi         R16,0x48                                
    sts         iospace:TWIC_MASTER_CTRLA,R16           ;= ??
    ldi         R16,0x1                                 
    sts         iospace:TWIC_MASTER_STATUS,R16          ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0006b7(void)
    push        Ylo                                     
    push        Yhi                                     
    ldi         R16,0x80                                
    sts         iospace:PORTB_OUTSET,R16                ;= ??
    ldi         R16,0x80                                
    sts         iospace:PORTB_DIRSET,R16                ;= ??
    ldi         R16,0xb0                                
    sts         iospace:PORTC_DIRSET,R16                ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTD_OUTSET,R16                ;= ??
    ldi         R16,0x9                                 
    sts         iospace:PORTD_DIRSET,R16                ;= ??
    ldi         R16,0x18                                
    sts         iospace:USARTD0_CTRLB,R16               ;= ??
    ldi         R16,0x10                                
    sts         iospace:USARTD0_CTRLA,R16               ;= ??
    ldi         R16,0xd1                                
    sts         iospace:SPIC,R16                        ;= ??
    ldi         R16,0x1                                 
    sts         iospace:TWIC_MASTER_STATUS,R16          ;= ??
    eor         R16,R16                                 
    ldi         Ylo,0x63                                
    ldi         Yhi,0x21                                
    st          Y+=>sram:DAT_mem_2163,R16               ;= ??
    st          Y+=>sram:DAT_mem_2164,R16               ;= ??
    ldi         R16,0xfe                                
    st          Y+=>sram:DAT_mem_2165,R16               ;= ??
    ldi         R16,0x25                                
    st          Y+=>sram:DAT_mem_2166,R16               ;= ??
    in          R16,iospace:GPIO_GPIOR0                 
    andi        R16,0xc7                                
    out         iospace:GPIO_GPIOR0,R16                 
    ldi         R16,0xe0                                
    std         Y+0x1=>sram:DAT_mem_2168,R16            ;= ??
    rcall       FUN_code_0006e6                         ;undefined FUN_code_0006e6(void)
    pop         Yhi                                     
    pop         Ylo                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0006e6(void)
    sts         iospace:TWIC_MASTER_ADDR,R16            ;= ??
    ldi         R16,0x58                                
    sts         iospace:TWIC_MASTER_CTRLA,R16           ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0006ec(void)
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
    lds         R16,iospace:PORTF_IN                    ;= ??
    sbrc        R16,0x1                                 
    rjmp        LAB_code_000716                         
    inc         Yhi                                     
    ld          R17,-Z=>sram:DAT_mem_2003               ;= ??
    ld          R16,-Z=>sram:DAT_mem_2002               ;= ??
    cp          R16,R17                                 
    brbs        LAB_code_000715,Zflg                    
    lds         R18,iospace:USARTF0_STATUS              ;= ??
    sbrs        R18,0x5                                 
    rjmp        LAB_code_000710                         
    eor         R17,R17                                 
    inc         R16                                     
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    ld          R17,Z                                   
    sts         iospace:USARTF0,R17                     ;= ??
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    st          Z=>sram:DAT_mem_2002,R16                ;= ??
LAB_code_000710:              
    lds         R18,iospace:USARTF0_CTRLA               ;= ??
    ori         R18,0x2                                 
    sts         iospace:USARTF0_CTRLA,R18               ;= ??
LAB_code_000715:              
    adiw        Z,0x2                                   
LAB_code_000716:              
    st          Z=>sram:DAT_b_portf_1_set,Yhi           ;= ??
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000720(void)
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
    ld          R16,Z+=>sram:DAT_mem_2183               ;= ??
    ld          R17,Z=>sram:DAT_mem_2184                ;= ??
    cp          R16,R17                                 
    brbc        LAB_code_000734,Zflg                    
    lds         R19,iospace:USARTD0_CTRLA               ;= ??
    andi        R19,0xfc                                
    sts         iospace:USARTD0_CTRLA,R19               ;= ??
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
    sts         iospace:USARTD0,R17                     ;= ??
    ldi         Zlo,0x83                                
    ldi         Zhi,0x21                                
    st          Z=>sram:DAT_mem_2183,R16                ;= ??
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
;undefined FUN_code_00074a(void)
    push        Zhi                                     
    in          Zhi,SREG                                
    push        Zhi                                     
    push        Zlo                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    push        R16                                     
    lds         R19,iospace:USARTD0_STATUS              ;= ??
    lds         R16,iospace:USARTD0                     ;= ??
    sbrc        R19,0x4                                 
    rjmp        LAB_code_000792                         
    lds         R19,sram:DAT_mem_2185                   ;= ??
    sbrc        R19,0x5                                 
    call        FUN_code_001238                         ;undefined FUN_code_001238(void)
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
    lds         R16,sram:DAT_mem_2199                   ;= ??
    lds         R17,sram:DAT_mem_219a                   ;= ??
    lds         R18,sram:DAT_mem_2186                   ;= ??
    lds         R19,sram:DAT_mem_2187                   ;= ??
    cp          R16,R18                                 
    cpc         R17,R19                                 
    brbc        LAB_code_000785,Zflg                    
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    eor         R19,R19                                 
    rjmp        LAB_code_000790                         
LAB_code_000785:              
    sts         sram:DAT_mem_2186,R16                   ;= ??
    sts         sram:DAT_mem_2187,R17                   ;= ??
    bset        Iflg                                    
    call        FUN_code_00118d                         ;undefined FUN_code_00118d(void)
    ldi         R19,0x48                                
    rjmp        LAB_code_000790                         
LAB_code_00078e:              
    andi        R18,0xf0                                
    or          R19,R18                                 
LAB_code_000790:              
    sts         sram:DAT_mem_2185,R19                   ;= ??
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
;*                                           FUNCTION                                           *
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
    ld          R16,Z+=>sram:DAT_mem_2002               ;= ??
    ld          R17,Z+=>sram:DAT_mem_2003               ;= ??
    ld          R18,Z=>sram:DAT_b_portf_1_set           ;= ??
    and         R18,R18                                 
    brbs        usart_f0_dre_send_else,Zflg             
    cp          R16,R17                                 
    brbc        usart_f0_dre_send_if,Zflg               
usart_f0_dre_send_else:       
    lds         R19,iospace:USARTF0_CTRLA               ;= ??
    andi        R19,0xfc                                
    sts         iospace:USARTF0_CTRLA,R19               ;= ??
    rjmp        usart_f0_dre_send_endif                 
usart_f0_dre_send_if:         
    inc         R16                                     
    eor         R17,R17                                 
    ldi         Zlo,0x47                                
    ldi         Zhi,0x20                                
    add         Zlo,R16                                 
    adc         Zhi,R17                                 
    ld          R17,Z                                   
    sts         iospace:USARTF0,R17                     ;= ??
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    st          Z=>sram:DAT_mem_2002,R16                ;= ??
usart_f0_dre_send_endif:      
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
    ld          R16,Z+=>sram:DAT_mem_2000               ;= ??
    ld          R17,Z=>sram:DAT_mem_2001                ;= ??
    inc         R17                                     
    andi        R17,0x3f                                
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cp          R18,R16                                 
    brbc        usart_f0_rx_buffer_full_endif,Zflg      
    ldi         R18,0x1                                 
    sts         iospace:PORTF_OUTSET,R18                ;= ??
    lds         R18,sram:DAT_usart_f0_new_line          ;= ??
    ori         R18,0x80                                
    sts         sram:DAT_usart_f0_new_line,R18          ;= ??
usart_f0_rx_buffer_full_endif:
    lds         R19,iospace:USARTF0_STATUS              ;= ??
    lds         R18,iospace:USARTF0                     ;= ??
    sbrc        R19,0x4                                 
    rjmp        usart_f0_rx_ferr_endif                  
    cp          R16,R17                                 
    brbs        usart_f0_rx_ferr_endif,Zflg             
    st          Z=>sram:DAT_mem_2001,R17                ;= ??
    ldi         Zlo,0x7                                 
    ldi         Zhi,0x20                                
    eor         R16,R16                                 
    add         Zlo,R17                                 
    adc         Zhi,R16                                 
    st          Z,R18                                   
    cpi         R18,0xd                                 
    brbc        usart_f0_rx_ferr_endif,Zflg             
    lds         R16,sram:DAT_usart_f0_new_line          ;= ??
    inc         R16                                     
    sts         sram:DAT_usart_f0_new_line,R16          ;= ??
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;void main(void)
    ldi         R16,0xcb                                
    sts         iospace:OSC_XOSCCTRL,R16                ;= ??
    ldi         R16,0x9                                 
    sts         iospace:OSC,R16                         ;= ??
;; wait for OSC
main_osc_while_1:             
    lds         R17,iospace:OSC_STATUS                  ;= ??
    sbrs        R17,0x3                                 
    rjmp        main_osc_while_1                        
    ldi         R16,0xc2                                
    sts         iospace:OSC_PLLCTRL,R16                 ;= ??
    ldi         R16,0x19                                
    sts         iospace:OSC,R16                         ;= ??
;; wait for OSC
main_osc_while_2:             
    lds         R17,iospace:OSC_STATUS                  ;= ??
    sbrs        R17,0x4                                 
    rjmp        main_osc_while_2                        
    ldi         R17,0xd8                                
    ldi         R16,0x4                                 
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:CLK,R16                         ;= ??
    ldi         R16,0x18                                
    sts         iospace:OSC,R16                         ;= ??
    ser         R25                                     
    out         SPL,R25                                 
    ldi         R25,0x3f                                
    out         SPH,R25                                 
    ldi         R16,000000000000000011111011b           
    sts         iospace:PORTA_DIRSET,R16                ;= ??
    ldi         R16,000000000000000011110011b           
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    ldi         R16,0x18                                
    sts         iospace:PORTA_PIN2CTRL,R16              ;= ??
    ldi         R16,0x80                                
    sts         iospace:PORTA_PIN1CTRL,R16              ;= ??
    sts         iospace:PORTA_PIN3CTRL,R16              ;= ??
    sts         iospace:PORTA_PIN4CTRL,R16              ;= ??
    ldi         R16,000000000000000000011111b           
    sts         iospace:PORTB_DIRSET,R16                ;= ??
    ldi         R16,000000000000000000010000b           
    sts         iospace:PORTB_OUTSET,R16                ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTB_PIN5CTRL,R16              ;= ??
    sts         iospace:PORTB_PIN6CTRL,R16              ;= ??
    ldi         R16,0x28                                
    sts         iospace:PORTC_PIN0CTRL,R16              ;= ??
    sts         iospace:PORTC_PIN1CTRL,R16              ;= ??
    ldi         R16,0x0                                 
    sts         iospace:PORTC_PIN3CTRL,R16              ;= ??
    sts         iospace:PORTC_PIN4CTRL,R16              ;= ??
    ldi         R16,0x28                                
    sts         iospace:PORTD_PIN1CTRL,R16              ;= ??
    sts         iospace:PORTD_PIN4CTRL,R16              ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTD_OUTCLR,R16                ;= ??
    ldi         R16,000000000000000000000010b           
    sts         iospace:PORTD_OUTSET,R16                ;= ??
    ldi         R16,000000000000000000010010b           
    sts         iospace:PORTD_DIRSET,R16                ;= ??
    ldi         R16,0x0                                 
    sts         iospace:PORTD_PIN5CTRL,R16              ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTD_PIN6CTRL,R16              ;= ??
    sts         iospace:PORTD_PIN7CTRL,R16              ;= ??
    ldi         R16,000000000000000000000100b           
    sts         iospace:PORTE_DIRSET,R16                ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTE_PIN0CTRL,R16              ;= ??
    ldi         R16,0x0                                 
    sts         iospace:PORTE_PIN1CTRL,R16              ;= ??
    ldi         R16,0x80                                
    sts         iospace:PORTE_PIN2CTRL,R16              ;= ??
    ldi         R16,0x0                                 
    sts         iospace:PORTE_PIN3CTRL,R16              ;= ??
    ldi         R16,0xa                                 
    sts         iospace:PORTE_INT0MASK,R16              ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INT1MASK,R16              ;= ??
    ldi         R16,0x9                                 
    sts         iospace:PORTF_DIRSET,R16                ;= ??
    ldi         R16,0x0                                 
    sts         iospace:PORTF_PIN1CTRL,R16              ;= ??
    sts         iospace:PORTF_PIN4CTRL,R16              ;= ??
    sts         iospace:PORTF_PIN5CTRL,R16              ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTF_PIN6CTRL,R16              ;= ??
    sts         iospace:PORTF_PIN7CTRL,R16              ;= ??
    ldi         R16,0xc                                 
    sts         iospace:PORTC_INT0MASK,R16              ;= ??
    ldi         R16,0x20                                
    sts         iospace:PORTD_INT0MASK,R16              ;= ??
    ldi         R16,0x2                                 
    sts         iospace:PORTF_INT0MASK,R16              ;= ??
    ldi         R16,0x30                                
    sts         iospace:PORTF_INT1MASK,R16              ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTF_OUTSET,R16                ;= ??
    ldi         R16,0x23                                
    sts         iospace:TWIC_MASTER_BAUD,R16            ;= ??
    ldi         R16,0x48                                
    sts         iospace:TWIC_MASTER_CTRLA,R16           ;= ??
    ldi         R16,0x1                                 
    sts         iospace:TWIC_MASTER_STATUS,R16          ;= ??
    ldi         R16,0x40                                
    sts         iospace:USARTD0_BAUDCTRLB,R16           ;= ??
    ldi         R16,0xc                                 
    sts         iospace:USARTD0_BAUDCTRLA,R16           ;= ??
    ldi         R16,0x3                                 
    sts         iospace:USARTD0_CTRLC,R16               ;= ??
    ldi         R16,0xd0                                
    sts         iospace:USARTF0_BAUDCTRLB,R16           ;= ??
    ldi         R16,0x83                                
    sts         iospace:USARTF0_BAUDCTRLA,R16           ;= ??
    ldi         R16,0x3                                 
    sts         iospace:USARTF0_CTRLC,R16               ;= ??
    ldi         R16,0x18                                
    sts         iospace:USARTF0_CTRLB,R16               ;= ??
    ldi         R16,0x10                                
    sts         iospace:USARTF0_CTRLA,R16               ;= ??
    ldi         R16,0x6                                 
    sts         iospace:TCC0,R16                        ;= ??
    ldi         R16,0x7d                                
    sts         iospace:TCC0_PER,R16                    ;= ??
    ldi         R16,0x0                                 
    sts         iospace:DAT_mem_0827,R16                ;= ??
    ldi         R16,0x0                                 
    sts         iospace:TCC0_CTRLB,R16                  ;= ??
    ldi         R16,0x0                                 
    sts         iospace:TCC0_CTRLE,R16                  ;= ??
    ldi         R16,0x1                                 
    sts         iospace:TCC0_INTCTRLA,R16               ;= ??
    ldi         R16,0x8                                 
    sts         iospace:NVM_CTRLB,R16                   ;= ??
    eor         R25,R25                                 
    out         iospace:GPIO_GPIOR0,R25                 
;; Clear 0x2000 - 0x23b2 (some bigger struct)
    ldi         Zlo,0x0                                 
    ldi         Zhi,0x20                                
    ldi         Ylo,0xb2                                
    ldi         Yhi,0x23                                
main_clear_struct:            
    st          Z+=>sram:DAT_mem_2000,R25               ;= ??
    cp          Zlo,Ylo                                 
    cpc         Zhi,Yhi                                 
    brbc        main_clear_struct,Zflg                  
    lds         R16,iospace:PORTF_IN                    ;= ??
    sbrs        R16,0x1                                 
    inc         R25                                     
    sts         sram:DAT_b_portf_1_set,R25              ;= ??
    lds         R16,iospace:PORTE_IN                    ;= ??
    bst         R16,0x1                                 
    eor         R16,R16                                 
    bld         R16,0x0                                 
    sts         sram:DAT_b_porte_1_set,R16              ;= ??
    brbs        main_porte_1_set_if,Tflg                
    sbi         iospace:GPIO_GPIOR0,0x1                 
    ldi         R16,0x1                                 
    sts         iospace:PORTA_OUTCLR,R16                ;= ??
    rjmp        main_porte_1_set_endif                  
main_porte_1_set_if:          
    ldi         R16,0x1                                 
    sts         sram:DAT_mem_215b,R16                   ;= ??
    ldi         R16,0xd0                                
    sts         sram:DAT_mem_215c,R16                   ;= ??
    ldi         R16,0x7                                 
    sts         sram:DAT_mem_215d,R16                   ;= ??
main_porte_1_set_endif:       
    ldi         R16,0xe8                                
    sts         sram:DAT_mem_215e,R16                   ;= ??
    ldi         R16,0x3                                 
    sts         sram:DAT_mem_215f,R16                   ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    ldi         R16,0x2                                 
    sts         iospace:PORTF_INTCTRL,R16               ;= ??
    ldi         R16,0x3                                 
    sts         iospace:PMIC_CTRL,R16                   ;= ??
;; ADT7311 setup
;; 0x50 = 0b01010000
;; Fault queue: 00 = 1 fault (default)
;; CT pin polarity: 0 = active low
;; INT pin polarity: 0 = active low
;; INT/CT mode: 1 = comparator mode
;; Operation mode: 01 = one shot (240ms conversion)
;; Resolution: 0 = 13 bit, sign bit + 12 bits */
    rcall       adt7311_clear_faults                    ;undefined adt7311_clear_faults(void)
                                                        ;= ??
    ldi         R16,0x8                                 
    ldi         R17,0x50                                
    rcall       adt7311_send_1_byte                     ;undefined adt7311_send_1_byte(void)
                                                        ;= ??
    ldi         R16,0x20                                
    ldi         R17,0x0                                 
    ldi         R18,0x23                                
    rcall       adt7311_send_2_bytes                    ;undefined adt7311_send_2_bytes(void)
                                                        ;= ??
    ldi         R16,0x30                                
    ldi         R17,0x0                                 
    ldi         R18,0x1e                                
    rcall       adt7311_send_2_bytes                    ;undefined adt7311_send_2_bytes(void)
                                                        ;= ??
;; EEPROM copy configuration: 0x2189 -> 0x21ae (37 bytes)
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    ldi         Ylo,0x0                                 
    ldi         Yhi,0x10                                
    ldi         R17,0x21                                
main_eeprom_copy_loop:        
    ld          R16,Y+=>eeprom:DAT_mem_1000             ;= ??
    st          Z+=>sram:DAT_mem_2189,R16               ;= ??
    cpi         Zlo,0xae                                
    cpc         Zhi,R17                                 
    brbc        main_eeprom_copy_loop,Zflg              
    ser         R16                                     
    sts         sram:DAT_mem_2186,R16                   ;= ??
    sts         sram:DAT_mem_2187,R16                   ;= ??
    lds         R16,sram:DAT_portb_setup                ;= ??
    andi        R16,0xf                                 
;; Set PB0, PB3 according to EEPROM settings
    lds         R17,iospace:PORTB_OUT                   ;= ??
    andi        R17,0x90                                
    or          R16,R17                                 
    sts         iospace:PORTB_OUT,R16                   ;= ??
    bset        Iflg                                    
;; USART send "INR TCM control interface ready"
    ldi         Zlo,0x96                                
    ldi         Zhi,0x29                                
    call        usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
                                                        ;= ??
    ldi         R16,0x1                                 
    sts         iospace:PORTF_OUTCLR,R16                ;= ??
main_loop:                    
    lds         R16,sram:DAT_fpga_comm_request          ;= ??
    and         R16,R16                                 
    brbs        main_fpga_request_endif,Zflg            
    rcall       fpga_exchange_data                      ;undefined fpga_exchange_data(undefin...
                                                        ;= ??
main_fpga_request_endif:      
    lds         R16,sram:DAT_usart_f0_new_line          ;= ??
    and         R16,R16                                 
    brbs        main_loop,Zflg                          
    rcall       usart_f0_parse_prompt                   ;undefined usart_f0_parse_prompt(void)
                                                        ;= ??
    rjmp        main_loop                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_exchange_data(undefined2 param_1, undefined2 param_2, undefined2 param_3, undefined2 param_4, uint param_5)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined2      R23R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;param_5       uint            R17R16                      
    eor         param_5,param_5                         
    cli                                                 
    sts         sram:DAT_fpga_comm_request,param_5      ;= ??
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         param_4,0xf8                            
    lds         R15,iospace:PORTE_INTCTRL               ;= ??
    sbrc        R15,0x3                                 
    rjmp        LAB_code_00093f                         
LAB_code_00093d:              
    bset        Iflg                                    
    ret                                                 
LAB_code_00093f:              
    rcall       fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
                                                        ;= ??
    bset        Iflg                                    
    ldi         param_4,0x10                            
    mov         R15,param_5                             
LAB_code_000943:              
    lsr         R15                                     
    brbs        LAB_code_000947,Cflg                    
    adiw        Y,0x2                                   
    rjmp        LAB_code_0009b0                         
LAB_code_000947:              
    cli                                                 
    lds         R15,iospace:PORTE_INTCTRL               ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t1                        ;undefined fpga_send_msg_t1(undefined...
    bset        Iflg                                    
    cpi         param_4,0x13                            
    brbs        LAB_code_00096c,Zflg                    
    brbs        LAB_code_000952,Cflg                    
    rjmp        LAB_code_000995                         
LAB_code_000952:              
    ldi         param_1,0x4                             
    cpi         param_5,0x1                             
    cpc         param_5,param_1                         
    brbc        LAB_code_00095d,Sflg                    
    ldi         param_1,0xfc                            
    cpi         param_5,0x0                             
    cpc         param_5,param_1                         
    brbc        LAB_code_000966,Sflg                    
    ldi         param_5,0x0                             
    ldi         param_5,0xfc                            
    rjmp        LAB_code_00095f                         
LAB_code_00095d:              
    ldi         param_5,0x0                             
    ldi         param_5,0x4                             
LAB_code_00095f:              
    cli                                                 
    lds         R15,iospace:PORTE_INTCTRL               ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
LAB_code_000966:              
    cli                                                 
    st          Y+=>sram:DAT_mem_2193,param_5           ;= ??
    st          Y+=>sram:DAT_mem_2194,param_5           ;= ??
    sbi         iospace:GPIO_GPIOR0,0x5                 
    bset        Iflg                                    
    rjmp        LAB_code_0009b0                         
LAB_code_00096c:              
    ldi         param_1,0x2e                            
    cpi         param_5,0xe1                            
    cpc         param_5,param_1                         
    brbs        LAB_code_000972,Cflg                    
    ldi         param_5,0xe0                            
    ldi         param_5,0x2e                            
LAB_code_000972:              
    cli                                                 
    ld          param_3,Y=>sram:DAT_mem_2193            ;= ??
    ldd         param_3,Y+0x1=>sram:DAT_mem_2194        ;= ??
    st          Y+=>sram:DAT_mem_2193,param_5           ;= ??
    st          Y+=>sram:DAT_mem_2194,param_5           ;= ??
    lds         param_1,sram:DAT_mem_2185               ;= ??
    ldi         param_1,0xdf                            
    and         param_1,param_1                         
    brbc        LAB_code_00098a,Zflg                    
    cp          param_5,param_3                         
    cpc         param_5,param_3                         
    brbs        LAB_code_000993,Zflg                    
    sts         sram:DAT_mem_2186,param_5               ;= ??
    sts         sram:DAT_mem_2187,param_5               ;= ??
    bset        Iflg                                    
    call        FUN_code_00118d                         ;undefined FUN_code_00118d(void)
    ori         param_1,0x48                            
    sts         sram:DAT_mem_2185,param_1               ;= ??
    rjmp        LAB_code_00098d                         
LAB_code_00098a:              
    brbc        LAB_code_00098d,Nflg                    
    ori         param_5,0x80                            
    rjmp        LAB_code_00098e                         
LAB_code_00098d:              
    ori         param_5,0x40                            
LAB_code_00098e:              
    lds         R15,iospace:PORTE_INTCTRL               ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
LAB_code_000993:              
    bset        Iflg                                    
    rjmp        LAB_code_0009b0                         
LAB_code_000995:              
    cpi         param_5,0x10                            
    brbc        LAB_code_000999,Cflg                    
    and         param_5,param_5                         
    brbs        LAB_code_0009a2,Zflg                    
LAB_code_000999:              
    eor         param_5,param_5                         
    andi        param_5,0xf                             
    cli                                                 
    lds         R15,iospace:PORTE_INTCTRL               ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
                                                        ;= ??
    bset        Iflg                                    
LAB_code_0009a2:              
    st          Y+=>sram:DAT_mem_2193,param_5           ;= ??
    adiw        Y,0x1                                   
    cli                                                 
    lds         R15,iospace:PORTE_INTCTRL               ;= ??
    sbrs        R15,0x3                                 
    rjmp        LAB_code_00093d                         
    lds         param_5,iospace:PORTB_OUT               ;= ??
    andi        param_5,0x90                            
    or          param_5,param_5                         
    sts         iospace:PORTB_OUT,param_5               ;= ??
    bset        Iflg                                    
LAB_code_0009b0:              
    inc         param_4                                 
    cpi         param_4,0x15                            
    brbs        LAB_code_0009b4,Zflg                    
    rjmp        LAB_code_000943                         
LAB_code_0009b4:              
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_parse_prompt(void)
    andi        R16,0x7f                                
    sts         sram:DAT_usart_f0_new_line,R16          ;= ??
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x41                                
    brbc        LAB_code_0009c1,Zflg                    
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x43                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        LAB_code_000a88                         
LAB_code_0009c1:              
    cpi         R16,0x43                                
    brbc        LAB_code_0009ce,Zflg                    
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x41                                
    brbc        LAB_code_0009c8,Zflg                    
    rjmp        FUN_code_000e1a                         ;undefined FUN_code_000e1a(void)
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
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x41                                
    brbc        LAB_code_0009df,Zflg                    
    rjmp        LAB_code_000aeb                         
LAB_code_0009df:              
    cpi         R16,0x46                                
    brbc        LAB_code_0009ec,Zflg                    
    rjmp        FUN_code_000b32                         ;undefined FUN_code_000b32(void)
LAB_code_0009e2:              
    cpi         R16,0x52                                
    brbc        LAB_code_0009ed,Zflg                    
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x41                                
    brbc        LAB_code_0009f4,Zflg                    
    rjmp        FUN_code_000ee2                         ;undefined FUN_code_000ee2(void)
LAB_code_0009f4:              
    cpi         R16,0x43                                
    brbc        LAB_code_0009f7,Zflg                    
    rjmp        FUN_code_000ede                         ;undefined FUN_code_000ede(void)
LAB_code_0009f7:              
    cpi         R16,0x49                                
    brbc        LAB_code_0009fa,Zflg                    
    rjmp        FUN_code_000e52                         ;undefined FUN_code_000e52(void)
LAB_code_0009fa:              
    cpi         R16,0x4c                                
    brbc        LAB_code_0009fd,Zflg                    
    rjmp        FUN_code_000eda                         ;undefined FUN_code_000eda(void)
LAB_code_0009fd:              
    cpi         R16,0x4d                                
    brbc        LAB_code_000a00,Zflg                    
    rjmp        FUN_code_000e7d                         ;undefined FUN_code_000e7d(void)
LAB_code_000a00:              
    cpi         R16,0x53                                
    brbc        LAB_code_000a03,Zflg                    
    rjmp        FUN_code_000eb3                         ;undefined FUN_code_000eb3(void)
LAB_code_000a03:              
    cpi         R16,0x54                                
    brbc        LAB_code_000a0f,Zflg                    
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0x48                                
    brbc        LAB_code_000a09,Zflg                    
    rjmp        FUN_code_000cf3                         ;undefined FUN_code_000cf3(void)
LAB_code_000a09:              
    cpi         R16,0x4c                                
    brbc        LAB_code_000a0c,Zflg                    
    rjmp        FUN_code_000cf7                         ;undefined FUN_code_000cf7(void)
LAB_code_000a0c:              
    cpi         R16,0x4d                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        FUN_code_000e9e                         ;undefined FUN_code_000e9e(void)
LAB_code_000a0f:              
    cpi         R16,0x56                                
    brbc        LAB_code_000a12,Zflg                    
    rjmp        LAB_code_000ad7                         
LAB_code_000a12:              
    cpi         R16,0x57                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        FUN_code_000f04                         ;undefined FUN_code_000f04(void)
LAB_code_000a15:              
    cpi         R16,0x54                                
    brbc        LAB_code_000a2a,Zflg                    
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x48                                
    brbc        LAB_code_000a21,Zflg                    
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x41                                
    brbc        LAB_code_000a1e,Zflg                    
    rjmp        FUN_code_000cdb                         ;undefined FUN_code_000cdb(void)
LAB_code_000a1e:              
    cpi         R16,0x43                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        FUN_code_000cdf                         ;undefined FUN_code_000cdf(void)
LAB_code_000a21:              
    cpi         R16,0x4d                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x41                                
    brbc        LAB_code_000a27,Zflg                    
    rjmp        FUN_code_000cd3                         ;undefined FUN_code_000cd3(void)
LAB_code_000a27:              
    cpi         R16,0x43                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        FUN_code_000cd7                         ;undefined FUN_code_000cd7(void)
LAB_code_000a2a:              
    cpi         R16,0x57                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0x52                                
    brbc        usart_f0_collect_msg_line_2,Zflg        
    rjmp        FUN_code_000d14                         ;undefined FUN_code_000d14(void)
usart_f0_collect_msg_line:    
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
usart_f0_collect_msg_line_2:  
    cpi         R16,0xd                                 
    brbc        usart_f0_collect_msg_line,Zflg          
;; Send "Syntax error"
    ldi         Zlo,0xbe                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
                                                        ;= ??
    ret                                                 
LAB_code_000a37:              
    ldi         R20,0x1                                 
LAB_code_000a38:              
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0xd                                 
    brbc        usart_f0_collect_msg_line_2,Zflg        
    lds         R16,sram:DAT_mem_21ad                   ;= ??
    cp          R16,R20                                 
    brbc        LAB_code_000a41,Zflg                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000a41:              
    sts         sram:DAT_mem_21ad,R20                   ;= ??
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a41                         
    ldi         R16,0x36                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:NVM_CTRLA,R16                   ;= ??
    bset        Iflg                                    
LAB_code_000a52:              
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a52                         
    ldi         Ylo,0x24                                
    ldi         Yhi,0x10                                
    st          Y=>eeprom:DAT_mem_1024,R20              ;= ??
    ldi         R16,0x35                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    sts         iospace:NVM,Ylo                         ;= ??
    sts         iospace:NVM_ADDR1,Yhi                   ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:NVM_CTRLA,R16                   ;= ??
    bset        Iflg                                    
LAB_code_000a68:              
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000a68                         
    and         R20,R20                                 
    brbc        LAB_code_000a84,Zflg                    
    ldi         R16,0x4                                 
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
LAB_code_000a71:              
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    sbrc        R16,0x3                                 
    rjmp        LAB_code_000a71                         
    cli                                                 
    ldi         R16,0x1                                 
    sts         sram:DAT_mem_215b,R16                   ;= ??
    ldi         R16,0xd0                                
    sts         sram:DAT_mem_215c,R16                   ;= ??
    ldi         R16,0x7                                 
    sts         sram:DAT_mem_215d,R16                   ;= ??
    cbi         iospace:GPIO_GPIOR0,0x1                 
    ldi         R16,0x41                                
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    bset        Iflg                                    
LAB_code_000a84:              
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000a85:              
    eor         R20,R20                                 
    rjmp        LAB_code_000a38                         
LAB_code_000a87:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_000a88:              
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0xd                                 
    brbc        LAB_code_000a87,Zflg                    
    cli                                                 
    lds         R16,sram:DAT_mem_2185                   ;= ??
    ori         R16,0x20                                
    sts         sram:DAT_mem_2185,R16                   ;= ??
    bset        Iflg                                    
usart_f0_parse_prompt_while...
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x1b                                
    brbs        usart_f0_parse_p...,Zflg                
    call        FUN_code_00129c                         ;undefined FUN_code_00129c(void)
    rjmp        usart_f0_parse_prompt_while_not_esc     
usart_f0_parse_prompt_while...
    cli                                                 
    lds         R16,sram:DAT_mem_2185                   ;= ??
    andi        R16,0xdf                                
    sts         sram:DAT_mem_2185,R16                   ;= ??
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000aa2:              
    call        usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
                                                        ;= ??
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
    st          Y+=>sram:DAT_mem_219d,R16               ;= ??
    st          Y+=>sram:DAT_mem_219e,R17               ;= ??
    inc         R18                                     
    cpi         R18,0x7                                 
    brbc        LAB_code_000aac,Zflg                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000ab6:              
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0x20                                
    brbc        LAB_code_000ad6,Zflg                    
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    mov         R20,R16                                 
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    lds         R16,sram:DAT_mem_2162                   ;= ??
    cpi         R20,0x31                                
    brbs        LAB_code_000aca,Zflg                    
    cpi         R20,0x30                                
    brbc        LAB_code_000ad6,Zflg                    
    sbrs        R16,0x3                                 
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
    cli                                                 
    ldi         R16,0xa                                 
    eor         R17,R17                                 
    rjmp        LAB_code_000acf                         
LAB_code_000aca:              
    sbrc        R16,0x3                                 
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
    cli                                                 
    ldi         R16,0x2                                 
    ldi         R17,0x8                                 
LAB_code_000acf:              
    sts         iospace:PORTF_INTCTRL,R16               ;= ??
    sts         sram:DAT_mem_2162,R17                   ;= ??
    rcall       FUN_code_000559                         ;undefined FUN_code_000559(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000ad6:              
    rjmp        usart_f0_collect_msg_line_2             
LAB_code_000ad7:              
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000ad6,Zflg                    
    rcall       FUN_code_0010d4                         ;undefined FUN_code_0010d4(void)
    brbs        LAB_code_000ad6,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000ad6,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000ae1,Cflg                    
    ret                                                 
LAB_code_000ae1:              
    sts         sram:ARRAY_BOARD_SN,R20                 ;= ??
    sts         sram:ARRAY_BOARD_SN[1],R21              
    ldi         R18,0x17                                
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000aeb:              
    rcall       FUN_code_000b1f                         ;undefined FUN_code_000b1f(void)
    brbs        LAB_code_000ad6,Cflg                    
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         Zlo,R16                                 
    mov         R20,R16                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         Zhi,R16                                 
    mov         R21,R16                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         R22,R16                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         R3,R16                                  
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         R4,R16                                  
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         R5,R16                                  
    cpi         R22,0x2                                 
    brbc        LAB_code_000ad6,Sflg                    
    cp          R3,Zlo                                  
    cpc         R4,Zhi                                  
    cpc         R5,R22                                  
    brbs        LAB_code_000ad6,Cflg                    
    cli                                                 
    sts         RAMPZ,R22                               
    rcall       FUN_code_000675                         ;undefined FUN_code_000675(void)
    eor         R16,R16                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    sts         iospace:TCC0_INTCTRLA,R16               ;= ??
    ldi         R16,0x4                                 
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
    ldi         R16,0x43                                
    ldi         R17,0xd8                                
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:PMIC_CTRL,R16                   ;= ??
    ldi         R16,0x26                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:NVM_CTRLA,R16                   ;= ??
    bset        Iflg                                    
    jmp         code:FUN_code_010184                    ;undefined FUN_code_010184(void)
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000b1f(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
                                                        ;= ??
    cpi         R16,0xd                                 
    brbc        LAB_code_000b2f,Zflg                    
    ldi         Zlo,0x74                                
    ldi         Zhi,0x2b                                
LAB_code_000b24:              
    lpm         R17,Z+=>PTR_LOOP_code_0015ba            ;= code:005678
                                                        ;= codebyte:005678
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
                                                        ;= ??
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
;undefined FUN_code_000b32(void)
    rcall       FUN_code_000b1f                         ;undefined FUN_code_000b1f(void)
    brbs        LAB_code_000b31,Cflg                    
    ldi         R16,0x2                                 
    sts         iospace:PORTD_OUTCLR,R16                ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTSET,R16                ;= ??
    ldi         R16,0xb0                                
    sts         iospace:PORTE_DIRSET,R16                ;= ??
    ldi         R16,0x50                                
    sts         iospace:SPIE,R16                        ;= ??
    eor         R16,R16                                 
    ldi         Xlo,0xae                                
    ldi         Xhi,0x23                                
    st          X+=>sram:DAT_mem_23ae,R16               ;= ??
    st          X+=>sram:DAT_mem_23af,R16               ;= ??
    st          X+=>sram:DAT_mem_23b0,R16               ;= ??
    st          X=>sram:DAT_mem_23b1,R16                ;= ??
    rcall       FUN_code_000c6a                         ;undefined FUN_code_000c6a(void)
    eor         R17,R17                                 
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    movw        R17R16,R19R18                           
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    rcall       FUN_code_0011f1                         ;undefined FUN_code_0011f1(void)
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         Ylo,R16                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         Yhi,R16                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         Zlo,R16                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         R0,R16                                  
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    mov         R1,R16                                  
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
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
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
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
    lds         R24,sram:DAT_mem_23ae                   ;= ??
    lds         R25,sram:DAT_mem_23af                   ;= ??
LAB_code_000b6e:              
    ldi         Xlo,0xae                                
    ldi         Xhi,0x21                                
    add         Xlo,R24                                 
    adc         Xhi,R25                                 
    rcall       FUN_code_0011fd                         ;undefined FUN_code_0011fd(void)
    st          X,R16                                   
    adiw        R25R24,0x1                              
    andi        R25,0x1                                 
    dec         R17                                     
    brbc        LAB_code_000b6e,Zflg                    
    sts         sram:DAT_mem_23ae,R24                   ;= ??
    sts         sram:DAT_mem_23af,R25                   ;= ??
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
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    movw        R17R16,R19R18                           
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    rcall       FUN_code_0011f1                         ;undefined FUN_code_0011f1(void)
    cli                                                 
    ldi         R16,0x1                                 
    sts         iospace:PORTE_INTCTRL,R16               ;= ??
    ldi         R16,0x2                                 
    sts         iospace:PORTF_INTCTRL,R16               ;= ??
    eor         R16,R16                                 
    sts         iospace:PORTC_INTCTRL,R16               ;= ??
    sts         iospace:PORTD_INTCTRL,R16               ;= ??
    sts         iospace:SPIE,R16                        ;= ??
    ldi         R16,0xb0                                
    sts         iospace:PORTE_DIRCLR,R16                ;= ??
    cbi         iospace:GPIO_GPIOR0,0x1                 
    ldi         R16,0x1                                 
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    ldi         R16,0x2                                 
    sts         sram:DAT_mem_215b,R16                   ;= ??
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000ba3(void)
    rcall       FUN_code_000bd9                         ;undefined FUN_code_000bd9(void)
                                                        ;= ??
    ldi         R16,0x2                                 
    rcall       FUN_code_000c4e                         ;undefined FUN_code_000c4e(undefined2...
                                                        ;= ??
    lds         R24,sram:DAT_mem_23b0                   ;= ??
    lds         R25,sram:DAT_mem_23b1                   ;= ??
LAB_code_000baa:              
    ldi         Xlo,0xae                                
    ldi         Xhi,0x21                                
    add         Xlo,R24                                 
    adc         Xhi,R25                                 
    ld          R16,X                                   
    adiw        R25R24,0x1                              
    andi        R25,0x1                                 
    sts         iospace:SPIE_DATA,R16                   ;= ??
LAB_code_000bb3:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bb3                         
    cp          R0,R20                                  
    cpc         R1,R21                                  
    cpc         R2,R22                                  
    brbc        LAB_code_000bc4,Zflg                    
    sts         sram:DAT_mem_23b0,R24                   ;= ??
    sts         sram:DAT_mem_23b1,R25                   ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTSET,R16                ;= ??
    bset        Cflg                                    
    ret                                                 
LAB_code_000bc4:              
    subi        R20,0xff                                
    sbci        R21,0xff                                
    sbci        R22,0xff                                
    and         R20,R20                                 
    brbc        LAB_code_000baa,Zflg                    
    sts         sram:DAT_mem_23b0,R24                   ;= ??
    sts         sram:DAT_mem_23b1,R25                   ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTSET,R16                ;= ??
    clc                                                 
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000bd2(void)
    rcall       FUN_code_000bd9                         ;undefined FUN_code_000bd9(void)
    ldi         R16,0xd8                                
    rcall       FUN_code_000c4e                         ;undefined FUN_code_000c4e(undefined2...
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTSET,R16                ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000bd9(void)
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
    ldi         R16,0x6                                 
    sts         iospace:SPIE_DATA,R16                   ;= ??
LAB_code_000bdf:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bdf                         
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTSET,R16                ;= ??
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
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
    ldi         R16,0x5                                 
    sts         iospace:SPIE_DATA,R16                   ;= ??
LAB_code_000bf1:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bf1                         
    sts         iospace:SPIE_DATA,R24                   ;= ??
LAB_code_000bf7:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000bf7                         
    lds         R24,iospace:SPIE_DATA                   ;= ??
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTSET,R16                ;= ??
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
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
caseD_58:                     
    ldi         R16,0x3                                 
    sts         iospace:SPIE_DATA,R16                   ;= ??
    eor         R10,R10                                 
LAB_code_000c0a:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c0a                         
    sts         iospace:SPIE_DATA,Zlo                   ;= ??
LAB_code_000c10:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c10                         
    sts         iospace:SPIE_DATA,Yhi                   ;= ??
LAB_code_000c16:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c16                         
    sts         iospace:SPIE_DATA,Ylo                   ;= ??
    ser         R16                                     
    ser         R17                                     
    ser         R18                                     
    ser         R19                                     
    ldi         param_2,0xb7                            
    ldi         param_1,0x1d                            
    ldi         param_1,0xc1                            
    ldi         Xlo,0x4                                 
LAB_code_000c24:              
    lds         param_2,iospace:SPIE_STATUS             ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000c24                         
OFF_code_000c28:              
    sts         iospace:SPIE_DATA,R10                   ;= ??
LAB_code_000c2a:              
    lds         param_2,iospace:SPIE_STATUS             ;= ??
    sbrs        param_2,0x7                             
    rjmp        LAB_code_000c2a                         
    lds         param_2,iospace:SPIE_DATA               ;= ??
    cp          R0,Ylo                                  
    cpc         R1,Yhi                                  
    cpc         R2,Zlo                                  
    brbs        LAB_code_000c3a,Zflg                    
    sts         iospace:SPIE_DATA,R10                   ;= ??
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
;undefined FUN_code_000c4e(undefined2 param_1, undefined param_2, undefined2 param_3, undefined2 param_4, undefined unaff_R16)
          ;param_1       undefined2      R25R24                      
          ;param_2       undefined          R22                      
          ;param_3       undefined2      R21R20                      
          ;param_4       undefined2      R19R18                      
          ;unaff_R16     undefined          R16                      
    ldi         R17,0x10                                
    sts         iospace:PORTE_OUTCLR,R17                ;= ??
    sts         iospace:SPIE_DATA,unaff_R16             ;= ??
LAB_code_000c53:              
    lds         param_4,iospace:SPIE_STATUS             ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c53                         
    sts         iospace:SPIE_DATA,param_2               ;= ??
LAB_code_000c59:              
    lds         param_4,iospace:SPIE_STATUS             ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c59                         
    sts         iospace:SPIE_DATA,param_3               ;= ??
LAB_code_000c5f:              
    lds         param_4,iospace:SPIE_STATUS             ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c5f                         
    sts         iospace:SPIE_DATA,param_3               ;= ??
LAB_code_000c65:              
    lds         param_4,iospace:SPIE_STATUS             ;= ??
    sbrs        param_4,0x7                             
    rjmp        LAB_code_000c65                         
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000c6a(void)
    ldi         R16,0x10                                
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
    ldi         R16,0x9f                                
    sts         iospace:SPIE_DATA,R16                   ;= ??
    eor         R20,R20                                 
LAB_code_000c71:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c71                         
    sts         iospace:SPIE_DATA,R20                   ;= ??
LAB_code_000c77:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c77                         
    lds         R18,iospace:SPIE_DATA                   ;= ??
    sts         iospace:SPIE_DATA,R20                   ;= ??
LAB_code_000c7f:              
    lds         R19,iospace:SPIE_STATUS                 ;= ??
    sbrs        R19,0x7                                 
    rjmp        LAB_code_000c7f                         
    lds         R19,iospace:SPIE_DATA                   ;= ??
    sts         iospace:SPIE_DATA,R20                   ;= ??
LAB_code_000c87:              
    lds         R20,iospace:SPIE_STATUS                 ;= ??
    sbrs        R20,0x7                                 
    rjmp        LAB_code_000c87                         
    lds         R16,iospace:SPIE_DATA                   ;= ??
LAB_code_000c8d:              
    ldi         R20,0x10                                
    sts         iospace:PORTE_OUTSET,R20                ;= ??
    ret                                                 
LAB_code_000c91:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_system_params(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0xd                                 
    brbc        LAB_code_000c91,Zflg                    
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ld          R16,Y+=>sram:DAT_mem_2193               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2194               ;= ??
    rcall       FUN_code_001121                         ;undefined FUN_code_001121(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_2195               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2196               ;= ??
    rcall       FUN_code_001121                         ;undefined FUN_code_001121(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_2197               ;= ??
    ld          R17,Y+=>sram:DAT_mem_2198               ;= ??
    rcall       FUN_code_001121                         ;undefined FUN_code_001121(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_2199               ;= ??
    ld          R17,Y+=>sram:DAT_mem_219a               ;= ??
    rcall       FUN_code_001115                         ;undefined FUN_code_001115(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_portb_setup            ;= ??
    eor         R17,R17                                 
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    rcall       FUN_code_0011f1                         ;undefined FUN_code_0011f1(void)
    adiw        Y,0x1                                   
    ld          R16,Y+=>sram:DAT_mem_219d               ;= ??
    ld          R17,Y+=>sram:DAT_mem_219e               ;= ??
    rcall       FUN_code_001121                         ;undefined FUN_code_001121(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_219f               ;= ??
    ld          R17,Y+=>sram:DAT_mem_21a0               ;= ??
    rcall       FUN_code_001121                         ;undefined FUN_code_001121(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_21a1               ;= ??
    ld          R17,Y+=>sram:DAT_mem_21a2               ;= ??
    rcall       FUN_code_001125                         ;undefined FUN_code_001125(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_21a3               ;= ??
    ld          R17,Y+=>sram:DAT_mem_21a4               ;= ??
    rcall       FUN_code_001125                         ;undefined FUN_code_001125(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_21a5               ;= ??
    ld          R17,Y+=>sram:DAT_mem_21a6               ;= ??
    rcall       FUN_code_001125                         ;undefined FUN_code_001125(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_21a7               ;= ??
    ld          R17,Y+=>sram:DAT_mem_21a8               ;= ??
    rcall       FUN_code_001125                         ;undefined FUN_code_001125(void)
    ldi         R16,0x20                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Y+=>sram:DAT_mem_21a9               ;= ??
    eor         R17,R17                                 
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    rcall       FUN_code_0011f1                         ;undefined FUN_code_0011f1(void)
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000cd3(void)
    ldi         Ylo,0xa1                                
    ldi         Yhi,0x21                                
    ldi         R18,0x2                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000cd7(void)
    ldi         Ylo,0xa3                                
    ldi         Yhi,0x21                                
    ldi         R18,0x3                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000cdb(void)
    ldi         Ylo,0xa5                                
    ldi         Yhi,0x21                                
    ldi         R18,0x4                                 
    rjmp        LAB_code_000ce2                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000cdf(void)
    ldi         Ylo,0xa7                                
    ldi         Yhi,0x21                                
    ldi         R18,0x5                                 
LAB_code_000ce2:              
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000d13,Zflg                    
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
    brbs        LAB_code_000d13,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000d13,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000cec,Cflg                    
    ret                                                 
LAB_code_000cec:              
    st          Y+=>sram:DAT_mem_21a7,R20               ;= ??
    st          Y+=>sram:DAT_mem_21a8,R21               ;= ??
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000cf3(void)
    ldi         Ylo,0x9f                                
    ldi         Yhi,0x21                                
    ldi         R18,0x1                                 
    rjmp        LAB_code_000cfa                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000cf7(void)
    ldi         Ylo,0x9d                                
    ldi         Yhi,0x21                                
    ldi         R18,0x0                                 
LAB_code_000cfa:              
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000d13,Zflg                    
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
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
    st          Y+=>sram:DAT_mem_219d,R20               ;= ??
    st          Y+=>sram:DAT_mem_219e,R21               ;= ??
    movw        R17R16,R21R20                           
    cli                                                 
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000d13:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000d14(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0xd                                 
    brbc        LAB_code_000d13,Zflg                    
LAB_code_000d17:              
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d17                         
    ldi         R16,0x36                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:NVM_CTRLA,R16                   ;= ??
    bset        Iflg                                    
    ldi         Zlo,0x89                                
    ldi         Zhi,0x21                                
    ser         Ylo                                     
    ldi         Yhi,0xf                                 
    ldi         R20,0x21                                
LAB_code_000d2b:              
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d2b                         
    eor         R19,R19                                 
LAB_code_000d30:              
    adiw        Y,0x1                                   
    ld          R16,Z+=>sram:DAT_mem_2189               ;= ??
    ld          R17,Y=>eeprom:DAT_mem_1000              ;= ??
    eor         R17,R16                                 
    brbs        LAB_code_000d37,Zflg                    
    st          Y=>eeprom:DAT_mem_1000,R16              ;= ??
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
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000d42(void)
    and         R19,R19                                 
    brbs        LAB_code_000d58,Zflg                    
    ldi         R16,0x35                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    sts         iospace:NVM,Ylo                         ;= ??
    sts         iospace:NVM_ADDR1,Yhi                   ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:NVM_CTRLA,R16                   ;= ??
    bset        Iflg                                    
LAB_code_000d53:              
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        LAB_code_000d53                         
    eor         R19,R19                                 
LAB_code_000d58:              
    ret                                                 
usart_f0_collect_line_lr_if:  
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_system_status(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0xd                                 
    brbc        usart_f0_collect_line_lr_if,Zflg        
;; Send "Board S/N"
    ldi         Zlo,0x54                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    lds         R16,sram:ARRAY_BOARD_SN                 ;= ??
    lds         R17,sram:ARRAY_BOARD_SN[1]              
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
;; Send "Flash timestamp:"
    ldi         Zlo,0x60                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x7c                                
    ldi         Zhi,0x2b                                
    lpm         R18,Z+=>DAT_code_0015be                 ;= 5Eh
    lpm         R19,Z+=>DAT_code_0015be                 ;= 5Eh
    lpm         R16,Z+=>PTR_LOOP_code_0015bf            ;= code:007aab
    lpm         R17,Z+=>PTR_LOOP_code_0015bf            ;= code:007aab
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    movw        R17R16,R19R18                           
    rcall       usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    ldi         Zlo,0xdc                                
    ldi         Zhi,0x29                                
;; Send "External power source:"
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    cli                                                 
    lds         R18,sram:DAT_b_porte_1_set              ;= ??
    lds         R16,sram:DAT_mem_2160                   ;= ??
    lds         R17,sram:DAT_mem_2161                   ;= ??
    lds         R20,iospace:PORTE_IN                    ;= ??
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
    rcall       FUN_code_001119                         ;undefined FUN_code_001119(void)
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
    lds         R19,sram:DAT_mem_2162                   ;= ??
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
    lds         R20,sram:DAT_mem_2158                   ;= ??
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
    ldd         R16,Z+0x2=>sram:DAT_mem_218b            ;= ??
    rcall       FUN_code_0011c6                         ;undefined FUN_code_0011c6(void)
    ldi         R16,0x2e                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ldd         R16,Z+0x3                               
    rcall       FUN_code_0011c6                         ;undefined FUN_code_0011c6(void)
    ldi         R16,0x2e                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ld          R16,Z                                   
    rcall       FUN_code_0011c6                         ;undefined FUN_code_0011c6(void)
    ldi         R16,0x2e                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ldd         R16,Z+0x1                               
    rcall       FUN_code_0011c6                         ;undefined FUN_code_0011c6(void)
    ldi         Zlo,0x1e                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ldi         Zlo,0x93                                
    ldi         Zhi,0x21                                
LAB_code_000e0c:              
    ld          R16,-Z=>sram:DAT_mem_2192               ;= ??
    ld          R17,-Z=>sram:DAT_mem_2191               ;= ??
    call        usart_f0_send_4_halfbytes               ;undefined usart_f0_send_4_halfbytes(...
    cpi         Zlo,0x8d                                
    brbs        LAB_code_000e15,Zflg                    
    ldi         R16,0x3a                                
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
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
;undefined FUN_code_000e1a(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0xd                                 
    brbc        LAB_code_000e19,Zflg                    
    cli                                                 
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    in          R17,iospace:GPIO_GPIOR0                 
    andi        R17,0x3                                 
    brbc        LAB_code_000e2c,Zflg                    
    lds         R16,sram:DAT_mem_2158                   ;= ??
    andi        R16,0xfd                                
    sts         sram:DAT_mem_2158,R16                   ;= ??
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
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
caseD_86:                     
    andi        R16,0x1f                                
    sts         sram:DAT_b_porte_1_set,R16              ;= ??
    eor         R16,R16                                 
    sts         sram:DAT_mem_2158,R16                   ;= ??
    ldi         R16,0x1                                 
    sts         sram:DAT_mem_215b,R16                   ;= ??
    ldi         R16,0x4                                 
    sts         iospace:PORTE_OUTCLR,R16                ;= ??
    ldi         R16,0xd0                                
    sts         sram:DAT_mem_215c,R16                   ;= ??
    ldi         R16,0x7                                 
    sts         sram:DAT_mem_215d,R16                   ;= ??
    cbi         iospace:GPIO_GPIOR0,0x1                 
    ldi         R16,0x41                                
    sts         iospace:PORTA_OUTSET,R16                ;= ??
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
;undefined FUN_code_000e52(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000e51,Zflg                    
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0x2e                                
    brbc        LAB_code_000e51,Zflg                    
    mov         R0,R20                                  
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0x2e                                
    brbc        LAB_code_000e51,Zflg                    
    mov         R1,R20                                  
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
    brbs        LAB_code_000e51,Cflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e51,Zflg                    
    cpi         R16,0x2e                                
    brbc        LAB_code_000e51,Zflg                    
    mov         R2,R20                                  
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
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
    st          Z+=>sram:DAT_mem_2189,R2                ;= ??
    st          Z+=>sram:DAT_mem_218a,R20               ;= ??
    st          Z+=>sram:DAT_mem_218b,R0                ;= ??
    st          Z=>sram:DAT_mem_218c,R1                 ;= ??
    cli                                                 
    rcall       fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000e7d(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000e51,Zflg                    
    rcall       FUN_code_0010d4                         ;undefined FUN_code_0010d4(void)
    brbs        LAB_code_000e51,Cflg                    
    cpi         R16,0x3a                                
    brbc        LAB_code_000e51,Zflg                    
    movw        R1R0,R21R20                             
    rcall       FUN_code_0010d4                         ;undefined FUN_code_0010d4(void)
    brbs        LAB_code_000e9d,Cflg                    
    cpi         R16,0x3a                                
    brbc        LAB_code_000e51,Zflg                    
    movw        R3R2,R21R20                             
    rcall       FUN_code_0010d4                         ;undefined FUN_code_0010d4(void)
    brbs        LAB_code_000e51,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000e9d,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000e91,Cflg                    
    ret                                                 
LAB_code_000e91:              
    ldi         Zlo,0x8d                                
    ldi         Zhi,0x21                                
    st          Z+=>sram:DAT_mem_218d,R21               ;= ??
    st          Z+=>sram:DAT_mem_218e,R20               ;= ??
    st          Z+=>sram:DAT_mem_218f,R3                ;= ??
    st          Z+=>sram:DAT_mem_2190,R2                ;= ??
    st          Z+=>sram:DAT_mem_2191,R1                ;= ??
    st          Z+=>sram:DAT_mem_2192,R0                ;= ??
    cli                                                 
    rcall       fpga_send_msg_t3                        ;undefined fpga_send_msg_t3(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000e9d:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000e9e(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000e9d,Zflg                    
    rcall       FUN_code_0010d4                         ;undefined FUN_code_0010d4(void)
    brbs        LAB_code_000e9d,Cflg                    
    cpi         R16,0xd                                 
    brbc        LAB_code_000e9d,Zflg                    
    and         R21,R21                                 
    brbc        LAB_code_000e9d,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000eaa,Cflg                    
    ret                                                 
LAB_code_000eaa:              
    sts         sram:DAT_mem_21a9,R20                   ;= ??
    mov         R16,R20                                 
    ldi         R18,0x6                                 
    eor         R17,R17                                 
    cli                                                 
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000eb3(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000ed9,Zflg                    
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0xd                                 
    brbc        LAB_code_000ed9,Zflg                    
    rcall       is_fpga_ready                           ;undefined is_fpga_ready(void)
    brbc        LAB_code_000ec8,Cflg                    
    ret                                                 
LAB_code_000ec8:              
    sts         sram:DAT_portb_setup,R20                ;= ??
    mov         R16,R20                                 
    cli                                                 
    lds         R17,iospace:PORTB_OUT                   ;= ??
    andi        R17,0x90                                
    or          R20,R17                                 
    sts         iospace:PORTB_OUT,R20                   ;= ??
    bset        Iflg                                    
    ldi         R18,0x14                                
    eor         R17,R17                                 
    cli                                                 
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
LAB_code_000ed9:              
    rjmp        usart_f0_parse_prompt::usart_f0_colle...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000eda(void)
    ldi         Ylo,0x97                                
    ldi         Yhi,0x21                                
    ldi         R18,0x12                                
    rjmp        LAB_code_000ee5                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000ede(void)
    ldi         Ylo,0x95                                
    ldi         Yhi,0x21                                
    ldi         R18,0x11                                
    rjmp        LAB_code_000ee5                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_000ee2(void)
    ldi         Ylo,0x93                                
    ldi         Yhi,0x21                                
    ldi         R18,0x10                                
LAB_code_000ee5:              
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000f02,Zflg                    
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
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
    st          Y+=>sram:DAT_mem_2193,R20               ;= ??
    st          Y+=>sram:DAT_mem_2194,R21               ;= ??
    sbi         iospace:GPIO_GPIOR0,0x5                 
    movw        R17R16,R21R20                           
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
;; Send "OK"
usart_f0_parse_send_ok:       
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
;undefined FUN_code_000f04(void)
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
    cpi         R16,0x20                                
    brbc        LAB_code_000f02,Zflg                    
    rcall       FUN_code_001098                         ;undefined5 FUN_code_001098(undefined...
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
    ld          R16,Y=>sram:DAT_mem_2199                ;= ??
    ldd         R17,Y+0x1=>sram:DAT_mem_219a            ;= ??
    cp          R16,R20                                 
    cpc         R17,R21                                 
    brbs        LAB_code_000f37,Zflg                    
    st          Y=>sram:DAT_mem_2199,R20                ;= ??
    std         Y+0x1=>sram:DAT_mem_219a,R21            ;= ??
    movw        R17R16,R21R20                           
    lds         R18,sram:DAT_mem_2185                   ;= ??
    and         R18,R18                                 
    brbs        LAB_code_000f2a,Zflg                    
    brbc        LAB_code_000f2e,Nflg                    
    ori         R17,0x80                                
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    ldi         Zlo,0x38                                
    ldi         Zhi,0x2b                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
LAB_code_000f2a:              
    sts         sram:DAT_mem_2186,R20                   ;= ??
    sts         sram:DAT_mem_2187,R21                   ;= ??
LAB_code_000f2e:              
    ori         R17,0x40                                
    ldi         R18,0x13                                
    rcall       fpga_send_msg_t2                        ;undefined fpga_send_msg_t2(void)
    bset        Iflg                                    
    mov         R17,R21                                 
    rcall       FUN_code_00118d                         ;undefined FUN_code_00118d(void)
    ldi         R16,0x48                                
    sts         sram:DAT_mem_2185,R16                   ;= ??
LAB_code_000f37:              
    bset        Iflg                                    
    rjmp        FUN_code_000ee2::usart_f0_parse_send_ok 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined is_fpga_ready(void)
    clc                                                 
    lds         R16,sram:DAT_b_porte_1_set              ;= ??
    sbrc        R16,0x4                                 
    ret                                                 
;; Send "FPGA not ready"
    ldi         Zlo,0xa8                                
    ldi         Zhi,0x2a                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    bset        Cflg                                    
    ret                                                 
    align       align(1)                                

 ->  [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined fpga_send_msg_t2(void)
    push        R18                                     
    push        R21                                     
    push        R22                                     
    ldi         R22,0xd1                                
    sts         iospace:SPIC,R22                        ;= ??
    eor         R21,R21                                 
    lsr         R18                                     
    ror         R21                                     
    lsr         R18                                     
    ror         R21                                     
    ldi         R22,0x1                                 
    sts         iospace:PORTD_OUTCLR,R22                ;= ??
    sts         iospace:SPIC_DATA,R18                   ;= ??
fpga_send_msg_t2_st_ready_1:  
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_1             
    sts         iospace:SPIC_DATA,R21                   ;= ??
fpga_send_msg_t2_st_ready_2:  
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_2             
    sts         iospace:SPIC_DATA,R17                   ;= ??
fpga_send_msg_t2_st_ready_3:  
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_3             
    sts         iospace:SPIC_DATA,R16                   ;= ??
fpga_send_msg_t2_st_ready_4:  
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        fpga_send_msg_t2_st_ready_4             
    ldi         R22,0x1                                 
    sts         iospace:PORTD_OUTSET,R22                ;= ??
    pop         R22                                     
    pop         R21                                     
    pop         R18                                     
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
    sts         iospace:SPIC,param_2                    ;= ??
    ldi         param_2,0x1                             
    lsr         param_4                                 
    ror         param_3                                 
    lsr         param_4                                 
    ror         param_3                                 
    ori         param_4,0x80                            
    sts         iospace:PORTD_OUTCLR,param_2            ;= ??
    sts         iospace:SPIC_DATA,param_4               ;= ??
fpga_send_msg_t1_st_ready_1:  
    lds         param_2,iospace:SPIC_STATUS             ;= ??
    sbrs        param_2,0x7                             
    rjmp        fpga_send_msg_t1_st_ready_1             
    sts         iospace:SPIC_DATA,param_3               ;= ??
fpga_send_msg_t1_st_ready_2:  
    lds         param_2,iospace:SPIC_STATUS             ;= ??
    sbrs        param_2,0x7                             
    rjmp        fpga_send_msg_t1_st_ready_2             
    sts         iospace:SPIC_DATA,param_5               ;= ??
fpga_send_msg_t1_st_ready_3:  
    lds         param_2,iospace:SPIC_STATUS             ;= ??
    sbrs        param_2,0x7                             
    rjmp        fpga_send_msg_t1_st_ready_3             
    lds         param_5,iospace:SPIC_DATA               ;= ??
    sts         iospace:SPIC_DATA,param_5               ;= ??
fpga_send_msg_t1_st_ready_4:  
    lds         param_2,iospace:SPIC_STATUS             ;= ??
    sbrs        param_2,0x7                             
    rjmp        fpga_send_msg_t1_st_ready_4             
    lds         param_5,iospace:SPIC_DATA               ;= ??
    ldi         param_2,0x1                             
    sts         iospace:PORTD_OUTSET,param_2            ;= ??
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
    sts         iospace:SPIC,R22                        ;= ??
    ldi         R18,0x3c                                
    eor         R21,R21                                 
    ldi         R22,0x1                                 
    sts         iospace:PORTD_OUTCLR,R22                ;= ??
    sts         iospace:SPIC_DATA,R18                   ;= ??
LAB_code_000fd2:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000fd2                         
    sts         iospace:SPIC_DATA,R21                   ;= ??
LAB_code_000fd8:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000fd8                         
LAB_code_000fdc:              
    ld          R18,Y+=>sram:DAT_mem_2189               ;= ??
    sts         iospace:SPIC_DATA,R18                   ;= ??
LAB_code_000fdf:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000fdf                         
    cpi         Ylo,0x93                                
    brbc        LAB_code_000fdc,Zflg                    
    ldi         R22,0x1                                 
    sts         iospace:PORTD_OUTSET,R22                ;= ??
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
    sts         iospace:SPIC,R22                        ;= ??
    ldi         R18,0x3d                                
    ldi         R21,0x40                                
    ldi         R22,0x1                                 
    sts         iospace:PORTD_OUTCLR,R22                ;= ??
    sts         iospace:SPIC_DATA,R18                   ;= ??
LAB_code_000ffd:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_000ffd                         
    sts         iospace:SPIC_DATA,R21                   ;= ??
LAB_code_001003:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_001003                         
LAB_code_001007:              
    lpm         R18,Z+=>DAT_code_0015be                 ;= 5Eh
                                                        ;= code:007aab
    lpm         R21,Z+=>DAT_code_0015be                 ;= 5Eh
                                                        ;= code:007aab
    sts         iospace:SPIC_DATA,R21                   ;= ??
LAB_code_00100b:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_00100b                         
    sts         iospace:SPIC_DATA,R18                   ;= ??
LAB_code_001011:              
    lds         R22,iospace:SPIC_STATUS                 ;= ??
    sbrs        R22,0x7                                 
    rjmp        LAB_code_001011                         
    cpi         Zlo,0x80                                
    brbc        LAB_code_001007,Zflg                    
    ldi         R22,0x1                                 
    sts         iospace:PORTD_OUTSET,R22                ;= ??
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
    sts         iospace:PORTA_OUTCLR,R18                ;= ??
    mov         R19,R17                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    mov         R16,R19                                 
    rcall       FUN_code_001058                         ;undefined FUN_code_001058(void)
    ldi         R18,0x10                                
    sts         iospace:PORTA_OUTSET,R18                ;= ??
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
    sts         iospace:PORTA_OUTCLR,R20                ;= ??
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
    sts         iospace:PORTA_OUTSET,R18                ;= ??
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
    sts         iospace:PORTA_OUTCLR,R16                ;= ??
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
    sts         iospace:PORTA_OUTSET,R16                ;= ??
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001058(void)
    ldi         R18,0x8                                 
LAB_code_001059:              
    ldi         R17,0x8                                 
    sbrc        R16,0x7                                 
    sts         iospace:PORTA_OUTSET,R17                ;= ??
    sbrs        R16,0x7                                 
    sts         iospace:PORTA_OUTCLR,R17                ;= ??
    ldi         R17,0x2                                 
    sts         iospace:PORTA_OUTCLR,R17                ;= ??
    add         R16,R16                                 
    nop                                                 
    sts         iospace:PORTA_OUTSET,R17                ;= ??
    lds         R17,iospace:PORTA_IN                    ;= ??
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
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined5 FUN_code_001098(undefined2 param_1, undefined param_2, undefined2 param_3, undefined2 param_4, char unaff_R16)
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
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
;undefined FUN_code_0010d4(void)
    push        R22                                     
    push        R18                                     
    eor         R18,R18                                 
    eor         R20,R20                                 
    eor         R21,R21                                 
LAB_code_0010d9:              
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
    rcall       usart_f0_get_next_byte                  ;undefined usart_f0_get_next_byte(void)
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_4_halfbytes(void)
    push        R16                                     
    push        R17                                     
    push        R18                                     
    mov         R18,R16                                 
    swap        R17                                     
    mov         R16,R17                                 
    rcall       usart_f0_send_half_byte                 ;undefined usart_f0_send_half_byte(void)
    swap        R17                                     
    mov         R16,R17                                 
    rcall       usart_f0_send_half_byte                 ;undefined usart_f0_send_half_byte(void)
    swap        R18                                     
    mov         R16,R18                                 
    rcall       usart_f0_send_half_byte                 ;undefined usart_f0_send_half_byte(void)
    swap        R18                                     
    mov         R16,R18                                 
    rcall       usart_f0_send_half_byte                 ;undefined usart_f0_send_half_byte(void)
    pop         R18                                     
    pop         R17                                     
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_half_byte(void)
    andi        R16,0xf                                 
    subi        R16,0xd0                                
    cpi         R16,0x3a                                
    brbs        LAB_code_001113,Cflg                    
    subi        R16,0xf9                                
LAB_code_001113:              
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001115(void)
    push        R20                                     
    ldi         R20,0x2                                 
    bset        Cflg                                    
    rjmp        LAB_code_001128                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001119(void)
    push        R20                                     
    ldi         R20,0x1                                 
    bset        Cflg                                    
    rjmp        LAB_code_001128                         

 ->  [UNDEFINED BYTES REMOVED]

;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001121(void)
    push        R20                                     
    eor         R20,R20                                 
    bset        Cflg                                    
    rjmp        LAB_code_001128                         
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001125(void)
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
    st          Z=>sram:DAT_mem_2156,R19                ;= ??
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
    st          -Z=>sram:DAT_mem_2155,R18               ;= ??
    inc         R19                                     
    cp          R20,R19                                 
    brbc        LAB_code_00115a,Zflg                    
    ldi         R18,0x2e                                
    st          -Z=>sram:DAT_mem_2154,R18               ;= ??
LAB_code_00115a:              
    and         R17,R17                                 
    brbc        LAB_code_00113f,Zflg                    
    and         R16,R16                                 
    brbc        LAB_code_00113f,Zflg                    
    cp          R20,R19                                 
    brbs        LAB_code_00116c,Sflg                    
    ldi         R18,0x30                                
    st          -Z=>sram:DAT_mem_2153,R18               ;= ??
    brbs        LAB_code_00116c,Zflg                    
LAB_code_001163:              
    inc         R19                                     
    cp          R19,R20                                 
    brbs        LAB_code_001168,Zflg                    
    st          -Z=>sram:DAT_mem_2152,R18               ;= ??
    rjmp        LAB_code_001163                         
LAB_code_001168:              
    ldi         R18,0x2e                                
    st          -Z=>sram:DAT_mem_2152,R18               ;= ??
    ldi         R18,0x30                                
    st          -Z=>sram:DAT_mem_2151,R18               ;= ??
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
    st          -Z=>sram:DAT_mem_2150,R16               ;= ??
    ldi         R16,0x20                                
    dec         R17                                     
LAB_code_001178:              
    cp          Zlo,R17                                 
    brbs        LAB_code_00117c,Zflg                    
    st          -Z=>sram:DAT_mem_214f,R16               ;= ??
    rjmp        LAB_code_001178                         
LAB_code_00117c:              
    adiw        Z,0x1                                   
LAB_code_00117d:              
    ld          R16,Z+=>sram:DAT_mem_2151               ;= ??
    and         R16,R16                                 
    brbs        LAB_code_001182,Zflg                    
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_00118d(void)
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
    st          Z=>sram:DAT_mem_214f,R18                ;= ??
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
    st          -Z=>sram:DAT_mem_214e,R18               ;= ??
    inc         R19                                     
    and         R17,R17                                 
    brbc        LAB_code_00119b,Zflg                    
    and         R16,R16                                 
    brbc        LAB_code_00119b,Zflg                    
    ldi         R16,0x53                                
    st          -Z=>sram:DAT_mem_214d,R16               ;= ??
LAB_code_0011b8:              
    ld          R16,Z+=>sram:DAT_mem_214d               ;= ??
    rcall       FUN_code_00129c                         ;undefined FUN_code_00129c(void)
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0011c6(void)
    push        R14                                     
    push        R16                                     
    push        R18                                     
    push        Zlo                                     
    push        Zhi                                     
    ldi         Zlo,0x56                                
    ldi         Zhi,0x21                                
    eor         R14,R14                                 
    st          Z=>sram:DAT_mem_2156,R14                ;= ??
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
    st          -Z=>sram:DAT_mem_2155,R18               ;= ??
    and         R16,R16                                 
    brbc        LAB_code_0011cf,Zflg                    
LAB_code_0011e6:              
    ld          R16,Z+=>sram:DAT_mem_2155               ;= ??
    and         R16,R16                                 
    brbs        LAB_code_0011eb,Zflg                    
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
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
;undefined FUN_code_0011f1(void)
    ldi         Zlo,0xba                                
    ldi         Zhi,0x29                                
    rcall       usart_f0_send_msg                       ;undefined usart_f0_send_msg(void)
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_msg(void)
    push        R16                                     
LAB_code_0011f6:              
    lpm         R16,Z+                                  
    and         R16,R16                                 
    brbs        LAB_code_0011fb,Zflg                    
    rcall       usart_f0_send_byte                      ;undefined usart_f0_send_byte(void)
    rjmp        LAB_code_0011f6                         
LAB_code_0011fb:              
    pop         R16                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0011fd(void)
    push        R19                                     
    ldi         R19,0x1                                 
    rjmp        usart_f0_get_next_byte::usart_f0_get_...
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_get_next_byte(void)
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
    ld          R17,Z=>sram:DAT_mem_2000                ;= ??
    ldd         R16,Z+offset sram:DAT_mem_2001 &0xff    ;= ??
    bset        Iflg                                    
    cp          R16,R17                                 
    brbs        usart_f0_get_next_byte_wait,Zflg        
    inc         R17                                     
    andi        R17,0x3f                                
    lds         R20,iospace:PORTF_OUT                   ;= ??
    sbrs        R20,0x0                                 
    rjmp        LAB_code_00121c                         
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cpse        R16,R18                                 
    ldi         R20,0x1                                 
    sts         iospace:PORTF_OUTCLR,R20                ;= ??
LAB_code_00121c:              
    eor         R18,R18                                 
    ldi         Zlo,0x7                                 
    ldi         Zhi,0x20                                
    add         Zlo,R17                                 
    adc         Zhi,R18                                 
    ld          R18,Z                                   
    sts         sram:DAT_mem_2000,R17                   ;= ??
    cpi         R18,0xd                                 
    brbc        LAB_code_00122b,Zflg                    
    lds         R17,sram:DAT_usart_f0_new_line          ;= ??
    dec         R17                                     
    sts         sram:DAT_usart_f0_new_line,R17          ;= ??
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_001238(void)
    push        Zhi                                     
    push        Zlo                                     
    push        R20                                     
    push        R19                                     
    push        R18                                     
    push        R17                                     
    ldi         Zlo,0x2                                 
    ldi         Zhi,0x20                                
    ld          R17,Z+=>sram:DAT_mem_2002               ;= ??
    ld          R18,Z+=>sram:DAT_mem_2003               ;= ??
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
    st          Z=>sram:DAT_mem_2003,R18                ;= ??
    rjmp        LAB_code_001260                         
LAB_code_001251:              
    inc         R18                                     
    ld          R19,Z=>sram:DAT_b_portf_1_set           ;= ??
    and         R19,R19                                 
    brbs        LAB_code_001247,Zflg                    
    lds         R20,iospace:USARTF0_STATUS              ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_001247                         
    sts         iospace:USARTF0,R16                     ;= ??
    lds         R20,iospace:USARTF0_CTRLA               ;= ??
    ori         R20,0x2                                 
    sts         iospace:USARTF0_CTRLA,R20               ;= ??
LAB_code_001260:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         Zlo                                     
    pop         Zhi                                     
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined usart_f0_send_byte(void)
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
    ld          R17,Z+=>sram:DAT_mem_2002               ;= ??
    ld          R18,Z+=>sram:DAT_mem_2003               ;= ??
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
    st          Z=>sram:DAT_mem_2003,R18                ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_001295                         
LAB_code_001285:              
    inc         R18                                     
    ld          R19,Z=>sram:DAT_b_portf_1_set           ;= ??
    and         R19,R19                                 
    brbs        LAB_code_00127a,Zflg                    
    lds         R20,iospace:USARTF0_STATUS              ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_00127a                         
    sts         iospace:USARTF0,R16                     ;= ??
    lds         R20,iospace:USARTF0_CTRLA               ;= ??
    ori         R20,0x2                                 
    sts         iospace:USARTF0_CTRLA,R20               ;= ??
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
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_00129c(void)
    push        Zhi                                     
    push        Zlo                                     
    push        R20                                     
    push        R18                                     
    push        R17                                     
    ldi         Zlo,0x83                                
    ldi         Zhi,0x21                                
LAB_code_0012a3:              
    cli                                                 
    ld          R17,Z+=>sram:DAT_mem_2183               ;= ??
    ld          R18,Z+=>sram:DAT_mem_2184               ;= ??
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
    st          Z=>sram:DAT_mem_2184,R18                ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_0012c8                         
LAB_code_0012ba:              
    inc         R18                                     
    andi        R18,0xf                                 
    lds         R20,iospace:USARTD0_STATUS              ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_0012af                         
    sts         iospace:USARTD0,R16                     ;= ??
    lds         R20,iospace:USARTD0_CTRLA               ;= ??
    ori         R20,0x1                                 
    sts         iospace:USARTD0_CTRLA,R20               ;= ??
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
;undefined FUN_code_010184(void)
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
    st          Y+=>sram:DAT_mem_21ae,R16               ;= ??
    sbiw        X,0x1                                   
    brbc        LAB_code_01019a,Zflg                    
    ldi         Ylo,0xae                                
    ldi         Yhi,0x21                                
    rcall       FUN_code_0101eb                         ;undefined FUN_code_0101eb(void)
    ldi         R16,0x23                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    rjmp        LAB_code_0101ac                         
LAB_code_0101a5:              
    spm         Z+                                      
    lds         R6,RAMPZ                                
    cp          Zlo,R3                                  
    cpc         Zhi,R4                                  
    cpc         R6,R5                                   
    brbc        LAB_code_0101b5,Cflg                    
LAB_code_0101ac:              
    ld          R0,Y+=>sram:DAT_mem_21ae                ;= ??
    ld          R1,Y+=>sram:DAT_mem_21af                ;= ??
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
    sts         iospace:NVM,R20                         ;= ??
    sts         iospace:NVM_ADDR1,R21                   ;= ??
    sts         iospace:NVM_ADDR2,R22                   ;= ??
    sts         iospace:NVM_DATA0,R3                    ;= ??
    sts         iospace:NVM_DATA1,R4                    ;= ??
    sts         iospace:NVM_DATA2,R5                    ;= ??
    ldi         R16,0x3a                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    cli                                                 
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:NVM_CTRLA,R16                   ;= ??
    bset        Iflg                                    
    rcall       FUN_code_0101eb                         ;undefined FUN_code_0101eb(void)
    lds         R16,iospace:NVM_DATA2                   ;= ??
    eor         R17,R17                                 
    rcall       FUN_code_0101fa                         ;undefined FUN_code_0101fa(void)
    lds         R16,iospace:NVM_DATA0                   ;= ??
    lds         R17,iospace:NVM_DATA1                   ;= ??
    rcall       FUN_code_0101fa                         ;undefined FUN_code_0101fa(void)
    ldi         R16,0xd                                 
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
    ldi         R16,0xa                                 
    rcall       FUN_code_01023e                         ;undefined FUN_code_01023e(void)
LAB_code_0101dc:              
    lds         R19,iospace:USARTF0_CTRLA               ;= ??
    andi        R19,0x3                                 
    brbc        LAB_code_0101dc,Zflg                    
    cli                                                 
    ldi         R16,0x1                                 
    sts         iospace:SLEEP,R16                       ;= ??
    ldi         R16,0x1                                 
    ldi         R17,0xd8                                
    sts         iospace:CPU_CCP,R17                     ;= ??
    sts         iospace:RST_CTRL,R16                    ;= ??
    sleep                                               
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0101eb(void)
    lds         R16,iospace:NVM_STATUS                  ;= ??
    sbrc        R16,0x7                                 
    rjmp        FUN_code_0101eb                         
    ret                                                 
;************************************************************************************************
;*                                           FUNCTION                                           *
;************************************************************************************************
;undefined FUN_code_0101f0(void)
    ldi         R16,0x25                                
    sts         iospace:NVM_CMD,R16                     ;= ??
    ldi         R16,0x9d                                
    cli                                                 
    sts         iospace:CPU_CCP,R16                     ;= ??
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
    ld          R17,Z=>sram:DAT_mem_2000                ;= ??
    ldd         R16,Z+offset sram:DAT_mem_2001 &0xff    ;= ??
    bset        Iflg                                    
    cp          R16,R17                                 
    brbs        LAB_code_01021c,Zflg                    
    inc         R17                                     
    andi        R17,0x3f                                
    lds         R20,iospace:PORTF_OUT                   ;= ??
    sbrs        R20,0x0                                 
    rjmp        LAB_code_01022f                         
    mov         R18,R17                                 
    subi        R18,0xec                                
    andi        R18,0x3f                                
    cpse        R16,R18                                 
    ldi         R20,0x1                                 
    sts         iospace:PORTF_OUTCLR,R20                ;= ??
LAB_code_01022f:              
    eor         R18,R18                                 
    ldi         Zlo,0x7                                 
    ldi         Zhi,0x20                                
    add         Zlo,R17                                 
    adc         Zhi,R18                                 
    ld          R18,Z                                   
    sts         sram:DAT_mem_2000,R17                   ;= ??
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
    ld          R17,Z+=>sram:DAT_mem_2002               ;= ??
    ld          R18,Z+=>sram:DAT_mem_2003               ;= ??
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
    st          Z=>sram:DAT_mem_2003,R18                ;= ??
    bset        Iflg                                    
    rjmp        LAB_code_01026c                         
LAB_code_01025c:              
    inc         R18                                     
    ld          R19,Z=>sram:DAT_b_portf_1_set           ;= ??
    and         R19,R19                                 
    brbs        LAB_code_010251,Zflg                    
    lds         R20,iospace:USARTF0_STATUS              ;= ??
    sbrs        R20,0x5                                 
    rjmp        LAB_code_010251                         
    sts         iospace:USARTF0,R16                     ;= ??
    lds         R20,iospace:USARTF0_CTRLA               ;= ??
    ori         R20,0x2                                 
    sts         iospace:USARTF0_CTRLA,R20               ;= ??
    bset        Iflg                                    
LAB_code_01026c:              
    pop         R17                                     
    pop         R18                                     
    pop         R19                                     
    pop         R20                                     
    pop         Zlo                                     
    pop         Zhi                                     
    ret                                                 

