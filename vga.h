#ifndef _I386_VGA_H
#define _I386_VGA_H


#define VGAATTR(blink,bg,intensity,fg) ((blink<<7)|(bg<<4)|(intensity<<3)|(fg))
#define VGAW(c,blink,bg,intensity,fg) ((c)|(blink<<15)|(bg<<12)|(intensity<<11)|(fg<<8))
#define NOIR  0
#define BLEU  1
#define VERT  2
#define CYAN  3
#define ROUGE 4
#define MAGEN 5
#define JAUNE 6
#define BLANC 7

#endif
