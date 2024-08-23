# heckeros
build and run with qemu:
nasm -f bin boot.asm -o boot.bin
qemu-system-i386 -s -S -drive format=raw,file=boot.bin
qemu with vnc
qemu-system-i386 -s -S -drive format=raw,file=boot.bin --vnc :1
