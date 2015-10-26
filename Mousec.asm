.model small
.code
empieza: mov ax,@data
         mov ds,ax
         MOV ES,AX
         call limpiar
         mov dx,Offset msg1
         call letrero
         mov ax,0
         int 33h
         cmp ax,0
         je nomouse
         mov ax,1
         int 33h
INFORMACION: 
            mov bx,0
            mov cx,0
            mov dx,0
          mov ax,3
         int 33h
         mov ax,dx
         call cursor1
         call condec
         mov ax,cx
         call cursor2
         call condec
         cmp bx,1
         je BOTON1
         cmp bx,2
         je fin
         jmp informacion
    BOTON1: call limpiar
         call cursor
         mov dx, offset MSG3
         call letrero
         jmp informacion
nomouse: call limpiar
         mov dx,offset msg2
         call letrero
     fin:call limpiar
         call cursor
         mov dx, offset MSG4
         call letrero
         mov ax,4c00h
         int 21h

 limpiar PROC NEAR
         PUSH AX
         PUSH BX
         PUSH CX
         PUSH DX
         mov ah,0
         mov al,2
         int 10h
         POP AX
         POP BX
         POP CX
         POP DX
         ret
 LIMPIAR ENDP
letrero PROC NEAR
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
         mov ah,09
         int 21h
         POP AX
         POP BX
         POP CX
         POP DX
         ret


LETRERO ENDP
cursor PROC NEAR
       PUSH AX
       PUSH BX
       PUSH CX
       PUSH DX
        mov ah,2
         mov bh,10
         mov dh,14
         mov dl,0
         int 10h
         POP AX
         POP BX
         POP CX
         POP DX
         ret
CURSOR ENDP
cursor1 PROC NEAR
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
         mov ah,2
         mov bh,0
         mov dh,20
         mov dl,30h
         int 10h
         POP AX
         POP BX
         POP CX
         POP DX
         ret
CURSOR1 ENDP
cursor2 PROC NEAR
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
         mov ah,2
         mov bh,0
         mov dh,21
         mov dl,30h
         int 10h
         POP AX
         POP BX
         POP CX
         POP DX
         ret
CURSOR2 ENDP
 condec PROC NEAR
          PUSH    AX
          PUSH    BX
          PUSH    CX
          PUSH    DX
          MOV     CX,0001H
          MOV     BL,0AH
    REG:  DIV     BL
          PUSH    AX
          CMP     AL,0H
          JZ      CO0
          INC     CL
          MOV     AH,0H
          JMP     REG
CO0:CMP     CL,0H
    JZ      SAD
    POP     AX
    MOV     BL,AH
    CALL    IDC

    DEC     CL
    JMP     CO0
SAD:
    POP     DX
    POP     CX
    POP     BX
    POP     AX
    RET

IDC:ADD     BL,30H
    MOV     AH,2H
    MOV     DL,BL
    INT     21H
    RET
  CONDEC ENDP



.stack
.data
      msg1 db  'BIENVENIDO... PARA TERMINAR OPRIMA BOTON DERECHO$'
      MSG3 DB  'OPRIMISTE BOTON IZQUIERDO$'
      MSG4 DB  'OPRIMIO BOTON DERECHO , FIN DEL PROGRAMA$'
      MSG2 DB 'EL MOUSE NO ESTA INSTALADO$'
end empieza
