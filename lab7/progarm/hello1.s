.data
 
greeting:
 .asciz "Hello world"
 
.balign 4
return: .word 0
 
.text
.global main
.global puts

main:
    ldr r1, address_of_return     @ save return address from main
    str lr, [r1]
 
    ldr r0, address_of_greeting   @ parameter of puts
    bl puts
 
    ldr r1, address_of_return
    ldr lr, [r1]
    bx lr                         @ return from main
address_of_greeting: .word greeting
address_of_return: .word return
