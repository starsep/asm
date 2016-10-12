global sum

section .data
  t1 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  len equ 10

section .text

sum:
  mov rcx, len
  mov rax, 0
l1:
  add rax, [(t1 - 4) + rcx * 4]
  loop l1
  ret
