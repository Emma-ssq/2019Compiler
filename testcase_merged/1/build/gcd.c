int gcd (int u, int v) {
  if (v == 0) return u;
  else return gcd(v, u - u / v * v);
}

int main(void) {
  int x;
  int y;
  int temp;
  x = 18;
  y = 24;
  if (x < y) {
    temp = x;
    x = y;
    y = temp;
  }
  
  temp = gcd(x, y);
  ;
  return temp;
}
