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

; jump to the kernel
  jmp dword BASE:0


msgDebut db "Lizard lizard lizard", 0xa, 0

bootdrv: db 0

;--- NOP jusqu'à 510 ---
  times 510-($-$$) db 144
  dw 0xAA55
