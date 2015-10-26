VPR     SEGMENT   
	ASSUME CS:VPR, DS:VPR, SS:VPR, ES:VPR

	ORG     100H

	JMP     INICIA

	SP0 DD 100H DUP(?)
	SP1 DD 100H DUP(?)
	SP2 DD 100H DUP(?)
	SP3 DD 100H DUP(?)
	COUNT DB 0

INICIA: 
	POP     ES
	MOV     SP, OFFSET SP0 
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX

	MOV     SP, OFFSET SP1 
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX

	MOV     SP, OFFSET SP2
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX

	MOV     SP, OFFSET SP3
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX

	MOV     AH,00
	MOV     AL,03
	INT     10h

P:      NOP
	CMP     COUNT,0
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
	JMP     AS

O1:     CMP     COUNT,1
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
	
O2:     CMP     COUNT,2
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

O3:     CMP     COUNT,3
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

NO:     CMP     COUNT, 03
	JE      P
	INC     COUNT
	JMP     P

;1er proceso
AS:     MOV     BL,61H
OT1:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,7BH
	JE      AS
	JMP     OT1

;2do proceso
N:      MOV     AH,02H
	MOV     BH,0
	MOV     DH,04H
	MOV     DL,0
	INT     10H  ; SELECCIONAMOS RENGLON

NS:     MOV     BL,30H
OT2:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,3AH
	JE      NS
	JMP     OT2

;3er proceso
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
	JE      MS
	JMP     OT3

;4to proceso
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
	JE      RO
	JMP     OT4

	MOV     AX, 4C00H
	INT     21H

VPR     ENDS
	END     INICIA
