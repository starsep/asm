global locate

section .text

locate:
  cld
  push rsi
l1:
  lodsb
  cmp al, 0
  je fail
  cmp al, dil
  jne l1
success:
  mov rax, rsi
  pop rsi
  sub rax, rsi
  dec rax
  ret
fail:
  mov rax, -1
  pop rsi
  ret
