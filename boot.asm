[BITS 16]          ; Indicate 16-bit mode
[ORG 0x7C00]      ; Bootloader loads at memory address 0x7C00

start:
    mov si, msg   ; Load the address of the message
    call print    ; Call the print function
    call shutdown  ; Call the shutdown function

print:
    mov ah, 0x0E  ; BIOS teletype function
.next_char:
    lodsb         ; Load byte at DS:SI into AL and increment SI
    cmp al, 0     ; Check for null terminator
    je .done      ; If null, we're done
    int 0x10      ; Print character in AL
    jmp .next_char; Repeat for next character
.done:
    ret

shutdown:
    ; Simulate shutdown by halting the CPU
    cli             ; Clear interrupts
    hlt             ; Halt the CPU
    jmp $           ; Infinite loop (if hlt does not work)

msg db 'Hello, World! OS failed to boot because: Not completed!', 0x0A, 0x0D
    db 'Did you know? This OS is 16-bit', 0x0A, 0x0D, 0
    db 'Now precompiled!!!', 0x0A, 0x0D,

times 510 - ($ - $$) db 0 ; Fill the rest of the sector with zeros
dw 0xAA55                 ; Boot signature
