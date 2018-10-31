
class Gun {
  PVector pos;
  PVector vel;
  boolean alive;

  
  Gun(PVector pos, PVector vel) {
    this.pos = pos;
    //this.vel = vel;
    alive = true;

  }

  boolean collision(Asteroids other) {
    
    if(dist(mouseX, mouseY, other.posVector.x, other.posVector.y) < other.radius){
    alive = false;
      return true;
    }
    return false;
  }

  void draw() {
    //if (alive) {      
     // pushMatrix();      
      //translate(pos.x, pos.y);

    }
  
    void mousePressed(){
        stroke(255, 0, 0);
         strokeWeight(10);
         line(pos.x, pos.y, mouseX, mouseY);
    }
  }

      