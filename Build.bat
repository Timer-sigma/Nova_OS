@echo off
echo Building Nova OS...
nasm -f bin boot.asm -o boot.bin
echo > kernel.bin
copy /b boot.bin + kernel.bin novaos.bin
echo Done! Run: qemu-system-x86_64 -fda novaos.bin
pause