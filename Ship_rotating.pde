class Ship_rotating {
  float xPos;
  float yPos;

  PImage ship1;


  float a;
    Ship_rotating() {
    xPos = width/2;
    yPos = height/2;

    ship1 = loadImage("ship.png");
    
  }

  void render() {
   
    imageMode(CENTER);
    pushMatrix();
    translate(width/2, height/2);
    a = atan2(mouseY-height/2, mouseX-width/2);
    rotate(a-300);
    image(ship1, 0, 0, 50, 70);
    popMatrix();
  }
}