#include <iostream>

extern "C" int end(void) {
	return std::cin.eof();
}

extern "C" void init(void) {}

extern "C" int read_int(void) {
	int x;
	std::cin >> x;
	return x;
}
