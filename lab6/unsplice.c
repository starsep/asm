/* Scenariusz na lab 6 */

#include <stdio.h>

extern void unsplice (char* dane, char* dane1, char* dane2);

int main () {
  char dane[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
  char dane1[8], dane2[8];
  int i;

  unsplice(dane, dane1, dane2);
  printf("OK\n");
  for (i = 0; i < 8; i++)
    printf("%d,", dane1[i]);
  printf("\n");
  for (i = 0; i < 8; i++)
    printf("%d,", dane2[i]);
  printf("\n");
}

/*EOF*/
