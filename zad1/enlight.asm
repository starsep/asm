global enlight

section .data
  red dq 0
  green dq 0
  blue dq 0
  N dd 0
  M dd 0
  change dd 0
  delta db 0

section .text
enlight:
  mov qword[red], rdi
  mov qword[green], rsi
  mov qword[blue], rdx
  mov dword[N], ecx
  mov dword[M], r8d
  mov dword[change], r9d
  mov al, byte[rsp + 8]
  mov byte[delta], al
  ret
