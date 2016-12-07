.data
 
greeting:
 .asciz "Hello world"
 
.balign 4
return: .word 0
 
.text
.global main
.global puts

main:
    ldr r1, =return     @ save return address from main
    str lr, [r1]
 
    ldr r0, =greeting   @ parameter of puts
    bl puts
 
    ldr r1, =return
    ldr lr, [r1]
    bx lr                         @ return from main
