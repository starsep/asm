global sum

section .data
  t1 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  len equ 10

section .text

sum:
  mov r10, 0
  mov rax, 0
loop:
  add rax, [t1 + r10 * 4]
  inc r10
  cmp r10, len
  jne loop

  ret
