.section    .text
.global divsub
.type divsub, %function
divsub:
    mov r2, #0
loop:
    cmp r0, r1
    blt loopout
    add r2, r2, #1
    sub r0, r0, r1
    b loop
loopout:
    mov r0,r2
    bx lr
