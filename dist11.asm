VPR     SEGMENT
	ASSUME CS:VPR, DS:VPR
	ORG   100h

INICIO: JMP   main

	SP0 DD 100H DUP(?)
	SP1 DD 100H DUP(?)
	SP2 DD 100H DUP(?)
	SP3 DD 100H DUP(?)
	COUNT DB 0
;------------------------------------ Minusculas
PR:     MOV     AH,02H
	MOV     BH,0
	MOV     DH,0
	MOV     DL,0
	INT     10H  ; SELECCIONAMOS RENGLON

AS:     MOV     BL,61H
OT1:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,7BH
	JE      PR
	JMP     OT1     
;---------------------------------------------------- NUMEROS
N:      MOV     AH,02H
	MOV     BH,0
	MOV     DH,04H
	MOV     DL,0
	INT     10H  ; SELECCIONAMOS RENGLON

	MOV     BL,30H
OT2:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,3AH
	JE      N
	JMP     OT2
;-------------------------------------------------------MAYUSCULAS
LM:     MOV     AH,02H
	MOV     BH,0
	MOV     DH,08H
	MOV     DL,0
	INT     10H  ; SELECCIONAMOS RENGLON

MS:     MOV     BL,41H
OT3:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,5BH
	JE      LM
	JMP     OT3

;-------------------------------------------------------SIMBOLOS
SM:     MOV     AH,02H
	MOV     BH,0
	MOV     DH,12
	MOV     DL,0
	INT     10H  ; SELECCIONAMOS RENGLON

RO:     MOV     BL,8AH
OT4:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,250
	JE      SM
	JMP     OT4
;------------------------------------------------------

controla_int08 PROC
	       PUSHF
	       CALL  CS:ant_int08   ; llamar al gestor normal de INT 8
	       STI
;*********************************
P:      NOP
	INC     COUNT
	CMP     COUNT,1
	JNE     O1
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP0-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	JMP     PR

O1:     CMP     COUNT,2
	JNE     O2
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP1-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	JMP     N

O2:     CMP     COUNT,3
	JNE     O3
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP2-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	JMP     LM

O3:     CMP     COUNT,4
	JNE     NO
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP3-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	JMP     SM
	
NO:     MOV     COUNT, 0
	JMP     P

;------------------------------------------
	       ; Colocar el proceso a ejecutar 18,2 veces/seg.

fin_int08:
	       IRET
controla_int08 ENDP

ant_int08      LABEL DWORD
ant_int08_off  DW    ?
ant_int08_seg  DW    ?

	       ; Dejar residente

main:     
	MOV     AH,00
	MOV     AL,03
	INT     10

	PUSH    ES
	MOV     AX,3508h
	INT     21h               ; obtener vector de INT 8
	MOV     ant_int08_seg,ES
	MOV     ant_int08_off,BX
	POP     ES

	LEA     DX,controla_int08
	MOV     AX,2508h
	INT     21h               ; nueva rutina de INT 8

	PUSH    ES
	MOV     ES,DS:[2Ch]       ; dirección del entorno
	MOV     AH,49h
	INT     21h               ; liberar espacio de entorno
	POP     ES

	LEA     DX,main           ; fin del código residente
	ADD     DX,15             ; redondeo a párrafo
	MOV     CL,4
	SHR     DX,CL             ; bytes -> párrafos
	MOV     AX,3100h          ; terminar residente
	INT     21h

VPR ENDS
	END   inicio
;Codigo tomado de 
