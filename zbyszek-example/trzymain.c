#include <stdio.h>

extern int trzy(void);

int main (int argc, char* args[]) {
  int wynik = trzy();
  printf("Wynik=%d\n", wynik);
  return wynik;
}
