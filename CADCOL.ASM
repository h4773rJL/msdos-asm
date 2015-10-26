INCLUDE PERSA.BIB
.MODEL SMALL
.STACK
.DATA
        M1 DB 'INTRODUCE UNA CADENA',0AH,0DH,'$'
	V1 DB 64 DUP (0)

.CODE
INICIA:	MOV 	AX,@DATA
	MOV 	DS,AX
	MOV 	ES,AX
	CLS
	MOV     AH,09
	MOV     DX,OFFSET M1
	INT     21H
	MOV     SI,OFFSET V1
	MOV     AL,255
	MOV     [SI],AL
	MOV     AH,0Ah
	MOV     DX,SI
	INT     21h
	CLS
	MOV     SI,OFFSET V1
	INC     SI
	MOV     CX,[SI]
	MOV     DL,01
 	MOV     AL,10h
 	MOV     CH,00
ACZ1:   PUSH    CX
 	PUSH    AX
 	INC     SI
 	CALL    IMP
 	INC     DL
 	POP     AX
 	INC     AL
 	POP     CX
        LOOP    ACZ1
        MOV     AX,4C00h
        INT     21h

;INICIO DE PROCEDIMIENTOS

IMP PROC NEAR
	PUSH    DX
	MOV     AH,02
	MOV     BL,00
        MOV     DH,10
	MOV     DL,AL
        INT     10h
	POP     DX
	MOV     AH,09
	MOV     AL,[SI]
	MOV     BH,00
	MOV     BL,DL
	MOV     CX,0001
        INT     10h
	RET
IMP ENDP

END INICIA

