INCLUDE PERSA.BIB
.MODEL MEDIUM
.STACK
.DATA
        PROMPT        DB  '¯ $'
        DIVIS         DB  '  $'
        NEXTL         DB  ' ',10,13,'$'
        FAILSEND      DB  'Instruccion invalida$'
        KEY           DB  80 DUP (' ')
        DIR           DW  0
        OP1           DW  0
        OP2           DW  0  
        ID            DB  'Persa.... $'
        MAX           DB  'AX=$'
        MBX           DB  'BX=$'
        MCX           DB  'CX=$'
        MDX           DB  'DX=$'
        MSP           DB  'SP=$'
        MBP           DB  'BP=$'
        MSI           DB  'SI=$'
        MDI           DB  'DI=$'
        MCS           DB  'CS=$'
        MDS           DB  'DS=$'
        MSS           DB  'SS=$'
        MES           DB  'ES=$'
        MIP           DB  'IP=$'
        A             DW  0            
        B             DW  0
        C             DW  0
        D             DW  0
        APILA         DW  6852         
        BASEP         DW  0
        SSI           DW  0            
        DDI           DW  0
        SDS           DW  7276         
        SES           DW  7276
        SSS           DW  7276
        SCS           DW  7276
        SIP           DW  0256         

.CODE
INI:    MOV     AX,@DATA
        MOV     DS,AX
        CLS
FETCH:  WRITE   NEXTL
        WRITE   PROMPT
        MOV     SI,OFFSET KEY
        MOV     AL,80
        MOV     [SI],AL
        MOV     AH,0Ah
        MOV     DX,SI
        INT     21h
        CALL    MAYMIN
        MOV     SI,OFFSET KEY
        ADD     SI,2
        MOV     AL,00     ;SIN CADENA
        CMP     [SI-1],AL
        JZ      FETCH
        MOV     AL,'R'    ;COMANDO R
        CMP     [SI],AL
        JZ      ITS_R
        MOV     AL,'D'    ;COMANDO D
        CMP     [SI],AL
        JZ      ITS_D
        MOV     AL,'E'    ;COMANDO E
        CMP     [SI],AL
        JZ      ITS_E
        MOV     AL,'H'    ;COMMANDO H
        CMP     [SI],AL
        JZ      ITS_H
        MOV     AL,'Q'    ;COMMANDO SALIR
        CMP     [SI],AL
        JZ      ITS_Q
        WRITE   FAILSEND  ;QUE RAYOS TECLEASTE
        JMP     FETCH       ;CICLO DE LECTURA
;------------------------------------------ ITS WHAT YOU CHOOSE ?
ITS_D:  JMP    IS_D
ITS_E:  JMP    IS_E
ITS_H:  JMP    IS_H

ITS_Q:  JMP PERSA
;---------------------------------------------
ITS_R:  MOV     SI,OFFSET KEY
        MOV     AL,1
        CMP     [SI+1],AL
        JZ      SINR
        JMP     RAND

SINR:   WRITE   NEXTL
        WRITE   MAX
        MOV     AX,A
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG AX

        WRITE   MBX
        MOV     AX,B
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG  BX

        WRITE   MCX
        MOV     AX,C
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG CX
        
        WRITE   MDX
        MOV     AX,D
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG DX

        WRITE   MSP
        MOV     AX,APILA
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG SP

        WRITE   MBP
        MOV     AX,BASEP
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG BP

        WRITE   MSI
        MOV     AX,SSI
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG SI

        WRITE   MDI
        MOV     AX,DDI
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG DI

        WRITE   NEXTL

        WRITE   MDS
        MOV     AX,SDS
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG DS

        WRITE   MES
        MOV     AX,SES
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG ES

        WRITE   MSS
        MOV     AX,SSS
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG SS

        WRITE   MCS
        MOV     AX,SCS
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG CS

        WRITE   MIP
        MOV     AX,SIP
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   DIVIS   ;REG IP
        WRITE   ID
        JMP     FETCH

RAND:   MOV     SI,OFFSET KEY
        MOV     AL,4
        CMP     [SI+1],AL
        JZ      OK01
        JMP     WRONG

OK01:   ADD     SI,4
        MOV     AL,'A'
        CMP     [SI],AL
        JNZ     OK02
        MOV     AL,'X'
        CMP     [SI+1],AL
        JZ      DO_01
        JMP     WRONG

DO_01:  WRITE   NEXTL
        WRITE   MAX
        MOV     AX,A
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     A,BX
        JMP     FIN_RP   ;FIN PARAMETRO AX

OK02:   MOV     AL,'B'
        CMP     [SI],AL
        JNZ     OK03
        MOV     AL,'X'
        CMP     [SI+1],AL
        JZ      DO_02
        JMP     OK06        ;PASO AL BP

DO_02:  WRITE   NEXTL
        WRITE   MBX
        MOV     AX,B
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     B,BX
        JMP     FIN_RP   ;FIN PARAMETRO BX
        
OK03:   MOV     AL,'C'
        CMP     [SI],AL
        JNZ     OK04
        MOV     AL,'X'
        CMP     [SI+1],AL
        JZ      DO_03
        JMP     OK12        ;PASO LA CS

DO_03:  WRITE   NEXTL
        WRITE   MCX
        MOV     AX,C
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     C,BX
        JMP     FIN_RP   ;FIN PARAMETRO CX

OK04:   MOV     AL,'D'
        CMP     [SI],AL
        JNZ     OK05
        MOV     AL,'X'
        CMP     [SI+1],AL
        JZ      DO_04
        JMP     OK08        ;PASA AL DI

DO_04:  WRITE   NEXTL
        WRITE   MDX
        MOV     AX,D
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     D,BX
        JMP     FIN_RP   ;FIN PARAMETRO DX

OK05:   MOV     AL,'S'
        CMP     [SI],AL
        JNZ     OK06
        MOV     AL,'P'
        CMP     [SI+1],AL
        JZ      DO_05
        JMP     OK07        ;PASA AL SI

DO_05:  WRITE   NEXTL
        WRITE   MSP
        MOV     AX,APILA
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     APILA,BX
        JMP     FIN_RP   ;FIN PARAMETRO SP

OK06:   MOV     AL,'B'
        CMP     [SI],AL
        JNZ     OK07
        MOV     AL,'P'
        CMP     [SI+1],AL
        JZ      DO_06
        JMP     OK07

DO_06:  WRITE   NEXTL
        WRITE   MBP
        MOV     AX,BASEP
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     BASEP,BX
        JMP     FIN_RP   ;FIN PARAMETRO BP

OK07:   MOV     AL,'S'
        CMP     [SI],AL
        JNZ     OK08
        MOV     AL,'I'
        CMP     [SI+1],AL
        JZ      DO_07
        JMP     OK11        ;PASA AL SS

DO_07:  WRITE   NEXTL
        WRITE   MSI
        MOV     AX,SSI
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     SSI,BX
        JMP     FIN_RP   ;FIN PARAMETRO SI

OK08:   MOV     AL,'D'
        CMP     [SI],AL
        JNZ     OK09
        MOV     AL,'I'
        CMP     [SI+1],AL
        JZ      DO_08
        JMP     OK09

DO_08:  WRITE   NEXTL
        WRITE   MDI
        MOV     AX,DDI
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     DDI,BX
        JMP     FIN_RP   ;FIN PARAMETRO DI

OK09:   MOV     AL,'D'
        CMP     [SI],AL
        JNZ     OK10
        MOV     AL,'S'
        CMP     [SI+1],AL
        JZ      DO_09
        JMP     WRONG

DO_09:  WRITE   NEXTL
        WRITE   MDS
        MOV     AX,SDS
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     SDS,BX
        JMP     FIN_RP   ;FIN PARAMETRO DS

OK10:   MOV     AL,'E'
        CMP     [SI],AL
        JNZ     OK11
        MOV     AL,'S'
        CMP     [SI+1],AL
        JZ      DO_10
        JMP     WRONG

DO_10:  WRITE   NEXTL
        WRITE   MES
        MOV     AX,SES
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        WRITE   NEXTL
        CALL    DAT
        MOV     SES,BX
        JMP     FIN_RP   ;FIN PARAMETRO ES

OK11:   MOV     AL,'S'
        CMP     [SI],AL
        JNZ     OK12
        MOV     AL,'S'
        CMP     [SI+1],AL
        JZ DO_11
        JMP WRONG

DO_11:  WRITE NEXTL
        WRITE MSS
        MOV AX,SSS
        PUSH AX
        MOV BL,AH
        CALL IMPRI
        POP AX
        MOV BL,AL
        CALL IMPRI
        WRITE NEXTL
        CALL DAT
        MOV SSS,BX
        JMP FIN_RP   ;FIN PARAMETRO SS

OK12:   MOV AL,'C'
        CMP [SI],AL
        JNZ OK13
        MOV AL,'S'
        CMP [SI+1],AL
        JZ DO_12
        JMP WRONG

DO_12:  WRITE NEXTL
        WRITE MCS
        MOV AX,SCS
        PUSH AX
        MOV BL,AH
        CALL IMPRI
        POP AX
        MOV BL,AL
        CALL IMPRI
        WRITE NEXTL
        CALL DAT
        MOV SCS,BX
        JMP FIN_RP   ;FIN PARAMETRO CS
        
OK13:   MOV AL,'I'
        CMP [SI],AL
        JNZ NO
        MOV AL,'P'
        CMP [SI+1],AL
        JZ DO_13
NO:     JMP WRONG

DO_13:  WRITE NEXTL
        WRITE MIP
        MOV AX,SIP
        PUSH AX
        MOV BL,AH
        CALL IMPRI
        POP AX
        MOV BL,AL
        CALL IMPRI
        WRITE NEXTL
        CALL DAT
        MOV SIP,BX
        JMP FIN_RP   ;FIN PARAMETRO IP

WRONG:  WRITE FAILSEND             
FIN_RP: JMP FETCH                 ;FIN COMMANDO R
;--------------------------------- INI  COMANDO D
IS_D:   MOV     DI,OFFSET KEY
        MOV     AL,1
        CMP     [DI+1],AL
        JZ      DSIN
        JMP     DAND

DSIN:   MOV     CX,8
        MOV     DI,SIP
ANY:    PUSH    CX
        MOV     SI,DI
        MOV     AX,SDS
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        MOV     AH,02
        MOV     DL,':'
        INT     21H     ;IMPRIME EL CS
        MOV     AX,DI
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI   ;IMPRIME LE IP
        MOV     DL,' '
        MOV     AH,02
        INT     21H
        PUSH    CX
        MOV     CX,1
        PUSH    BX
INCX:   MOV     BL,[SI]
        PUSH    CX
        MOV     DL,BL
        CALL    IMPRI
        MOV     AH,02
        MOV     DL,' '
        INT     21H
        POP     CX
        INC     CX
        INC     SI
        CMP     CX,17
        JNZ     INCX ;IMPRIME EN HEXA
        MOV     BX,0000
        MOV     SI,DI
        MOV     CX,1
ICX:    MOV     BL,[SI]
        PUSH    CX
        CMP     BL,1FH
        JLE     PUNTO
        MOV     DL,BL
        MOV     AH,02
        INT     21H
        
RT:     POP     CX
        INC     CX
        INC     SI
        CMP     CX,17
        JNZ     ICX ;IMPRIME EN ASCII
        JMP     EXT
PUNTO:  MOV     DL,'.'
        MOV     AH,02
        INT     21H
        JMP     RT
EXT:    POP     BX
        POP     CX  
        CALL    OTR_LIN
        ADD     DI,16
        POP     CX
        LOOP    ANY
        JMP FETCH
                  
DAND:   MOV AL,6
        CMP [DI+1],AL
        CLD
        JZ CHKDIR
        JMP NODIR

CHKDIR: ADD DI,4
        MOV CX,4

CHAN:   PUSH CX
        MOV AL,30H
        CMP [DI],AL
        JL NODR
KEEP1:  MOV AL,39H
        CMP [DI],AL
        JG LET
        JMP GOD

LET:    MOV AL,46H
        CMP [DI],AL
        JG NODR
        MOV AL,41H
        CMP [DI],AL
        JL NODR
        JMP GOD

NODR:   JMP NODIR

GOD:    POP CX
        INC DI
        LOOP CHAN

        MOV DI,OFFSET KEY
        ADD DI,4
        MOV AL,[DI]
        CALL ASCII_BIN
        MOV BH,AL
        MOV CL,4
        SHL BH,CL
        MOV AL,[DI+1]
        CALL ASCII_BIN
        ADD BH,AL
        MOV AL,[DI+2]
        CALL ASCII_BIN
        MOV BL,AL
        MOV CL,4
        SHL BL,CL
        MOV AL,[DI+3]
        CALL ASCII_BIN
        ADD BL,AL
        MOV DIR,BX

        CALL OTR_LIN
      
DSIN1:  MOV     CX,8
        MOV     DI,DIR
ANY1:   PUSH    CX
        MOV     SI,DI
        MOV     AX,SDS
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI
        MOV     AH,02
        MOV     DL,':'
        INT     21H     ;IMPRIME EL CS
        MOV     AX,DI
        PUSH    AX
        MOV     BL,AH
        CALL    IMPRI
        POP     AX
        MOV     BL,AL
        CALL    IMPRI   ;IMPRIME DIR
        MOV     DL,' '
        MOV     AH,02
        INT     21H
        PUSH    CX
        MOV     CX,1
        PUSH    BX
INCX1:  MOV     BL,[SI]
        PUSH    CX
        MOV     DL,BL
        CALL    IMPRI
        MOV     AH,02
        MOV     DL,' '
        INT     21H
        POP     CX
        INC     CX
        INC     SI
        CMP     CX,17
        JNZ     INCX1 ;IMPRIME EN HEXA
        MOV     BX,0000
        MOV     SI,DI
        MOV     CX,1
ICX1:   MOV     BL,[SI]
        PUSH    CX
        CMP     BL,1FH
        JLE     PUNTO1
        MOV     DL,BL
        MOV     AH,02
        INT     21H
        
RT1:    POP     CX
        INC     CX
        INC     SI
        CMP     CX,17
        JNZ     ICX1 ;IMPRIME EN ASCII
        JMP     EXT1
PUNTO1: MOV     DL,'.'
        MOV     AH,02
        INT     21H
        JMP     RT
EXT1:   POP     BX
        POP     CX  
        CALL    OTR_LIN
        ADD     DI,16
        POP     CX
        LOOP    ANY1
        JMP FETCH

NODIR:  WRITE FAILSEND
        JMP FETCH
                                  ;FIN COMANDO D
;--------------------------------- INI COMANDO E
IS_E:   MOV DI,OFFSET KEY
        
EAND:   MOV AL,9
        CMP [DI+1],AL
        CLD
        JGE CHKDRE
        JMP NODRE

CHKDRE: ADD DI,4
        MOV CX,4

CHANE:  PUSH CX
        MOV AL,30H
        CMP [DI],AL
        JL NODRE
KEEPE:  MOV AL,39H
        CMP [DI],AL
        JG LET_E
        JMP GOD_E
                 
LET_E:  MOV AL,46H
        CMP [DI],AL
        JG NODRE
        MOV AL,41H
        CMP [DI],AL
        JL NODRE

GOD_E:  POP CX
        INC DI
        LOOP CHANE
        
        MOV DI,OFFSET KEY
        ADD DI,4
        MOV AL,[DI]
        CALL ASCII_BIN
        MOV BH,AL
        MOV CL,4
        SHL BH,CL
        MOV AL,[DI+1]
        CALL ASCII_BIN
        ADD BH,AL
        MOV AL,[DI+2]
        CALL ASCII_BIN
        MOV BL,AL
        MOV CL,4
        SHL BL,CL
        MOV AL,[DI+3]
        CALL ASCII_BIN
        ADD BL,AL
        MOV DIR,BX    ;IDENTIFICA LA DIRECCION DE ESCRITURA

        MOV SI,DIR
        MOV DI,OFFSET KEY
        MOV AL,[DI+1]
        MOV BL,07
        SUB AL,BL
        MOV CX,0
        MOV CL,AL
        ADD DI,9
ESMEM:  PUSH CX
        MOV AL,[DI]
        MOV [SI],AL
        INC DI
        INC SI
        POP CX
        LOOP ESMEM      
        CALL OTR_LIN
        JMP FETCH
NODRE:  WRITE FAILSEND
        JMP FETCH
                                  ;FIN COMANDO E
;--------------------------------- INI COMANDO H
IS_H:   MOV DI,OFFSET KEY
        MOV AL,11
        CMP [DI+1],AL
        JZ CHK_OP
        JMP BAD_OP

CHK_OP: ADD DI,4
        MOV CX,9

CH_H:   PUSH CX
        MOV AL,20H
        CMP [DI],AL
        JZ GOD_H
        MOV AL,30H
        CMP [DI],AL
        JL BAD_P
KEEPH:  MOV AL,39H
        CMP [DI],AL
        JG LET_H
        JMP GOD_H
                 
LET_H:  MOV AL,46H
        CMP [DI],AL
        JG BAD_P
        MOV AL,41H
        CMP [DI],AL
        JL BAD_P
        JMP GOD_H

BAD_P:  JMP BAD_OP


GOD_H:  POP CX
        INC DI
        CMP CX,6
VE:     LOOP CH_H

        MOV DI,OFFSET KEY
        ADD DI,4
        MOV AL,[DI]
        CALL ASCII_BIN
        MOV BH,AL
        MOV CL,4
        SHL BH,CL
        MOV AL,[DI+1]
        CALL ASCII_BIN
        ADD BH,AL
        MOV AL,[DI+2]
        CALL ASCII_BIN
        MOV BL,AL
        MOV CL,4
        SHL BL,CL
        MOV AL,[DI+3]
        CALL ASCII_BIN
        ADD BL,AL
        MOV OP1,BX            

        MOV DI,OFFSET KEY
        ADD DI,9
        MOV AL,[DI]
        CALL ASCII_BIN
        MOV BH,AL
        MOV CL,4
        SHL BH,CL
        MOV AL,[DI+1]
        CALL ASCII_BIN
        ADD BH,AL
        MOV AL,[DI+2]
        CALL ASCII_BIN
        MOV BL,AL
        MOV CL,4
        SHL BL,CL
        MOV AL,[DI+3]
        CALL ASCII_BIN
        ADD BL,AL
        MOV OP2,BX

        CALL OTR_LIN
        CALL OTR_LIN
        WRITE DIVIS
        WRITE DIVIS
        
        MOV AX,OP1
        MOV BX,OP2
        ADD AX,BX
        PUSH AX
        MOV BL,AH
        CALL IMPRI
        POP AX
        MOV BL,AL
        CALL IMPRI
        WRITE DIVIS

        MOV AX,OP1
        MOV BX,OP2
        SUB AX,BX
        PUSH AX
        MOV BL,AH
        CALL IMPRI
        POP AX
        MOV BL,AL
        CALL IMPRI

        JMP FETCH
BAD_OP: WRITE FAILSEND
        JMP FETCH

;--------------------------------- THE END OF PROG
PERSA:  WRITE ID
        MOV AH,4CH
        INT 21H


;INICIO DE PROCEDURES
;ALL THE INSTRUCTIONS WERE IDEAS OF PERSA....

MAYMIN PROC NEAR
        MOV DI,OFFSET KEY
        ADD DI,2
        MOV CH,00
        MOV CL,[DI-1]
        CMP CX,0
        JZ FN1
CAM:    MOV AH,[DI]
        CMP AH,'a'
        JL OTRO
        CMP AH,'z'
        JLE UPCASE
UPCASE: SUB AH,20H
        MOV [DI],AH
OTRO:   INC DI
        LOOP CAM
FN1:    RET
MAYMIN ENDP

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

DAT PROC NEAR
        PUSH CX
        MOV AH,01
        INT 21H
        CALL ASCII_BIN
        MOV CL,04
        SHL AL,CL
        MOV CH,AL
        MOV AH,01
        INT 21H
        CALL ASCII_BIN
        ADD AL,CH
        POP CX
        MOV BH,AL
        PUSH CX
        MOV AH,01
        INT 21H
        CALL ASCII_BIN
        MOV CL,04
        SHL AL,CL
        MOV CH,AL
        MOV AH,01
        INT 21H
        CALL ASCII_BIN
        ADD AL,CH
        POP CX
        MOV BL,AL
        RET
DAT ENDP

ASCII_BIN PROC NEAR
        CMP AL,30H
        JL ERR
        CMP AL,39H
        JLE RES_30
        CMP AL,41H
        JL ERR
        CMP AL,46H
        JG ERR
        SUB AL,37H
        JMP FD
ERR:    MOV AL,0
        JMP FD
RES_30: SUB AL,30H
FD:     RET
ASCII_BIN ENDP

OTR_LIN PROC NEAR
        MOV     AH,02
        MOV     DL,0AH
        INT     21H
        MOV     AH,02
        MOV     DL,0DH
        INT     21H     ;CAMBIO DE LINEA
        RET
OTR_LIN ENDP

END INI

; Program By Persa.....
; SOME EXAMPLES
; COMANDOS
; R ............. MUESTRA LOS REGISTROS
; R AX .......... REGISTRO AX (PUEDE PONER CUALQUIER REGISTRO)
; D ............. MUESTRA MEMORIA DESDE EL VALOR DEL IP
; D 0100 ........ MUESTRA MEMORIA DESDE 0200 (DE 0000 HASTA F000)
; E CADENA....... INSERTA EN LA MEMORIA DESDE EL IP LA CADENA
; H 0200 0020.... SUMA Y RESTA HEXADECIMAL
