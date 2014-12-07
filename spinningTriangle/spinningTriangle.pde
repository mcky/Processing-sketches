int x1;
int y1;
int x2;
int y2;
int x3;
int y3;

void setup() {
  size(400, 400);
  frameRate(300);
  reset();
}

void draw() {
  background(0);

  if (x3 > 0)
    x3--;
  else if (y2 < height)
    y2++;
  else if (x1 < width)
    x1++;
  else if (y3 > 0)
    y3--;
  else
    reset();
  triangle(x1, y1, x2, y2, x3, y3);
}

void reset() {
  x1 = 0;
  y1 = 0;
  x2 = width;
  y2 = 0;
  x3 = width;
  y3 = height;
}
