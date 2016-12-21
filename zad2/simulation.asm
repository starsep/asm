global start
global step
global clean

; zależności z libc
extern malloc
extern free
extern memcpy

; tylko do debugu
; najlepiej potem usunąć
extern debug_matrix

; stałe
SIZE_OF_FLOAT equ 4

%macro align_call 1
  sub rsp, 8
  call %1
  add rsp, 8
%endmacro

%macro align_push 1
  sub rsp, 8
  push %1
%endmacro

%macro align_pop 1
  pop %1
  add rsp, 8
%endmacro

section .data
  n dd 0 ; wysokość
  m dd 0 ; szerokość
  M dq 0 ; wskaźnik do danych
  G dq 0 ; wskaźnik do grzejników
  C dq 0 ; wskaźnik do chłodnic
  ratio dd 0.0 ; współczynnik (float), waga
  size dd 0 ; wielkość macierzy, na których będę robić SSE
  input_matrix dq 0 ; wskaźnik do macierzy, w której będzie wynik
  delta_matrix dq 0 ; wskaźnik do macierzy, która będzie = ratio * oryginalna

section .text
start:
  align_call assign_arguments
  align_call calculate_size
  align_call alloc_matrices
  ret

assign_arguments:
  ; przypisujemy argumenty
  mov dword[n], edi
  mov dword[m], esi
  mov qword[M], rdx
  mov qword[G], rcx
  mov qword[C], r8
  movss dword[ratio], xmm0
  ret

calculate_size:
  ; liczymy size = (n + 2) * (m + 2)
  mov eax, dword[n]
  add eax, 2
  mov r9d, dword[m]
  add r9d, 2
  imul eax, r9d
  mov dword[size], eax
  ret


alloc_matrices:
  ; zachowujemy r12, aby mieć wolny rejestr
  align_push r12
  ; input_matrix = malloc(size * sizeof(float));
  mov r12, input_matrix
  align_call alloc_matrix
  ; delta_matrix = malloc(size * sizeof(float));
  mov r12, delta_matrix
  align_call alloc_matrix
  ; ustawiamy r12 na starą wartość
  align_pop r12
  ret

; alokuje size floatów
; argumenty:
;   r12: wskaźnik na wynik
alloc_matrix:
  ; edi = size * sizeof(float)
  mov edi, dword[size]
  imul edi, SIZE_OF_FLOAT
  ; rax = malloc(edi)
  align_call malloc
  ; *r12 = rax
  mov qword[r12], rax
  ret

clean:
clean_matrices:
  ; free(input_matrix)
  mov rdi, qword[input_matrix]
  align_call free
  ; free(delta_matrix)
  mov rdi, qword[delta_matrix]
  align_call free
  ret

init_result:
  ret
;   mov rdi, qword[result_matrix]
;   mov rsi, qword[M]
;   mov r10, qword[rsi]
;   mov qword[rdi], r10
;   ret
;   mov ecx, dword[n]
; init_result_loop:
;   ; dest
;   mov rdi, qword[result_matrix]
;   mov r10d, dword[m]
;   add r10d, 2
;   imul r10d, ecx
;   inc r10d
;   imul r10d, 4
;   add rdi, r10
;   ; src
;   mov rsi, qword[M]
;   mov r10d, dword[m]
;   imul r10d, ecx
;   sub r10d, dword[m]
;   imul r10d, 4
;   add rsi, r10
;   ; size
;   mov edx, dword[m]
;   imul edx, 4
;   push rcx
;   align_call memcpy
;   align_pop rcx
;   loop init_result_loop
;   ret

move_result:
  ret
  ; (rdi, rsi, rdx, rcx, r8, r9) (rax, r10, r11)
;   mov ecx, dword[n]
; move_result_loop:
;   ; dest
;   mov rdi, qword[M]
;   mov r10d, dword[m]
;   imul r10d, ecx
;   sub r10d, dword[m]
;   imul r10d, 4
;   add rdi, r10
;   ; src
;   mov rsi, qword[result_matrix]
;   mov r10d, dword[m]
;   add r10d, 2
;   imul r10d, ecx
;   inc r10d
;   imul r10d, 4
;   add rsi, r10
;   ; size
;   mov edx, dword[m]
;   imul edx, 4
;   align_push rcx
;   align_call memcpy
;   align_pop rcx
;   loop move_result_loop
;   ret

step:
  ; call init_result
  mov rdi, qword[M] ; qword[result_matrix]
  mov esi, 4 ; dword[size]
  align_call debug_matrix
  align_call calculate_result
  align_call move_result
  ret

calculate_result:
  ret
