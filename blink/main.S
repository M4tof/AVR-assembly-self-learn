; Blink LED on Arduino Uno (PB5) using pure AVR assembly
; Works with avr-gcc without external include files

.global main

; I/O register addresses (in I/O space, not SRAM space)
.equ DDRB, 0x04   ; 0x04 is address of the DDRB for port B
.equ PORTB, 0x05  ; Defines PORTB as the I/O address 0x05, Output Register for Port B
.equ PB5, 5       ; Refers to pin 5 of Port B (digital pin 13 on Arduino Uno)

main:
    ; --- Setup ---
    sbi DDRB, PB5            ; Set bit 5 of DDRB to 1 → configure PB5 as output

loop:
    ; --- LED ON ---
    sbi PORTB, PB5           ; Set bit 5 of PORTB to 1 → drive PB5 high (LED on)
    rcall delay_500ms        ; Call delay subroutine (~500 ms)

    ; --- LED OFF ---
    cbi PORTB, PB5           ; Clear bit 5 of PORTB → drive PB5 low (LED off)
    rcall delay_500ms        ; Wait another ~500 ms

    rjmp loop                ; Repeat forever

; --- Delay subroutine (~500 ms @ 16 MHz) ---
delay_500ms:
    ldi r18, 62              ; put the decimal value 62 into register r18
outer_loop:
    ldi r19, 255             ; Middle loop counter
inner_loop1:
    ldi r20, 255             ; Inner loop counter
inner_loop2:
    dec r20                  ; Decrement inner loop counter
    brne inner_loop2         ; BRanch if Not Equal to zero, if r20 ≠ 0, jump back and keep looping

    dec r19                  ; Decrement middle loop counter
    brne inner_loop1         ; Repeat until r19 = 0

    dec r18                  ; Decrement outer loop counter
    brne outer_loop          ; Repeat until r18 = 0

    ret                      ; Return to caller (end of delay)
