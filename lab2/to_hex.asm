global to_hex

section .data
  output db `012345678`
  output_len db 0
section .text

to_hex:
  mov byte[output], `0`
  mov byte[output_len], 0
  cmp rdi, 0
  jne l1
  inc byte[output_len]
  call write
  ret
l1:

end:
  call write
  ret
write:
  xor eax, eax
  mov al, byte[output_len]
  mov byte[output + eax], `\n`
  inc byte[output_len]
  mov eax, 4 ; SYS_WRITE
  mov ebx, 1 ; STDOUT
  mov ecx, output ; char *
  xor edx, edx
  mov dl, byte[output_len] ; len
  int 0x80 ; kernel call
  ret
