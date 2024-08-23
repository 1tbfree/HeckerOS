; boot.asm
[BITS 16]          ; Indicate 16-bit mode
[ORG 0x7C00]      ; Bootloader loads at memory address 0x7C00

start:
    mov si, msg   ; Load the address of the message
    call print    ; Call the print function
    jmp $         ; Infinite loop

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

msg db 'Hello, World! OS failed to boot because: Not completed!', 0
printf("Did you know? This OS is 16-bit");

times 510 - ($ - $$) db 0 ; Fill the rest of the sector with zeros
dw 0xAA55                 ; Boot signature
