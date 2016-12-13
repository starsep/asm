#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define check_fscanf(len, ...) if (fscanf(__VA_ARGS__) != len) { \
  fprintf(stderr, "Problem with fscanf occurred. Exiting.\n"); \
  exit(1);\
}

extern void start(int n, int m, float *M, float *G, float *C, float ratio);
extern void step(void);

typedef struct {
  int n, m;
  float *M, *G, *C;
} data;

/* wypisuje poprawne użycie programu */
void usage(const char *error, const char *name) {
  fprintf(stderr,
    "%s! Exiting.\n"
    "Usage: %s filename ratio steps\n"
    "\tfilename is name of simulation file\n"
    "\tratio is float representing how much heat is transfered\n"
    "\tsteps is number of steps in simulation\n"
    "Program takes data from file, waits for enters at standard input, "
    "prints on standard output.\n",
    error, name);
  exit(1);
}

/* funkcja parsująca parametry */
void parse_parameters(int argc, char **argv, char **filename,
  float *ratio, int *steps) {
  if (argc != 4) {
    usage("Bad number of arguments", argv[0]);
  }
  size_t filename_length = strlen(argv[1]);
  *filename = malloc(sizeof(char) * (filename_length + 1));
  strcpy(*filename, argv[1]);
  *ratio = atof(argv[2]);
  *steps = atoi(argv[3]);
}

/* konstuktor dla struktury data */
data *init_data(const int n, const int m) {
  data *result = (data *) malloc(sizeof(data));
  result->n = n;
  result->m = m;
  result->M = (float *) malloc(sizeof(float) * n * m);
  result->G = (float *) malloc(sizeof(float) * m);
  result->C = (float *) malloc(sizeof(float) * n);
  return result;
}

/* destruktor dla struktury data */
void delete_data(data *d) {
  free(d->M);
  free(d->G);
  free(d->C);
  free(d);
}

data *input_data(const char *filename) {
  FILE *input = fopen(filename, "r");
  int n, m;
  check_fscanf(2, input, "%d%d", &n, &m);
  data *result = init_data(n, m);
  for (int i = 0; i < n * m; i++) {
    check_fscanf(1, input, "%f", &result->M[i]);
  }
  for (int i = 0; i < m; i++) {
    check_fscanf(1, input, "%f", &result->G[i]);
  }
  for (int i = 0; i < n; i++) {
    check_fscanf(1, input, "%f", &result->C[i]);
  }
  fclose(input);
  return result;
}

/* wypisuje dane w tablicy */
void print_data(const data *d) {
  for (int i = 0; i < d->n; i++) {
    for (int j = 0; j < d->m; j++) {
      printf("%.2f ", d->M[i * d->m + j]);
    }
    puts("");
  }
}

/* prints message, waits for any character */
void wait_for_input(void) {
  puts("***Press return to continue***");
  getchar();
}

/* główna funkcja symulacji */
void simulation(const data *d, const int steps) {
  for (int i = 0; i < steps; i++) {
    step();
    print_data(d);
    if (i != steps - 1) {
      wait_for_input();
    }
  }
}

/* główna funkcja */
int main(int argc, char **argv) {
  char *filename = NULL;
  float ratio;
  int steps;
  parse_parameters(argc, argv, &filename, &ratio, &steps);
  data *d = input_data(filename);
  start(d->n, d->m, d->M, d->G, d->C, ratio);
  simulation(d, steps);
  delete_data(d);
  free(filename);
  return 0;
}
