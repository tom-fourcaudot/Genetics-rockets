Population p;
final int POP_SIZE = 2000;
final int MAX_SPAN = 200;
final int NB_OBSTACLE = 3;
int span;
int gen;
Obstacle[] o;
PVector target;
PVector start;
final float MUTATION_RATE = 0.05;

void setup() {
  size(700, 700);
  background(20);
  o = new Obstacle[3];
  start = new PVector(width/2, height-50);
  p = new Population(MUTATION_RATE, POP_SIZE, MAX_SPAN);
  span = 0;
  gen = 0;
  o[0] = new Obstacle(width/4, height-150, 3*width/4, 50);
  o[1] = new Obstacle(0, height/2, 3*width/4, 50);
  o[2] = new Obstacle(width/4, height/2, 3*width/4, 50);
  target = new PVector(width/2, height/2);
  frameRate(600);
  
}

void draw() {
  background(20);
  for (Obstacle ob : o) {
    ob.render();
  }
  showTarget(target);
  showInfo();
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
  }
}

void showTarget(PVector p) {
  fill(0, 255, 150);
  circle(p.x, p.y, 20);
}

void showInfo() {
  fill(255);
  textSize(15);
  textAlign(LEFT, TOP);
  text("Generation : "+gen,5, 5);
}
