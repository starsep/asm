	global _start
	
        section .text

_start: 

	mov rax,10
	push rax
	push rsp
	pop rbx 	
	mov	edx,msg_size	; CPU zero extends 32-bit operation to 64-bit
				; we can use less bytes than in case mov rdx,...
	lea	rsi,[msg]
	mov	edi,1		; STDOUT
	mov	eax,1		; sys_write
	syscall

	xor	edi,edi		; exit code 0
	mov	eax,60		; sys_exit
	syscall

        section .data

msg db 'Hello 64-bit world!',0xA
msg_size equ $-msg
