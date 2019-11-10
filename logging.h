#ifndef __LIZARD_LOGGING_H
#define __LIZARD_LOGGING_H

#include "vga.h"

typedef enum {
	LOG = 0,
	INFO = 1,
	WARN = 2,
	ERROR = 3,
	NUM_LEVELS
}__LIZARD_LOG_LEVEL;

struct log_level_details{
	const char * prefix;
	u8 blink:1;
	u8 intensite:1;
	u8 arriere_plan:4;
	u8 premiere_plan:4;
};

int _klogs(__LIZARD_LOG_LEVEL level, const char * str);

int klog(const char * str);
int kinfo(const char * str);
int kwarn(const char * str);
int kerror(const char * str);

#endif
