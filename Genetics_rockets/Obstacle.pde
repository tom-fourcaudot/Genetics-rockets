class Obstacle {
  int x; 
  int y; 
  int w; 
  int h; 
  
  public Obstacle (int _x, int _y, int _w, int _h) {
    this.x = _x; 
    this.y = _y; 
    this.w = _w; 
    this.h = _h;
  }
  
  public void render() {
    fill(120);
    rect(this.x, this.y, this.w, this.h);
  }
  
  public boolean collision(Rocket r) {
    if (r.pos.x < 0 || r.pos.x > width || r.pos.y < 0 || r.pos.y > height){
      return true;
    }
    return this.x < r.pos.x+3 && this.x + this.w > r.pos.x-3  && this.y < r.pos.y+3 && this.y + this.h > r.pos.y-3;
  }
  
}
