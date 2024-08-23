[BITS 16]
[ORG 0x7C00]

start:
    cli                 ; Clear interrupts
    lgdt [gdt_descriptor] ; Load GDT
    mov eax, cr0
    or eax, 1            ; Set PE bit
    mov cr0, eax
    jmp 0x08:protected_mode

[BITS 32]
protected_mode:
    mov eax, 0xC0000000  ; Address of the GDT
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, 0xC0000080  ; Enable PAE
    mov cr4, eax

    ; Load 64-bit mode
    mov eax, cr3
    mov cr3, eax         ; Set up paging
    mov eax, 0x00000010  ; Enable long mode
    mov cr4, eax

    mov eax, cr0
    or eax, 0x80000001   ; Set PE and LME bits
    mov cr0, eax

    ; Jump to 64-bit mode
    jmp 0x10:64_bit

[BITS 64]
64_bit:
    mov rsi, msg
    call print
    hlt

print:
    mov rax, 1           ; sys_write
    mov rdi, 1           ; file descriptor 1 (stdout)
    mov rdx, msg_length  ; length of the message
    mov rax, 1           ; sys_write
    syscall
    ret

msg db 'Hello, World! OS failed to boot because: Not completed!', 0x0A, 0x0D
    db 'Did you know? This OS is 64-bit', 0x0A, 0x0D
msg_length equ $ - msg

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
