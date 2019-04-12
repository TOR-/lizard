[BITS 16]
[ORG 0x0]

jmp start
%include "UTIL.INC"
start:
; init segments to 0x100
  mov ax, 0x100
  mov ds, ax
  mov es, ax

; init stack segment
  mov ax, 0x8000
  mov ss, ax
  mov sp, 0xF000

; display message
  mov si, msg_charge
  call afficher

boucle:
  jmp boucle


msg_charge: db 'Noyau Lizard chargé', 0xA, 0
