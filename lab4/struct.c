#include <stdio.h>

struct s1 {
  int a;
  int b, c, d, e;
} z1;

struct s1 f1 (int a, int b) {
  struct s1 z2;

  z2.a = a;
  z2.b = b;
  return z2;
}

int main () {
  z1 = f1(3, 5);
  printf("%d,%d\n", z1.a, z1.b);
}

