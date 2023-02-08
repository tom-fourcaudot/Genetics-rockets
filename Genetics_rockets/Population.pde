class Population {
  Rocket[] pop;
  Rocket[] matingPool;
  final int MAX_MAT_SIZE;
  int mateSize;
  int popSize;
  // Simulation duration of a generation
  float mutationRate;
  int maxScore;
  int sumScore;
  
  public Population(float mr, int _size, int maxi) {
    this.popSize = _size;
    this.mutationRate = mr;
    this.pop = new Rocket[_size];
    for (int i = 0; i < _size; i++) {
      pop[i] = new Rocket(start.copy(), maxi, i);
    }
    this.MAX_MAT_SIZE = _size * 50;
    this.maxScore = 0;
    this.mateSize = 0;
  }
  
  public void render() {
    for (int i = 0; i < popSize; i++) {
      pop[i].render();
    }
  }
  
  public void update(Obstacle[] o) {
    for (Rocket r : this.pop) {
      r.applyForce(r.gene.genes[span]);
      r.update(o);
    }
  }
  
  public void calcFitness(PVector target) {
    for(Rocket r : this.pop) {
      r.calcFitness(target);
      this.maxScore = max(r.score, this.maxScore);
      this.sumScore += r.score;
    }
  }
  
  public void naturalSelection() {
    this.matingPool = new Rocket[this.MAX_MAT_SIZE];
    int count = 0;
    for (Rocket r : this.pop) {
      for (int i = 0; i < (int)Math.floor(map(float(r.score)/this.sumScore, 0, 1, 0, this.MAX_MAT_SIZE)); i++){
        matingPool[count] = r;
        count++;
      }
    }
    this.mateSize = count-1;
  }
  
  public void next() {
    for (int i = 0; i < this.popSize; i++) {
      Rocket parentA = this.matingPool[int(random(0, this.mateSize-1))];
      Rocket parentB = parentA;
      while (parentA.id == parentB.id) {
        parentB = this.matingPool[int(random(0, this.mateSize-1))];
      }
      Rocket child = parentA.crossover(parentB, i);
      child.mutate(this.mutationRate);
      this.pop[i] = child;
    }
    this.maxScore = 0;
    this.mateSize = 0;
  }
  
}
