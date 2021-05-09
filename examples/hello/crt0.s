.section .vectors,"ax"

.org    0x00
_reset:
; Load FAULT into r14
    mfrc r14
    andi r14, r14, 0xf00
    lsr r14, r14, 8

; if RESET jump to _start
    cmpi.eq r14, 15
    bt _start

; Hang on unhandled fault
.L1:
    bra .L1

.section .text
.global _start
.type   _start,@function
_start:	  
; Init stack/frame pointers
    movu r15, 15
    movl r15, 0
    movu r14, 15
    movl r14, 0

; Clear BSS
    movi r0, 0
    movu r1, %hi(__bss_start)
    movl r1, %lo(__bss_start)
    movu r2, %hi(end)
    movl r2, %lo(end)
.L2:
    st r0, [r1, 0]
    addi r1, r1, 4
    cmp.eq r1, r2
    bf .L2

; Setup constructors/destructors
;    call _init
;    movu r0, %hi(fini)
;    movl r0, %lo(fini)
;    call atexit

; Jump to main
    movi r0, 0
    movi r1, 0
    call main

; Hang upon return
    call exit
.L3:
    bra .L3
