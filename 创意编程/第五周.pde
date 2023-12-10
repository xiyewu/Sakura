int numFrames = 8; // 图片帧数
int currentFrame = 0; // 当前帧索引
PImage[] images; // 存储图片的数组
float angle = 0; // 旋转角度
float angleSpeed = 0.1; // 旋转速度

void setup() {
  size(400, 400);
  
  // 初始化图片数组
  images = new PImage[numFrames];
  
  // 加载图片
  for (int i = 0; i < numFrames; i++) {
    images[i] = loadImage("image" + (i + 1) + ".jpg");
  }
}

void draw() {
  background(255);
  translate(width / 2, height / 2);
  
  // 通过旋转创建动态效果
  rotate(radians(angle));

  // 显示当前帧的图片
  image(images[currentFrame], -images[currentFrame].width / 2, -images[currentFrame].height / 2);
  
  // 更新旋转角度和帧索引
  angle += angleSpeed;
  currentFrame = (currentFrame + 1) % numFrames;
}
