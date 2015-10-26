INCLUDE PERSA.BIB
.MODEL SMALL
.STACK
.DATA
	M1 DB 'INTRODUCE UN NUMERO',0AH,0DH,'$'
	M2 DB 'INTRODUCE OTRO NUMERO',0AH,0DH,'$'
        M3 DB 'EXCOJE LA OPERACION UNA OPERACION (+,-)',0AH,0DH,'$'
.CODE
INI:	MOV	AX,@DATA
	MOV 	DS,AX
        MOV     ES,AX
	CLS
 	MOV     AH,09
	MOV     DX,OFFSET M1
	INT     21h
	MOV     AH,01
	INT     21h
	CALL    VALIDAR1
	PUSH    AX
LEE2:   CLS
        MOV     AH,09
	MOV	DX,OFFSET M2
        INT     21H
	MOV     AH,01
	INT     21h
	CALL    VALIDAR2
	PUSH    AX
OPER:	CLS
        WRITE   M3
	MOV     AH,01
	INT     21H
	CMP     AL,2Bh
	JZ      SUMA
	CMP     AL,2Dh
        JZ      LLAMAR
	JMP     OPER
TNT:    MOV     AX,4C00H
	INT     21H
LLAMAR: CALL RESTA


	
;INICIO DE PROCEDIMIENTOS Y MACROS PERSONALIZADO
;PROGRAM By PERSA (980018841).. THANKS CLAUDIA ZV

VALIDAR1 PROC NEAR
	CMP     AL,30H
	JL      ERR
	CMP     AL,39H
        JLE     RT30
	CMP     AL,41H
	JL      ERR
	CMP     AL,46H
        JLE     RT37
	JMP     ERR
RT30:   SUB     AL,30H
	JMP     FINP
RT37:   SUB     AL,37H
FINP:	RET
ERR:	POP 	AX
	JMP	INI
VALIDAR1 ENDP

VALIDAR2 PROC NEAR
	CMP     AL,30H
        JL      ER
	CMP     AL,39H
	JLE     RES30
	CMP     AL,41H
	JL      ER
	CMP     AL,46H
	JLE     RES37
	JMP     ER
RES30:	SUB     AL,30H
	JMP     FINP2
RES37:	SUB     AL,37H
FINP2:	RET
ER:	POP 	AX
	JMP	LEE2
VALIDAR2 ENDP

SUMA PROC NEAR
	CLS       
	POP     AX
	MOV     DX,AX
	POP     AX
	PUSH    AX
	PUSH    DX
	MOV     BX,AX
	CMP     BL,09
	JG      SUM37
	ADD     BL,30H
	JMP     IMP
SUM37:	ADD     BL,37H
IMP:	MOV     DL,BL
	MOV     AH,02
	INT     21H
	MOV     AH,02
	MOV     DL,2BH
	INT     21H
	POP     BX
	PUSH    BX
	CMP     BL,09
	JG      SU37
	ADD     BL,30H
	JMP     IM
SU37:	ADD     BL,37H
IM:	MOV     DL,BL
	MOV     AH,02
	INT     21H
	MOV     AH,02
	MOV     DL,3DH
	INT     21H
	POP     AX
	POP     BX
	ADD     BX,AX
	MOV     BH,00
        PUSH    BX
        MOV     BL,04
        SHR     BL,CL
        CMP     BL,9
        JG      SA0
        ADD     BL,30h
        JMP     PT01
   SA0: ADD     BL,37h
  PT01: MOV     DL,BL
        MOV     AH,02
        INT     21h 
        POP     BX
        AND     BL,0Fh
        CMP     BL,9
        JG      SA1
        ADD     BL,30h
        JMP     PTA1
   SA1: ADD     BL,37h
  PTA1: MOV     DL,BL
        MOV     AH,02
        INT     21h       
        JMP     TNT
SUMA ENDP

RESTA PROC NEAR
	CLS
        POP     BX
        POP     AX
	MOV     DX,AX
	POP     AX
        PUSH    BX
        PUSH    AX
	PUSH    DX
	MOV     BX,AX
	CMP     BL,09
        JG      SM37
	ADD     BL,30H
	JMP     IMPR
SM37:   ADD     BL,37H
IMPR:	MOV     DL,BL
	MOV     AH,02
	INT     21H
	MOV     AH,02
	MOV     DL,2BH
	INT     21H
	POP     BX
	PUSH    BX
	CMP     BL,09
	JG      SUR37
	ADD     BL,30H
	JMP     IMR
SUR37:	ADD     BL,37H
IMR:	MOV     DL,BL
	MOV     AH,02
	INT     21H
	MOV     AH,02
	MOV     DL,3DH
	INT     21H
	POP     AX
	POP     BX
	SUB     BX,AX
	MOV     BH,00
        PUSH    BX
        MOV     BL,04
        SHR     BL,CL

        CMP     BL,9
        JG      ACZV
        ADD     BL,30h
        JMP     CRIO
ACZV:   ADD     BL,37h
CRIO:   MOV     DL,BL
        MOV     AH,02
        INT     21h 
        POP     BX
        AND     BL,0Fh
        CMP     BL,9
        JG      CLAUS
        ADD     BL,30h
        JMP     LUIS
CLAUS:  ADD     BL,37h
LUIS:   MOV     DL,BL
        MOV     AH,02
        INT     21h 
        JMP     TNT
RESTA ENDP
END INI
