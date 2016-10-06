; fasm demonstration of writing 64-bit ELF executable
; note that linux from kernel 2.6.??? needs last segment to be writeable
; else segmentation fault is generated
; compiled with fasm 1.66

; syscall numbers: /usr/src/linux/include/asm-x86_64/unistd.h
; kernel parameters:
; r9	; 6th param
; r8	; 5th param
; r10	; 4th param
; rdx	; 3rd param
; rsi	; 2nd param
; rdi	; 1st param
; eax	; syscall_number
; syscall
;
; return register:
; rax	; 1st
; rdx	; 2nd
;
; preserved accross function call: RBX RBP ESP R12 R13 R14 R15
;
; function parameter (when linked with external libraries):
; r9	; 6th param
; r8	; 5th param
; rcx	; 4th param
; rdx	; 3rd param
; rsi	; 2nd param
; rdi	; 1st param
; call library

	global _start
	
        section .text

_start: 

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
