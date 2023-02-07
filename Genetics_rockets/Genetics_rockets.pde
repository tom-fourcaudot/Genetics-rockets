Population p;
final int POP_SIZE = 500;
final int MAX_SPAN = 200;
int span;
int gen;
Obstacle o;
PVector target;
PVector start;
final float MUTATION_RATE = 0.01;

void setup() {
  size(700, 700);
  background(255);
  start = new PVector(width/2, height-50);
  p = new Population(MUTATION_RATE, POP_SIZE, MAX_SPAN);
  span = 0;
  gen = 0;
  o = new Obstacle(300, 200, 100, 50);
  target = new PVector(width/2, 50);
}

void draw() {
  background(255);
  o.render();
  showTarget(target);
  if (span < MAX_SPAN) {
    p.update(o);
    p.render();
    span++;
  } else {
    p.calcFitness(target);
    p.naturalSelection();
    p.next();
    span = 0;
    gen++;
    println("--- "+gen+" ---");
  }
}

void showTarget(PVector p) {
  fill(0, 255, 150);
  circle(p.x, p.y, 20);
}
