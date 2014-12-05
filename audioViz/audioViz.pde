import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

PShape poly;
int sides;
float r;
float mult;
float add;

void setup() {
  size(500, 500, P2D); 
  minim = new Minim(this);
  song = minim.loadFile("song.mp3", 512);
  song.play();
  background(0);
  sides = 360;
  r = 100;
  mult = 200;
  add = 30;
}

void draw() {
  noStroke();
  fill(0,0,0,50);
  rect(0,0,width,height);

  poly = createShape();
  poly.beginShape();
  for (int i = 0; i < sides; i++) {
    float audio = (song.mix.get(i) * mult) + add;
    float angle = 360/sides;
    float z = r + audio;
    float x = z * cos(radians(i *angle));
    float y = z * sin(radians(i *angle));
    poly.noFill();
    poly.stroke(255,255,255, 120);
    poly.vertex(x, y);
  }
  poly.endShape(CLOSE);
  
  shape(poly, width/2, height/2);
}
