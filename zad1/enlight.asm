global enlight

section .data
  red dq 0
  green dq 0
  blue dq 0
  channel dq 0
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
  call set_channel
  mov rax, qword[channel]
  ret

set_channel:
  mov eax, dword[change]
  cmp eax, 1
  jne not_1
  mov rax, qword[red]
  mov qword[channel], rax
  ret
not_1:
  cmp eax, 2
  jne not_2
  mov rax, qword[green]
  mov qword[channel], rax
  ret
not_2:
  mov rax, qword[blue]
  mov qword[channel], rax
  ret
