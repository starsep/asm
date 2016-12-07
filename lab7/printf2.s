.data
 
.balign 4
message1: .asciz "Hey, type a number: "
 
.balign 4
message2: .asciz "%d times 5 is %d\n"
 
/* Format pattern for scanf */
.balign 4
scanf_pattern : .asciz "%d"
 
.balign 4
number_read: .word 0
 
.balign 4
return: .word 0

.text 
.global printf
.global scanf
.global main

/* mult_by_5 local function */
mult_by_5: 
    add r0, r0, r0, LSL #2           @ r0 * 5
    bx lr                            @ return using lr

main:
    ldr r1, =return
    str lr, [r1]
 
    ldr r0, =message1                @ call to printf
    bl printf
 
    ldr r0, =scanf_pattern           @ call to scanf
    ldr r1, =number_read
    bl scanf
 
    ldr r0, =number_read             @ call to mult_by_5
    ldr r0, [r0]
    bl mult_by_5
 
    mov r2, r0                       @ call to printf
    ldr r1, =number_read
    ldr r1, [r1]
    ldr r0, =message2
    bl printf
 
    ldr lr, =return
    ldr lr, [lr]
    bx lr                            @ return from main
