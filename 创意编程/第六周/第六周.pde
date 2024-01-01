ArrayList<Boid> boids;

void setup() {
  size(800, 600);
  boids = new ArrayList<Boid>();
  for (int i = 0; i < 100; i++) {
    boids.add(new Boid(random(width), random(height)));
  }
}

void draw() {
  background(255);

  for (Boid b : boids) {
    b.update(boids);
    b.display();
  }
}

void mouseClicked() {
  boids.add(new Boid(mouseX, mouseY));
}

class Boid {
  PVector position;
  PVector velocity;
  float maxSpeed = 2;
  float maxForce = 0.1;

  Boid(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
  }

  void update(ArrayList<Boid> boids) {
    PVector alignment = align(boids);
    PVector cohesion = cohesion(boids);
    PVector separation = separate(boids);

    // 加权合力
    alignment.mult(1.0);
    cohesion.mult(1.0);
    separation.mult(1.5);

    // 应用合力
    velocity.add(alignment);
    velocity.add(cohesion);
    velocity.add(separation);
    velocity.limit(maxSpeed);

    // 更新位置
    position.add(velocity);

    // 边界处理
    if (position.x < 0) position.x = width;
    if (position.y < 0) position.y = height;
    if (position.x > width) position.x = 0;
    if (position.y > height) position.y = 0;
  }

  void display() {
    fill(127);
    stroke(0);
    ellipse(position.x, position.y, 16, 16);
  }

  PVector align(ArrayList<Boid> boids) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < 50)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(maxSpeed);
      sum.sub(velocity);
      sum.limit(maxForce);
    }
    return sum;
  }

  PVector cohesion(ArrayList<Boid> boids) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < 50)) {
        sum.add(other.position);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    } else {
      return new PVector(0, 0);
    }
  }

  PVector separate(ArrayList<Boid> boids) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < 25)) {
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(maxSpeed);
      sum.sub(velocity);
      sum.limit(maxForce);
    }
    return sum;
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
