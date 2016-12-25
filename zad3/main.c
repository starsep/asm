#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define check_fscanf(len, ...) if (fscanf(__VA_ARGS__) != len) { \
  fprintf(stderr, "Problem with fscanf occurred. Exiting.\n"); \
  exit(1);\
}

typedef unsigned char uchar;
typedef signed char schar;

/* funkcja zaimplementowana w asemblerze dla ARM
 * TODO: argumenty */
extern void grayscale();

/* pomocnicza struktura do trzymania danych obrazka */
typedef struct {
  uchar *data;
  int N, M;
  int maxi;
} image;

/* nowy obrazek o wymiarach NxM, maksymalna wartość maxi, jeżeli P2 to P2 w p.p. P3 */
image *new_image(const int N, const int M, const int maxi, bool P2) {
  image *result = (image *) malloc(sizeof(image));
  result->N = N;
  result->M = M;
  result->maxi = maxi;
  const size_t size = sizeof(uchar) * N * M;
  result->data = (uchar *) malloc(P2 ? size : 3 * size);
  return result;
}

/* funkcja wypisująca obrazek w formacie P2 */
void print_image(const char *filename, const image *im) {
  FILE *out = fopen(filename, "w");
  if (out == NULL) {
    fprintf(stderr,
      "Error with fopen. Can't open file '%s' in write mode.\n", filename);
      exit(1);
  }
  fprintf(out, "P2\n");
  fprintf(out, "%d\n", im->maxi);
  fprintf(out, "%d %d\n", im->N, im->M);
  const int size = im->N * im->M;
  for (int i = 0; i < size; i++) {
    fprintf(out, "%d ", im->data[i]);
  }
  fprintf(out, "\n");
}

/* funkcja zwalniąjaca zasoby obrazka */
void delete_image(image *im) {
  free(im->data);
  free(im);
}

/* funkcja wczytująca obrazek z wejścia w formacie P3*/
image *input_image(const char *filename) {
  FILE *in = fopen(filename, "r");
  if (in == NULL) {
    fprintf(stderr,
      "Error with fopen. Can't open file '%s' in read mode.\n", filename);
      exit(1);
  }
  static const char P3[] = "P3";
  char s[5];
  check_fscanf(1, in, "%s[4]", s);
  if (strcmp(s, P3) != 0) {
    fprintf(stderr, "Input file is not in P3 format! Exiting.\n");
    exit(1);
  }
  int N, M, maxi;
  check_fscanf(3, in, "%d%d%d", &N, &M, &maxi);
  image *result = new_image(N, M, maxi, false);
  int size = N * M;
  unsigned R, G, B;
  for (int i = 0; i < size; i++) {
    check_fscanf(3, in, "%u%u%u", &R, &G, &B);
    result->data[3 * i] = R;
    result->data[3 * i + 1] = G;
    result->data[3 * i + 2] = B;
  }
  return result;
}

/* wypisuje poprawne użycie programu */
void usage(const char *error, const char *name) {
  fprintf(stderr,
    "%s! Exiting.\n"
    "Usage: %s input output\n"
    "\tinput is input filename\n"
    "\toutput is output filename\n",
    error, name);
  exit(1);
}

/* funkcja parsująca parametry */
void parse_parameters(int argc, char **argv, char **in_filename, char **out_filename) {
  if (argc != 3) {
    usage("Bad number of arguments", argv[0]);
  }
  *in_filename = argv[1];
  *out_filename = argv[2];
}

/* główna funkcja */
int main(int argc, char **argv) {
  char *in_filename, *out_filename;
  parse_parameters(argc, argv, &in_filename, &out_filename);
  image *in = input_image(in_filename);
  image *out = new_image(in->N, in->M, 255, true);
  grayscale(in->data, in->N, in->M);
  print_image(out_filename, out);
  delete_image(in);
  delete_image(out);
  return 0;
}
