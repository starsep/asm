#include <stdio.h>
#include <stdlib.h>

void debug_matrix(const float *matrix, int size) {
  for (int i = 0; i < size; i++) {
    printf("%f ", matrix[i]);
  }
  printf("\n");
}
