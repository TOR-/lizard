#include "types.h"
#include "vga.h"

u8 const *VGABUFADDR = (u8 *)0xB8000;
#define VGABUFSIZE	0xFA0
u8 const *VGABUFLIM  = (u8 *)0xB8FA0;

#define SCREENW		80	/* No of columns of screen */
#define SCREENH		25	/* No of rows of screen */
#define SCREEND		2	/* Depth of screen: no B assoc with each char */

char curX = 0;
char curY = 17;			// FIXME Why 17?
char curattr = VGAATTR(0, VGA_COULEUR_NOIR, 1, VGA_COULEUR_JAUNE);	// Attributes of next character to display

const u8 TABSTOP = 8;

/* Scroll screen up by n lines */
void scroll_up(u32 n)
{
	u8 *video, *tmp;

	for (video = (u8 *)VGABUFADDR;
			video < VGABUFLIM;
			video += 2)
	{
		tmp = (u8 *) (video + n * SCREEND * SCREENW);

		if (tmp < VGABUFLIM)
		{
			*video = *tmp;
			*(video + 1) = *(tmp + 1);
		} else {
			*video = 0;
			*(video + 1) = VGAATTR(0, VGA_COULEUR_NOIR, 0, VGA_COULEUR_BLANC);
		}
	}
	curY -= n;
	if (curY < 0)
		curY = 0;
}

void _vga_putch(u8 attr, char c)
{
	char *video;
	int i;			// TODO remove this

	if (c == '\n') {
		curX = 0;
		curY++;
	} else if (c == '\t') {
		curX += TABSTOP - (curX % TABSTOP);
	} else if (c == '\r') {
		curX = 0;
	} else {
		video = (char *)VGABUFADDR + (SCREEND * curX) + (SCREEND * SCREENW * curY);
		*video = c;
		*(video + 1) = attr;
		
		curX++;
		if (curX > SCREENW - 1)
		{
			curX = 0;
			curY++;
		}
	}

	if (curY > SCREENH - 1)
		scroll_up(curY - SCREENH - 1);
}

int _vga_prints(u8 attr, char * str)
{
	int i = 0;
	while (*str != 0)
	{
		_vga_putch(attr, *str);
		i++;
		str++;
	}
	return i;
}

void putch(char c)
{
	_vga_putch(curattr, c);
	return;
}

int prints(char *str)
{
	return _vga_prints(curattr, str);
}

