#include <cstdio>

extern "C" int read_int(void);
extern "C" void init(void);
extern "C" int end(void);

int main(void) {
	int sum = 0; // int overflow is ok
	init();
	while (!end()) {
		int input = read_int();
		sum += input;
	}
	printf("%d\n", sum);
	return 0;
}
