SSEG SEGMENT STACK PARA 'STACK'
    DW  256  DUP(?)
SSEG ENDS
DSEG SEGMENT PARA 'DATA'
     MENS   DB  '           $'
     CONM   DB   0
     SUM    DB   0
     CONT   DW   0
     PAL    DD   0
DSEG ENDS
CSEG SEGMENT PARA 'CODE'
  PRINCI PROC FAR
  ASSUME CS:CSEG, DS:DSEG, SS:SSEG
         PUSH DS
         XOR AX,AX
         PUSH AX
         MOV AX,DSEG
         MOV DS,AX
    ;REALIZA EL DESPLIEGUE ASCII
    CLI
    MOV AH,35H
    MOV AL,05
    INT 21H
    MOV WORD PTR PAL,BX
    MOV WORD PTR PAL+2,ES
    MOV AH,25H
    MOV AL,05
    MOV DX,OFFSET HEX_ASC
    INT 21H
    PRINCI ENDP
HEX_ASC PROC
         CALL DETIENE
         CMP AH,37H
         JE SALIR
         MOV SUM,0
         MOV CONT,0
         JMP SIGUE
  RESTA: SUB SUM,20
         SUB CONT,20
  SIGUE: MOV CL,1
         CALL LIMPIA
         CALL CURSOR
         CALL ALIM_LIN
         CALL ALIM_LIN
         CALL ALIM_LIN
SUMAOTRO:
         LEA DX,MENS
         CALL ESC_CADE
         MOV DL,SUM
         CALL ESCRIBE
         LEA DX,MENS
         CALL ESC_CADE
         MOV DL,SUM
         CALL DESEMPAQ
         CMP CONT,260
         JE  SALIR
         CALL ALIM_LIN
         INC CL
         INC SUM
         INC CONT
         CMP CL,10
         JL SUMAOTRO
         CALL MARCO
COMPARA:CALL DETIENE
        CMP AH,48H
        JE RESTA
        CMP AH,50H
        JE SIGUE
SALIR:  CALL LIMPIA
        IRET
HEX_ASC ENDP

DETIENE PROC
        MOV AH,10H
        INT 16H
        RET
DETIENE ENDP
BIN_ASC PROC
     CMP DL,09H
     JG SUMA37H
     ADD DL,30H
     JMP FINAL
SUMA37H:ADD DL,37H
     FINAL:RET
BIN_ASC ENDP
MARCO PROC
       MOV CONM,01H
OTRO:  MOV AH,02H
       MOV BH,00H
       MOV DH,00H
       MOV DL,CONM
       INT 10H
       CALL ESC_V
       INC CONM
       CMP CONM,23H
       JL OTRO
       MOV CONM,00H
OTRO1: MOV AH,02H
       MOV BH,00H
       MOV DH,CONM
       MOV DL,00H
       INT 10H
       CALL ESC_A
       INC CONM
       CMP CONM,0FH
       JL OTRO1
       MOV CONM,00H
OTRO2: MOV AH,02H
       MOV BH,00H
       MOV DH,CONM
       MOV DL,22H
       INT 10H
       CALL ESC_R
       INC CONM
       CMP CONM,0FH
       JL OTRO2
       MOV CONM,00H
OTRO3: MOV AH,02H
       MOV BH,00H
       MOV DH,0FH
       MOV DL,CONM
       INT 10H
       CALL ESC_C
       INC CONM
       CMP CONM,23H
       JL OTRO3
       RET
MARCO ENDP      
BIN_ASC2 PROC
     CMP DL,09H
     JG SUMA37
     ADD DL,30H
     JMP FINAL2
SUMA37:ADD DL,37H
       ADD DL,6
       MOV AL,DL
       DAA
       MOV DL,AL
     FINAL2:RET
BIN_ASC2 ENDP
LEE PROC
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH,01H
    INT 21H
    POP DX
    POP CX
    POP BX
    RET
LEE ENDP
ASC_BIN PROC
    CMP AL,30H
    JL ERROR
    CMP AL,39H
    JLE RESTA30H
    CMP AL,41H
    JL ERROR
    CMP AL,46H
    JG ERROR
    SUB AL,37H
    JMP FIN
RESTA30H:SUB AL,30H
         JMP FIN
ERROR:  MOV AL,00
FIN:RET
ASC_BIN ENDP
DESEMPAQ PROC
     PUSH DX
     PUSH CX
     MOV DH,DL
     MOV CL,04H
     SHR DL,CL
     CALL BIN_ASC
     CALL ESCRIBE
     MOV DL,DH
     AND DL,0FH
     CALL BIN_ASC
     CALL ESCRIBE
     POP CX
     POP DX
     RET
DESEMPAQ ENDP
ESC_DECI PROC
     PUSH DX
     PUSH CX
     MOV DH,DL
     MOV CL,04H
     SHR DL,CL
     CALL BIN_ASC2
     CALL ESCRIBE
     MOV DL,DH
     AND DL,0FH
     CALL BIN_ASC2
     CALL ESCRIBE
     POP CX
     POP DX
     RET
ESC_DECI ENDP
EMPAQUETA PROC
     PUSH CX
     CALL LEE
     CALL ASC_BIN
     MOV CL,04H
     SHL AL,CL
     MOV CH,AL
     CALL LEE
     CALL ASC_BIN
     ADD AL,CH
     POP CX
     RET
EMPAQUETA ENDP
ESC_V PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     MOV AH,09H
     MOV AL,219
     MOV BH,00
     MOV BL,02H
     MOV CX,1
     INT 10H
     POP DX
     POP CX
     POP BX
     POP AX
     RET
ESC_V ENDP
ESC_A PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     MOV AH,09H
     MOV AL,219
     MOV BH,00
     MOV BL,01H
     MOV CX,1
     INT 10H
     POP DX
     POP CX
     POP BX
     POP AX
     RET
ESC_A ENDP
ESC_R PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     MOV AH,09H
     MOV AL,219
     MOV BH,00
     MOV BL,0CH
     MOV CX,1
     INT 10H
     POP DX
     POP CX
     POP BX
     POP AX
     RET
ESC_R ENDP
ESC_C PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     MOV AH,09H
     MOV AL,219
     MOV BH,00
     MOV BL,03H
     MOV CX,1
     INT 10H
     POP DX
     POP CX
     POP BX
     POP AX
     RET
ESC_C ENDP

ESCRIBE PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     MOV AH,02H
     INT 21H
     POP DX
     POP CX
     POP BX
     POP AX
     RET
ESCRIBE ENDP
ESC_CADE PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     MOV AH,9H
     INT 21H
     POP DX
     POP CX
     POP BX
     POP AX
     RET
ESC_CADE ENDP
LIMPIA PROC NEAR
       MOV AX,0600H
       MOV BH,07H
       MOV CX,0000H
       MOV DX,184FH
       INT 10H
       RET
LIMPIA ENDP
CURSOR PROC
       MOV AH,02H
       MOV BH,00H
       MOV DX,0004H
       INT 10H
       RET
CURSOR ENDP    
ALIM_LIN PROC
     PUSH DX
     MOV DL,0AH
     CALL ESCRIBE
     MOV DL,0DH
     CALL ESCRIBE
     POP DX
     RET
ALIM_LIN ENDP
CSEG ENDS
     END PRINCI
