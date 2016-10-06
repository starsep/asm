        section .text
        global _start       ;Declaracja dla linkera (ld)

;; Wywołania systemowe 

SYS_EXIT   equ 60

;; Argument

ARG        equ 4

_start:                     ;Początek programu (punkt wejścia)
	nop
        mov rdi,1           ;Obliczana wartość
        mov rcx,ARG
l1:     cmp rcx,1           ;Czy już koniec?
        jle koniec
        imul rdi,rcx
        dec rcx             ;Zmniejszamy argument
        jmp l1

koniec: mov eax,SYS_EXIT    ;numer wywołania systemowego
        syscall             ;wywołanie systemowe
