int gcd (int u, int v) { /* calculate the gcd of u and v */
  int x;
  int a;
  int b;
  int c;
  a=1;
  b=2;
  c=a+b;
  if (v == 0){
      x=1;
      return u;
  }
  else return gcd(v, u - u / v * v); /* v,u-u/v*v is equals to u mod v*/
}
int main() {
  int x; 
  int y; 
  int temp;
  int z;
  int a;
  int b;
  int i;
  x = 72;
  z=0;
  a=x;
  b=x;
  i=0;
  y = 18;
  if (x<y) {
    i=i+1;
    z=4*i;
    temp = x;
    x = y;
    y = temp;
  }
  else{
    i=i+1;
    z=4*i;
    temp = y;
    x = x;
    y = temp;
  }
  return gcd(x,y);
}