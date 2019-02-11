Profile3D p;
LinearRotation3D lr;

boolean drawingMode;

int[] backgroundColor = {10, 20, 50};
int[] axisColor = {255, 255, 255};
int axisWeight = 3;

int[] figureColor = {0, 200, 0};
int[] figureFill = {220, 220, 220};
int figureWeight = 3;

int longitude = 20;//20
float angle = 360/longitude;

float angleX = radians(0.5);
float angleY = radians(0.5);

int initMouseX;
int initMouseY;

void setup(){
  size(800,800, P3D);
  
  drawingMode = true;
  
  p = new Profile3D(figureWeight, figureColor);
  lr = new LinearRotation3D(longitude, angleX, angleY, figureWeight, figureColor, figureFill);
}

void draw() {
  background(backgroundColor[0], backgroundColor[1], backgroundColor[2]);
  
  strokeWeight(axisWeight);
  stroke(axisColor[0], axisColor[1], axisColor[2]);
  line(width/2, 0, width/2, height);
  
  if(drawingMode) p.refresh();
  else {
    lr.refresh();
  }
}

void mouseClicked() {
  if(drawingMode) {
    p.addVertex(mouseX, mouseY, 0);
  }
}

void mouseDragged() {
  if(!drawingMode) {
    PVector rotationDir = new PVector(mouseX - initMouseX, mouseY - initMouseY, 0);
    println(rotationDir);
    lr.doRotation(rotationDir);
  }
}

void mouseMoved() {
  if(!drawingMode) {
    initMouseX = mouseX;
    initMouseY = mouseY;
  }
}

void keyPressed() {
  if(key == ' ' && drawingMode) {
    lr.setLatitude(p.getVertices().size());
    lr.createSurface(p);
    drawingMode = false;
  } else if(key == ' ' && !drawingMode) {
    p.destroy();
    lr.destroy();
    drawingMode = true;
  }
}
