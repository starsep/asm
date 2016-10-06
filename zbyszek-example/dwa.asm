        section .text
        global _start	    ;Deklaracja dla linkera (ld)
        extern printf,exit

_start:                     ;Początek programu (punkt wejscia)
        mov rdi,napis
	mov rax,0
        call printf

        mov rdi,0
        call exit

        section .data

;; Komunikat do wypisania

napis   db 'Witaj świecie!',0xa,0   ;napis zakonczony znakiem LF i zerem
