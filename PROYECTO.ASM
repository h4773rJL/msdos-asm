TITLE PROYECTO QUE GRAFICA EN BARRAS O HISTOGRAMA.
DATSEG    SEGMENT                             ;DECLARAR VARIABLES
LISTPARM  LABEL     BYTE
ARREGLO DB 20 DUP ('0'),'$'
BAN     DB '0' ;BAN INDICA LA ESCALA
BAND    DB '0' ;SE OCUPA PARA VER.SI PASO POR DATOS 
TEMP    DB ' '
TITGRAF DB ' '
NOVAL   DB 'NO EXISTEN DATOS $'
NOM     DB 'TITULO DE LA GRAFICA? $'
GUIA1   DB 'PRESS ALT PARA ACTIVAR LAS OPCIONES $'
MENU    DB '1.- 0 a 100     2.-0 A 10$'
MENU3   DB 'SELECCIONE','->','$'
DAT1    DB 'DAR DATO /.- ','$'
GUIA3   DB 'ALT-S  SALIR $'
LETRER  DB 'TIPO DE GRAFICA $'
GRAF1L  DB '[H] HISTOGRAMA $'
GRAF2   DB '[B] BARRAS $'
OP1     DB        'DATOS $'
OP2     DB        'GRAFICAR $'
OP3     DB        'SALIR $'
EJEX    DB '#0   #1  #2   #3  #4   #5  #6   #7  #8   #9$'
DATSEG    ENDS

STASEG    SEGMENT   STACK PARA 'STACK'                      ;RESERVAR 160 BYTES
	  DW        80 DUP(?)                   ;PARA EL 'STACK'
STASEG    ENDS

CODSEG    SEGMENT
	  ASSUME    CS:CODSEG,DS:DATSEG,SS:STASEG
CODIGO    PROC      FAR                         ;PROCEDIMIENTO LEJANO
	  PUSH      DS                          ;DS ANTERIOR
	  SUB       AX, AX                      ;0000H EN AX
	  PUSH      AX                          ;0000H EN EL 'STACK'
	  MOV       AX, DATSEG                  ;ACTUALIZAR EL SEGMENTO
	  MOV       DS, AX                      ;DE DATOS.

          MOV       AX, 0006H                  ;FIJA MODO DE
	  INT       10H                        ;VIDEO

	  MOV       AH, 12                   ;fija paleta DE
	  MOV       BL, 91H                    ;FONDO Y BORDES
	  INT       10H

INICIO:  CALL      CLRSCR 
	 CALL      MARCO
	  MOV       DH, 2       ;DH PARA Y, DL PARA X
	  MOV       DL, 3
	  CALL      CURSOR3
	  LEA       DX,OP1
	  MOV       AH, 9
	  INT       21H

	  MOV       DX,25          ;COORDENADA Y
	  MOV       CX,23           ;COORDENADA X
MAS:      CALL      CURSOR          ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX,30         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       MAS
	  
	  MOV       DH, 2
	  MOV       DL, 13
	  CALL      CURSOR3
	  LEA       DX,OP2
	  MOV       AH, 9
	  INT       21H

	  MOV       DX,25          ;COORDENADA Y
	  MOV       CX,104           ;COORDENADA X
MAS1:     CALL      CURSOR          ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX,111         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       MAS1
	  
	  MOV       DH,2 
	  MOV       DL, 23
	  CALL      CURSOR3
	  LEA       DX,OP3
	  MOV       AH, 9
	  INT       21H
	  
	  MOV       DX,25          ;COORDENADA Y
	  MOV       CX,184         ;COORDENADA X
MAS2:     CALL      CURSOR         ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX,191         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       MAS2
	  
	  MOV       DH,23 
	  MOV       DL,2
	  CALL      CURSOR3
	  LEA       DX,GUIA1
	  MOV       AH, 9
	  INT       21H
	  
LEE:    MOV         AH,08H
	INT         21H
	CMP         AL,00H
	JE          SIGUE
	JMP         LEE
SIGUE:  MOV         AH,08H
	INT         21H
	CMP         AL,20H
	JE          YES
	CMP         AL,22H
	JE          GRAFI1
	CMP         AL,1FH
	JE          FIN11
	JMP         LEE

YES:    MOV        DH,2  ;y
	MOV        DL,50  ;x
	CALL       CURSOR3
	LEA        DX,MENU
	MOV        AH,09H
	INT        21H
	JMP       OPC
INICIO1:MOV     AH,08H
	INT     21H
	JMP INICIO
OPC:    MOV       AH,08H  ;CAPTURA LA OPCION
	INT       21H
	CMP       AL,'1'
	JE        ESC100
	CMP       AL,'2'
	JE        ESC10
	JMP       OPC
	;JMP     FIN
FIN11:JMP FIN1
GRAFI1:JMP GRAFI
INICIO2:JMP INICIO
ESC100: MOV       SI,0
	MOV     BAN,0
	MOV       BAND,1
CEROS:  MOV       ARREGLO[SI],0
	INC       SI
	CMP       SI,19
	JNE       CEROS
	MOV       SI,0
	MOV     DAT1[9],'/'
	MOV     BL,5
	JMP     SIG100
INICIO3:JMP     INICIO1
SIG100: MOV     BH,0
	CMP     SI,19
	JGE     INICIO1
	ADD     DAT1[9],1
	MOV     DH,BL  ;Y
	MOV     DL,2  ;X
	PUSH    DX
	CALL      CURSOR3
	LEA       DX,DAT1
	MOV       AH,09H
	INT     21H
	POP       DX
SIG:    CALL LEDAT
	MOV  AL,TEMP
	MOV  ARREGLO[SI-1],AL
	CMP  BH,2
	JNE  SIG
	MOV  AL,TEMP
	MOV  ARREGLO[SI-1],AL
	INC  BL
	JMP SIG100
ESC10:  MOV SI,0
	MOV       BAN,1
	MOV       BAND,1
CEROS10:MOV       ARREGLO[SI],0
	INC       SI
	CMP       SI,19
	JNE       CEROS10
	MOV       SI,0

	MOV     DAT1[9],'/'
	MOV     BL,5

SIG10:  CMP     SI,10
	JGE     INICIO3
	ADD     DAT1[9],1
	MOV       DH,BL  ;Y
	MOV       DL,2  ;X
	PUSH      DX
	CALL      CURSOR3
	LEA       DX,DAT1
	MOV       AH,09H
	INT     21H
	POP       DX
	CALL LEDAT10 ;AQUI
	MOV  AL,TEMP
	MOV  ARREGLO[SI-1],AL;
	INC  BL
	JMP SIG10
	
GRAFI:  CMP  BAND,1
	JE     OPCGR
	MOV        DH,2  ;y
	MOV        DL,50  ;x
	CALL       CURSOR3
	MOV        DX,OFFSET NOVAL
	MOV        AH,09H
	INT        21H
	MOV     AH,08H
	INT     21H
	JMP        INICIO2
OPCGR:  MOV        DH,4  ;y
	MOV        DL,2  ;x
	CALL       CURSOR3
	MOV     DX,OFFSET LETRER
	MOV     AH,09H  
	INT     21H
	
	MOV       DH,5
	MOV       DL,3
	CALL      CURSOR3
	LEA       DX,GRAF1L 
	MOV       AH, 9
	INT       21H

	MOV       DH,6  ;Y
	MOV       DL,3  ;X
	CALL      CURSOR3
	LEA       DX,GRAF2
	MOV       AH, 9
	INT       21H

	MOV       DH,7  ;Y
	MOV       DL,2  ;X
	CALL      CURSOR3
	LEA       DX,MENU3
	MOV       AH, 9
	INT       21H
OGRAFI: MOV       AH,08H  
	INT       21H
	CMP       AL,'H'
	JE        HIS
	CMP       AL,'B'
	JE        BAR
	JMP       OGRAFI
HIS:   MOV      AH,02H
	MOV     DL,'H'
	INT     21H
	CALL HISTO
	JMP  INICIO
BAR:   MOV      AH,02H
	MOV     DL,'B'
	INT     21H
	CALL BARRAS
       JMP INICIO
FIN:      MOV       AH, 10
	  LEA       DX, LISTPARM
	  INT       21H

FIN1:     MOV       AX, 0003H   ;REGRESA
	  INT       10H         ;AL MODO DE VIDEO QUE TENIA
	  RET
CODIGO    ENDP

LEDAT     PROC   NEAR
	  PUSH  DX
LEENUM:   MOV    AH,08H 
	  INT    21H
	  CMP   AL,'0'
	  JL    LEENUM
	  CMP   AL,'9'
	  JG    LEENUM
	  MOV   AH,02H
	  MOV   DL,AL
	  INT   21H
	  MOV   TEMP,DL
	  INC   BH
	  INC   SI
	  POP   DX
	  RET 
LEDAT ENDP   

LEDAT10   PROC   NEAR
	  PUSH  DX
LEENUM10: MOV    AH,08H 
	  INT    21H
	  CMP   AL,'0'
	  JL    LEENUM10
	  CMP   AL,'9'
	  JG    LEENUM10
	  MOV   DL,AL
	  MOV   AH,02H
	  INT   21H
	  MOV   TEMP,DL
	  INC   SI
	  POP   DX
	  RET 
LEDAT10 ENDP   

MARCO     PROC   NEAR
	  MOV       DX,5           ;COORDENADA Y
	  MOV       CX, 5           ;COORDENADA X
MA1:      CALL      CURSOR          ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX, 615         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       MA1

	  MOV       DX, 5          
	  MOV       CX, 5
MA2:      CALL      CURSOR2        ;CURSOR2 ESCRIBE EL PIXEL E INCREMENTA Y
	  CMP       DX, 195        ;DE 5 A 195 EN Y
	  JNE       MA2

	  MOV       DX, 195          ;EN Y 195
	  MOV       CX, 5            ;EN X 5
MA3:      CALL      CURSOR           ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X   
	  CMP       CX, 615
	  JNE       MA3

	  MOV       DX, 5
	  MOV       CX, 615
MA4:      CALL      CURSOR2         ;CURSOR2 ESCRIBE EL PIXEL E INCREMENTA 
	  CMP       DX, 195         ;DE 5 A 195 EN Y
	  JNE       MA4

	  MOV       DX,175           ;COORDENADA Y
	  MOV       CX, 5           ;COORDENADA X
MA5:      CALL      CURSOR          ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX, 615         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       MA5
	  
	MOV     DX,27
	MOV     CX,240
MA6:    CALL    CURSOR2
	CMP     DX,175
	JNE     MA6
	

	  MOV       DX,27           ;COORDENADA Y
	  MOV       CX, 5           ;COORDENADA X
MA7:      CALL      CURSOR          ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX, 615         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       MA7
	  RET
MARCO     ENDP


CURSOR    PROC    NEAR
	  MOV     AH, 0CH       ;ESCRIBE UN PIXEL
	  MOV     AL, 15        ;COLOR DE PIXEL
	  INT     10H            ;INTERRUPCION
	  INC     CX            ;AUMENTA Y
	  RET
CURSOR    ENDP

CURSOR2   PROC    NEAR
	  MOV     AH, 0CH
	  MOV     AL, 15
	  INT     10H
	  INC     DX
	  RET
CURSOR2   ENDP

CURSOR3   PROC    NEAR          
	  PUSH    AX            
	  PUSH    BX            ;ESTA FUNCION FIJA LA
	  MOV     AH, 2         ;POSICI‡N DEL CURSOR
	  MOV     BH, 0         ;EN LA COL,RENG ESPECIFICADA
	  INT     10H           ;CUANDO SE LLAMO A LA FUNCI‡N
	  POP     BX
	  POP     AX
	  RET
CURSOR3   ENDP



CLRSCR    PROC     NEAR
	  MOV AX,0691H
	  MOV BH,00
	  MOV CH,00
	  MOV CL,00
	  MOV DH,99
	  MOV DL,99
	  INT 10H
	  RET
CLRSCR ENDP

HISTO PROC NEAR
      MOV       DH,9  ;Y
      MOV       DL,2  ;X
      CALL      CURSOR3
      MOV       DX,OFFSET NOM
      MOV       AH,09H
      INT       21H
      MOV       AH,0AH
	INT     21H
	MOV     TITGRAF,AL
	CMP     BAN,1
	JE      GR10
	CALL    COORDENADAS
	MOV     SI,0
	MOV     DI,260
SIGHISTO:MOV    BH,0
	CMP     SI,19
	JGE     FING
	MOV     AL,ARREGLO[SI]
	SUB     AL,30H
	MOV     BL,10
	MUL     BL
	MOV     CL,150
	SUB     CL,AL
	INC     SI
	MOV     AL,ARREGLO[SI]
	INC     SI
	SUB     AL,30H
	SUB     CL,AL
	MOV     DH,0
	MOV     DL,CL
	MOV     CX,DI
	ADD     DI,36 
	CALL    SIMBOLO
	JMP     SIGHISTO

GR10:  CALL    COORDENADAS
	MOV     SI,0
	MOV     DI,260
SIGHISTO1:MOV    BH,0
	CMP     SI,9
	JG     FING
	MOV     AL,ARREGLO[SI]
	SUB     AL,30H
	MOV     BL,10
	MUL     BL
	MOV     CL,150
	SUB     CL,AL
	INC     SI
	MOV     DH,0
	MOV     DL,CL
	MOV     CX,DI
	ADD     DI,36 
	CALL   SIMBOLO
	JMP     SIGHISTO1

FING:MOV AH,08H 
     INT 21H
     RET
HISTO ENDP

BARRAS PROC NEAR
      MOV       DH,9  ;Y
      MOV       DL,2  ;X
      CALL      CURSOR3
      MOV       DX,OFFSET NOM
      MOV       AH,09H
      INT       21H
      MOV       AH,0AH
	INT     21H
	MOV     TITGRAF,AL
	CMP     BAN,1
	JE      BARRA10
	CALL    COORDENADAS
	MOV     SI,0
	MOV     DI,260
SIGBARRA:MOV    BH,0
	CMP     SI,19
	JGE     FINBARR1
	MOV     AL,ARREGLO[SI]
	SUB     AL,30H
	MOV     BL,10
	MUL     BL
	MOV     CL,150
	SUB     CL,AL
	INC     SI
	MOV     AL,ARREGLO[SI]
	INC     SI
	SUB     AL,30H
	SUB     CL,AL
	MOV     DH,0
	MOV     DL,CL
	MOV     CX,DI
	ADD     DI,36 
BORDESUP:
	CALL   CURSOR
	INC     BH
	CMP    BH,15
	JNE     BORDESUP
	JMP     LADOS
LADOS:
	MOV   CX,DI
	SUB     CX,36
       CALL   CURSOR2
	ADD     CX,15
	CALL    CURSOR2
	DEC     DL
       CMP    DX,150
       JNE   LADOS
	JMP     SIGBARRA
FINBARR1:JMP    FINBARR
BARRA10:
	CALL    COORDENADAS
	MOV     SI,0
	MOV     DI,260
SIGBARRA1:MOV    BH,0
	CMP     SI,9
	JG     FINBARR
	MOV     AL,ARREGLO[SI]
	SUB     AL,30H
	MOV     BL,10
	MUL     BL
	MOV     CL,150
	SUB     CL,AL
	INC     SI
	MOV     DH,0
	MOV     DL,CL
	MOV     CX,DI
	ADD     DI,36 
BORDESUP1:
	CALL   CURSOR
	INC     BH
	CMP    BH,15
	JNE     BORDESUP1
	JMP     LADOS1
LADOS1:
	MOV   CX,DI
	SUB     CX,36
       CALL   CURSOR2
	ADD     CX,15
	CALL    CURSOR2
	DEC     DL
       CMP    DX,150
       JNE   LADOS1
	JMP     SIGBARRA1

FINBARR:MOV     AH,08H
	INT     21H
	RET     
BARRAS ENDP

SIMBOLO PROC NEAR
	 PUSH CX
	 PUSH DX
	ADD     CX,5
	SUB     DX,2
	CALL    CURSOR
	INC     DX
	CALL    CURSOR
	INC     DX
	CALL    CURSOR
	INC     DX
	CALL    CURSOR
	INC     DX
	CALL    CURSOR
	SUB     DX,4
	DEC     CX
	CALL    CURSOR2
	DEC     CX
	CALL    CURSOR2
	DEC     CX
	INC     DX
	DEC     CX
	CALL    CURSOR2
	DEC     CX
	CALL    CURSOR2
	POP     DX
	POP     CX
	RET
SIMBOLO ENDP

COORDENADAS  PROC  NEAR
	MOV     DH,19
	MOV     DL,33
	CALL    CURSOR3
	MOV     AH,09H
	MOV     DX,OFFSET EJEX
	INT 21H
	  MOV       DX, 40
	  MOV       CX, 260
COORY:    CALL      CURSOR2        ;CURSOR2 ESCRIBE EL PIXEL E INCREMENTA Y
	  CMP       DX, 150        ;DE 5 A 195 EN Y
	  JNE       COORY
	  
	  MOV       DX,150           ;COORDENADA Y
	  MOV       CX,250           ;COORDENADA X
COORX:    CALL      CURSOR          ;CURSOR ESCRIBE EL PIXEL E INCREMENTA X
	  CMP       CX,610         ;PROCEDIMIENTO QUE HACE LA LINEA _ DEL MARGEN
	  JNE       COORX
      RET
COORDENADAS ENDP
CODSEG    ENDS

	  END       CODIGO
