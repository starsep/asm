typedef unsigned char uchar;

void grayscale(int size, int maxi, const uchar *in, uchar *out,
  uchar red, uchar green, uchar blue) {
  for (int i = 0; i < size; i++) {
    int r = in[3 * i], g = in[3 * i + 1], b = in[3 * i + 2];
    out[i] = (red * r + green * g + blue * b) / 256 % 256;
  }
}
