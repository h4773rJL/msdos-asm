.MODEL SMALL
.STACK
.DATA
	SEM DW ?
	DEP DW ?
	
.CODE
INICIA:
	MOV     AX,@DATA
	MOV     DS,AX
	MOV     ES,AX
	;ORG     100H

INA:
	CLI
	MOV     AH,35H
	MOV     AL,05H
	INT     21H

	MOV     SEM,ES 
	MOV     DEP,BX

	MOV     AH,25H
	MOV     AL,05H
	LEA     DX, NI
	INT 21H

	MOV     AH,31H
	MOV     DX, OFFSET INA
	STI
	INT 21H

NI:     MOV     AH,02
	MOV     DL,'*'
	INT     21H
	IRET


FIN:    MOV     AX,4C00h
	INT     21h

END INICIA

