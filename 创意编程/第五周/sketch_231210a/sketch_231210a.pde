int numFrames = 8; 
int currentFrame = 0; 
PImage[] images; 
float angle = 0; 
float angleSpeed = 0.1; 
void setup() {
  size(400, 400);
  

  images = new PImage[numFrames];
  

  for (int i = 0; i < numFrames; i++) {
    images[i] = loadImage("image" + (i + 1) + ".jpg");
  }
}

void draw() {
  background(255);
  translate(width / 2, height / 2);
  
  rotate(radians(angle));
  image(images[currentFrame], -images[currentFrame].width / 2, -images[currentFrame].height / 2);
  

  angle += angleSpeed;
  currentFrame = (currentFrame + 1) % numFrames;
}
