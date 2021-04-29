; int setjmp(jmp_buf)
    .globl setjmp
    .type  setjmp, @function
setjmp:
; save return address
    ld r1, [sp, 0]
    st r1, [r0, 0]
; save registers
    st r4, [r0, 4]
    st r5, [r0, 8]
    st r6, [r0, 12]
    st r7, [r0, 16]
    st r8, [r0, 20]
    st r9, [r0, 24]
    st r10, [r0, 28]
    st r11, [r0, 32]
    st r12, [r0, 36]
    st r13, [r0, 40]
    st r14, [r0, 44]
    st sp, [r0, 48]
; return 0
    movi r0, 0
    ret
    .size setjmp, .-setjmp

; volatile void longjmp(jmp_buf, int)
    .globl longjmp
    .type longjmp, @function
longjmp:
; load return address
    ld r1, [r0, 0]
    st r1, [sp, 0]
; load registers
    ld r4, [r0, 4]
    ld r5, [r0, 8]
    ld r6, [r0, 12]
    ld r7, [r0, 16]
    ld r8, [r0, 20]
    ld r9, [r0, 24]
    ld r10, [r0, 28]
    ld r11, [r0, 32]
    ld r12, [r0, 36]
    ld r13, [r0, 40]
    ld r14, [r0, 44]
    ld sp, [r0, 48]
; compute return
    movi    r0, 1
    cmpi.eq r1, 0
    mf r0, r1
    ret
    .size longjmp, .-longjmp
