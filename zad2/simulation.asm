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
  mov rdi, qword[result_matrix]
  mov rsi, qword[M]
  mov r10, qword[rsi]
  mov qword[rdi], r10
  ret
  mov ecx, dword[n]
init_result_loop:
  ; dest
  mov rdi, qword[result_matrix]
  mov r10d, dword[m]
  add r10d, 2
  imul r10d, ecx
  inc r10d
  imul r10d, 4
  add rdi, r10
  ; src
  mov rsi, qword[M]
  mov r10d, dword[m]
  imul r10d, ecx
  sub r10d, dword[m]
  imul r10d, 4
  add rsi, r10
  ; size
  mov edx, dword[m]
  imul edx, 4
  push rcx
  call memcpy
  pop rcx
  loop init_result_loop
  ret

move_result:
  ; (rdi, rsi, rdx, rcx, r8, r9) (rax, r10, r11)
  mov ecx, dword[n]
move_result_loop:
  ; dest
  mov rdi, qword[M]
  mov r10d, dword[m]
  imul r10d, ecx
  sub r10d, dword[m]
  imul r10d, 4
  add rdi, r10
  ; src
  mov rsi, qword[result_matrix]
  mov r10d, dword[m]
  add r10d, 2
  imul r10d, ecx
  inc r10d
  imul r10d, 4
  add rsi, r10
  ; size
  mov edx, dword[m]
  imul edx, 4
  push rcx
  call memcpy
  pop rcx
  loop move_result_loop
  ret

step:
  ; call init_result
  mov rdi, qword[M] ; qword[result_matrix]
  mov esi, 4 ; dword[size]
  call debug_matrix
  call calculate_result
  call move_result
  ret

calculate_result:
  ret
