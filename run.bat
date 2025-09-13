@echo off
echo Starting Nova OS Ultimate Edition...
echo.

if not exist novaos.bin (
    echo Error: novaos.bin not found!
    echo Please run Build.bat first.
    pause
    exit /b 1
)

echo Running QEMU with:
echo   - Floppy disk: novaos.bin
echo   - Memory: 64MB
echo   - CPU: x86-64 compatible
echo   - Display: Standard VGA
echo.
echo Press Ctrl+Alt to release mouse from QEMU
echo Press Ctrl+Alt+Del to reset virtual machine
echo.

qemu-system-x86_64 -fda novaos.bin -m 64M -no-reboot -monitor stdio

echo.
echo QEMU session ended.
pause