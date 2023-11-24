.section    .text
.global monthlen
.type monthlen, %function
monthlen:
    push {lr}
    mov r2, r0 @ y
    mov r3, r1 @ m
    mov r4, #0 @ q

    mov r1, #4
    bl  modsub @ y%4
    cmp r0, #0
    addeq r4, r4, #1

    mov r0, r2
    mov r1, #100
    bl  modsub @ y%100
    cmp r0, #0
    subeq r4, r4, #1 @ q -= y%100

    mov r0, r2
    mov r1, #400
    bl  modsub @ q += y%400
    cmp r0, #0
    addeq r4, r4, #1

    cmp r3, #2
    beq leap

    cmp r3, #4
    beq thirty
    cmp r3, #6
    beq thirty
    cmp r3, #9
    beq thirty
    cmp r3, #11
    beq thirty

    mov r0, #31

    b   end
leap:
    mov r0, #28
    cmp r4, #1
    moveq r0, #29
    b   end
thirty:
    mov r0, #30
end:
    pop {lr}
    bx  lr
