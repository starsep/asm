global enlight

section .data
  red dq 0     ; wskaźnik na czerwony kanał 
  green dq 0   ; wskaźnik na zielony kanał
  blue dq 0    ; wskaźnik na niebieski kanał
  data dq 0    ; wskaźnik na kanał, który zmieniamy
  N dd 0       ; liczba kolumn 
  M dd 0       ; liczba wierszy
  change dd 0  ; numer kanału zmienianego
  delta db 0   ; wartość, o którą zmieniamy

section .text
enlight:
  call assign_arguments ; przypisujemy argumenty
  call set_data         ; ustawiamy dobry kanał
  call make_deltas      ; robimy zmiany w danych
  ret

; przypisujemy argumenty:
; pierwszych 6 jest w rejestrach
; rdi, rsi, rdx, rcx, r8, r9
; ostatni na stosie
assign_arguments:
  mov qword[red], rdi 
  mov qword[green], rsi
  mov qword[blue], rdx
  mov dword[N], ecx
  mov dword[M], r8d
  mov dword[change], r9d
; 16, bo na stosie są jeszcze dwa kody powrotu: do enlight i do C
  mov al, byte[rsp + 16]
  mov byte[delta], al
  ret

set_data:
  mov eax, dword[change]
  cmp eax, 1 ; sprawdzamy czy zmieniamy czerwony
  jne not_1
  mov rax, qword[red]
  mov qword[data], rax
  ret
not_1:
  cmp eax, 2 ; sprawdzamy czy zmieniamy zielony
  jne not_2
  mov rax, qword[green]
  mov qword[data], rax
  ret
not_2: ; zakładam, że jeżeli nie czerwony, nie zielony to niebieski
  mov rax, qword[blue]
  mov qword[data], rax
  ret


make_deltas:
  mov ecx, dword[N]
  mov eax, dword[M]
  imul ecx, eax ; w ecx będzie N * M
loop_start:
  call make_delta
  loop loop_start ; zmniejszamy ecx, jeżeli ecx > 0 to powtarzamy
  ret

make_delta:
  mov rax, qword[data] ; w rax początek danych
  add rax, rcx ; przesuwamy nasz wskaźnik
  dec rax ; zmniejszamy o 1, w rax adres aktualnej komórki
  mov dl, byte[delta] ; do rejestru dl przypisujemy deltę
  cmp dl, 0 ; porównujemy z 0
  jl substracting ; sprawdzamy czy delta ujemna, jeżeli tak to odejmujemy
adding:
  add dl, byte[rax] ; do delty dodajemy wartość aktualnie przetwarzaną
  jc adding_overflow ; sprawdzamy nadmiar
  mov byte[rax], dl ; zapisujemy wynik
  ret
adding_overflow:
  mov byte[rax], 255 ; dodawanie się "przekręciło", więc ustawiamy max
  ret
substracting:
  mov r9b, dl ; do r9b przypisujemy deltę
  mov dl, 0 ; ustawiamy dl na zero
  sub dl, r9b ; odejmujemy od dl r9b (dostajemy -delta czyli dodatnią)
  mov r8b, byte[rax] ; do r8b przypisujemy aktualną wartość przetwarzaną
  sub r8b, dl ; odejmujemy (-deltę), dodatnią liczbę
  jc substracting_overflow ; sprawdzamy niedomiar
  mov byte[rax], r8b ; zapisujemy wynik
  ret
substracting_overflow:
  mov byte[rax], 0 ; wyszło ujemnie, więc przypisujemy minimum
  ret
