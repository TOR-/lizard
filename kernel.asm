[BITS 32]

%define vgac(c,blink,bg,int,fg) ((c)|(blink<<15)|(bg<<12)|(int<<11)|(fg<<8))
%define NOIR  0
%define BLEU  1
%define VERT  2
%define CYAN  3
%define ROUGE 4
%define MAGEN 5
%define JAUNE 6
%define BLANC 7

  mov word [0xB8A00], vgac('N', 0, BLEU,  0, JAUNE)
  mov word [0xB8A02], vgac('o', 1, VERT,  0, BLANC)
  mov word [0xB8A04], vgac('y', 0, CYAN,  1, NOIR)
  mov word [0xB8A06], vgac('a', 1, ROUGE, 1, BLEU)
  mov word [0xB8A08], vgac('u', 1, MAGEN, 1, VERT)

EXTERN scroll_up, prints
GLOBAL _start

_start:
  mov eax, msg
  push eax
  call prints
  pop eax
  
  mov eax, msg2
  push eax
  call prints
  pop eax

  mov eax, 2
  push eax
  call scroll_up

end:
  jmp end

msg: db 'un premier message', 10, 0
msg2: db 'un deuxième message', 10, 0
