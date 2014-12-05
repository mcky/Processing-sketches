import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

PShape poly;
int sides;
float r;
float mult;

void setup() {
  size(500, 500, P2D); 
  minim = new Minim(this);
  song = minim.loadFile("song.mp3", 512);
  song.play();
  background(0);
  sides = 360;
  r = 100;
  mult = 200;
}

void draw() {
  noStroke();
  fill(0,0,0,50);
  rect(0,0,width,height);

  poly = createShape();
  poly.beginShape();
  for (int i = 0; i < sides; i++) {
    float audio = (song.mix.get(i) * mult) + 30;
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


void mouseMoved() {
  mult = map(mouseX, 0, width, 0, 400);
  r = map(mouseY, 0, height, 0, 200);
}
