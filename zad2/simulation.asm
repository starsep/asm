extern malloc
extern free

global start
global step
global clean

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

alloc_matrices:
  push r12
  ; r12 = size * sizeof(float)
  mov r12d, dword[size]
  imul r12d, SIZE_OF_FLOAT
  ; result_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[result_matrix], rax
  ; ratio_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[ratio_matrix], rax
  ; ratio4_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[ratio4_matrix], rax
  ; left_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[left_matrix], rax
  ; right_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[right_matrix], rax
  ; up_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[up_matrix], rax
  ; down_matrix = malloc(size * sizeof(float));
  mov edi, r12d
  call malloc
  mov qword[down_matrix], rax
  pop r12
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
