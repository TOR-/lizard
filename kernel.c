#include "types.h"
#include "gdt.h"

#include "screen.h"
#include "vga.h"
#include "logging.h"

int kmain(void);

void _start(void)
{
	prints("message au kernel via prints\n");
	_vga_prints(VGAATTR(VGA_CONTROLE_NOBLINK, VGA_COULEUR_JAUNE, VGA_CONTROLE_INTENSITE_HAUT, VGA_COULEUR_BLEU), "message au noyau via _vga_prints\n");
	_klogs(LOG,"message au kernel via _klogs avec niveau egale a LOG\n");
	klog("message au kernel via klog\n");
	kinfo("message au kernel via kinfo\n");
	kwarn("message au kernel via kwarn\n");
	kerror("message au kernel via kerror\n");
	kmain();
	while (1);
}

int kmain(void)
{
	return 0;
}
