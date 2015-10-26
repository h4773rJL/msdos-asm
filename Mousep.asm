INCLUDE A:LIBRE.BIB
.MODEL SMALL
.STACK
.DATA
      MSG1  DB   'BIENVENIDO$'
      MSG2  DB   'ERROR$'
      MSG3  DB   'PRESIONE UNA TECLA PARA CONTINUAR..$'
      MSG4  DB   'R$'
      MSG5  DB   'C$'
      LET1  DB   'BOTON IZQUIERDO$'
      LET2  DB   '               $'
      VALOR   DW  0
      VALOR1  DB  0
      VALOR2  DW  0
.CODE
EMPIEZA:  JMP INICIO
HEXASCII  PROC  NEAR
          PUSH BX
          MOV CL,04H
          SHR BL,CL
          CMP BL,09H
          JG SUM37
          ADD BL,30H
          JMP SALTO2
SUM37:    ADD BL,37
SALTO2:   MOV DL,BL
          MOV AH,02H
          INT 21H
          POP BX
          AND BL,0FH
          CMP BL,09H
          JG SUMA37
          ADD BL,30H
          JMP SALTO3
SUMA37:   ADD BL,37
SALTO3:   MOV DL,BL
          MOV AH,02H
          INT 21H
          RET
HEXASCII  ENDP

INICIO:  MOV AX,@DATA
         MOV DS,AX
         MOV AH,00H
         INT 33H
         MOV VALOR,AX
         CMP VALOR,-1H
         JE SALTO1 
         LIMPIA
         CURSOR 1AH,22H
         MENS MSG2
         MOV AX,4C00H
         INT 21H
SALTO1:  LIMPIA
         CURSOR 1AH,22H
         MENS MSG1
         MOV AX,02H
         INT 33H
         CURSOR 5H,23H
         MENS MSG3
         MOV AH,00H
         INT 16H
         LIMPIA
         CURSOR 2H,1H
         MENS MSG4
         MOV AX,01H
         INT 33H
CICLO:   MOV AX,03H
         INT 33H
         MOV AX,BX
         PUSH AX
         PUSH DX
         CURSOR 2H,3H
         MOV BX,CX
         CALL HEXASCII
         CURSOR 2H,8H
         POP DX
         MOV BX,DX
         CALL HEXASCII
         POP AX
         MOV VALOR1,AX
         CMP VALOR1,2H
         JE FIN
         PONCUR 2H,13H
         CMP VALOR,1H
         JE  LETRE1
         CMP VALOR,3H
         JE  LETRE2
         JMP LETRE3
LETRE1:  MENS LET1
         JMP CICLO
LETRE2:  MENS LET2
         JMP CICLO
FIN:     MOV AX,4C00H
         INT 21H


END EMPIEZA
