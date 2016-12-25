#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define check_fscanf(len, ...) if (fscanf(__VA_ARGS__) != len) { \
  fprintf(stderr, "Problem with fscanf occurred. Exiting.\n"); \
  exit(1);\
}

#define DEFAULT_RED 77
#define DEFAULT_BLUE 151
#define DEFAULT_GREEN 28
#define CHANNELLS_IN_RGB 3
#define MAX_VALUE_P2 255

typedef unsigned char uchar;

/* funkcja zaimplementowana w asemblerze dla ARM
 * argumenty: N, M (wymiary obrazka), maksymalna wartość w P3, wartości
 * wejściowe, miejsce do zapisu, współczynniki składowych
 */
extern void grayscale(int size, int maxi, const uchar *in, uchar *out,
  uchar red, uchar green, uchar blue, int maxi_p2
);

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
  const size_t colors_per_pixel = P2 ? 1 : CHANNELLS_IN_RGB;
  const size_t size = sizeof(uchar) * N * M * colors_per_pixel;
  result->data = (uchar *) malloc(size);
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
  fprintf(out, "%d %d\n", im->N, im->M);
  fprintf(out, "%d\n", im->maxi);
  const int size = im->N * im->M;
  for (int i = 0; i < size; i++) {
    fprintf(out, "%d ", im->data[i]);
  }
  fprintf(out, "\n");
  fclose(out);
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
    check_fscanf(CHANNELLS_IN_RGB, in, "%u%u%u", &R, &G, &B);
    result->data[CHANNELLS_IN_RGB * i] = R;
    result->data[CHANNELLS_IN_RGB * i + 1] = G;
    result->data[CHANNELLS_IN_RGB * i + 2] = B;
  }
  fclose(in);
  return result;
}

/* wypisuje poprawne użycie programu */
void usage(const char *error, const char *name) {
  fprintf(stderr,
    "%s! Exiting.\n"
    "Usage: %s input output [red green blue]\n"
    "\tinput is input filename\n"
    "\toutput is output filename\n"
    "\tred, green, blue are optional ratios, they have to sum to %d.\n",
    error, name, MAX_VALUE_P2 + 1);
  exit(1);
}

/* funkcja parsująca parametry */
void parse_parameters(int argc, char **argv,
  char **in_filename, char **out_filename, int *red, int *green, int *blue) {
  if (argc != 3 && argc != 6) {
    usage("Bad number of arguments", argv[0]);
  }
  *in_filename = argv[1];
  *out_filename = argv[2];
  if (argc == 3) {
    *red = DEFAULT_RED;
    *green = DEFAULT_GREEN;
    *blue = DEFAULT_BLUE;
  } else {
    *red = atoi(argv[3]);
    *green = atoi(argv[4]);
    *blue = atoi(argv[5]);
  }
  if (*red + *green + *blue != MAX_VALUE_P2 + 1) {
    fprintf(stderr, "Red, green, blue ratios have to sum to %d. Exiting.\n",
      MAX_VALUE_P2 + 1
    );
    exit(1);
  }
}

/* główna funkcja */
int main(int argc, char **argv) {
  char *in_filename, *out_filename;
  int red, green, blue;
  parse_parameters(argc, argv, &in_filename, &out_filename,
    &red, &green, &blue);
  image *in = input_image(in_filename);
  image *out = new_image(in->N, in->M, MAX_VALUE_P2, true);
  grayscale(in->N * in->M, in->maxi, in->data, out->data,
    red, green, blue, MAX_VALUE_P2);
  print_image(out_filename, out);
  delete_image(in);
  delete_image(out);
  return 0;
}
