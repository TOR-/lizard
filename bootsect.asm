%define BASE	0x100	; 0x0100:0000 = 0x1000
%define KSIZE	1	; № of 512B sectors to load

[BITS 16]  ; indique a Nasm que l'on travaille en 16 bits
[ORG 0x0]

jmp start
%include "UTIL.INC"
start:

; initialisation des segments en 0x07C00
  mov ax, 0x07C0
  mov ds, ax
  mov es, ax
  mov ax, 0x8000
  mov ss, ax
  mov sp, 0xf000    ; pile de 0x8F000 -> 0x80000

; récuperation de l'unité de boot
  mov [bootdrv], dl

; affiche un msg
  mov si, msgDebut
  call afficher

; load the kernel
  xor ax, ax
  int 0x13
  
  push es
  mov ax, BASE
  mov es, ax
  mov bx, 0

  mov ah, 2
  mov al, KSIZE
  mov ch, 0
  mov cl, 2
  mov dh, 0
  mov dl, [bootdrv]
  int 0x13
  pop es

; init of GDT pointer
  ; calculate size of gdt
  mov ax, gdtend
  mov bx, gdt
  sub ax, bx      
  mov word [gdtptr], ax

  ; calculate linear address of gdt
  xor eax, eax
  xor ebx, ebx
  mov ax, ds
  mov ecx, eax
  shl ecx, 4
  mov bx, gdt
  add ecx, ebx
  mov dword [gdtptr+2], ecx

; move to protected mode
  cli
  lgdt [gdtptr]
  mov eax, cr0
  or ax, 1
  mov cr0, eax
  jmp next
next:
  ; data segment selectors
  mov ax, 0x10
  mov ds, ax
  mov fs, ax
  mov gs, ax
  mov es, ax
  ; stack segment
  mov ss, ax
  mov esp, 0x9F000

  ; offset 8 in gdt is code segment
  jmp dword 0x8:0x1000  ; reinit code segment
; jump to the kernel
  jmp dword BASE:0


msgDebut db "Lizard lizard lizard loading", 0xd, 0xa, 0

bootdrv: db 0

;----------------------
;--- GDT --------------
gdt:
  db 0, 0, 0, 0, 0, 0, 0, 0
gdt_cs:
  db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10011011b, 11011111b, 0x0
gdt_ds:
  db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10010011b, 11011111b, 0x0
gdtend:
;----------------------
gdtptr:
  dw 0  ; limit
  dd 0  ; base
;----------------------

;--- NOP jusqu'à 510 ---
  times 510-($-$$) db 144
  dw 0xAA55
