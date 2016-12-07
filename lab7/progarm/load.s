.data
 
/* Ensure data is 4-byte aligned */
.balign 4
var1:
    .word 3
 
.balign 4
var2:
    .word 4
 
.text
.global main
 
.balign 4
main:
    ldr r1, addr_of_var1
    ldr r1, [r1]
    ldr r2, addr_of_var2
    ldr r2, [r2]
    add r0, r1, r2
    bx lr
 
/* Labels needed to access data */
addr_of_var1 : .word var1
addr_of_var2 : .word var2
