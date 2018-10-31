/*
 start screen back ground - http://www.designtrends.com/graphic-web/backgrounds/trippy-background.html
 spaceship - https://au.pinterest.com/pin/436497388859683983/
 laser noise - http://soundbible.com/472-Laser-Blasts.html
 lvl two background - http://hdwallpaperbook.com/deep-space-wallpaper.html
 asteroid pic - http://pics-about-space.com/2d-asteroid-png?p=4
 font - http://fontzone.net/font-download/nasa
 some code by dogorcat3 - https://forum.processing.org/two/discussion/506/can-anyone-help-me-with-my-shooting-game

 Video link - https://vimeo.com/171070532

 Peter Hall n8738190
 */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//variable minim of type minim
Minim minim;

//variables of type AudioSample
AudioSample laser;

// Images
PImage background1, background2, background3, Astronaut, asteroid, spaceship;

//Cursor image
PImage mouseCursor;

// Font
PFont font;

// Classes
Ship_rotating ship_one;
Ship ship;
Astronaut astronaut;

// Arrays
ArrayList<Gun> gun = new ArrayList<Gun>();
ArrayList<Asteroids> asteroids = new ArrayList<Asteroids>();

// Boolean variables to track which key is currently being pressed
boolean up, down, left, right;

// track whether firing and if game is won
boolean fire = false, gameWon = false;

// PVector
float speed = 10;
PVector upVelocity = new PVector(0, -speed); // Moves UFO straight up
PVector downVelocity = new PVector(0, speed); // Moves UFO straight down
PVector leftVelocity = new PVector(-speed, 0); // Moves UFO straight to left
PVector rightVelocity = new PVector(speed, 0); // Moves UFO straight to right

PVector gunVelocity = new PVector(2*speed, 0);

// screens
int start = 0, main = 0, second, secondLevel  = 0, over = 0;

// Score
int score = 0;

void setup() {
  size(1300, 800);

  ship = new Ship(new PVector(width/2, height/2));
  ship_one = new Ship_rotating();
  astronaut = new Astronaut();

  // Sound Effects
  minim = new Minim(this);
  laser = minim.loadSample("laser.mp3", 512);

  // Images
  background1 = loadImage("startscreenbkgd.jpg");
  background2 = loadImage("Deep_Space.jpg");
  background3 = loadImage("leveltwo.jpg");
  Astronaut = loadImage("astronaut.png");
  asteroid = loadImage("asteroid.png");
  spaceship = loadImage("ship.png");
  
  mouseCursor = loadImage("mouseCursor.png");
  image(mouseCursor, 0, 0);
  mouseCursor.resize(20, 20);


  // Font
  font = loadFont("HelveticaNeue-Light-48.vlw");
  textFont(font);
}
// Depending on which key was pressed, set the 
// corresponding boolean variable to true
void keyPressed() {
  if (keyCode == UP) {
    up = true;
  } else if (keyCode == DOWN) {
    down = true;
  } else if (keyCode == LEFT) {
    left = true;
  } else if (keyCode == RIGHT) {
    right = true;
    // Space bar to end game.
  } else if ((keyCode == ' ')&&(main == 1)) {    
    over = 2;
  }
}



void mouseClicked() {
  fire = true;
  // display gun
  ship.shootGun();
}


// Depending on which key was released, set the 
// corresponding boolean variable to false
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) { 
      up = false;
    } else if (keyCode == DOWN) {
      down = false;
    } else if (keyCode == LEFT) {
      left = false;
    } else if (keyCode == RIGHT) {
      right = false;
    }
  }
} 


void draw() {
  cursor(mouseCursor, 0, 0);
  
  // determine which screen is shown
  if (start == 0) {
    startScreen();
  } 
  if (main == 1) {
    levelOne();
  }   
  if (second == 3) {
    levelTwoScreen();
  }
  if (secondLevel == 4) {
    levelTwo();
  }
  if (over == 2) {
    gameOver();
  }

  // Only have laser sound on level one.
  if ((mousePressed == true)&&(main == 1)&&(over == 0)) {
    laser.trigger();
  }
}

void startScreen() {
  imageMode(CENTER);
  image(background1, width/2, height/2);
  textSize(40);
  text("Click to start", 100, 250);
  text("Press spacebar to end game", 100, 300);
  String a = "You are stranded in space with broken thrusters! Shoot 15 asteroids to clear a path for an Astronaut to complete repairs.";
  textSize(35);
  text(a, 100, 40, 900, 200);
}

void levelOne() {

  if (!gameWon) {
    imageMode(CENTER);
    image(background2, width/2, height/2);

    textAlign(LEFT);
    text("Score: " + str(score), 0, height - 20);
  }

  // show rotating ship
  ship_one.render();

  // if more than 5 asteroids are hit, go to level two screen
  // change to > 50000 for the full 5 minute experience
  if (score > 15) {
    second = 3;
  }

  // add velocity to the ship
  if (up) {
    ship.move(upVelocity);
  }
  if (down) {
    ship.move(downVelocity);
  }
  if (left) {
    ship.move(leftVelocity);
  }
  if (right) {
    ship.move(rightVelocity);
  }


  if (fire) {
    // Create a new missile at the same location as the UFO and give it
    // velocity equal to missileVelocity. 
    // posVector.get() to make a copy of the constructor

    gun.add(new Gun(ship.posVector.get(), gunVelocity));

    fire = false;
  }

  // Randomly choose a number between 0 and 100. If it is less than 3
  // spawn an enemy.
  if (random(0, 100) < 3) {
    asteroids.add(new Asteroids(new PVector(width, random(0, height))));
  }

  // Draw and update all asteroids
  for (int j = 0; j < asteroids.size(); j++) {
    asteroids.get(j).draw();
    asteroids.get(j).update();
  }

  for (int i = 0; i < gun.size(); i++) {
    // Draw and update all asteroids
    gun.get(i).draw();
    //  gun.get(i).update();

    // Check for collisions between asteroids and gun. 
    for (int j = 0; j < asteroids.size(); j++) {
      if (gun.get(i).collision(asteroids.get(j))) {
        asteroids.get(j).alive = false;
        gun.get(i).alive = false;
        // update score
        score++;

        fill(255);
        //ellipse(,j,100,100);
      }
    }
  } 
  // Remove asteroids that are no longer alive
  for (int i = 0; i < asteroids.size(); i++) {
    if (!asteroids.get(i).alive) {
      asteroids.remove(i);
    }
  }

  // Remove bullets that are no longer alive
  for (int i = 0; i < gun.size(); i++) {
    if (!gun.get(i).alive) {
      gun.remove(i);
    }
  }
}
// initialise first level and secon level
void mouseReleased() {
  main = 1;
  if (second == 3) {
    secondLevel = 4;
    if (over == 2) {
      start = 0;
    }
  }
}

// level two info screen
void levelTwoScreen() {
  imageMode(CENTER);
  image(background3, width/2, height/2);

  String s = "You have sent an Astronaut outside to fix the thrusters, but he has drifted away. Use the arrows keys to direct the ship. bump into the astronaut to rescue him";
  textAlign(CENTER);
  text(s, width/2-400, height/2-300, 800, 400);

  text("click mouse to continue", width/2, height/1.1);
  textAlign(LEFT);
  text("Score: " + str(score), 0, height - 20);
}


// level two screen 
void levelTwo() {
  imageMode(CENTER);
  image(background2, width/2, height/2);

  // show movable ship and astronaut
  ship.update();
  ship.draw();

  astronaut.showAstronaut();
  astronaut.moveAstronaut();
}


// game over screen
void gameOver() {
  background(0);
  textAlign(CENTER);
  text("Game Over", width/2, height/2);
  text("Score = " + str(score), width/2, height/1.2);
}
