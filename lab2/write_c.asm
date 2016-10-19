global write_c

section .bss
  buffer resb 500

section .text

write_c:
  mov ecx, esi
  mov byte[buffer + ecx], `\n`
l1:
  mov byte[buffer + ecx - 1], dil
  loop l1
  call write
  ret

write:
  mov eax, 4 ; write()
  mov ebx, 1 ; stdout
  mov ecx, buffer ; char *
  xor edx, esi
  int 0x80
  ret
