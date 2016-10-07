section .text

global get_character

SYS_READ equ 3
KERNEL_CALL equ 0x80
STDIN equ 0

section .data
	input db 0

get_character:
	mov eax, SYS_READ ; read()
	mov ebx, STDIN ; file
	mov	ecx, input ; char *
	mov	edx, 1 ; len
	int KERNEL_CALL
	cmp eax, 0
	je eof
	mov al, byte[input]
eof_ret:
	ret

eof:
	mov eax, 0
	jmp eof_ret
