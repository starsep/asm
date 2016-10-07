#include <cstdio>

extern "C" int read_int(void);
extern "C" void init(void);
extern "C" int end(void);

int main(void) {
	int sum = 0; // int overflow is ok
	init();
	int input = 0;
	while (!end()) {
		input = read_int();
		if (input == -1) {
			break;
		}
		sum += input;
	}
	printf("%d\n", sum);
	return 0;
}
