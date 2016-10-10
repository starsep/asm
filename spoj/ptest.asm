global _start

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
KERNEL_CALL equ 0x80
STDIN equ 0
STDOUT equ 1
ASCII_ZERO equ 48
ASCII_NEWLINE equ 10
ZERO equ 0
TEN equ 10

section .data
	input db 0
	partial db 0
	result dw 0
	result_len db 4
	result_str db `0004` ; `` for escaping characters in C-style

section .text

_start:
	; call one_number
	; call one_number
	call print_result
	call exit

one_number:
  mov byte[partial], 0 ; clear partial result

	call read
  mov ah, byte[partial]
  imul ax, TEN
  mov bh, byte[input]
  sub bh, ASCII_ZERO
  add ah, bh

	mov byte[result], ah
	ret

print_result:
	mov ax, word[result]
	xor edx, edx
	mov dl, 0

print_result_loop:
	cmp al, 0
	jbe print_result_end ; unsigned jle
	mov ah, ZERO
	mov bl, TEN
	div bl

	mov cl, byte[result_str + edx]
	add cl, ah
	mov byte[result_str + edx], cl

	inc dl
	jmp print_result_loop

print_result_end:
	cmp dl, 0
	jne not_zero
	inc dl
not_zero:
	mov byte[result_str + edx], ASCII_NEWLINE
	inc dl
	mov byte[result_len], dl
	call reverse
	call write

reverse:
	mov al, byte[result_str]
	xor edx, edx
	mov dl, byte[result_len]
	sub dl, 2
	mov bl, byte[result_str + edx]
	mov byte[result_str], bl
	mov byte[result_str + edx], al
	ret

read:
	mov eax, SYS_READ ; read()
	mov ebx, STDIN ; file
	mov	ecx, input ; char *
	mov	edx, 1 ; len
	int KERNEL_CALL
	ret

write:
	mov eax, SYS_WRITE ; write()
	mov ebx, STDOUT ; file
	mov	ecx, result_str ; char *
	xor edx, edx
	mov	dl, byte[result_len] ; len
	int KERNEL_CALL
	ret

exit:
	mov	eax, SYS_EXIT ; exit()
	xor	ebx, ebx ; return 0;
	int KERNEL_CALL
