global start
global step
global clean

; zależności z libc
extern malloc
extern free
extern memcpy

; zależności do debugu
extern debug_matrix
extern debug_init

; stałe
SIZE_OF_FLOAT equ 4

section .data
  n dd 0 ; wysokość
  m dd 0 ; szerokość
  M dq 0 ; wskaźnik do danych
  G dq 0 ; wskaźnik do grzejników
  C dq 0 ; wskaźnik do chłodnic
  ratio dd 0.0 ; współczynnik (float), waga
  size dd 0 ; wielkość macierzy, na których będę robić SSE
  result_matrix dq 0 ; wskaźnik do macierzy, w której będzie wynik
  ratio_matrix dq 0 ; wskaźnik do macierzy, która będzie = ratio * oryginalna
  ratio4_matrix dq 0 ; wskaźnik do macierzy, która będzie = ratio_matrix * 4
  left_matrix dq 0 ; wskaźnik do macierzy (przesunięta ratio_matrix w lewo)
  right_matrix dq 0 ; wskaźnik do macierzy (przesunięta ratio_matrix w prawo)
  up_matrix dq 0 ; wskaźnik do macierzy (przesunięta ratio_matrix w górę)
  down_matrix dq 0 ; wskaźnik do macierzy (przesunięta ratio_matrix w dół)

section .text
start:
  call assign_arguments
  call calculate_size
  call init_debug
  call alloc_matrices
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

init_debug:
  mov edi, dword[n]
  mov esi, dword[m]
  call debug_init
  ret

alloc_matrices:
  ; zachowujemy r12, aby mieć wolny rejestr
  push r12
  ; result_matrix = malloc(size * sizeof(float));
  mov r12, result_matrix
  call alloc_matrix
  ; ratio_matrix = malloc(size * sizeof(float));
  mov r12, ratio_matrix
  call alloc_matrix
  ; ratio4_matrix = malloc(size * sizeof(float));
  mov r12, ratio4_matrix
  call alloc_matrix
  ; left_matrix = malloc(size * sizeof(float));
  mov r12, left_matrix
  call alloc_matrix
  ; right_matrix = malloc(size * sizeof(float));
  mov r12, right_matrix
  call alloc_matrix
  ; up_matrix = malloc(size * sizeof(float));
  mov r12, up_matrix
  call alloc_matrix
  ; down_matrix = malloc(size * sizeof(float));
  mov r12, down_matrix
  call alloc_matrix
  ; ustawiamy r12 na starą wartość
  pop r12
  ret

; alokuje size floatów
; argumenty:
;   r12: wskaźnik na wynik
alloc_matrix:
  ; edi = size * sizeof(float)
  mov edi, dword[size]
  imul edi, SIZE_OF_FLOAT
  ; rax = malloc(edi)
  call malloc
  ; *r12 = rax
  mov qword[r12], rax
  ret

clean:
clean_matrices:
  ; free(result_matrix)
  mov rdi, qword[result_matrix]
  call free
  ; free(ratio_matrix)
  mov rdi, qword[ratio_matrix]
  call free
  ; free(ratio4_matrix)
  mov rdi, qword[ratio4_matrix]
  call free
  ; free(left_matrix)
  mov rdi, qword[left_matrix]
  call free
  ; free(right_matrix)
  mov rdi, qword[right_matrix]
  call free
  ; free(up_matrix)
  mov rdi, qword[up_matrix]
  call free
  ; free(down_matrix)
  mov rdi, qword[down_matrix]
  call free
  ret

init_result:
  ret

move_result:
  ret

step:
  call init_result
  call calculate_result
  call move_result
  ret

calculate_result:
  ret
