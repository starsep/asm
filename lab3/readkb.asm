global readkb

section .data
  znak dd 0
  szablon db `%d\n\0`

section .text
  extern printf
readkb:
  mov eax, 3
  mov ebx, 0
  mov rsi, znak
  mov rdx, 1
  syscall
  cmp byte[znak], 'q'
  je end
  mov rdi, szablon
  mov rsi, [znak]
  mov rax, 0
  call printf
  jmp readkb
end:
  ret
