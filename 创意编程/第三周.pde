void setup() {
  size(600, 600);
  background(255);
  
  // 设置帧率为每秒 30 帧
  frameRate(1);
}

void draw() {
  // 绘制蒙德里安风格的艺术作品
  drawMondrianStyle();
}

void drawMondrianStyle() {
  // 清除画布
  background(255);
  
  // 绘制黑色外框
  strokeWeight(10);
  stroke(0);
  rect(0, 0, width, height);
  
  // 红、黄、白三种颜色
  color red = color(255, 0, 0);
  color yellow = color(255, 255, 0);
  color white = color(255);
  
  // 绘制几何形状和颜色
  randomSeed(frameCount); // 使用帧数作为随机数种子，使图形每帧都有变化
  
  int numRectangles = 0; // 计数已绘制的矩形数量
  while (numRectangles < 20) {
    float x = random(width);
    float y = random(height);
    float w = random(100, width - x);
    float h = random(100, height - y);
    int index = int(random(3)); // 随机选择红、黄、白三种颜色
    
    color selectedColor;
    if (index == 0) {
      selectedColor = red;
    } else if (index == 1) {
      selectedColor = yellow;
    } else {
      selectedColor = white;
    }
    
    // 绘制矩形
    fill(selectedColor);
    rect(x, y, w, h);
    numRectangles++;
  }
}
