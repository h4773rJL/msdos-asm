_STACK segment para stack 'STACK'
_STACK ENDS
_DATA SEGMENT WORD PUBLIC 'DATA'
      MSG DB 'LASTDRIVE = '
      DLETTER DB ?
              DB 0DH, 0AH, '$'
_DATA ENDS
_TEXT SEGMENT WORD PUBLIC 'CODE'
   ASSUME CS:_TEXT,DS:_DATA,SS:_STACK

MAIN PROC NEAR
          MOV AX,_DATA
          MOV DS,AX
          MOV AH,19H
          INT 21H

          MOV DL,AL
          MOV AH,0EH
          INT 21H

          MOV BL,AL
          ADD AL,('A'-1)
          MOV DLETTER,AL
          MOV DX,OFFSET MSG
          MOV AH,9
          INT 21H
          MOV AH,4CH
          MOV AL,BL
          INT 21H
MAIN ENDP
_TEXT ENDS
 END MAIN
