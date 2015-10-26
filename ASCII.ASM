STACKSEG SEGMENT PARA STACK 'STACK'
        DW 256 DUP(?)
STACKSEG ENDS
DSEG SEGMENT PARA 'DATA'
        CAD DB 'PROGRAMA QUE MUESTRA LA TABLA ASCCI ','$'
        chr db '                                                                º','$'
DSEG ENDS
CSEG SEGMENT PARA 'CODE'
SUM PROC FAR
ASSUME CS:CSEG, DS:DSEG, SS:STACKSEG
        PUSH DS
        SUB AX,AX
        push ax
        MOV AX,DSEG
        MOV DS,AX
        call limpia
        mov bh,0
        mov bl,1
        MOV Cx,0
        call alinea
  cciclo:
        
        MOV Ax,Cx
        inc bh
        inc cx
        mov dl,al
        cmp bh,1
        je uno
        cmp bh,2
        je dos
        cmp bh,3
        je tres
        cmp bh,4
        je cuatro
        cmp bh,5
        je cinco
        cmp bh,6
        je seis
        cmp bh,7
        je siete
        cmp bh,8
        je ocho
        cmp bh,9
        je nueve
        cmp bh,0ah
        je diez
        cmp ch,0dh
        
 REINS: Call Desemp
        Cmp cx,0dh
        je slt
        CALL ESCRIBE
     slt:CALL DECI
        CALL ALINEA
        cmp bh,09h
        jg escc
        CMP Cx,0ffh     
        JL cciclo
   escc:
        call lee
        call limpia
        call pos1
        call alinea
        call rem
        mov bh,0
        inc bl
        cmp bl,1ah
        jg  fin1
        jmp cciclo
        fin1:  ret
        uno:call one
        jmp reins
        dos:call two
        jmp reins
        tres:call three
        jmp reins
        cuatro:call four
        jmp reins
        cinco:call five
        jmp reins
        seis:call six
        jmp reins
        siete:call seven
        jmp reins
        ocho:call eight
        jmp reins
        nueve:call nine
        jmp reins
        diez:call ten
        jmp reins

;Procedimiento para alimentar linea
alinea proc
        push ax
        push bx
        push cx
        push dx
        mov dl,0ah
        call escribe
        mov dl,0dh
        call escribe
        pop dx
        pop cx
        pop bx
        pop ax
        ret
alinea endp

; procedimiento que transforma el valor ascii

limpia proc
        push ax
        push bx
        push cx
        push dx
        call pos
        mov ax,0600h
        mov bh,07
        mov cx,0000
        mov dx,184fh
        int 10h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
limpia endp

;Procedimiento para mandar resultado a pantalla
escribe proc
        push ax
        push bx
        push cx
        push dx
        mov ah,2
        int 21h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
escribe endp

lee proc
        push ax
        push bx
        push cx
        push dx
        mov ah,1
        int 21h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
lee endp

pos proc
        push ax
        push bx
        push cx
        push dx
        mov ah,02
        mov bh,00
        mov dh,03
        mov dl,00h
        int 10h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
pos endp

pos1 proc
        push ax
        push bx
        push cx
        push dx
        mov ah,02
        mov bh,00
        mov dh,00
        mov dl,017h
        int 10h
        
        pop dx
        pop cx
        pop bx
        pop ax
        ret
pos1 endp

pos2 proc
        push ax
        push bx
        push cx
        push dx
        mov ah,02
        mov bh,00
        mov dh,01
        mov dl,01      
        pop dx
        pop cx
        pop bx
        pop ax
        ret
pos2 endp
pos3 proc
        push ax
        push bx
        push cx
        push dx
        mov ah,02
        mov bh,00
        mov dh,01
        mov dl,08      
        pop dx
        pop cx
        pop bx
        pop ax
        ret
pos3 endp

desemp proc
        push ax
        push bx
        push cx
        push dx
        mov ch,dl
        mov cl,4
        shr dl,cl
        call binasci
        call escribe
        mov dl,ch
        and dl,0fh
        call binasci
        call escribe
        pop dx
        pop cx
        pop bx
        pop ax
        ret
desemp endp
desemp1 proc
        push ax
        push bx
        push cx
        push dx
        mov ch,dl
        mov cl,4
        shr dl,cl
        call binasci
        mov dl,ch
        and dl,0fh
        call binasci
        call escribe
        pop dx
        pop cx
        pop bx
        pop ax
        ret
desemp1 endp

binasci proc
        cmp dl,9
        jg suma37
        add dl,30h
        jmp fin2
suma37: add dl,37h
fin2:   ret
binasci endp


ascibin proc
        cmp al,30h
        jl error
        cmp al,39h
        jle resta30
        cmp al,41h
        jl error
        cmp al,46h
        jg error
        sub al,37h
        jmp fin3
resta30:sub al,30h
        jmp fin3
error:  mov al,0
fin3:    ret
ascibin endp


deci    proc
        push ax
        push bx
        push dx
        cmp al,064h
        jge solouna
        CMP AL,080h
        jge solouna
        aam
        mov dl,ah
        call desemp1
        mov dl,al
        call desemp1
        jmp hhh
solouna:aam
        mov bl,al
        mov al,ah
        aam
        mov dl,ah
        call desemp1
        mov dl,al
        call desemp1
        mov dl,bl
        call desemp1        
    hhh:pop dx
        pop bx
        pop ax
        ret
deci    endp



;marco     PROC
 ;         PUSH AX
  ;        PUSH BX
   ;       PUSH CX
    ;      PUSH DX

     ;   call limpia

         ; mov dx,0c9h  ;escribe É
          ;call escribe
          ;mov cl,1
          ;call reng
       ;ll:inc cl       ;escribe la parte superior del marco
        ;  mov dx,0cdH                     
         ; call escribe
          ;cmp cl,40h
          ;jle ll
          ;mov dx,0bbh  ;escribe »
          ;call escribe
          ;mov cl,1
          ;call alinea
      ;bb: mov dx,0bah
       ;   call escribe
        ;  call aux
         ; call alinea
          ;inc cl       
          ;cmp cl,0eh  ;escribe la parte izquierda del marco
          ;jle bb
          ;call ren
          ;mov dx,0c8h  ;escribe È
          ;call escribe          
          ;mov cl,1
          
      ; mm:inc cl
       ;   mov dx,0cdH
        ;  call escribe
         ; cmp cl,40h ;escribe la parte inferior del marco
          ;jle mm
       ;   mov dx,0bch
        ;  call escribe
         ; POP  DX
         ; POP  CX
          ;POP  BX
        ;  POP  AX
         ; RET
;marco    ENDP
aux       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH Dx    
          LEA Dx,chr            
          MOV AH,9
          INT 21H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
aux       ENDP


ren       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,012H
          MOV DL,00H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
ren       ENDP

rem       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,02H
          MOV DL,05H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
rem      ENDP

reng      PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,01
          MOV BH,00
          MOV DH,02H
          MOV DL,01H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
reng      ENDP
reng1      PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          pop bx
          MOV DH,bh
          MOV DL,05H
          INT 10H
          POP  DX
          POP  CX
         ; POP  BX
          POP  AX
          RET
reng1      ENDP
reng2      PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,bh
          MOV DL,05H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
reng2      ENDP

one       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,06h
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
one       ENDP
two       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,07
          MOV DL,020h
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
two       ENDP
three     PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,08
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
three     ENDP
four      PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,09
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
four      ENDP
five      PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,0ah
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
five      ENDP
six       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,0bh
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
six       ENDP
seven     PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,0ch
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
seven     ENDP
eight     PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV DH,0dh
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
eight     ENDP
nine      PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV Dh,0eH
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
nine      ENDP
ten       PROC
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          MOV AH,02
          MOV BH,00
          MOV Dh,0fH
          MOV DL,020H
          INT 10H
          POP  DX
          POP  CX
          POP  BX
          POP  AX
          RET
ten       ENDP


Sum Endp
Cseg Ends
End Sum

        


       
