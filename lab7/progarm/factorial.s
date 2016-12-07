.data
 
message1: .asciz "Type a number: "
format:   .asciz "%d"
message2: .asciz "The factorial of %d is %d\n"
 
.text
.globl main
 
factorial:
    str lr, [sp,#-4]!
    str r0, [sp,#-4]!

    cmp r0, #0
    bne is_nonzero
    mov r0, #1         @ base case
    b end
is_nonzero:
                       @ call factorial(n-1)
    sub r0, r0, #1
    bl factorial

    ldr r1, [sp]
    mul r0, r0, r1
 
end:
    add sp, sp, #+4    @ clean the stack
    ldr lr, [sp], #+4  @ return address to lr 
    bx lr

main:
    str lr, [sp,#-4]!
    sub sp, sp, #4       @ room for the number entered by the user

    ldr r0, =message1    @ call printf
    bl printf
 
    ldr r0, =format      @ Parameters for scanf 
    mov r1, sp           @ (top of stack is the second parameter)
    bl scanf
 
    ldr r0, [sp]         @ Call factorial on integer read by scanf
    bl factorial       
 
    mov r2, r0           @ Parameters for printf
    ldr r1, [sp]
    ldr r0, =message2
    bl printf
 
    add sp, sp, #+4      @ Clean the stack and return
    ldr lr, [sp], #+4
    bx lr
