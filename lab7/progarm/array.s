.data
 
.balign 4
a: .skip 400  @tablica 100 liczb

/* Ustawiamy jej elementy na 100 kolejnych liczb */

.text
.global main

main:
    ldr r1, addr_of_a       @ bazowy adres tablicy a 
    mov r2, #0              @ początkowy indeks 
loop:
    cmp r2, #100            @ koniec? 
    beq end
    add r3, r1, r2, LSL #2  @ adres kolejnego elementu 
    str r2, [r3]
    add r2, r2, #1
    b loop
end:
    bx lr
addr_of_a: .word a
