#ifndef __LIZARD_VGA_H
#define __LIZARD_VGA_H


#define VGAATTR(blink,bg,intensity,fg) ((blink<<7)|(bg<<4)|(intensity<<3)|(fg))
#define VGAW(c,blink,bg,intensity,fg) ((c)|(blink<<15)|(bg<<12)|(intensity<<11)|(fg<<8))
#define VGA_COULEUR_NOIR  0
#define VGA_COULEUR_BLEU  1
#define VGA_COULEUR_VERT  2
#define VGA_COULEUR_CYAN  3
#define VGA_COULEUR_ROUGE 4
#define VGA_COULEUR_MAGEN 5
#define VGA_COULEUR_JAUNE 6
#define VGA_COULEUR_BLANC 7

#define VGA_CONTROLE_BLINK   1
#define VGA_CONTROLE_NOBLINK 0

#define VGA_CONTROLE_INTENSITE_HAUT  1
#define VGA_CONTROLE_INTENSITE_BASSE 0

#endif
