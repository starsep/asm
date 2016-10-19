global sum

section .text

sum:
  mov rcx, rsi
  mov rax, 0
l1:
  add rax, [(rdi - 4) + rcx * 4]
  loop l1
  ret
