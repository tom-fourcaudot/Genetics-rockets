class DNA{
  PVector[] genes;
  int size;
   public DNA(int _size){
     this.genes = new PVector[_size];
     this.size = _size;
     for (int i = 0; i < _size; i++) {
       genes[i] = PVector.random2D();
     }
   }
}
