INCLUDE PERSA.BIB
.MODEL SMALL
.STACK
.DATA
  M1 DB 'DESPLAZAMIENTO Y DIRECCION DE INTERRUPCIONES',10,13,'$'
  M2 DB ' ',10,13,'$'
.CODE

I:      MOV     AX,@DATA
        MOV     DS,AX
        MOV     ES,AX

        CLS
        WRITE   M1

        MOV     CX, 0

P:      MOV     AH, 35H
        MOV     AL, CL
        INT     21H

        PUSH    CX
        PUSH    BX
        PUSH    ES

        MOV     DX,ES
        MOV     BL,DH
        CALL    IMPRI
        POP     ES
        MOV     DX,ES
        MOV     BL,DL
        CALL    IMPRI
        MOV     AH,02
        MOV     DL,':'
        INT     21H
        POP     BX
        MOV     AX,BX
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        ;MOV     AH,02
        ;MOV     DL,0DH
        ;INT     21H

        WRITE M2

        POP     CX
        INC     CX
        CMP     CX,20
        JE      FIN
        JMP     P


FIN:    MOV     AX,4C00h
        INT     21h


IMPRI PROC NEAR
        PUSH    BX
        MOV     CL,04
        SHR     BL,CL
        CMP     BL,09
        JG      S37
        ADD     BL,30H
        JMP     PD
S37:    ADD     BL,37H
PD:     MOV     DL,BL
        MOV     AH,02
        INT     21H
        POP     BX
        AND     BL,0FH
        CMP     BL,09
        JG      S137
        ADD     BL,30H
        JMP     PD1
        S137:   ADD     BL,37H
        PD1:    MOV     DL,BL
        MOV     AH,02
        INT     21H
        RET
IMPRI ENDP
END I
