global debug_matrix
global debug_init

extern printf

section .data
  rows dd 0 ; n + 2
  columns dd 0 ; m + 2
  deb_matrix dq 0
  matrix dq 0 ; adres macierzy
  counter dq 0
  ; do printfa
  int_pattern db `%d\n\0`
  long_pattern db `%lld\n\0`
  float_pattern db `%.2f \0`
  newline_pattern db `\n\0`

section .text
; wypisuje macierz
; argumenty:
;   rdi: adres macierzy
debug_matrix:
  mov qword[deb_matrix], rdi
  call debug_matrix_row
  mov rdi, qword[deb_matrix]
  ret

; wypisuje wiersz macierzy
; argumenty:
;   rdi: adres macierzy
;   rsi: numer wiersza
debug_matrix_row:
  push rbp
  mov rbp, rsp
  mov qword[matrix], rdi
  mov ecx, dword[columns]
debug_matrix_row_loop:
  mov rdi, qword[matrix]
  mov r10d, dword[columns]
  lea rdi, [rdi + 4 * rcx - 4]
  movss xmm0, dword[rdi]
  cvtss2sd xmm0, xmm0
  mov rax, 1
  mov rdi, float_pattern
  mov qword[counter], rcx ; zapisujemy counter
  call printf
  mov rcx, qword[counter] ; przywracamy counter
  loop debug_matrix_row_loop
  xor rax, rax
  mov rdi, newline_pattern
  call printf
  leave
  ret

; ustawia zmienne globalne (rows, columns)
; argumenty:
;   edi: n
;   esi: m
debug_init:
  ; edi += 2
  add edi, 2
  ; rows = edi (= n + 2)
  mov dword[rows], edi
  ; esi += 2
  add esi, 2
  ; columns = esi (= m + 2)
  mov dword[columns], esi
  ret
