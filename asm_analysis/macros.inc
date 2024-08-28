        .nolist

;Registers pairs
;   MSB LSB     Function
;Z  R31 R30     program/data memory pointer
;Y  R29 R28     data memory pointer
;X  R27 R26     data memory pointer
;W  R25 R24
;V  R23 R22
;U  R21 R20
;T  R19 R18
;S  R17 R16
;R  R15 R14
;Q  R13 R12
;P  R11 R10
;O  R9  R8
;N  R7  R6
;M  R5  R4
;L  R3  R2
;K  R1  R0      Result for multiplication

        .macro LOOP
my_loop:
        rjmp    my_loop
        .endm

        .macro ABS REG
        brpl    1f
        neg     \REG
1:
        .endm

        .macro SWAP_REG REG1 REG2 RTEMP
        mov     \RTEMP,\REG1
        mov     \REG1,\REG2
        mov     \REG2,\RTEMP
        .endm

        .macro BRCLR BYTE BIT ADDRESS
        sbrs    \BYTE,\BIT
        rjmp    \ADDRESS
        .endm

        .macro BRSET BYTE BIT ADDRESS
        sbrc    \BYTE,\BIT
        rjmp    \ADDRESS
        .endm

        .macro IOBRCLR BYTE BIT ADDRESS
        sbis    \BYTE,\BIT
        rjmp    \ADDRESS
        .endm

        .macro IOBRSET BYTE BIT ADDRESS
        sbic    \BYTE,\BIT
        rjmp    \ADDRESS
        .endm

		.macro ISR_PUSH_SREG_R16
        push    r16
        in      r16,SREG
        push    r16
        .endm

        .macro ISR_POP_SREG_R16_RETI
        pop     r16
        out     SREG,r16
        pop     r16
        reti
        .endm

        .macro CASE_R16 VALUE NEXT_CASE
        cpi     r16,(\VALUE)
        brne    (\NEXT_CASE)
        .endm

		.macro STS_IMM ADDRESS VALUE
		ldi		r16,(\VALUE)
		sts     (\ADDRESS),r16
		.endm

; When using the I/O specific commands IN and OUT,
; the I/O addresses 0x00 – 0x1F must be used //0x3F must be used.

; When addressing I/O Registers as data space using LD and ST instructions,
; 0x20 must be added to these addresses.

; For the Extended I/O space from 0x60 – 0xFF in SRAM,
; only the ST/STS/STD and LD/LDS/LDD
; instructions can be used.

        .macro OUT_PORT16 PORT VALUE
        ldi     r16,hi8(\VALUE)
        .if (\PORT > 0x1F)
        sts     (\PORT+1),r16
        .else
		out     (\PORT+1),r16
		.endif
        ldi     r16,lo8(\VALUE)
        .if (\PORT > 0x1F)
        sts     (\PORT),r16
        .else
		out		(\PORT),r16
		.endif
        .endm

		.macro OUT_PORT PORT VALUE
		ldi		r16,\VALUE
		.if (\PORT > 0x1F)
		sts     \PORT,r16
		.else
		out     \PORT,r16
		.endif
		.endm

		.macro IN_PORT PORT
		ldi		r16,\VALUE
		.if (\PORT > 0x1F)
		lds     r16,\PORT
		.else
		in      r16,\PORT
		.endif
		.endm

		.macro LD_IMM REG VALUE
		ldi		r16,\VALUE
		mov		\REG,r16
		.endm

		.macro CP_IMM REG VALUE
		ldi		r16,\VALUE
		cp		\REG,r16
		.endm

		.macro SUB_IMM REG VALUE
		ldi		r16,\VALUE
		sub		\REG,r16
		.endm

		.macro ADD_IMM REG VALUE
		ldi		r16,\VALUE
		add		\REG,r16
		.endm

		.macro AND_IMM REG VALUE
		ldi		r16,\VALUE
		and		\REG,r16
		.endm

		.macro OR_IMM REG VALUE
		ldi		r16,\VALUE
		or		\REG,r16
		.endm

		.macro ADI_REG REG VALUE
		subi	\REG,(-(\VALUE)) & 0xff
		.endm

		.macro LDS_K ADDRESS
        lds     r0,\ADDRESS
        lds     r1,(\ADDRESS)+1
        .endm

		.macro STS_K ADDRESS
        sts     \ADDRESS,r0
        sts     (\ADDRESS)+1,r1
        .endm

		.macro LDS_S ADDRESS
        lds     r16,\ADDRESS
        lds     r17,(\ADDRESS)+1
        .endm

		.macro STS_S ADDRESS
        sts     \ADDRESS,r16
        sts     (\ADDRESS)+1,r17
        .endm

		.macro LDS_T ADDRESS
        lds     r18,\ADDRESS
        lds     r19,(\ADDRESS)+1
        .endm

		.macro STS_T ADDRESS
        sts     \ADDRESS,r18
        sts     (\ADDRESS)+1,r19
        .endm

		.macro LDS_U ADDRESS
        lds     r20,\ADDRESS
        lds     r21,(\ADDRESS)+1
        .endm

		.macro STS_U ADDRESS
        sts     \ADDRESS,r20
        sts     (\ADDRESS)+1,r21
        .endm

		.macro LDS_V ADDRESS
        lds     r22,\ADDRESS
        lds     r23,(\ADDRESS)+1
        .endm

		.macro STS_V ADDRESS
        sts     \ADDRESS,r22
        sts     (\ADDRESS)+1,r23
        .endm

		.macro LDS_W ADDRESS
        lds     r24,\ADDRESS
        lds     r25,(\ADDRESS)+1
        .endm

		.macro STS_W ADDRESS
        sts     \ADDRESS,r24
        sts     (\ADDRESS)+1,r25
        .endm

		.macro LDS_X ADDRESS
        lds     r26,\ADDRESS
        lds     r27,(\ADDRESS)+1
        .endm

		.macro STS_X ADDRESS
        sts     \ADDRESS,r26
        sts     (\ADDRESS)+1,r27
        .endm

		.macro LDS_Y ADDRESS
        lds     r28,\ADDRESS
        lds     r29,(\ADDRESS)+1
        .endm

		.macro STS_Y ADDRESS
        sts     \ADDRESS,r28
        sts     (\ADDRESS)+1,r29
        .endm

		.macro LDS_Z ADDRESS
        lds     r30,\ADDRESS
        lds     r31,(\ADDRESS)+1
        .endm

		.macro STS_Z ADDRESS
        sts     \ADDRESS,r30
        sts     (\ADDRESS)+1,r31
        .endm

		.macro LDI_S VALUE
		ldi		r16,lo8(\VALUE)
		ldi		r17,hi8(\VALUE)
		.endm

		.macro LDI_T VALUE
		ldi		r18,lo8(\VALUE)
		ldi		r19,hi8(\VALUE)
		.endm

		.macro LDI_U VALUE
		ldi		r20,lo8(\VALUE)
		ldi		r21,hi8(\VALUE)
		.endm

		.macro LDI_V VALUE
		ldi		r22,lo8(\VALUE)
		ldi		r23,hi8(\VALUE)
		.endm

		.macro LDI_W VALUE
		ldi		r24,lo8(\VALUE)
		ldi		r25,hi8(\VALUE)
		.endm

		.macro LDI_X VALUE
		ldi		r26,lo8(\VALUE)
		ldi		r27,hi8(\VALUE)
		.endm

		.macro LDI_Y VALUE
		ldi		r28,lo8(\VALUE)
		ldi		r29,hi8(\VALUE)
		.endm

		.macro LDI_Z VALUE
		ldi		r30,lo8(\VALUE)
		ldi		r31,hi8(\VALUE)
		.endm

        .macro TST_S
        push	r0
        or      r0,r16
        or		r0,r17
        pop		r0
        .endm

        .macro TST_T
        push	r0
        or      r0,r18
        or		r0,r19
        pop		r0
        .endm

        .macro CLR_K
        clr     r0
        clr     r1
        .endm

        .macro CLR_L
        clr     r2
        clr     r3
        .endm

        .macro CLR_M
        clr     r4
        clr     r5
        .endm

        .macro CLR_S
        clr     r16
        clr     r17
        .endm

        .macro CLR_T
        clr     r18
        clr     r19
        .endm

        .macro CLR_U
        clr     r20
        clr     r21
        .endm

        .macro CLR_V
        clr     r22
        clr     r23
        .endm

        .macro CLR_W
        clr     r24
        clr     r25
        .endm

        .macro SET_S
        ser     r16
        ser     r17
        .endm

        .macro SET_T
        ser     r18
        ser     r19
        .endm

        .macro SET_U
        ser     r20
        ser     r21
        .endm

        .macro SET_V
        ser     r22
        ser     r23
        .endm

        .macro SET_W
        ser     r24
        ser     r25
        .endm

        .macro INC_S
        sec
        adc     r16,r0
        adc     r17,r0
        .endm

        .macro INC_T
        sec
        adc     r18,r0
        adc     r19,r0
        .endm

        .macro INC_U
        sec
        adc     r20,r0
        adc     r21,r0
        .endm

        .macro INC_V
        sec
        adc     r22,r0
        adc     r23,r0
        .endm

        .macro INC_W
        sec
        adc     r24,r0
        adc     r25,r0
        .endm

        .macro DEC_S
        sec
        sbc    r16,r0
        sbc    r17,r0
        .endm

        .macro DEC_T
        sec
        sbc     r18,r0
        sbc     r19,r0
        .endm

        .macro DEC_U
        sec
        sbc     r20,r0
        sbc     r21,r0
        .endm

        .macro DEC_V
        sec
        sbc     r22,r0
        sbc     r23,r0
        .endm

        .macro DEC_W
        sec
        sbc     r24,r0
        sbc     r25,r0
        .endm

        .macro LSL_S
        lsl     r16
        rol     r17
        .endm

        .macro LSL_T
        lsl     r18
        rol     r19
        .endm

		.macro LSL_U
		lsl		r20
		rol		r21
		.endm

		.macro LSL_V
		lsl		r22
		rol		r23
		.endm

        .macro LSR_S
        lsr     r17
        ror     r16
        .endm

        .macro LSR_T
        lsr     r19
        ror     r18
        .endm

		.macro LSR_U
		lsr		r21
		ror		r20
		.endm

		.macro LSR_V
		lsr		r23
		ror		r22
		.endm

        .macro ASR_S
        asr     r17
        ror     r16
        .endm

        .macro ASR_T
        asr     r19
        ror     r18
        .endm

		.macro ASR_U
		asr		r21
		ror		r20
		.endm

		.macro ASR_V
		asr		r23
		ror		r22
		.endm

		.macro ROR_U
		ror		r21
		ror		r20
		.endm

        .macro RETZ
        brne    1f
        ret
1:
        .endm

        .macro PUSH_L
        push    r2
        push    r3
        .endm

        .macro POP_L
        pop     r3
        pop     r2
        .endm

        .macro PUSH_M
        push    r4
        push    r5
        .endm

        .macro POP_M
        pop     r5
        pop     r4
        .endm

        .macro PUSH_N
        push    r20
        push    r21
        .endm

        .macro POP_N
        pop     r21
        pop     r20
        .endm

        .macro PUSH_S
        push    r16
        push    r17
        .endm

        .macro POP_S
        pop     r17
        pop     r16
        .endm

        .macro PUSH_T
        push    r18
        push    r19
        .endm

        .macro POP_T
        pop     r19
        pop     r18
        .endm

        .macro PUSH_U
        push    r20
        push    r21
        .endm

        .macro POP_U
        pop     r21
        pop     r20
        .endm

        .macro PUSH_V
        push    r22
        push    r23
        .endm

        .macro POP_V
        pop     r23
        pop     r22
        .endm

        .macro PUSH_W
        push    r24
        push    r25
        .endm

        .macro POP_W
        pop     r25
        pop     r24
        .endm

        .macro PUSH_X
        push    r26
        push    r27
        .endm

        .macro POP_X
        pop     r27
        pop     r26
        .endm

        .macro PUSH_Y
        push    r28
        push    r29
        .endm

        .macro POP_Y
        pop     r29
        pop     r28
        .endm

        .macro PUSH_Z
        push    r30
        push    r31
        .endm

        .macro POP_Z
        pop     r31
        pop     r30
        .endm

		.macro EX_TU
		push	r21
		push	r20
		mov		r21,r19
		mov		r20,r18
		pop		r18
		pop		r19
		.endm

        .macro _GET_ROM_TABLE TABLE REG
        PUSH_Z
        LDI_Z   \TABLE
        add     r30,\REG
        adc     r31,r0
        lpm     \REG,z
        POP_Z
        ret
        .endm

        .list
