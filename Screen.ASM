TITLE  SCREENSAVER

PILA     SEGMENT PARA 'STACK'
       DW 80 DUP  (' ')
PILA     ENDS

DATA SEGMENT PARA 'DATA'

PRESS DB 0dh,0ah,'           I N S T U T O   T E C N O L O G I C O   D E   P U E B L A'
      DB 0dh,0ah,' '
      DB 0dh,0ah,'                                   PROFESOR:'
      DB 0dh,0ah,'                          LIC. OSCAR HERNANDEZ MORALES'
      DB 0dh,0ah,' '
      DB 0dh,0ah,'                            VICENTE LOPEZ RODRIGUEZ'
      DB 0dh,0ah,'                                      VINNY'
      DB 0dh,0ah,'                             E X A M E N   F I N A L'
      DB 0dh,0ah,'                             -----------------------','$'



BITA  DB '²²      ²²  ²²²²²²²²  ²²²²    ²²  ²²²²    ²²  ²²      ²²','$'
BITB  DB '²²      ²²   ²²²²²²   ²² ²²   ²²  ²² ²²   ²²  ²²      ²²','$'
BITC  DB '²²      ²²     ²²     ²² ²²   ²²  ²² ²²   ²²  ²²      ²²','$'
BITD  DB '²²      ²²     ²²     ²²  ²²  ²²  ²²  ²²  ²²   ²      ² ','$'
BITE  DB '²²      ²²     ²²     ²²  ²²  ²²  ²²  ²²  ²²    ²    ²  ','$'
BITF  DB '²²      ²²     ²²     ²²   ²² ²²  ²²   ²² ²²     ²  ²   ','$'
BITG  DB '²²      ²²     ²²     ²²   ²² ²²  ²²   ²² ²²      ²²    ','$'  
BITH  DB ' ²      ²      ²²     ²²    ²²²²  ²²    ²²²²      ²²    ','$' 
BITI  DB '  ²    ²     ²²²²²²   ²²     ²²²  ²²     ²²²      ²²    ','$'
BITJ  DB '   ²²²²     ²²²²²²²²  ²²      ²²  ²²      ²²    ²²²²²²  ','$'


KEEP    DB 0DH,0AH,'PRESIONA CUALQUIER TECLA PARA CONTINUAR...'
	DB 0DH,0AH,'[ENTER] SALIR ','$'
CAD     DB 50 DUP (' ')
REN     DB 24 DUP (' ')
COL     DB 80 DUP (' ')
DATA      ENDS

CODE      SEGMENT PARA 'CODE'

ASSUME   SS:PILA,DS:DATA,CS:CODE

CLS MACRO
	MOV AH,00
	MOV AL,02
	INT 10H
ENDM

MARCO MACRO
     GOTOXYS 0,0
     MOV AH,09  ;MARCO
     MOV AL,"É"
     MOV BH,0
     MOV BL,3
     MOV CX,1
     INT 10H

     GOTOXYS 0,1

     MOV AH,09
     MOV AL,"Í"
     MOV BH,0
     MOV BL,3
     MOV CX,78
     INT 10H
     GOTOXYS 0,79

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

     GOTOXYS DL,0
    
     MOV AH,09  ;MARCO |
     MOV AL,"º"
     MOV BH,0
     MOV BL,3

     MOV CX,1
     INT 10H
     POP DX
     PUSH DX

     GOTOXYS DL,79

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
     GOTOXYS 23,0

     MOV AH,09  ;MARCO
     MOV AL,"È"
     MOV BH,0
     MOV BL,3
     MOV CX,1
     INT 10H

     GOTOXYS 23,1

     MOV AH,09
     MOV AL,"Í"
     MOV BH,0
     MOV BL,3
     MOV CX,78
     INT 10H

     GOTOXYS 23,79

     MOV AH,09
     MOV AL,"¼"
     MOV BH,0
     MOV BL,3
     MOV CX,1
     INT 10H  ; FIN DEL MARCO
ENDM


GOTOXYS MACRO X,Y
	MOV AH,02
	MOV BH,00
	MOV DH,X
	MOV DL,Y
	INT 10H
ENDM

TIMMER  PROC    NEAR
	 MOV     SI,0000
 TNT:    INC     SI
	 CMP     SI,3500
	 JE      FUT
	 MOV     DX,0000
 VINN:   INC     DX
	 CMP     DX,3500
	 JNE     SEX
	 JE      TNT
 SEX:    NOP
	 JMP    VINN
FUT:     RET
TIMMER  ENDP


INI     PROC     FAR
	PUSH     DS
	SUB      AX,AX
	PUSH     AX
	MOV      AX,DATA
	MOV      DS,AX

	CLS
	gotoxys 8,10
	lea     dx,press
	mov     ah,09h
	int     21h


	MARCO
	MOV     AH,01h
	int     21h


AGAIN:  CALL     YADY
	GOTOXYS  22,0
	LEA      DX,KEEP
	MOV      AH,09H
	INT      21H
	MOV      AH,01H
	INT      21H
	MOV      CAD[SI],AL
	MOV      AL,CAD[SI]
	CMP      AL,0DH
	JE       FIN
	JMP     AGAIN
FIN:    CLS
	RET
INI     ENDP


YADY     PROC    NEAR
	 CLS
	 MOV REN,9
	 MOV COL,80        
R11:     CLS
	 CALL    CARTEL
	 CALL    TIMMER
	 SUB     COL,5
	 MOV     REN,9
	 CMP     COL,0
	 JNZ R11
	 RET
YADY     ENDP



CARTEL  PROC NEAR

	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITA
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITB
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITC
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITD
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITE
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITF
	 MOV AH,09H
	 INT 21H


	 INC REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITG
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITH
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITI
	 MOV AH,09H
	 INT 21H

	 INC     REN
	 GOTOXYS REN,COL
	 MOV DX,OFFSET BITJ
	 MOV AH,09H
	 INT 21H

	RET
CARTEL  ENDP
       ; ENDS
	END  INI

