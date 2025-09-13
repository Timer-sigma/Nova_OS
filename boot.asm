[bits 16]
[org 0x7C00]

; Константы
KERNEL_OFFSET equ 0x1000
KERNEL_SECTORS equ 4         ; Всего 4 сектора для ядра

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; Сохраняем номер диска
    mov [boot_drive], dl

    ; Очистка экрана
    mov ax, 0x0003
    int 0x10

    ; Сообщение о загрузке
    mov si, loading_msg
    call print_string

    ; Загрузка ядра (CHS метод)
    mov ax, KERNEL_OFFSET    ; Сегмент
    mov es, ax
    xor bx, bx               ; Смещение 0
    
    mov ah, 0x02             ; Функция чтения
    mov al, KERNEL_SECTORS   ; Количество секторов
    mov ch, 0                ; Цилиндр 0
    mov cl, 2                ; Сектор 2 (после загрузочного)
    mov dh, 0                ; Головка 0
    mov dl, [boot_drive]     ; Номер диска
    int 0x13
    jc error

    ; Проверка загрузки
    cmp al, KERNEL_SECTORS
    jne error

    ; Успешная загрузка
    mov si, success_msg
    call print_string

    ; Переход к ядру
    jmp KERNEL_OFFSET:0x0000

error:
    mov si, error_msg
    call print_string
    mov ah, 0x00
    int 0x16
    int 0x19

print_string:
    mov ah, 0x0E
    mov bh, 0
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

boot_drive db 0
loading_msg db "Loading Nova OS...", 13, 10, 0
success_msg db "OK", 13, 10, 0
error_msg db "Boot error! Press any key...", 0

times 510-($-$$) db 0
dw 0xAA55