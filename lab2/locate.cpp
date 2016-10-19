#include <cstdio>

extern "C" int locate(char c, char *s);

int main() {
  char s[159];
  char c;
  printf("Write string and character!\n");
  scanf("%s %c", s, &c);
  int pos = locate(c, s);
  if (pos < 0) {
    printf("There is no %c in %s\n", c, s);
  } else {
    printf("Character %c was found at %d in %s.\n", c, pos, s);
  }
}
