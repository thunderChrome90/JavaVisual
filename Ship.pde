
class Ship {
  
  PVector posVector;
  
  Ship(PVector posVector) {
    this.posVector = posVector;
  }

  void move(PVector distance) {
    posVector.add(distance); // Add is a method in the PVector class.
  }

  // If the ship goes off the screen, wrap it around to the
  // other side of the screen.
  void update() {
    if (posVector.x > width) {
      posVector.x = 0;
    }
    if (posVector.x < 0) {
      posVector.x = width;
    }
    if (posVector.y > height) {
      posVector.y = 0;
    }
    if (posVector.y < 0) {
      posVector.y = height;
    }
  
  }
  void draw() {
    pushMatrix ();
    image(spaceship, posVector.x,posVector.y, 50, 70);
    popMatrix();

}
void shootGun(){
  strokeWeight(3);
  stroke(#FBFF1A);
  line(posVector.x,posVector.y, mouseX, mouseY);
  ellipse(mouseX, mouseY, 10, 10);
}
}