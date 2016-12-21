#include <stdio.h>
#include <stdlib.h>

void debug_matrix(const float *matrix, int n, int m) {
  fprintf(stderr, "-- DEBUGING MATRIX %d x %d --\n", n, m);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      fprintf(stderr, "%.2f ", matrix[i * n + j]);
    }
    fprintf(stderr, "\n");
  }
  fprintf(stderr, "-- END DEBUGING --\n");
}
