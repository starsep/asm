#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void start(int szer, int wys, float *M, float *G, float *C, float waga);
extern void step(void);

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

/* główna funkcja */
int main(int argc, char **argv) {
  char *filename = NULL;
  float ratio;
  int steps;
  parse_parameters(argc, argv, &filename, &ratio, &steps);
  free(filename);
  return 0;
}
