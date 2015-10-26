
demores        SEGMENT
	       ASSUME CS:demores, DS:demores

	       ORG   100h
inicio:
	       JMP   main

controla_int08 PROC
	       PUSHF
	       CALL  CS:ant_int08   ; llamar al gestor normal de INT 8
	       STI

SM:     MOV     AH,02H
	MOV     BH,0
	MOV     DH,12
	MOV     DL,0
	INT     10H  ; SELECCIONAMOS RENGLON

RO:     MOV     BL,8AH
OT4:    MOV     AH,02
	MOV     DL,BL
	INT     21H
	INC     BL
	CMP     BL,250
	JE      RO
	JMP     OT4

	       

	       ; Colocar aquí el proceso a ejecutar 18,2 veces/seg.
	       ; que puede invocar funciones de INT 10h
fin_int08:
	       IRET
controla_int08 ENDP

ant_int08      LABEL DWORD
ant_int08_off  DW    ?
ant_int08_seg  DW    ?

	       ; Dejar residente hasta aquí.

main:          PUSH  ES
	       MOV   AX,3508h
	       INT   21h               ; obtener vector de INT 8
	       MOV   ant_int08_seg,ES
	       MOV   ant_int08_off,BX
	       POP   ES

	       LEA   DX,controla_int08
	       MOV   AX,2508h
	       INT   21h               ; nueva rutina de INT 8

	       PUSH  ES
	       MOV   ES,DS:[2Ch]       ; dirección del entorno
	       MOV   AH,49h
	       INT   21h               ; liberar espacio de entorno
	       POP   ES

	       LEA   DX,main           ; fin del código residente
	       ADD   DX,15             ; redondeo a párrafo
	       MOV   CL,4
	       SHR   DX,CL             ; bytes -> párrafos
	       MOV   AX,3100h          ; terminar residente
	       INT   21h

demores        ENDS
	       END   inicio
