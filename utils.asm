section .text
global _asm_inb, _asm_outb

_asm_inb:
    mov dx, [esp + 4]
    in al, dx
    ret

_asm_outb:
    mov dx, [esp + 4]
    mov al, [esp + 8]
    out dx, al
    ret