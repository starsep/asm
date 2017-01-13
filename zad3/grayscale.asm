.data

.balign 4
red: .word 0
green: .word 0
blue: .word 0

.text
.global grayscale
.func grayscale

grayscale:
assign:
  /* zapisujemy w red argument przekazany w r3 */
  ldr ip, addr_red
  str r3, [ip]
  /* zapisujemy w green argument przekazany na wierzchu stosu */
  ldr ip, addr_green
  ldmfd r13!, {r3}
  str r3, [ip]
  /* zapisujemy w blue argument przekazany jako drugi na stosie */
  ldr ip, addr_blue
  ldmfd r13!, {r3}
  str r3, [ip]
  /* wrzucamy na stos rejestry, aby móc je potem przywrócić */
  stmfd r13!, {r4-r8}
  /* zapisujemy dane w rejestrach, skoro są już wolne */
  /* red do r3 */
  ldr ip, addr_red
  ldr r3, [ip]
  /* green do r4 */
  ldr ip, addr_green
  ldr r4, [ip]
  /* blue do r5 */
  ldr ip, addr_blue
  ldr r5, [ip]
  /* Założenia:
    w r0 trzymamy counter stosu, początkowo size przekazany jako argument
    w r1 trzymamy wskaźnik na aktualne dane wejściowe
    w r2 trzymamy wskaźnik na wyjście
    w r3, r4 oraz r5: red, blue, green
    r6, r7, r8 to scratch rejestry do obliczeń */
grayscale_loop:
  /* do r6 ładujemy wartość czerwonego kolejnego piksela */
  ldrb r6, [r1]
  /* mnożymy przez współczynnik czerwonego */
  mul r6, r3, r6
  /* inkrementujemy wskaźnik na wejście */
  add r1, r1, #1
  /* do r7 ładujemy wartość zielonego kolejnego piksela */
  ldrb r7, [r1]
  /* mnożymy przez współczynnik zielonego */
  mul r7, r4, r7
  /* inkrementujemy wskaźnik na wejście */
  add r1, r1, #1
  /* do r8 ładujemy wartość niebieskiego kolejnego piksela */
  ldrb r8, [r1]
  /* mnożymy przez współczynnik niebieskiego */
  mul r8, r5, r8
  /* inkrementujemy wskaźnik na wejście */
  add r1, r1, #1
  /* dodajemy wyniki z niebieskiego i zielonego do czerwonego */
  add r6, r6, r7
  add r6, r6, r8
  asr r6, r6, #8
  /* tutaj robimy dzielenie przez (red + green + blue),
    ale *założenie* ich suma = 256. */
  /* zapisujemy wynik (z r6) na wyjście */
  str r6, [r2]
  /* inkrementujemy wskaźnik na wyjście */
  add r2, r2, #1
  /* zmniejszamy counter pętli */
  sub r0, r0, #1
  /* sprawdzamy czy już wyzerowaliśmy r0 */
  cmp r0, #0
  /* jeżeli nie to powtarzamy */
  bne grayscale_loop
  /* przywracamy rejestry */
  ldmfd r13!, {r4-r8}
  /* wrzucamy na stos rejestry, aby wierzchołek był w tym samym miejscu */
  stmfd r13!, {r0-r1}
  /* wracamy do C */
  bx lr

/* adresy (Global Object Table) */
addr_red: .word red
addr_green: .word green
addr_blue: .word blue
