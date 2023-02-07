class Rocket {
  // Physics variables
  PVector pos;
  PVector vel;
  PVector acc;
  final float MAX_VEL = 5;
  final int MAX_ACC = 1;
  // Genetics informations
  DNA gene;
  // Var for fitness
  boolean alive;
  int timeLived;
  int score;
  
  
  public Rocket(PVector start,int maxi){
    // Initialize physics
    this.pos = start.copy();
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    // Create random DNA for 1st gen
    this.gene = new DNA(maxi);
    // Make the variables default to avoid null exeption
    this.alive = true;
    this.timeLived = 0;
    this.score = 0;
  }
  
  public void applyForce(PVector f) {
    if(this.alive) {
      this.acc.add(f);
    }
  }
  
  public void update(Obstacle o) {
    if(this.alive){
      this.acc.limit(MAX_ACC);
      this.vel.add(this.acc);
      this.vel.limit(MAX_VEL);
      this.pos.add(this.vel);
      this.acc.mult(0);
      this.timeLived++;
      this.alive = !o.collision(this);
    } else {
      vel.mult(0);
      acc.mult(0);
    }
  }
  
  public void render() {
    noStroke();
    if (this.alive) {
    fill(200);
    } else {
    fill(255, 0, 0);
  }
    circle(pos.x, pos.y, 6);
  }
  
  void calcFitness(PVector target) {
    float d = dist(this.pos.x, this.pos.y, target.x, target.y);
    this.score = int(map(-d, -700, 0, 0, 100));
    this.score += this.timeLived/2;
    this.score = int(this.score)/2;
    if (this.score < 0) {
      println("negative score");
      this.score = 0;
    }
  }
  
  Rocket crossover(Rocket mate) {
    Rocket child = new Rocket(start, MAX_SPAN);
    for (int i = 0; i < child.gene.size; i++){
      float choice = random(0, 1);
      if (choice < 0.5) {
        child.gene.genes[i] = this.gene.genes[i];
      } else {
        child.gene.genes[i] = mate.gene.genes[i];
      }
    }
    return child;
  }
  
  void mutate(float mr) {
    float choice = random(0, 1);
    for (int i = 0; i < this.gene.size; i++) {
      if(choice < mr) {
        this.gene.genes[i] = PVector.random2D().normalize();
      }
    }
  }
}
