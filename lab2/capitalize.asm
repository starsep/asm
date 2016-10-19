global capitalize

section .text

capitalize:
  push rsi
  mov rsi, rdi
l1:
  lodsb
  cmp al, 0
  je end
  cmp al, 'a'
  jl l1
  cmp al, 'z' - 'a'
  ja l1
  sub byte[rdi - 1], 'a' - 'A'
end:
  pop rsi
  ret
