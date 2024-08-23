[BITS 16]
[ORG 0x7C00]

start:
    cli                 ; Clear interrupts
    lgdt [gdt_descriptor] ; Load Global Descriptor Table
    mov eax, cr0
    or eax, 1            ; Set PE bit to enter protected mode
    mov cr0, eax
    jmp 0x08:protected_mode ; Far jump to flush the pipeline and enter protected mode

[BITS 32]
protected_mode:
    mov eax, 0xC0000000  ; Load the address of the GDT
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, msg
    mov esi, eax
    call print
    call shutdown

print:
    mov edx, 0xB8000    ; Video memory address
    mov ecx, 0x7F       ; Number of characters to print
.next_char:
    lodsb
    cmp al, 0
    je .done
    mov [edx], ax
    add edx, 2
    loop .next_char
.done:
    ret

shutdown:
    cli
    hlt
    jmp $

msg db 'Hello, World! OS failed to boot because: Not completed!', 0x0A, 0x0D
    db 'Did you know? This OS is 32-bit', 0x0A, 0x0D, 0

gdt:
    dq 0x0000000000000000   ; Null Descriptor
    dq 0x00CF9A000000FFFF   ; Code Segment Descriptor
    dq 0x00CF92000000FFFF   ; Data Segment Descriptor

gdt_descriptor:
    dw gdt_end - gdt - 1
    dd gdt

gdt_end:
times 510 - ($ - $$) db 0
dw 0xAA55
