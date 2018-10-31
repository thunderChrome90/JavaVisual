
class Asteroids {

  int radius = 40;
  
  // asteroid speed
  PVector velocityVector = new PVector(-7, 0); 
  PVector posVector;

  boolean alive = true;

  Asteroids(PVector posVector) {
    this.posVector = posVector;
  }

  // If the UFO goes off the screen, wrap it around to the
  // other side of the screen.
  void update() {
    posVector.add(velocityVector); // Add is a method in the PVector class.

    if (posVector.x > width) {
      alive = false;
    }
    if (posVector.x < 0) {
      alive = false;
    }
    if (posVector.y > height) {
      alive = false;
    }
    if (posVector.y < 0) {
      alive = false;
    }
  }

  void draw() {
    if (alive) {
      pushMatrix();
      translate(posVector.x, posVector.y);
      image(asteroid, 0, 0, radius, radius);
      popMatrix();
    }else{
      fill(255);
      ellipse(posVector.x, posVector.y, 250, 250);
    }
  }
}