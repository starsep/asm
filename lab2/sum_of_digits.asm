global sum_of_digits

section .text

sum_of_digits:
  push rsi
  mov rsi, rdi
  mov rax, 0
  mov rdi, 0
l1:
  lodsb
  cmp al, 0
  je end
  sub al, '0'
  add rdi, rax
  jmp l1
end:
  pop rsi
  mov rax, rdi
  ret
