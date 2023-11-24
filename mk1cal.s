.section    .text
.global mk1cal
.type mk1cal, %function
mk1cal:
    push {r4-r12, lr}
    mov r4, r0  @ y
    mov r5, r1  @ m
    mov r6, r2  @ canvas

    mov r0, r2  @ canvas
    mov r1, r4  @ y
    mov r2, r5  @ m
    bl head

    mov r0, r4
    mov r1, r5
    bl monthlen
    mov r7, r0  @dlen

    mov r0, r4
    mov r1, r5
    mov r2, #1
    bl zella
    mov r11, r0  @woff

    mov r8, #2  @r=0
    mov r9, #1  @d=1

loop:
    cmp r7, r9
    blt end

    add r0, r11, r9 @ c=(woff+d-1+7)%IW
    add r0, r0, #6
    mov r1, #7
    bl modsub
    mov r10, r0     @ c=r10

    mov r0, #21
    mul r0, r8, r0 @b=r*OW+c*CW
    mov r1, #3
    mul r1, r10, r1
    add r12, r0, r1 @ b=r12
    
    cmp r9, #10     @if(d>=10)
    blt loop2

    mov r0, r9      @ d/10 + '0'
    mov r1, #10
    bl divsub
    add r1, r0, #48
    strb r1, [r6, r12] @ canvas[b]=
loop2:
    add r12, r12, #1     @ b++
    @ d%10 + '0'
    mov r0, r9
    mov r1, #10
    bl modsub
    add r1, r0, #48 
      
    strb r1, [r6, r12]

    cmp r10, #6 @if(c >= IW-1)
    blt loop3
    add r8, r8, #1     @r++
loop3:
    add r9, r9, #1     @d++
    b loop

end:
    pop {r4-r12, lr}
    bx  lr
