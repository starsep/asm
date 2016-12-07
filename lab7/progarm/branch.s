.text
.global main
        
main:
    mov r0, #2
    b end
    mov r0, #3
end:
    bx lr