section .text
global _keyboard_handler

extern _keyboard_buffer, _keyboard_buffer_index

_keyboard_handler:
    pusha
    in al, 0x60
    mov bl, al
    mov edi, _keyboard_buffer
    mov ecx, [_keyboard_buffer_index]
    mov [edi + ecx], bl
    inc ecx
    mov [_keyboard_buffer_index], ecx
    mov al, 0x20
    out 0x20, al
    popa
    iretd