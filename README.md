# HeckerOS
Build:
nasm -f bin boot16.asm -o boot16.bin (for 16 bit mode, use boot32 for 32 bit mode and testboot64 for 32 bit mode)

Run with QEMU:
qemu-system-i386 -s -S -drive format=raw,file=boot16.bin

Or, if you prefer, with VNC:
qemu-system-i386 -s -S -drive format=raw,file=boot16.bin -vnc :1
