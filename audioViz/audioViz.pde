import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;
AudioInput in;

String songName;
String songPath;
boolean songLoaded = false;
boolean songPlaying = false;

PShape poly;
int sides;
float r;
float mult;

float audio;
float angle;
float z;
float x;
float y;
    
int colorIndex;
color currentColor;
color[] colors = {
  color(255, 255, 255),
  color(255, 0, 0),
  color(0, 255, 0),
  color(0, 0, 255)
};

boolean mic;
boolean fullScreen;

void setup() {
  if (sketchFullScreen()) {
    size(displayWidth, displayHeight, P2D); 
  } else {
    size(500, 500, P2D);
  }
  minim = new Minim(this);
  mic = false;
  sides = 360;
  r = 100;
  mult = 200;
  colorIndex = 0;
  currentColor = colors[colorIndex];
  
  if (mic) {
    in = minim.getLineIn();
  } else {
    println("select");
    selectInput("Select input", "fileSelected");
  }
  
  background(0);
}


void draw() {
  if (songLoaded || mic) {
    if (!songPlaying && !mic) {
      song = minim.loadFile(songName, 512);
      song.play();
      songPlaying = true;
    }
    audioViz();
  }
}

void fileSelected(File selection) {
  songPath = "../data/song.mp3";
  if (selection != null) {
    songName = selection.getAbsolutePath();
  } else {
    songName = songPath;
  }
  songLoaded = true;
}

void audioViz() {
  if ((frameCount % 3) == 1) {
    noStroke();
    fill(0,0,0,60);
    rect(0,0,width,height);
  }
  poly = createShape();
  poly.beginShape();
  for (int i = 0; i < sides; i++) {
    if (mic) {
      audio = in.mix.get(i);
    } else {
      audio = song.mix.get(i);
    }
    angle = 360/sides;
    z = r + (audio * mult) + 30;
    x = z * cos(radians(i *angle));
    y = z * sin(radians(i *angle));
    poly.noFill();
    poly.stroke(currentColor, 150);
    poly.vertex(x, y);
    if (sides != 360) {
      fill(currentColor, 150);
      ellipse((width/2)+x, (height/2)+y, 4, 4);
      noFill();
    }
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

boolean sketchFullScreen() {
  return false;
}
