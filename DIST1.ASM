TPM     SEGMENT
	ASSUME CS:TPM, DS:TPM

	ORG 100H

	SP0 DD 100H DUP(?)
	SP1 DD 100H DUP(?)
	SP2 DD 100H DUP(?)
	SP3 DD 100H DUP(?)
	COUNT DB 0

INICIA: nop
	nop
	MOV     SP, OFFSET SP0 
	MOV     AX,0
	MOV     BX,0
	MOV     CX,0
	MOV     DX,0
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX

	MOV     SP, OFFSET SP1 
	MOV     AX,20h
	MOV     BX,20h
	MOV     CX,20h
	MOV     DX,20h
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX
	

	MOV     SP, OFFSET SP2
	MOV     AX,40h
	MOV     BX,40h
	MOV     CX,40h
	MOV     DX,40h
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX

	MOV     SP, OFFSET SP3
	MOV     AX,70h
	MOV     BX,70h
	MOV     CX,70h
	MOV     DX,70h
	PUSH    AX
	PUSH    BX     
	PUSH    CX
	PUSH    DX
	
FT:     MOV     SP, [OFFSET SP0-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	INC     AX
	INC     BX
	INC     CX
	INC     DX
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP1-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	INC     AX
	INC     BX
	INC     CX
	INC     DX
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP2-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	INC     AX
	INC     BX
	INC     CX
	INC     DX
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	MOV     SP, [OFFSET SP3-8]
	POP     DX
	POP     CX
	POP     BX
	POP     AX
	INC     AX
	INC     BX
	INC     CX
	INC     DX
	PUSH    AX
	PUSH    BX
	PUSH    CX
	PUSH    DX
	INC     COUNT
	JMP FT

	;MOV     AH,00
	;MOV     AL,03
	;INT     10h
       

FIN:    MOV     AX,4C00h
	INT     21h

TPM ENDS
 END INICIA

