#include <cstdio>

extern "C" int end(void) {
	return feof(stdin);
}

extern "C" void init(void) {}

extern "C" int read_int(void) {
	int x;
	scanf("%d", &x);
	return x;
}
