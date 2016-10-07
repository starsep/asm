        section .text
        global trzy       ;Declaracja dla linkera (ld)

;; Argument

ARG        equ 4

trzy:                     ;Początek programu (punkt wejścia)
        push rbp
        mov rbp,rsp
        mov ebx,1           ;Obliczana wartość
        mov ecx,ARG
l1:     cmp ecx,1           ;Czy już koniec?
        jle koniec
        imul ebx,ecx
        dec ecx             ;Zmniejszamy argument
        jmp l1

koniec: mov eax,ebx
        pop rbp
        ret
