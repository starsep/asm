#include <cstdio>

extern "C" char get_character(void) {
	return fgetc_unlocked(stdin);
}
