#include <cstdio>

extern "C" char get_character(void);

extern "C" void init(void) { }

extern "C" int end(void) {
	return feof(stdin);
}

extern "C" int read_int(void) {
	register int result = 0;
	register char c = 1;
	while (c <= ' ' && !feof(stdin)) {
    c = get_character();
    if (c == 0) {
      return -1;
    }
  }
	while (c > ' ' && !feof(stdin)) {
		result = result * 10 + (c - '0');
		c = get_character();
  }
	return result;
}
