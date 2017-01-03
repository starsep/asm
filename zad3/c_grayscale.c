typedef unsigned char uchar;

/* implementacja w C,
 * kod w asemblerze dla ARMa powinien robić to samo,
 * ten kod przydatny do testów itp. */
void grayscale(int size, const uchar *in, uchar *out, uchar red,
               uchar green, uchar blue) {
  for (int i = 0; i < size; i++) {
    int r = in[3 * i], g = in[3 * i + 1], b = in[3 * i + 2];
    out[i] = red * r + green * g + blue * b;
    // tutaj jeszcze możnaby zrobić / (red + green + blue),
    // ale *założenie* ich suma = 256.
  }
}
