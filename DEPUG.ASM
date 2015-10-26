;Mini Ensamblador
;P‚rez Rend¢n Jos‚ Luis 980018841
;Hacer los Siguientes comandos  (sin espacios)
;   -d  dir1,dir2
;   -r  bx -rdx etc.    4 regirtros de proposito general
;       SI   DI   -signo -cero -overflow -carry
;   -e  dir
;   -q

;     ===========================================================


STACKSG SEGMENT PARA STACK 'STACK'
        DW 32 DUP(0)
STACKSG ENDS


DATASG SEGMENT PARA 'DATA'
        PROMPT          DB  '¯ $'
        MENSAJE_ERROR   DB  'INSTRUCCION INVALIDA$'
        INST            DB  40 DUP (' ')
        CAMBIA_BAND     DB  22 DUP (' ')
        BANDERAS        DB   8 DUP (0)
        MAX             DB  'AX = $'
        MBX             DB  'BX = $'
        MCX             DB  'CX = $'
        MDX             DB  'DX = $'
        MSP             DB  'SP = $'
        MBP             DB  'BP = $'
        MSI             DB  'SI = $'
        MDI             DB  'DI = $'
        MCS             DB  'CS = $'
        MDS             DB  'DS = $'
        MSS             DB  'SS = $'
        MES             DB  'ES = $'
        MIP             DB  'IP = $'
        OV              DB  'OV   $'
        NV              DB  'NV   $'
        DN              DB  'DN   $'
        UP              DB  'UP   $'
        EI              DB  'EI   $'
        CI              DB  'DI   $'
        NG              DB  'NG   $'
        PL              DB  'PL   $'
        ZR              DB  'ZR   $'
        NZ              DB  'NZ   $'
        AC              DB  'AC   $'
        NA              DB  'NA   $'
        PE              DB  'PE   $'
        PO              DB  'PO   $'
        CY              DB  'CY   $'
        NC              DB  'NC   $'
        SEPARADOR       DB  '        $'
        MENS1           DB  'REGISTROS DE PROPOSITO GENERAL: $'
        MENS2           DB  'REGISTROS DEL STACK: $'
        MENS3           DB  'REGISTROS INDICE: $'
        MENS4           DB  'REGISTROS DE SEGMENTO: $'
        MENS5           DB  'REGISTRO APUNTADOR DE INSTRUCCIONES: $'
        MENS6           DB  'REGISTRO DE BANDERAS: $'
        DIREC           DW  0
        A               DW  0            ; VALORES SIMULADOS DE LOS REGISTROS
        B               DW  0
        C               DW  0
        D               DW  0
        AP_PILA         DW  0            ; VALORES DE REGISTROS STACK
        BASEP           DW  0
        SSI             DW  0            ; APUNTADORES DI Y SI
        DDI             DW  0
        SDS             DW  0            ; VALORES DE LOS SEGMENTOS
        SES             DW  0
        SSS             DW  0
        SCS             DW  0
        SIP             DW  0            ; VALOR DEL IP
DATASG ENDS


CODESG SEGMENT PARA 'CODE'
    PP PROC FAR
                ASSUME CS:CODESG,DS:DATASG,SS:STACKSG,ES:DATASG
        START:  PUSH DS
                XOR AX,AX
                PUSH AX
                MOV AX,DATASG
                MOV DS,AX

        CICLO:  CALL ALI_LINEA
                LEA DX,PROMPT
                CALL ESC_CAD                    ; IMPRIME EL PROMPT

                LEA SI,INST
                ADD SI,2
                LEA DX,INST
                CALL LEE_CAD

                LEA DI,INST                     ; CAMBIA A MAYUSCULAS LA CADENA
                CALL MAYUSCULAS

                MOV AL,0                        ; SI NO SE DIO NINGUNA INST.
                CMP [SI-1],AL
                JZ CICLO

                MOV AL,'R'                      ; SI LA INSTRUCCION ES 'R'
                CMP AL,[SI]
                JZ FUE_R

                MOV AL,'E'                      ; SI LA INSTRUCCION ES 'E'
                CMP AL,[SI]
                JZ FUE_E

                MOV AL,'D'                      ; SI LA INSTRUCCION ES 'D'
                CMP AL,[SI]
                JZ FUE_D

                MOV AL,'Q'                      ; SI LA INSTRUCCION ES 'Q'
                CMP AL,[SI]
                JZ FUE_Q

                LEA DX,MENSAJE_ERROR            ; SI NO FUE NINGUNA INST. VALIDA

                CALL ALI_LINEA
                CALL ESC_CAD
                CALL ALI_LINEA
                CALL LIMPIA
                JMP CICLO

        FUE_R:  CALL INST_R
                CALL LIMPIA
                JMP CICLO

        FUE_E:  CALL INST_E
                CALL LIMPIA
                JMP CICLO

        FUE_D:  CALL INST_D
                CALL LIMPIA
                JMP CICLO

        FUE_Q:  CALL ALI_LINEA
                RET

    PP ENDP

;*****************************************************************************

    INST_R PROC
                LEA SI,INST
                MOV AL,1
                CMP [SI+1],AL           ; VERIFICA SI SE DIO ALGUN PARAMETRO
                JZ SIN_PARAMETRO
                CALL R_PARAMETRO
                JMP FINR

         SIN_PARAMETRO:
                CALL ALI_LINEA
                CALL ALI_LINEA
                LEA DX,MENS1
                CALL ESC_CAD
                CALL ALI_LINEA
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MAX              ; IMPRIME EL VALOR DE AX
                CALL ESC_CAD
                MOV DX,A
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MBX              ; IMPRIME EL VALOR DE BX
                CALL ESC_CAD
                MOV DX,B

                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MCX              ; IMPRIME EL VALOR DE CX
                CALL ESC_CAD
                MOV DX,C
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MDX              ; IMPRIME EL VALOR DE DX
                CALL ESC_CAD
                MOV DX,D
                CALL DESEMPAQUETA2

                CALL ALI_LINEA
                CALL ALI_LINEA
                LEA DX,MENS2
                CALL ESC_CAD
                CALL ALI_LINEA
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MSP              ; IMPRIME EL VALOR DE SP
                CALL ESC_CAD
                MOV DX,AP_PILA
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MBP              ; IMPRIME EL VALOR DE BP
                CALL ESC_CAD
                MOV DX,BASEP
                CALL DESEMPAQUETA2

                CALL ALI_LINEA
                CALL ALI_LINEA
                LEA DX,MENS3
                CALL ESC_CAD
                CALL ALI_LINEA
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MSI              ; IMPRIME EL VALOR DE SI
                CALL ESC_CAD
                MOV DX,SSI
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MDI              ; IMPRIME EL VALOR DE DI
                CALL ESC_CAD
                MOV DX,DDI
                CALL DESEMPAQUETA2

                CALL ALI_LINEA
                CALL ALI_LINEA
                LEA DX,MENS4
                CALL ESC_CAD
                CALL ALI_LINEA
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MDS              ; IMPRIME EL VALOR DE DS
                CALL ESC_CAD
                MOV DX,SDS
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MES              ; IMPRIME EL VALOR DE ES
                CALL ESC_CAD
                MOV DX,SES
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MSS              ; IMPRIME EL VALOR DE SS
                CALL ESC_CAD
                MOV DX,SSS
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MCS              ; IMPRIME EL VALOR DE CS
                CALL ESC_CAD
                MOV DX,SCS
                CALL DESEMPAQUETA2

                CALL ALI_LINEA
                CALL ALI_LINEA
                LEA DX,MENS5
                CALL ESC_CAD
                CALL ALI_LINEA
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA DX,MIP              ; IMPRIME EL VALOR DEL IP
                CALL ESC_CAD
                MOV DX,SIP
                CALL DESEMPAQUETA2
                LEA DX,SEPARADOR
                CALL ESC_CAD

                CALL ALI_LINEA          ; IMPRIME EL REGISTRO DE BANDERAS
                CALL ALI_LINEA
                LEA DX,MENS6
                CALL ESC_CAD

                CALL ALI_LINEA
                LEA DX,SEPARADOR
                CALL ESC_CAD
                CALL ESC_CAD

                CALL IMPRIME_BANDERAS
                CALL ALI_LINEA
         FINR:  RET
    INST_R ENDP

;*****************************************************************************

    R_PARAMETRO PROC
                LEA SI,INST
                MOV AL,3
                CMP [SI+1],AL
                JLE SIG1
                JMP ERRONEO
                
         SIG1:  ADD SI,3                ; ADELANTA EL PUNTERO DESPUES DE LA 'R'

                MOV AL,'A'              ; AVERIGUA SI FUE 'RAX'
                CMP [SI],AL
                JNZ R1
                MOV AL,'X'
                CMP [SI+1],AL
                JZ SIG2
                JMP ERRONEO
         SIG2:  CALL ALI_LINEA
                LEA DX,MAX
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV A,BX
                JMP FIN_R_PAR

           R1:  MOV AL,'B'              ; AVERIGUA SI FUE 'RBP'
                CMP [SI],AL
                JNZ R2
                MOV AL,'P'
                CMP [SI+1],AL
                JNZ R12                 ; TAL VEZ FUE 'RBX'
                CALL ALI_LINEA
                LEA DX,MBP
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV BASEP,BX
                JMP FIN_R_PAR

          R12:  MOV AL,'X'              ; AVERIGUA SI FUE 'RBX'
                CMP [SI+1],AL
                JZ SIG3
                JMP ERRONEO
         SIG3:  CALL ALI_LINEA
                LEA DX,MBX
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV B,BX
                JMP FIN_R_PAR

           R2:  MOV AL,'C'              ; AVERIGUA SI FUE 'RCX'
                CMP [SI],AL
                JNZ R3
                MOV AL,'X'
                CMP [SI+1],AL
                JNZ R22                 ; TAL VEZ FUE 'RCS'
                CALL ALI_LINEA
                LEA DX,MCX
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV C,BX
                JMP FIN_R_PAR

          R22:  MOV AL,'S'              ; AVERIGUA SI FUE 'RCS'
                CMP [SI+1],AL
                JZ SIG4
                JMP ERRONEO
         SIG4:  CALL ALI_LINEA
                LEA DX,MCS
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV SCS,BX
                JMP FIN_R_PAR

           R3:  MOV AL,'D'              ; AVERIGUA SI FUE 'RDX'
                CMP [SI],AL
                JNZ R4
                MOV AL,'X'
                CMP [SI+1],AL
                JNZ R32                 ; TAL VEZ FUE 'RDI'
                CALL ALI_LINEA
                LEA DX,MDX
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV D,BX
                JMP FIN_R_PAR

          R32:  MOV AL,'I'              ; AVERIGUA SI FUE 'RDI'
                CMP [SI+1],AL
                JNZ R33                 ; TAL VEZ FUE 'RDS'
                CALL ALI_LINEA
                LEA DX,MDI
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV DDI,BX
                JMP FIN_R_PAR

          R33:  MOV AL,'S'              ; AVERIGUA SI FUE 'RDS'
                CMP [SI+1],AL
                JZ SIG5
                JMP ERRONEO
         SIG5:  CALL ALI_LINEA
                LEA DX,MDS
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV SDS,BX
                JMP FIN_R_PAR

           R4:  MOV AL,'S'              ; AVERIGUA SI FUE 'RSP'
                CMP [SI],AL
                JNZ R5
                MOV AL,'P'
                CMP [SI+1],AL
                JNZ R42                 ; TAL VEZ FUE 'RSS'
                CALL ALI_LINEA
                LEA DX,MSP
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV AP_PILA,BX
                JMP FIN_R_PAR

          R42:  MOV AL,'S'              ; AVERIGUA SI FUE 'RSS'
                CMP [SI+1],AL
                JNZ R43                 ; TAL VEZ FUE 'RSI'
                CALL ALI_LINEA
                LEA DX,MSS
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV SSS,BX
                JMP FIN_R_PAR

          R43:  MOV AL,'I'              ; AVERIGUA SI FUE 'RSI'
                CMP [SI+1],AL
                JZ SIG6
                JMP ERRONEO
         SIG6:  CALL ALI_LINEA
                LEA DX,MSI
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV SSI,BX
                JMP FIN_R_PAR

           R5:  MOV AL,'E'              ; AVERIGUA SI FUE 'RES'
                CMP [SI],AL
                JNZ R6
                MOV AL,'S'
                CMP [SI+1],AL
                JZ SIG7
                JMP ERRONEO
         SIG7:  CALL ALI_LINEA
                LEA DX,MES
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV SES,BX
                JMP FIN_R_PAR

           R6:  MOV AL,'I'              ; AVERIGUA SI FUE 'RIP'
                CMP [SI],AL
                JNZ R7
                MOV AL,'P'
                CMP [SI+1],AL
                JZ SIG8
                JMP ERRONEO
         SIG8:  CALL ALI_LINEA
                LEA DX,MIP
                CALL ESC_CAD
                CALL EMPAQUETA2
                MOV SIP,BX
                JMP FIN_R_PAR

           R7:  MOV AL,'F'              ; AVERIGUA SI FUE 'RF'
                CMP [SI],AL
                JNZ R8
                CALL R_BANDERAS
                JMP FIN_R_PAR

           R8:  JMP ERRONEO

      ERRONEO:  LEA DX,MENSAJE_ERROR    ; SI NO FUE NINGUNA INST. VALIDA
                CALL ALI_LINEA
                CALL ESC_CAD

      FIN_R_PAR:CALL ALI_LINEA
                RET

    R_PARAMETRO ENDP

;*****************************************************************************

    R_BANDERAS PROC
                CALL ALI_LINEA          ; IMPRIME BANDERAS ACTUALES
                CALL IMPRIME_BANDERAS
                LEA DX,SEPARADOR
                CALL ESC_CAD

                LEA BX,CAMBIA_BAND      ; LIMPIA LA CADENA
                ADD BX,2
                MOV AL,' '
                MOV CH,0
                MOV CX,20
                LIMPIA_B:
                        MOV [BX],AL
                        INC BX
                LOOP LIMPIA_B

                LEA SI,BANDERAS
                LEA DX,CAMBIA_BAND
                CALL LEE_CAD

                LEA DI,CAMBIA_BAND      ; CAMBIA A MAYUSCULAS LA CADENA
                CALL MAYUSCULAS
                
                LEA DI,CAMBIA_BAND

                MOV AL,0
                CMP [DI+1],AL           ; SI NO SE DIO NINGUNA CADENA
                JNZ BUENA_BANDERA
                JMP FIN_BAND

         BUENA_BANDERA:
                ADD DI,2

         INICIO_BANDERA:
                MOV AL,'N'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'N'
                JNZ S2                  ; NO HAY NINGUNA 'N'

                INC DI
                MOV AL,'V'              ; VERIFICA SI FUE 'NV'
                CMP [DI],AL
                JNZ S12                 ; TAL VEZ FUE 'NZ'
                MOV AL,0
                MOV [SI],AL             ; APAGA LA BANDERA DE DESBORDE
                ADD DI,2
                JMP INICIO_BANDERA

          S12:  MOV AL,'Z'              ; VERIFICA SI FUE 'NZ'
                CMP [DI],AL
                JNZ S13                 ; TAL VEZ FUE 'NA'
                MOV AL,0
                MOV [SI+4],AL           ; APAGA LA BANDERA DE CERO
                ADD DI,2
                JMP INICIO_BANDERA

          S13:  MOV AL,'A'              ; VERIFICA SI FUE 'NA'
                CMP [DI],AL
                JNZ S14                 ; TAL VEZ 'NC'
                MOV AL,0
                MOV [SI+5],AL           ; APAGA LA BANDERA DE ACARREO AUXILIAR
                ADD DI,2
                JMP INICIO_BANDERA

          S14:  MOV AL,'C'              ; VERIFICA SI FUE 'NC'
                CMP [DI],AL
                JNZ S15                 ; TAL VEZ FUE 'NG'
                MOV AL,0
                MOV [SI+7],AL           ; APAGA LA BANDERA DE ACARREO
                ADD DI,2
                JMP INICIO_BANDERA

          S15:  MOV AL,'G'              ; VERIFICA SI FUE 'NG'
                CMP [DI],AL
                JNZ S2
                MOV AL,1
                MOV [SI+3],AL           ; ENCIENDE LA BANDERA DE SIGNO
                ADD DI,2
                JMP INICIO_BANDERA

           S2:  MOV AL,'P'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'P'
                JNZ S3                  ; NO HAY NINGUNA 'P'

          S21:  INC DI
                MOV AL,'L'              ; VERIFICA SI FUE 'PL'
                CMP [DI],AL
                JNZ S22                 ; TAL VEZ FUE 'PO'
                MOV AL,0
                MOV [SI+3],AL           ; APAGA LA BANDERA DE SIGNO
                ADD DI,2
                JMP INICIO_BANDERA

          S22:  MOV AL,'O'              ; VERIFICA SI FUE 'PO'
                CMP [DI],AL
                JNZ S23                 ; TAL VEZ FUE 'PE'
                MOV AL,0
                MOV [SI+6],AL           ; APAGA LA BANDERA DE PARIDAD
                ADD DI,2
                JMP INICIO_BANDERA

          S23:  MOV AL,'E'              ; VERIFICA SI FUE 'PE'
                CMP [DI],AL
                JNZ S3
                MOV AL,1
                MOV [SI+6],AL           ; ENCIENDE LA BANDERA DE PARIDAD
                ADD DI,2
                JMP INICIO_BANDERA

           S3:  MOV AL,'D'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'D'
                JNZ S4                  ; NO HAY NINGUNA 'D'

          S31:  INC DI
                MOV AL,'N'              ; VERIFICA SI FUE 'DN'
                CMP [DI],AL
                JNZ S32                 ; TAL VEZ FUE 'DI'
                MOV AL,1
                MOV [SI+1],AL           ; ENCIENDE LA BANDERA DE DIRECCION
                ADD DI,2
                JMP INICIO_BANDERA

          S32:  MOV AL,'I'              ; VERIFICA SI FUE 'DI'
                CMP [DI],AL
                JNZ S4
                MOV AL,0
                MOV [SI+2],AL           ; APAGA LA BANDERA DE INTERRUPCION
                ADD DI,2
                JMP INICIO_BANDERA

           S4:  MOV AL,'A'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'A'
                JNZ S5                  ; NO HAY NINGUNA 'A'

                INC DI
                MOV AL,'C'              ; VERIFICA SI FUE 'AC'
                CMP [DI],AL
                JNZ S5
                MOV AL,1
                MOV [SI+5],AL           ; ENCIENDE LA BANDERA DE ACARREO AUXILIAR
                ADD DI,2
                JMP INICIO_BANDERA

           S5:  MOV AL,'C'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'C'
                JNZ S6                  ; NO HAY NINGUNA 'C'

                INC DI
                MOV AL,'Y'              ; VERIFICA SI FUE 'CY'
                CMP [DI],AL
                JNZ S6
                MOV AL,1
                MOV [SI+7],AL           ; ENCIENDE LA BANDERA DE ACARREO
                ADD DI,2
                JMP INICIO_BANDERA

           S6:  MOV AL,'E'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'E'
                JNZ S7                  ; NO HAY NINGUNA 'E'

                INC DI
                MOV AL,'I'              ; VERIFICA SI FUE 'EI'
                CMP [DI],AL
                JNZ S7
                MOV AL,1
                MOV [SI+2],AL           ; ENCIENDE LA BANDERA INTERRUPCION
                ADD DI,2
                JMP INICIO_BANDERA

           S7:  MOV AL,'O'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'O'
                JNZ S8                  ; NO HAY NINGUNA 'O'

                INC DI
                MOV AL,'V'              ; VERIFICA SI FUE 'OV'
                CMP [DI],AL
                JNZ S8
                MOV AL,1
                MOV [SI],AL             ; ENCIENDE LA BANDERA DE DESBORDE
                ADD DI,2
                JMP INICIO_BANDERA

           S8:  MOV AL,'Z'
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'Z'
                JNZ S9                  ; NO HAY NINGUNA 'Z'

                INC DI
                MOV AL,'R'              ; VERIFICA SI FUE 'ZR'
                CMP [DI],AL
                JNZ S9
                MOV AL,1
                MOV [SI+4],AL           ; ENCIENDE LA BANDERA DE CERO
                ADD DI,2
                JMP INICIO_BANDERA

           S9:  MOV AL,'U'
                MOV CX,20
                CMP [DI],AL             ; BUSCA EN LA CADENA POR 'U'
                JNZ S10                 ; NO HAY NINGUNA 'U'

                INC DI
                MOV AL,'P'              ; VERIFICA SI FUE 'UP'
                CMP [DI],AL
                JNZ S10
                MOV AL,0
                MOV [SI+1],AL           ; APAGA LA BANDERA DE DIRECCION
                ADD DI,2
                JMP INICIO_BANDERA

          S10:  MOV AL,' '
                CMP [DI],AL
                JZ FIN_BAND

    ERROR_BAND: LEA DX,MENSAJE_ERROR    ; SI NO FUE NINGUNA INST. VALIDA
                CALL ALI_LINEA
                CALL ESC_CAD

     FIN_BAND:  RET

    R_BANDERAS ENDP

;*****************************************************************************

    IMPRIME_BANDERAS PROC
                LEA SI,BANDERAS
                MOV AL,1

                CMP [SI],AL             ; VERIFICA SI HAY DESBORDE
                JNZ B1
                LEA DX,OV
                CALL ESC_CAD
                JMP F1
            B1: LEA DX,NV
                CALL ESC_CAD

            F1: INC SI
                CMP [SI],AL             ; VERIFICA DIRECCION
                JNZ B2
                LEA DX,DN
                CALL ESC_CAD
                JMP F2
            B2: LEA DX,UP
                CALL ESC_CAD

            F2: INC SI
                CMP [SI],AL             ; VERIFICA INTERRUPCION
                JNZ B3
                LEA DX,EI
                CALL ESC_CAD
                JMP F3
            B3: LEA DX,CI
                CALL ESC_CAD

            F3: INC SI
                CMP [SI],AL             ; VERIFICA SIGNO
                JNZ B4
                LEA DX,NG
                CALL ESC_CAD
                JMP F4
            B4: LEA DX,PL
                CALL ESC_CAD

            F4: INC SI
                CMP [SI],AL             ; VERIFICA CERO
                JNZ B5
                LEA DX,ZR
                CALL ESC_CAD
                JMP F5
            B5: LEA DX,NZ
                CALL ESC_CAD

            F5: INC SI
                CMP [SI],AL             ; VERIFICA ACARREO AUXILIAR
                JNZ B6
                LEA DX,AC
                CALL ESC_CAD
                JMP F6
            B6: LEA DX,NA
                CALL ESC_CAD

            F6: INC SI
                CMP [SI],AL             ; VERIFICA PARIDAD
                JNZ B7
                LEA DX,PE
                CALL ESC_CAD
                JMP F7
            B7: LEA DX,PO
                CALL ESC_CAD

            F7: INC SI
                CMP [SI],AL             ; VERIFICA ACARREO
                JNZ B8
                LEA DX,CY
                CALL ESC_CAD
                JMP F8
            B8: LEA DX,NC
                CALL ESC_CAD

            F8: RET
    IMPRIME_BANDERAS ENDP

;******************************************************************************

    INST_E PROC
                LEA DI,INST             ; POSICIONA EL CURSOR EN DONDE DEBE IR
                ADD DI,4                ; LA DIREC. DONDE SE INTRODUC. LOS DATOS

                CALL ASCII_DIRECCION    ; CONVIERTE LA CADENA A UNA DIRECCION
                CMP BX,0                ; COMPRUEBA QUE SEA UNA DIRECCION VALIDA
                JNZ GOOD_E

                JMP FIN_E_ERROR
                
       GOOD_E:  LEA DI,INST             ; AVERIGUA SI SE DIO UN PARAMETRO
                MOV AL,6
                CMP [DI+1],AL
                JG E_PARAMETRO
                    
   E_NO_PARAM:  MOV AX,SDS
                CALL ALI_LINEA
                MOV DL,AH               ; IMPRIME LA DIRECCION DE DS
                CALL DESEMPAQUETA
                MOV DL,AL
                CALL DESEMPAQUETA

                MOV DL,3AH              ; IMPRIME LA DIRECCION DONDE SE INTROD.
                CALL ESCRIBE            ; LOS DATOS
                MOV DL,BH
                CALL DESEMPAQUETA
                MOV DL,BL
                CALL DESEMPAQUETA
                LEA DX,SEPARADOR
                CALL ESC_CAD

                MOV DL,[BX+1000H]       ; IMPRIME EL VALOR ACTUAL
                CALL DESEMPAQUETA
                MOV DL,2EH
                CALL ESCRIBE

                CALL EMPAQUETA          ; PREGUNTA POR UN NUEVO VALOR
                MOV [BX+1000H],AL

                INC BX
                CALL LEE                ; AVERIGUA SI SE DESEA INTROD. OTRO DATO
                CMP AL,0DH              ; [ENTER] PARA SALIR
                JZ FIN_INST_E
                JMP E_NO_PARAM

   E_PARAMETRO: ADD DI,9                ; POSICIONA EL CURSOR DONDE DEBE ESTAR
                                        ; EL DATO A INTRODUCIR O EL INICIO DE LA
                                        ; CADENA
                MOV CL,25
                MOV AL,27H              ; ALMACENA EN AL EL CARACTER '
                CMP [DI],AL
                JNZ INTRO_E             ; SE DIERON NUMEROS PARA INTRODUCIR
                                        ; A MEMORIA
 INTRO_CADENA:  INC DI                  ; SE INTRODUCIRA UNA CADENA
                CMP [DI],AL
                JNZ E20
                JMP FIN_INST_D
          E20:  MOV AH,[DI]
                MOV [BX+1000H],AH
                INC BX
                DEC CL                  ; SI NO SE INTRODUJO UNA SEGUNDA '
                CMP CL,0                ; SE MARCA ERROR
                JLE FIN_E_ERROR
                JMP INTRO_CADENA

       INTRO_E: MOV AL,[DI]
                CALL ASCII_BIN          ; EMPAQUETA EL DATO DADO Y LO PONE EN DH
                MOV DH,AL
                MOV CL,4
                SHL DH,CL
                MOV AL,[DI+1]
                CALL ASCII_BIN
                ADD DH,AL

                MOV [BX+1000H],DH       ; ALMACENA EL DATO
                INC BX

                ADD DI,2                ; ANALIZA LA SINTAXIS
                MOV AL,0DH
                CMP [DI],AL
                JZ FIN_INST_E
                MOV AL,' '
                CMP [DI],AL
                JNZ FIN_E_ERROR
                INC DI
                JMP INTRO_E

   FIN_E_ERROR: LEA DX,MENSAJE_ERROR    ; SI NO FUE NINGUNA INST. VALIDA
                CALL ALI_LINEA
                CALL ESC_CAD

    FIN_INST_E: RET

    INST_E ENDP

;*****************************************************************************

    INST_D PROC
                LEA DI,INST
                MOV AL,1
                CMP [DI+1],AL           ; SI SOLO SE TECLEO 'D'
                JZ D_SOLA
                JMP D_PARAMETRO

       D_SOLA:  MOV CH,0
                MOV CX,16
                CALL IMPRIME_MEMORIA
                JMP FIN_INST_D

       D_PARAMETRO:
                MOV AL,6
                CMP [DI+1],AL           ; SI SE DIO DIRECCION INICIAL Y FINAL
                JLE UNA_DIRECCION
                JMP DOS_DIRECCIONES

       UNA_DIRECCION:
                LEA DI,INST
                ADD DI,4                ; COLOCA EL CURSOR EN LA POSICION INICIAL
                CALL ASCII_DIRECCION    ; DE LA DIRECCION
                CMP BX,0                ; COMPRUEBA QUE SEA UNA DIRECCION VALIDA
                JNZ GOOD_D
                JMP FIN_D_ERROR

       GOOD_D:  MOV DIREC,BX
                MOV CH,0
                MOV CX,16
                CALL IMPRIME_MEMORIA
                JMP FIN_INST_D

       DOS_DIRECCIONES:
                LEA DI,INST
                ADD DI,4
                CALL ASCII_DIRECCION
                CMP BX,0
                JZ FIN_D_ERROR
                MOV DX,BX               ; ALMACENA EN DX LA DIRECCION INICIAL

                LEA DI,INST
                ADD DI,9
                CALL ASCII_DIRECCION    ; ALMACENA EN BX LA DIRECCION FINAL
                CMP BX,0
                JZ FIN_D_ERROR          ; COMPRUEBA QUE SEA UNA DIR. VALIDA
                CMP DX,BX
                JGE FIN_D_ERROR

                MOV AX,BX               ; ALMACENA EN AX LA DIFERENCIA ENTRE
                SUB AX,DX               ; DIRECCION INICIAL Y FINAL

                MOV DIREC,DX            ; DIRECCION INICIAL
                CMP AX,10H
                JLE ES_MENOR_10

       CICLO_16:
                MOV CX,1
                SUB AX,10H
                CALL IMPRIME_MEMORIA
                CMP AX,0
                JNLE CICLO_16
                JMP FIN_INST_D

       ES_MENOR_10:
                MOV CX,1
                CALL IMPRIME_MEMORIA
                JMP FIN_INST_D

       FIN_D_ERROR:
                LEA DX,MENSAJE_ERROR    ; SI NO FUE NINGUNA INST. VALIDA
                CALL ALI_LINEA
                CALL ESC_CAD

       FIN_INST_D:
                RET

    INST_D ENDP

;*****************************************************************************

    IMPRIME_MEMORIA PROC

                PUSH AX
                PUSH BX
                PUSH DX

    OTRA_LINEA: MOV AX,SDS
                MOV BX,DIREC
                CALL ALI_LINEA
                MOV DL,AH               ; IMPRIME LA DIRECCION DE DS
                CALL DESEMPAQUETA
                MOV DL,AL
                CALL DESEMPAQUETA

                MOV DL,3AH              ; IMPRIME LA DIRECCION A MOSTRAR
                CALL ESCRIBE
                MOV DL,BH
                CALL DESEMPAQUETA
                MOV DL,BL
                CALL DESEMPAQUETA
                MOV DL,' '
                CALL ESCRIBE
                CALL ESCRIBE

                MOV DH,16

      ESC_HEXA: MOV DL,[BX+1000H]       ; IMPRIME LOS SIGUIENTES 16 VALORES
                CALL DESEMPAQUETA       ; EN HEXADECIMAL
                MOV DL,' '
                CALL ESCRIBE
                INC BX
                DEC DH
                CMP DH,0
                JNZ ESC_HEXA

                MOV DL,' '
                CALL ESCRIBE
                CALL ESCRIBE
                MOV DH,16
                MOV BX,DIREC

     ESC_CARAC: MOV DL,[BX+1000H]       ; IMPRIME LOS MISMOS 16 VALORES PERO
                CMP DL,1FH              ; EN ASCII
                JLE IMPRIME_PUNTO
                CALL ESCRIBE
                INC BX
                DEC DH
                CMP DH,0
                JNZ ESC_CARAC

                JMP FIN_D_PAR

 IMPRIME_PUNTO: MOV DL,'.'              ; SI ES UN CARACTER DE CONTROL IMPRIME
                CALL ESCRIBE            ; UN PUNTO
                INC BX
                DEC DH
                CMP DH,0
                JNZ ESC_CARAC

    FIN_D_PAR:  ADD DIREC,16
                DEC CX
                CMP CX,0
                JZ FIN_50
                JMP OTRA_LINEA

       FIN_50:  POP DX
                POP BX
                POP AX
                RET

    IMPRIME_MEMORIA ENDP

;******************************************************************************

    ASCII_DIRECCION PROC

                MOV CL,4                ; LAS CUATRO POSICIONES DE LA DIRECCION

         VERIFICA_RANGO:
                MOV AL,30H              ; COMPRUEBA QUE SEA UNA DIRECCION VALIDA
                CMP [DI],AL
                JL ERROR_DIR
                MOV AL,39H
                CMP [DI],AL
                JG ES_LETRA
                JMP ES_BUENA_DIR

             ES_LETRA:
                MOV AL,46H
                CMP [DI],AL
                JG ERROR_DIR
                MOV AL,41H
                CMP [DI],AL
                JL ERROR_DIR

             ES_BUENA_DIR:
                INC DI
                DEC CL
                CMP CL,0
                JZ SIGUE_DIR
                JMP VERIFICA_RANGO

             ERROR_DIR:
                JMP FIN_ERROR_DIR
                
             SIGUE_DIR:
                SUB DI,4

                MOV AL,[DI]             ; EMPAQUETA LA DIRECCION DADA PARTE ALTA
                CALL ASCII_BIN
                MOV BH,AL
                MOV CL,4
                SHL BH,CL
                MOV AL,[DI+1]
                CALL ASCII_BIN
                ADD BH,AL

                MOV AL,[DI+2]           ; DEJA LA DIRECCION COMPLETA EN BX
                CALL ASCII_BIN
                MOV BL,AL
                MOV CL,4
                SHL BL,CL
                MOV AL,[DI+3]
                CALL ASCII_BIN
                ADD BL,AL

                CMP BX,65535
                JNAE GOOD_DIR

             FIN_ERROR_DIR:
                MOV BH,0                ; SI LA DIRECCION ES INVALIDA COLOCA
                MOV BL,0                ; A 'BX' UN ESPACIO EN BLANCO

             GOOD_DIR:
                RET
    ASCII_DIRECCION ENDP

;******************************************************************************

    LIMPIA PROC
                PUSH AX
                PUSH BX
                PUSH CX
                MOV CX,40
                LEA BX,INST
                MOV AL,40
                MOV [BX],AL
                MOV AL,' '
                INC BX

                CICLO2:
                        MOV [BX],AL
                        INC BX
                LOOP CICLO2

                POP CX
                POP BX
                POP AX
                RET
    LIMPIA ENDP

;*****************************************************************************

    MAYUSCULAS PROC
                PUSH AX
                ADD DI,2
                MOV CH,0
                MOV CL,[DI-1]
                CMP CX,0
                JZ FIN_MAYUS

                CAMBIA_MINUS:
                        MOV AH,[DI]
                        CMP AH,61H
                        JB B30
                        CMP AH,7AH
                        JA B30
                        AND AH,11011111B
                        MOV [DI],AH

                    B30:INC DI
                LOOP CAMBIA_MINUS

    FIN_MAYUS:  POP AX
                RET

    MAYUSCULAS ENDP

;*****************************************************************************

    LEE PROC
                PUSH BX
                PUSH CX
                PUSH DX
                MOV AH,1
                INT 21H
                POP DX
                POP CX
                POP BX
                RET
    LEE ENDP

;*****************************************************************************

    ESCRIBE PROC
                PUSH AX
                PUSH BX
                PUSH CX
                PUSH DX
                MOV AH,2
                INT 21H
                POP DX
                POP CX
                POP BX
                POP AX
                RET
    ESCRIBE ENDP

;*****************************************************************************

    ASCII_BIN PROC
                CMP AL,30H
                JL ERROR
                CMP AL,39H
                JLE RESTA_30
                CMP AL,41H
                JL ERROR
                CMP AL,46H
                JG ERROR
                SUB AL,37H
                JMP FIN1
        ERROR:  MOV AL,0
                JMP FIN1
                RESTA_30:
                SUB AL,30H
         FIN1:  RET
    ASCII_BIN ENDP

;*****************************************************************************

    BIN_ASCII PROC
                CMP DL,9H
                JG SUMA_37
                ADD DL,30H
                JMP FIN2
      SUMA_37:  ADD DL,37H
         FIN2:  RET
    BIN_ASCII ENDP

;*****************************************************************************

    EMPAQUETA PROC
                PUSH CX
                CALL LEE
                CALL ASCII_BIN
                MOV CL,4
                SHL AL,CL
                MOV CH,AL
                CALL LEE
                CALL ASCII_BIN
                ADD AL,CH
                POP CX
                RET
    EMPAQUETA ENDP

;*****************************************************************************

    DESEMPAQUETA PROC
                PUSH CX
                PUSH DX
                MOV CL,4
                SHR DL,CL
                CALL BIN_ASCII
                CALL ESCRIBE
                POP DX
                AND DL,0FH
                CALL BIN_ASCII
                CALL ESCRIBE
                POP CX
                RET
    DESEMPAQUETA ENDP

;*****************************************************************************

    EMPAQUETA2 PROC
                CALL EMPAQUETA
                MOV BH,AL
                CALL EMPAQUETA
                MOV BL,AL
                RET
    EMPAQUETA2 ENDP

;*****************************************************************************

    DESEMPAQUETA2 PROC
                XCHG DL,DH
                CALL DESEMPAQUETA
                XCHG DL,DH
                CALL DESEMPAQUETA
                RET
    DESEMPAQUETA2 ENDP

;*****************************************************************************

    LEE_CAD PROC
                PUSH AX
                PUSH BX
                PUSH CX
                PUSH DX
                MOV AH,10
                INT 21H
                POP DX
                POP CX
                POP BX
                POP AX
                RET
    LEE_CAD ENDP

;*****************************************************************************

    ESC_CAD PROC
                PUSH AX
                PUSH BX
                PUSH CX
                PUSH DX
                MOV  AH,9
                INT 21H
                POP DX
                POP CX
                POP BX
                POP AX
                RET
    ESC_CAD ENDP

;*****************************************************************************

    ALI_LINEA PROC
                PUSH DX
                MOV DL,10
                CALL ESCRIBE
                MOV DL,13
                CALL ESCRIBE
                POP DX
                RET
    ALI_LINEA ENDP

;*****************************************************************************

CODESG ENDS
END START
