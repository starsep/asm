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

; makra do utrzymywania wyrównania stosu
;
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

%macro matrix_debug 3
  mov rdi, qword[%1]
  mov esi, %2
  mov edx, %3
  align_call debug_matrix
%endmacro

%macro big_matrix_debug 1
  mov esi, dword[n]
  add esi, 2
  mov edx, dword[m]
  add edx, 2
  matrix_debug %1, esi, edx
%endmacro

section .data
  n dd 0 ; wysokość
  m dd 0 ; szerokość
  M dq 0 ; wskaźnik do danych
  G dq 0 ; wskaźnik do grzejników
  C dq 0 ; wskaźnik do chłodnic
  ratio dd 0.0 ; współczynnik (float), waga
  size dd 0 ; wielkość macierzy, na których będę robić SSE
  result_matrix dq 0 ; wskaźnik do macierzy, w której będzie wynik
  delta_matrix dq 0 ; wskaźnik do macierzy, która będzie = ratio * oryginalna
  pi dd 3.1415 ; wartość ~PI, sztuczna wartość dla komórek

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


%macro alloc_matrix 1
  ; edi = size * sizeof(float)
  mov edi, dword[size]
  imul edi, SIZE_OF_FLOAT
  ; rax = malloc(edi)
  align_call malloc
  ; zapisujemy wynik
  mov qword[%1], rax
%endmacro

alloc_matrices:
  ; result_matrix = malloc(size * sizeof(float));
  alloc_matrix result_matrix
  ; delta_matrix = malloc(size * sizeof(float));
  alloc_matrix delta_matrix
  ret

clean:
clean_matrices:
  ; free(result_matrix)
  mov rdi, qword[result_matrix]
  align_call free
  ; free(delta_matrix)
  mov rdi, qword[delta_matrix]
  align_call free
  ret

; inicjalizuję wartość dla rogów result_matrix
; zasadniczo niepotrzebne, ale ładnie wygląda na debugu
init_result_corners:
  mov rdi, qword[result_matrix]
  mov esi, dword[pi]
  ; lewy górny róg (result_matrix[0])
  mov dword[rdi], esi
  mov edx, dword[m]
  ; edx = m + 1
  inc edx
  imul edx, SIZE_OF_FLOAT
  add rdi, rdx
  ; prawy górny róg (result_matrix[m + 1])
  mov dword[rdi], esi
  mov ecx, dword[n]
  inc ecx
  mov r8d, dword[m]
  add r8d, 2
  ; ecx = (n + 1) * (m + 2)
  imul ecx, r8d
  imul ecx, SIZE_OF_FLOAT
  add rdi, rcx
  ; prawy dolny róg (result_matrix[m + 1 + (n + 1) * (m + 2)])
  mov dword[rdi], esi
  sub rdi, rdx
  ; lewy dolny róg (result_matrix[(n + 1) * (m + 2)])
  mov dword[rdi], esi
  ret

; (rdi, rsi, rdx, rcx, r8, r9) (rax, r10, r11)

; kopiujemy grzejniki do result_matrix
init_result_G:
  ; w rdi result_matrix++
  mov rdi, qword[result_matrix]
  add rdi, SIZE_OF_FLOAT
  mov rsi, qword[G]
  mov edx, dword[m]
  imul edx, SIZE_OF_FLOAT
  ; memcpy(result_matrix + 1, G, sizeof(float) * m)
  align_call memcpy
  ; mamy skopiowane górne grzejniki, teraz dolne
  mov rdi, qword[result_matrix]
  mov ecx, dword[n]
  inc ecx
  mov r8d, dword[m]
  add r8d, 2
  imul ecx, r8d
  inc ecx
  ; ecx = (n + 1) * (m + 2) + 1
  imul ecx, SIZE_OF_FLOAT
  ; arytmetyka wskaźników
  add rdi, rcx
  mov rsi, qword[G]
  mov edx, dword[m]
  imul edx, SIZE_OF_FLOAT
  ; memcpy(result_matrix + (n + 1) * (m + 2) + 1, G, sizeof(float) * m)
  align_call memcpy
  ret

init_result_C:
  ; w r8 będziemy trzymać wskaźnik na lewe pole chłodnic w result_matrix
  ; w r9 -||- prawe pole chłodnic
  ; w r10 trzymamy C + i (* SIZE_OF_FLOAT), dla i = 0 .. n - 1
  mov r8, qword[result_matrix]
  mov edi, dword[m]
  add edi, 2
  imul edi, SIZE_OF_FLOAT
  ; w rdi trzymamy (m + 2) * SIZE_OF_FLOAT
  add r8, rdi
  ; r8 = result_matrix + m + 2
  mov r9, r8
  add r9, rdi
  sub r9, SIZE_OF_FLOAT
  ; r9 = (result_matrix + m + 2) + (m + 1)
  ; będziemy zmieniać n wierszy
  mov ecx, dword[n]
  ; r10 = C
  mov r10, qword[C]
init_result_C_loop:
  mov r11d, dword[r10]
  ; *r8 = C[i]; *r9 = C[i];
  mov dword[r8], r11d
  mov dword[r9], r11d
  ; r8 += m + 2; r9 += m + 2; r10++;
  add r8, rdi
  add r9, rdi
  add r10, SIZE_OF_FLOAT
  loop init_result_C_loop
  ret

init_result_M:
  ret

init_result:
  align_call init_result_corners
  align_call init_result_G
  align_call init_result_C
  align_call init_result_M
  ret

move_result:
  ret

step:
  align_call init_result
  big_matrix_debug result_matrix
  align_call calculate_result
  align_call move_result
  ret

calculate_result:
  ret
