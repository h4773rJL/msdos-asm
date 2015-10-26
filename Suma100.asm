include persa.bib
.model small
.data
        ana Db 'Suma de los 100 Primeros numeros Reales ',10,13,'$'
.stack
.code
ini:    Mov ax,@data
        mov ds,ax

        cls
        write ana

        mov ax,0
        mov cx,100
suma:   add ax,cx
        loop suma

        Push ax
        mov bl,ah
        call impri
        pop ax
        mov bl,al
        call impri

        MOV AH,4CH
        INT 21H




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

end ini



