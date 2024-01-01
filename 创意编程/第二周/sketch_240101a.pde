int numSquares = 5;
int squareSize = 50;

void setup() {
  size(400, 400);
  background(255);
  drawSquares();
}

void drawSquares() {
  for (int i = 0; i < numSquares; i++) {
    drawSquare(i * (squareSize + 10), 0);
  }
}

void drawSquare(float x, float y) {
  rect(x, y, squareSize, squareSize);
}
