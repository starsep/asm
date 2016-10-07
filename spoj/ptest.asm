global _start

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
KERNEL_CALL equ 0x80
STDIN equ 0
STDOUT equ 1
ASCII_ZERO equ 48
TEN equ 10

section .data
	input db 0
	partial db 0
	result db 0
	result_str db `000\n\0` ; `` for escaping characters in C-style

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
    imul ax, 10
    mov bh, byte[input]
    sub bh, ASCII_ZERO
    add ah, bh
    
	ret
	
print_result:
	mov byte[result], 123 ; fake data
	mov al, 22
	mov ah, 0
	mov bl, 10
	div bl
	
	mov cl, byte[result_str]
	add cl, al
	mov byte[result_str], cl
	
	call write

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
	mov	edx, 5 ; len
	int KERNEL_CALL
	ret
	
exit:
	mov	eax, SYS_EXIT ; exit()
	xor	ebx, ebx ; return 0;
	int KERNEL_CALL
