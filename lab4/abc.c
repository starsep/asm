#include <stdio.h>
int main(void) {
	int x = 42;
	for (int i = 1; i <= 10; i++) {
		x *= i;
	}
	x++;
	printf("%d\n", x);
	return 0;
}
