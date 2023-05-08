import ddf.minim.*;

PImage DogImg, RaindropImg, BackgroundImg, BackRainImg;
int score;
boolean gameOver, gameStarted;
float playerX, playerY, playerSpeed;
float obstacleX, obstacleY, obstacleSpeed;
float obstacleWidth, obstacleHeight;

Minim minim;
AudioSnippet Arrive;

void setup() {
  size(400, 400);
  minim = new Minim(this);
  Arrive = minim.loadSnippet("bensound-arrival.mp3");
  DogImg = loadImage("Dog.png");
  RaindropImg = loadImage("Raindrop.png");
  BackgroundImg = loadImage("Background.png");
  BackRainImg = loadImage("BackRain.png");
  reset();
  Arrive.loop();
}

void reset() {
  score = 0;
  gameOver = false;
  gameStarted = false;
  playerX = width/2;
  playerY = height-50;
  playerSpeed = 5;
  obstacleX = random(width);
  obstacleY = 0;
  obstacleSpeed = 3;
  obstacleWidth = random(20, 80);
  obstacleHeight = random(20, 80);
}

void draw() {
  if (gameStarted) {
   
    image(BackgroundImg, 0, 0, width, height);

    if (!gameOver) {
      // move player
      if (keyPressed && (key == 'a' || key == 'A')) {
        playerX -= playerSpeed;
      }
      if (keyPressed && (key == 'd' || key == 'D')) {
        playerX += playerSpeed;
      }
      
      if (playerX < 0) {
        playerX = 0;
      }
      if (playerX > width) {
        playerX = width;
      }
      
      obstacleY += obstacleSpeed;
      
      if (obstacleY > height) {
        score++;
        obstacleX = random(width);
        obstacleY = 0;
        obstacleWidth = random(20, 80);
        obstacleHeight = random(20, 80);
        obstacleSpeed += 0.5;
      } else {
        if (obstacleX < playerX + 50 && obstacleX + obstacleWidth > playerX && obstacleY < playerY + 50 && obstacleY + obstacleHeight > playerY) {
          gameOver = true;
        }
      }
      
      image(DogImg, playerX, playerY, 50, 50);
      
      image(RaindropImg, obstacleX, obstacleY, obstacleWidth, obstacleHeight);
      // draw score
      fill(255);
      textSize(20);
      textAlign(LEFT, TOP);
      text("Score: " + score, 10, 10);
    } else {
      // game over screen
      background(0, 0, 255);
      fill(255);
      textSize(30);
      textAlign(CENTER);
      text("Game Over", width/2, height/2);
      textSize(20);
      text("Final Score: " + score, width/2, height/2 + 30);
      text("Press 'R' to restart", width/2, height/2 + 60);
    }
  } else {
    // start screen
    image(BackRainImg, 0, 0, width, height);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("Dodgy Doggie", width/5, height/5);
    text("Use the keys 'A' to go left and 'D' to go right", width/2, height/2);
    text("Press any key to start", width/2, height - 50);
  }
}

void keyPressed() {
  if (!gameStarted) {
    gameStarted = true;
  } else {
    if (key == 'r' || key == 'R') {
      reset();
    }
    if (!gameOver) {
      // move player
      if (key == 'a' || key == 'A') {
        playerX -= playerSpeed;
      }
      if (key == 'd' || key == 'D') {
        playerX += playerSpeed;
      }
    }
  }
}
