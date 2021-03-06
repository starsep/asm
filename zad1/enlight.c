#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define BYTES_PER_LINE 8 // ile bajtów na linię wypisujemy na wyjściu
#define MIN_DELTA -128
#define MAX_DELTA 127

#define check_scanf(len, ...) if (scanf(__VA_ARGS__) != len) { \
  fprintf(stderr, "Problem with scanf occurred. Exiting.\n"); \
  exit(1);\
}

typedef unsigned char uchar;
typedef signed char schar;

/* funkcja zaimplementowana w NASM
 * argumenty: 3 wskaźniki na kanały, wymiary obrazka, nr kanału
 * zmienianego, wartość o jaką zmieniamy */
extern void enlight(uchar *red, uchar *green, uchar *blue,
  int N, int M, int change, schar delta);

/* pomocnicza struktura do trzymania danych obrazka */
typedef struct {
  uchar *red, *green, *blue;
  int N, M;
  int maxi;
} image;

/* nowy obrazek o wymiarach NxM, maksymalna wartość maxi */
image *new_image(const int N, const int M, const int maxi) {
  image *result = (image *) malloc(sizeof(image));
  result->N = N;
  result->M = M;
  result->maxi = maxi;
  const size_t size = sizeof(uchar) * N * M;
  result->red = (uchar *) malloc(size);
  result->green = (uchar *) malloc(size);
  result->blue = (uchar *) malloc(size);
  return result;
}

/* funkcja wypisująca obrazek */
void print_image(const image *im) {
  printf("P3\n");
  printf("%d %d\n", im->N, im->M);
  printf("%d\n", im->maxi);
  const int size = im->N * im->M;
  for (int i = 0; i < size; i++) {
    printf("%d %d %d", im->red[i], im->green[i], im->blue[i]);
    bool newline = (i % BYTES_PER_LINE == BYTES_PER_LINE - 1) || i == size - 1;
    printf("%c", newline ? '\n' : ' ');
  }
}

/* funkcja zwalniąjaca zasoby obrazka */
void delete_image(image *im) {
  free(im->red);
  free(im->green);
  free(im->blue);
  free(im);
}

/* funkcja wczytująca obrazek z wejścia */
image *input_image() {
  static const char P3[] = "P3";
  char s[5];
  check_scanf(1, "%s[4]", s);
  if (strcmp(s, P3) != 0) {
    fprintf(stderr, "Input file is not in P3 format! Exiting.\n");
    exit(1);
  }
  int N, M, maxi;
  check_scanf(3, "%d%d%d", &N, &M, &maxi);
  image *result = new_image(N, M, maxi);
  int size = N * M;
  unsigned R, G, B;
  for (int i = 0; i < size; i++) {
    check_scanf(3, "%u%u%u", &R, &G, &B);
    result->red[i] = R;
    result->green[i] = G;
    result->blue[i] = B;
  }
  return result;
}

/* wypisuje poprawne użycie programu */
void usage(const char *error, const char *name) {
  fprintf(stderr,
    "%s! Exiting.\n"
    "Usage: %s change delta\n"
    "\tchange is 1 (red), 2 (green) or 3 (blue)\n"
    "\tdelta is signed char (%d ... %d)\n"
    "Program takes data from standard input, "
    "prints on standard output.\n",
    error, name, MIN_DELTA, MAX_DELTA);
  exit(1);
}

/* funkcja parsująca parametry */
void parse_parameters(int argc, char **argv, int *change, schar *delta) {
  if (argc != 3) {
    usage("Bad number of arguments", argv[0]);
  }

  *change = atoi(argv[1]);
  if (*change < 1 || *change > 3) {
    usage("Change is incorrect", argv[0]);
  }

  int tmp_delta = atoi(argv[2]);
  if (tmp_delta < MIN_DELTA || tmp_delta > MAX_DELTA) {
    usage("Delta out of the bounds", argv[0]);
  }
  *delta = (schar) tmp_delta;
}

/* główna funkcja */
int main(int argc, char **argv) {
  int change;
  schar delta;
  parse_parameters(argc, argv, &change, &delta);
  image *im = input_image();
  enlight(im->red, im->green, im->blue, im->N, im->M, change, delta);
  print_image(im);
  delete_image(im);
  return 0;
}
