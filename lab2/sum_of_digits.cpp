#include <cstdio>

extern "C" int sum_of_digits(char *n);

int main() {
  char numb[] = "12349";
  printf("%d\n", sum_of_digits(numb));
}
