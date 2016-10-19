global maks

section .text

maks:
  xor rax, rax
  mov eax, edi
  cmp eax, esi
  cmovl eax, esi ; if second is greater then it is a result
  cmp eax, edx
  cmovl eax, edx ; if third is greater then it is a result
  ret
