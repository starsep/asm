#include <cstdio>

extern "C" void capitalize(char *s);

int main() {
  char s[] = "examPle asd LLE sss aqwe EE 123 !@#!@#!3 abC";
  capitalize(s);
  printf("%s\n", s);
  return 0;
}
