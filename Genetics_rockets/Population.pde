class Population {
  Rocket[] pop;
  Rocket[] matingPool;
  int mateSize;
  int popSize;
  // Simulation duration of a generation
  float mutationRate;
  
  public Population(float mr, int _size, int maxi) {
    this.popSize = _size;
    this.mutationRate = mr;
    this.pop = new Rocket[_size];
    for (int i = 0; i < _size; i++) {
      pop[i] = new Rocket(start.copy(), maxi);
    }
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
      this.mateSize += r.score;
    }
  }
  
  public void naturalSelection() {
    this.matingPool = new Rocket[this.mateSize];
    int count = 0;
    for (Rocket r : this.pop) {
      for (int i = 0; i < r.score; i++){
        matingPool[count] = r;
        count++;
      }
    }
  }
  
  public void next() {
    for (int i = 0; i < this.popSize; i++) {
      Rocket parentA = this.matingPool[int(random(0, this.mateSize-1))];
      Rocket parentB = this.matingPool[int(random(0, this.mateSize-1))];
      Rocket child = parentA.crossover(parentB);
      child.mutate(this.mutationRate);
      this.pop[i] = child;
    }
    this.mateSize = 0;
  }
  
}
