	.file	"struct.c"
	.intel_syntax noprefix
	.text
.Ltext0:
	.comm	z1,20,16
	.globl	f1
	.type	f1, @function
f1:
.LFB0:
	.file 1 "struct.c"
	.loc 1 8 0
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-40], rdi
	mov	DWORD PTR [rbp-44], esi
	mov	DWORD PTR [rbp-48], edx
	.loc 1 11 0
	mov	eax, DWORD PTR [rbp-44]
	mov	DWORD PTR [rbp-32], eax
	.loc 1 12 0
	mov	eax, DWORD PTR [rbp-48]
	mov	DWORD PTR [rbp-28], eax
	.loc 1 13 0
	mov	rax, QWORD PTR [rbp-40]
	mov	rdx, QWORD PTR [rbp-32]
	mov	QWORD PTR [rax], rdx
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
	mov	edx, DWORD PTR [rbp-16]
	mov	DWORD PTR [rax+16], edx
	.loc 1 14 0
	mov	rax, QWORD PTR [rbp-40]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	f1, .-f1
	.section	.rodata
.LC0:
	.string	"%d,%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.loc 1 16 0
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	.loc 1 16 0
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR [rbp-8], rax
	xor	eax, eax
	.loc 1 17 0
	lea	rax, [rbp-48]
	mov	edx, 5
	mov	esi, 3
	mov	rdi, rax
	call	f1
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR z1[rip], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR z1[rip+8], rax
	mov	eax, DWORD PTR [rbp-32]
	mov	DWORD PTR z1[rip+16], eax
	.loc 1 18 0
	mov	edx, DWORD PTR z1[rip+4]
	mov	eax, DWORD PTR z1[rip]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	mov	eax, 0
	.loc 1 19 0
	mov	rcx, QWORD PTR [rbp-8]
	xor	rcx, QWORD PTR fs:40
	je	.L5
	call	__stack_chk_fail
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x125
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF9
	.byte	0xc
	.long	.LASF10
	.long	.LASF11
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF8
	.uleb128 0x4
	.string	"s1"
	.byte	0x14
	.byte	0x1
	.byte	0x3
	.long	0xb1
	.uleb128 0x5
	.string	"a"
	.byte	0x1
	.byte	0x4
	.long	0x57
	.byte	0
	.uleb128 0x5
	.string	"b"
	.byte	0x1
	.byte	0x5
	.long	0x57
	.byte	0x4
	.uleb128 0x5
	.string	"c"
	.byte	0x1
	.byte	0x5
	.long	0x57
	.byte	0x8
	.uleb128 0x5
	.string	"d"
	.byte	0x1
	.byte	0x5
	.long	0x57
	.byte	0xc
	.uleb128 0x5
	.string	"e"
	.byte	0x1
	.byte	0x5
	.long	0x57
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.string	"f1"
	.byte	0x1
	.byte	0x8
	.long	0x73
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0xf7
	.uleb128 0x7
	.string	"a"
	.byte	0x1
	.byte	0x8
	.long	0x57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x7
	.string	"b"
	.byte	0x1
	.byte	0x8
	.long	0x57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x8
	.string	"z2"
	.byte	0x1
	.byte	0x9
	.long	0x73
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x9
	.long	.LASF12
	.byte	0x1
	.byte	0x10
	.long	0x57
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xa
	.string	"z1"
	.byte	0x1
	.byte	0x6
	.long	0x73
	.uleb128 0x9
	.byte	0x3
	.quad	z1
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF2:
	.string	"short unsigned int"
.LASF3:
	.string	"unsigned int"
.LASF9:
	.string	"GNU C11 5.4.0 20160609 -masm=intel -mtune=generic -march=x86-64 -g -O0 -fstack-protector-strong"
.LASF4:
	.string	"signed char"
.LASF11:
	.string	"/home/starsep/studia/asm/lab4"
.LASF0:
	.string	"long unsigned int"
.LASF8:
	.string	"char"
.LASF1:
	.string	"unsigned char"
.LASF12:
	.string	"main"
.LASF6:
	.string	"long int"
.LASF10:
	.string	"struct.c"
.LASF5:
	.string	"short int"
.LASF7:
	.string	"sizetype"
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.2) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
