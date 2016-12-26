typedef unsigned char uchar;

void grayscale(int size, int maxi, const uchar *in, uchar *out, uchar red,
               uchar green, uchar blue, int p2_maxi) {
  int sum = red + green + blue;
  p2_maxi++;
  for (int i = 0; i < size; i++) {
    int r = in[3 * i], g = in[3 * i + 1], b = in[3 * i + 2];
    out[i] = (red * r + green * g + blue * b) / sum % p2_maxi;
  }
}
