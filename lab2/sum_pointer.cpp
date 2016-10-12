#include <cstdio>

extern "C" int sum(int data[], int len);

int main() {
  int data[] = { 1, 2, 3, 4, 5, 6, 7, 10, 11};
  printf("%d\n", sum(data, sizeof(data) / sizeof(int)));
}
