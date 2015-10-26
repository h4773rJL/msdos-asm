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

        MOV AH,09  ;MARCO
        MOV AL,"É"
        MOV BH,0
        MOV BL,3
        MOV CX,1
        INT 10H

        GOTOXY 0,1

        MOV AH,09
        MOV AL,"Í"
        MOV BH,0
        MOV BL,3
        MOV CX,78
        INT 10H

        GOTOXY 0,79
         
        MOV AH,09
        MOV AL,"»"
        MOV BH,0
        MOV BL,3
        MOV CX,1
        INT 10H ;  ------

        
        MOV DX,01
        MOV CX,22

 DRAW:  PUSH CX
        PUSH DX

        GOTOXY DL,0

        MOV AH,09  ;MARCO |
        MOV AL,"º"
        MOV BH,0
        MOV BL,3
        MOV CX,1
        INT 10H
        POP DX
        PUSH DX

        GOTOXY DL,79

        MOV AH,09  ;MARCO |
        MOV AL,"º"
        MOV BH,0
        MOV BL,3
        MOV CX,1
        INT 10H
        POP DX
        INC DX
        POP CX
        LOOP DRAW


        GOTOXY 23,0

        MOV AH,09  ;MARCO
        MOV AL,"È"
        MOV BH,0
        MOV BL,3
        MOV CX,1
        INT 10H

        GOTOXY 23,1

        MOV AH,09
        MOV AL,"Í"
        MOV BH,0
        MOV BL,3
        MOV CX,78
        INT 10H

        GOTOXY 23,79
         
        MOV AH,09
        MOV AL,"¼"
        MOV BH,0
        MOV BL,3
        MOV CX,1
        INT 10H  ; FIN DEL MARCO




        MOV     AX,4C00h
        INT     21h



END INICIA
