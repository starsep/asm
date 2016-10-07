#include <cstdio>

extern "C" void init(void) { }

extern "C" int end(void) {
	return feof(stdin);
}

extern "C" int read_int(void) {
	register int result = 0;
	register char c = 0;
	while (c <= ' ' && !feof(stdin)) { 
		c = fgetc_unlocked(stdin);
	}
	while (c > ' ') {
		result =  result * 10 + (c - '0');
		c = fgetc_unlocked(stdin);
	}
	return result;
}
