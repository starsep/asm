global debug_matrix
global debug_init

extern printf

section .data
  rows dd 0 ; n + 2
  columns dd 0 ; m + 2
  ; do printfa
  float_pattern db `%f \0`
  newline_pattern db `\n\0`

section .text
; wypisuje macierz
; argumenty:
;   rdi: adres macierzy
debug_matrix:
  call debug_matrix_row
  ret

debug_matrix_row:

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
