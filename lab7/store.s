.data
 
/* Ensure variables are is 4-byte aligned */
.balign 4
var1:
    .word 0
.balign 4
var2:
    .word 0
 
.text
.global main
 
/* Ensure code starts 4 byte aligned */
.balign 4
main:
    ldr r1, addr_of_var1
    mov r3, #3
    str r3, [r1]
    ldr r2, addr_of_var2
    mov r3, #4
    str r3, [r2]
 
    /* Same instructions as earlier */
    ldr r1, addr_of_var1
    ldr r1, [r1]
    ldr r2, addr_of_var2
    ldr r2, [r2]
    add r0, r1, r2
    bx lr
 
/* Labels needed to access data */
addr_of_var1: .word var1
addr_of_var2: .word var2
