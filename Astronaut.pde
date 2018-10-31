
class Astronaut {

  int xPos = 0, yPos = 0;
  int xDir = 2, yDir = 5;

  Astronaut() {
  
}

  void showAstronaut() {
    imageMode(CENTER);
    image(Astronaut, xPos, yPos, 60, 60);
  }

  void moveAstronaut() {
    //  assign directional values to x and y pos variables to enable movement
    xPos = xPos + xDir;
    yPos = yPos + yDir;

    //  If statements test to see if x and y positions are out of frame, 
    //  if they are, reverse direction by multiplying by -1
    if (xPos > width || xPos < 0) {
      xDir *= -1;
    }

    if (yPos > height  || yPos < 0) {
      yDir *= -1;
    }
  }
}