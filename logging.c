#include "types.h"
#include "screen.h"
#include "logging.h"
#include "vga.h"

const struct log_level_details const lldetarr [NUM_LEVELS] = 
{
	{"LOG"  , VGA_CONTROLE_NOBLINK, VGA_CONTROLE_INTENSITE_HAUT, VGA_COULEUR_NOIR , VGA_COULEUR_BLANC}, /* log */
	{"INFO" , VGA_CONTROLE_NOBLINK, VGA_CONTROLE_INTENSITE_HAUT, VGA_COULEUR_VERT , VGA_COULEUR_NOIR }, /* info */
	{"WARN" , VGA_CONTROLE_NOBLINK, VGA_CONTROLE_INTENSITE_HAUT, VGA_COULEUR_JAUNE, VGA_COULEUR_ROUGE}, /* warn */
	{"ERROR", VGA_CONTROLE_NOBLINK, VGA_CONTROLE_INTENSITE_HAUT, VGA_COULEUR_ROUGE, VGA_COULEUR_BLANC} /* error */
};

/* Kernel logging */
int _klogs(__LIZARD_LOG_LEVEL level, const char * str)
{
	u8 attr = VGAATTR(
			lldetarr[level].blink,
			lldetarr[level].arriere_plan,
			lldetarr[level].intensite,
			lldetarr[level].premiere_plan
			);
	return _vga_prints(attr,str);
}

int klog(const char * str)   { return _klogs(LOG  , str); }
int kinfo(const char * str)  { return _klogs(INFO , str); }
int kwarn(const char * str)  { return _klogs(WARN , str); }
int kerror(const char * str) { return _klogs(ERROR, str); }
