float baseSizeX = 100;
float baseSizeY = 50;
float extrusionDepth = 50;
color baseColor;
float rotationX = 0;
float rotationY = 0;
int numLayers = 10;
float layerHeight = 20;
float twistAmount = 30;

void setup() {
  size(800, 600, P3D);
  baseColor = color(255);  // 将颜色设置为白色
}

void draw() {
  background(255);
  lights();
  translate(width / 2, height / 2, -200);
  drawShape(baseSizeX, baseSizeY, extrusionDepth, baseColor, rotationX, rotationY, numLayers, layerHeight, twistAmount);
}

void drawShape(float sizeX, float sizeY, float depth, color c, float rotX, float rotY, int layers, float layerHeight, float twist) {
  fill(c);
  stroke(255);  // 将线条颜色设置为白色
  strokeWeight(1);  // 减小线条宽度

  for (int i = 0; i < layers; i++) {
    pushMatrix();
    rotateX(radians(rotX));
    rotateY(radians(rotY));

    float currentLayerHeight = i * layerHeight;
    translate(0, 0, currentLayerHeight);

    beginShape(QUAD_STRIP);
    for (float angle = 0; angle <= 360; angle += 5) {  // 增加顶点数量
      float x = cos(radians(angle)) * sizeX / 2;
      float y = sin(radians(angle)) * sizeY / 2;

      float twistAngle = radians(angle + twist * i);
      float twistedX = x * cos(twistAngle) - y * sin(twistAngle);
      float twistedY = x * sin(twistAngle) + y * cos(twistAngle);

      vertex(twistedX, twistedY, 0);
      vertex(twistedX, twistedY, depth);
    }
    endShape();

    popMatrix();
  }
}

void mousePressed() {
  baseSizeX = random(50, 150);
  baseSizeY = random(30, 80);
  extrusionDepth = random(20, 100);
  rotationX = random(360);
  rotationY = random(360);
  numLayers = int(random(5, 15));
  layerHeight = random(10, 30);
  twistAmount = random(10, 50);
}
