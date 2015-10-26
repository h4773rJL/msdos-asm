.MODEL SMALL
.STACK
.DATA
        M1 DB 'BIENVENIDO$'
.CODE
EMPIEZA:        MOV AX,@DATA
                MOV DS,AX

                MOV AH,00
                MOV AL,02
                INT 10H

                MOV AH,09
                MOV DX,OFFSET M1
                INT 21H

                MOV AX,4C00H
                INT 21H
END EMPIEZA

