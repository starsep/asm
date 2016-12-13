global start
global step

section .data
  n dd 0 ; wysokość
  m dd 0 ; szerokość
  M dq 0 ; wskaźnik do danych
  G dq 0 ; wskaźnik do grzejników
  C dq 0 ; wskaźnik do chłodnic
  ratio dd 0.0 ; współczynnik (float), waga

section .text
start:
  call assign_arguments
  ret

assign_arguments:
  mov dword[n], edi
  mov dword[m], esi
  mov qword[M], rdx
  mov qword[G], rcx
  mov qword[C], r8
  movss dword[ratio], xmm0
  ret

step:
  ret
