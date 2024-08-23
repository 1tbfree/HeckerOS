[BITS 16]
[ORG 0x7C00]

start:
    mov si, msg
    call print
    call shutdown

print:
    mov ah, 0x0E
.next_char:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .next_char
.done:
    ret

shutdown:
    cli
    hlt
    jmp $

msg db 'Hello, World! OS failed to boot because: Not completed!', 0x0A, 0x0D
    db 'Did you know? This OS is 16-bit', 0x0A, 0x0D, 0

times 510 - ($ - $$) db 0
dw 0xAA55
