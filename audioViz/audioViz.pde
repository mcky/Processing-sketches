import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

String songName;
boolean songLoaded = false;
boolean songPlaying = false;

PShape poly;
int sides;
float r;
float mult;

int colorIndex;
color currentColor;
color[] colors = {
  color(255, 255, 255),
  color(255, 0, 0),
  color(0, 255, 0),
  color(0, 0, 255)
};

void setup() {
  size(500, 500, P2D); 
  minim = new Minim(this);
  background(0);
  sides = 360;
  r = 100;
  mult = 200;
  colorIndex = 0;
  currentColor = colors[colorIndex];
  
  selectInput("Select input", "fileSelected");  
}


void draw() {
  if (songLoaded) {
    if (!songPlaying) {
      song = minim.loadFile(songName, 512);
      song.play();
      songPlaying = true;
    }
    audioViz();
  }
}

void fileSelected(File selection) {
  songName = selection.getAbsolutePath(); 
  songLoaded = true;
}

void audioViz() {
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
    poly.stroke(currentColor, 120);
    poly.vertex(x, y);
  }
  poly.endShape(CLOSE);
  
  shape(poly, width/2, height/2);
}

void mouseMoved() {
  mult = map(mouseX, 0, width, 0, 400);
  r = map(mouseY, 0, height, 0, 200);
}

void keyPressed() {
  if (keyCode == UP) {
    if (colorIndex == colors.length-1) {
      colorIndex = 0;
    } else {
      colorIndex++;
    }
    currentColor = colors[colorIndex];
  } else if (keyCode == DOWN) {
    if (colorIndex == 0) {
      colorIndex = colors.length-1;
    } else {
      colorIndex--;
    }
    currentColor = colors[colorIndex];
  } else if (keyCode == LEFT) {
    if (sides == 360) {
      sides = 10;
    } else if(sides == 3) {
      sides = 360;
    } else {
      sides--;
    }
  } else if (keyCode == RIGHT) {
    if (sides == 360) {
      sides = 3;
    } else if(sides > 10) {
      sides = 360;
    } else {
      sides++;
    }
  }
}
