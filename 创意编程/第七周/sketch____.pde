Fractal fractal;
ArrayList<LifeForm> lifeForms;

void setup() {
  size(800, 600);
  fractal = new Fractal(width / 2, height / 2, 300);
  lifeForms = new ArrayList<LifeForm>();
}

void draw() {
  background(255);
  
  // 绘制分形
  fractal.display();
  
  // 更新和显示生命形式
  for (LifeForm lifeForm : lifeForms) {
    lifeForm.update();
    lifeForm.display();
  }
}

void mousePressed() {
  // 在鼠标点击位置添加生命形式
  LifeForm lifeForm = new LifeForm(mouseX, mouseY);
  lifeForms.add(lifeForm);
}

class Fractal {
  float x, y;
  float size;

  Fractal(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void display() {
    // 绘制分形，这里使用了简单的分形示例（三角形）
    float height = sqrt(3) * this.size / 2;
    float x1 = this.x - this.size / 2;
    float x2 = this.x + this.size / 2;
    float y1 = this.y + height / 2;
    float y2 = this.y - height / 2;
    float x3 = this.x;
    float y3 = this.y - height / 2;

    triangle(x1, y1, x2, y1, x3, y3);
  }
}

class LifeForm {
  PVector position;
  PVector velocity;
  float size;
  color col;

  LifeForm(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D().mult(random(1, 3));
    size = random(5, 15);
    col = color(random(100, 255), random(100, 255), random(100, 255), 150);
  }

  void update() {
    // 生命形式的移动
    position.add(velocity);

    // 边界处理
    if (position.x < 0 || position.x > width || position.y < 0 || position.y > height) {
      position.x = mouseX;
      position.y = mouseY;
    }
  }

  void display() {
    noStroke();
    fill(col);
    ellipse(position.x, position.y, size, size);
  }
}
