.section    .text
.global head
.type head, %function
head:
    @canvas, y, m
    push {r4-r8, lr}
    mov r4, r0 @ canvas
    mov r5, r1 @ y
    mov r6, r2 @ m
    ldr r7, =msg
    mov r8, #0
@  show year
    add r4, r4, #7
    mov r0, r5
    mov r1, r4
    bl pdec
    add r4, r4, #5
@   show month
    mov r0, r6
    mov r1, r4
    bl pdec
    add r4, r4, #9
loop:
    cmp r8, #21
    bgt loopout
    ldrb r0, [r7, r8]
    strb r0, [r4, r8]
    add r8, r8, #1
    b loop
loopout:
    add r4, r4, #21
    pop {r4-r8, lr}
    bx  lr

.section    .data
msg:
    .ascii "Su Mo Tu We Th Fr Sa  "
