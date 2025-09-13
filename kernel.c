@echo off
echo Building Nova OS...
echo.

echo Step 1: Compiling bootloader...
nasm -f bin boot.asm -o boot.bin
if errorlevel 1 (
    echo Error compiling bootloader!
    pause
    exit /b 1
)

echo Step 2: Compiling kernel...
gcc -ffreestanding -fno-builtin -nostdlib -m32 -c kernel.c -o kernel.o
if errorlevel 1 (
    echo Error compiling kernel!
    pause
    exit /b 1
)

echo Step 3: Linking kernel...
ld -nostdlib -Ttext 0x1000 -e _start -o kernel.bin kernel.o
if errorlevel 1 (
    echo Linking failed!
    pause
    exit /b 1
)

echo Step 4: Checking sizes...
echo Bootloader: %~z0 bytes
dir kernel.bin | find "kernel.bin"

echo Step 5: Creating OS image...
copy /b boot.bin + kernel.bin novaos.bin > nul

echo Step 6: Final check...
dir novaos.bin | find "novaos.bin"

echo.
echo ===== BUILD COMPLETE =====
echo.
echo Run with: qemu-system-x86_64 -fda novaos.bin
echo.
pause