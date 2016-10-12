#include <cstdio>

extern "C" int sum(void);

int main() {
  printf("%d\n", sum());
}
