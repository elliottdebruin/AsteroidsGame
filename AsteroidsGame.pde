
SpaceShip ship = new SpaceShip();
UFO ufo = new UFO();
ArrayList<Asteroid> rocks;
ArrayList<Bullet> bullets;
ArrayList<Laser> lasers;
Star[] nStar;
public boolean gameOver = false;
public boolean startGame = false;
public boolean instructions = false;

public int score;
public int health;
public int bestScore = 0;

public void setup() {
    size(800, 600);
    background(0);
    score = 0;
    health = 3;
    rocks = new ArrayList<Asteroid>();
    bullets = new ArrayList<Bullet>();
    lasers = new ArrayList<Laser>();
    nStar = new Star[200];

    for (int i = 0; i < nStar.length; i++) {
        nStar[i] = new Star();
    }
}
public void mousePressed () {
      //TRY AGAIN BUTTON
      if(startGame == true && gameOver == true && mouseX>250 && mouseX<550 && mouseY>400 && mouseY<500){
        gameOver = false;
        score = 0;
      }
      //START GAME BUTTON
      if(startGame == false && gameOver == false && mouseX>250 && mouseX<550 && mouseY>400 && mouseY<500){
        startGame = true;
      }
      if(startGame == false && gameOver == false && mouseX>250 && mouseX<550 && mouseY>510 && mouseY<550){
        instructions = true;
      }
      if(instructions == true && mouseX>530 && mouseX<630 && mouseY>530 && mouseY<580){
        instructions = false;
        startGame = false;
      }
      if(mousePressed == true && gameOver == false){
        bullets.add(new Bullet(ship));
      }
}
public void draw() {
  if(startGame == false){

    background(50);
    textSize(75);
    text("ASTEROIDS", 190, 120, 600, 600);

    //START BUTTON
    fill(0);
    rect(250,400,300,100,20);
    fill(255);
    textSize(50);
    text("Start Game", 270, 430, 600, 600);

    fill(0);
    rect(250,510,300,50,20);
    fill(255);
    textSize(40);
    text("Instructions", 295, 520, 600, 600);

    if(instructions == true){
      background(50);
      textAlign(CENTER);
      textSize(50);
      text("Controls", 100, 100, 600, 600);
      textSize(35);
      text("W = accelerate forward", 100, 175, 600, 600);
      text("S = decelerate", 100, 250, 600, 600);
      text("D = stop", 100, 325, 600, 600);
      text("SPACE = hyperspace", 100, 400, 600, 600);
      fill(0);
      rect(580,530,100,50,20);
      fill(255);
      textAlign(RIGHT);
      text("Back", 70, 544, 600, 600);
      textAlign(LEFT);
    }
  }


  if(startGame == true){
      //GAMEOVER SCREEN
      if(gameOver == true){
        background(150, 0, 0);

        //TEXT AND BUTTON
        textSize(75);
        text("GAME OVER", 185, 150, 600, 600);
        textSize(40);
        text("Best Score: " + bestScore, 275,280,600,600);
        text("Score: " + score, 325,330,600,600);
        fill(0);
        rect(250,400,300,100,20);
        fill(255);
        textSize(50);
        text("TRY AGAIN", 270, 420, 600, 600);

        
      }
      if(gameOver == false){
        background(0);
        if(bestScore<score){
          bestScore = score;
        }
        //CREATES ARRAY OF STARS
        for (int i = 0; i < nStar.length; i++) {
          nStar[i].show();
        }
        
        //ADDS ASTEROIDS IF THERE ARE LESS THAN 8
        if(rocks.size()<8){
          rocks.add(new Asteroid());
        }
        if(score>50){
          ufo.move();
          ufo.show();
        }
        //DRAWS AND MOVES ASTEROIDS
        for(int l = 0; l < lasers.size(); l++){
          if(dist((float)lasers.get(l).getX(), (float)lasers.get(l).getY(), (float)ship.getX(), (float)ship.getY())<20){
              lasers.remove(l);
               gameOver = true;
              ship.setX(300);
              ship.setY(300);
              ship.setDirectionX(0);
              ship.setDirectionY(0);
              
            }
        }
        for(int r = 0; r < rocks.size(); r++){
          rocks.get(r).move();
          rocks.get(r).show();
        
          for(int b = 0; b < bullets.size(); b++){
            if(dist((float)rocks.get(r).getX(), (float)rocks.get(r).getY(), (float)bullets.get(b).getX(), (float)bullets.get(b).getY())<20){
              
              if(score>50 ){
                lasers.add(new Laser(ufo));
              }
              rocks.remove(r);
              bullets.remove(b);
              score = score + 10;
              break;
            }

            if(dist((float)rocks.get(r).getX(), (float)rocks.get(r).getY(), (float)ship.getX(), (float)ship.getY())<20){
             gameOver = true;
              ship.setX(300);
              ship.setY(300);
              ship.setDirectionX(0);
              ship.setDirectionY(0);
              
            }

          }
        }
        if(health < 1){
             
        }
        //CREATES SPACESHIP
        ship.controls();
        ship.show();
        ship.move();
        //CREATES BULLETS    
        for(int i = 0; i < bullets.size(); i++){
          bullets.get(i).move();
          bullets.get(i).showBullet();
        }
        for(int i = 0; i < lasers.size(); i++){
          lasers.get(i).move();
          lasers.get(i).showLaser();
        }
        textSize(40);
        fill(255,0,0);
        text("Score: " + score, 10, 10, 600, 600);
      }
  }
}


class Asteroid extends Floater {

    

    public Asteroid() {
      sizeA = 6;
      if(Math.random()>0.5){
        rotAsteroid = (int)(Math.random()*2+1);
      } else {
        rotAsteroid = -(int)(Math.random()*2+1);
      }
      
      corners = 8;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = (int)(Math.random()*3*sizeA+7);
      yCorners[0] = -(int)(Math.random()*2*sizeA+7);
      xCorners[1] = (int)(Math.random()*5*sizeA+7);
      yCorners[1] = (int)(Math.random()*1*sizeA+7);
      xCorners[2] = (int)(Math.random()*3*sizeA+7);
      yCorners[2] = (int)(Math.random()*4*sizeA+7);
      xCorners[3] = (int)(Math.random()*0*sizeA+7);
      yCorners[3] = (int)(Math.random()*2*sizeA+7);
      xCorners[4] = -(int)(Math.random()*2*sizeA+7);
      yCorners[4] = (int)(Math.random()*3*sizeA+7);
      xCorners[5] = -(int)(Math.random()*4*sizeA+7);
      yCorners[5] = (int)(Math.random()*0*sizeA+7);
      xCorners[6] = -(int)(Math.random()*2*sizeA+7);
      yCorners[6] = -(int)(Math.random()*3*sizeA+7);
      xCorners[7] = (int)(Math.random()*1*sizeA+7);
      yCorners[7] = -(int)(Math.random()*2*sizeA+7);


      myCenterX = (int)(Math.random()*-20);
      myCenterY = (int)(Math.random()*-20);
      speed = 1 + (score/100);
      ang = Math.random()*2*Math.PI;
      myDirectionX = Math.cos(ang)*speed;
      myDirectionY = Math.sin(ang)*speed; 
      myPointDirection = 0;
      myColor = color(255);
    }

    //ASTEROID GETTERS AND SETTERS
    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int) myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int) myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}
    public void setColor(color rgb) {myColor = rgb;}
    public color getColor() {return myColor;}
    public int rotAsteroid;
    public int sizeA;
    public double ang, speed;


    public void move() 
        { 
          rotate(rotAsteroid); 
          super.move();
        }
    public void show() //Draws the floater at the current position  
        {
          super.show();
        }
}


class UFO extends Floater {
  double theta = 0;
  public UFO() {
    
    corners = 33;
    xCorners = new int[corners];
    yCorners = new int[corners];
        xCorners[0] = 14;
        yCorners[0] = 0;
        xCorners[1] = 13;
        yCorners[1] = 1;
        xCorners[2] = 12;
        yCorners[2] = 1;
        xCorners[3] = 11;
        yCorners[3] = 2;
        xCorners[4] = 5;
        yCorners[4] = 2;
        xCorners[5] = 3;
        yCorners[5] = 4;
        xCorners[6] = 2;
        yCorners[6] = 4;
        xCorners[7] = 0;
        yCorners[7] = 6;
        xCorners[8] = 0;
        yCorners[8] = 7;
        xCorners[9] = 2;
        yCorners[9] = 12;
        xCorners[10] = 9;
        yCorners[10] = 12;
        xCorners[11] = 9;
        yCorners[11] = 13;
        xCorners[12] = 0;
        yCorners[12] = 13;
        xCorners[13] = -6;
        yCorners[13] = 7;
        xCorners[14] = -7;
        yCorners[14] = 4;
        xCorners[15] = -8;
        yCorners[15] = 3;
        xCorners[16] = -6;
        yCorners[16] = 2;

        xCorners[17] = -6;
        yCorners[17] = -2;
        xCorners[18] = -8;
        yCorners[18] = -3;
        xCorners[19] = -7;
        yCorners[19] = -4;
        xCorners[20] = -6;
        yCorners[20] = -7;
        xCorners[21] = 0;
        yCorners[21] = -13;
        xCorners[22] = 9;
        yCorners[22] = -13;
        xCorners[23] = 9;
        yCorners[23] = -12;
        xCorners[24] = 2;
        yCorners[24] = -12;
        xCorners[25] = 0;
        yCorners[25] = -7;
        xCorners[26] = 0;
        yCorners[26] = -6;
        xCorners[27] = 2;
        yCorners[27] = -4;
        xCorners[28] = 3;
        yCorners[28] = -4;
        xCorners[29] = 5;
        yCorners[29] = -2;
        xCorners[30] = 11;
        yCorners[30] = -2;
        xCorners[31] = 12;
        yCorners[31] = -1;
        xCorners[32] = 13;
        yCorners[32] = -1;
       

     myColor = color(0,0,255);

        myCenterX = ship.getX() + 100*Math.cos(theta);
        myCenterY = ship.getY() + 100*Math.sin(theta);
        myDirectionX = ship.getDirectionX();
        myDirectionY = ship.getDirectionY();
        myPointDirection = 0;
  }
    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int) myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int) myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}
    public void setColor(color rgb) {myColor = rgb;}
    public color getColor() {return myColor;}

    public void accelerate(double dAmount) {

        double dRadians = myPointDirection * (Math.PI / 180);
        //change coordinates of direction of travel    
        myDirectionX += ((dAmount) * Math.cos(dRadians));
        myDirectionY += ((dAmount) * Math.sin(dRadians));
        if(myDirectionX > 10){
          myDirectionX = 10;
        }
        if(myDirectionY > 10){
          myDirectionY = 10;
        }
    }


    public void move() //move the floater in the current direction of travel
        {

            //change the x and y coordinates by myDirectionX and myDirectionY       
              myCenterX = ship.getX() + 250*Math.cos(theta);
              myCenterY = ship.getY() + 150*Math.sin(theta);
              theta = theta + 0.02;

            //FIRST QUADRANT
            if (ufo.getX() < ship.getX() && ufo.getY() > ship.getY()) {
                myPointDirection = (-1) * (180 / Math.PI) * Math.atan(Math.abs((double) ship.getY() - (double) ufo.getY()) / Math.abs((double) ship.getX() - (double) ufo.getX()));
            }
            //SECOND QUADRANT
            if (ufo.getX() > ship.getX() && ufo.getY() > ship.getY()) {
                myPointDirection = 180 + (180 / Math.PI) * Math.atan(Math.abs((double) ship.getY() - (double) ufo.getY()) / Math.abs((double) ship.getX() - (double) ufo.getX()));
            }
            //THIRD QUADRANT
            if (ufo.getX() > ship.getX() && ufo.getY() < ship.getY()) {
                myPointDirection = 180 - (180 / Math.PI) * Math.atan(Math.abs((double) ship.getY() - (double) ufo.getY()) / Math.abs((double) ship.getX() - (double) ufo.getX()));
            }
            //FOURTH QUADRANT
            if (ufo.getX() < ship.getX() && ufo.getY() < ship.getY()) {
                myPointDirection = (180 / Math.PI) * Math.atan(Math.abs((double) ship.getY() - (double) ufo.getY()) / Math.abs((double) ship.getX() - (double) ufo.getX()));
            }

            //wrap around screen    
            if (myCenterX > width) {
                myCenterX = 0;
            } else if (myCenterX < 0) {
                myCenterX = width;
            }
            if (myCenterY > height) {
                myCenterY = 0;
            } else if (myCenterY < 0) {
                myCenterY = height;
            }
        }



    public void show() {
        fill(myColor);
        stroke(myColor);
        super.show();
    }
}

class SpaceShip extends Floater {

    public SpaceShip() {

        //SPACESHIP
        corners = 55;
        xCorners = new int[corners];
        yCorners = new int[corners];
        xCorners[0] = 0;
        yCorners[0] = 0;
        xCorners[1] = -4;
        yCorners[1] = -3;
        xCorners[2] = 8;
        yCorners[2] = -3;
        xCorners[3] = 8;
        yCorners[3] = -2;
        xCorners[4] = 15;
        yCorners[4] = -2;
        xCorners[5] = 15;
        yCorners[5] = -2;
        xCorners[6] = 14;
        yCorners[6] = -2;
        xCorners[7] = 14;
        yCorners[7] = -3;
        xCorners[8] = 13;
        yCorners[8] = -3;
        xCorners[9] = 13;
        yCorners[9] = -4;
        xCorners[10] = 12;
        yCorners[10] = -4;
        xCorners[11] = 12;
        yCorners[11] = -5;
        xCorners[12] = -6;
        yCorners[12] = -5;
        xCorners[13] = -7;
        yCorners[13] = -7;
        xCorners[14] = -5;
        yCorners[14] = -7;
        xCorners[15] = -1;
        yCorners[15] = -9;
        xCorners[16] = -5;
        yCorners[16] = -11;
        xCorners[17] = -6;
        yCorners[17] = -11;
        xCorners[18] = -11;
        yCorners[18] = -13;
        xCorners[19] = -11;
        yCorners[19] = -11;
        xCorners[20] = -12;
        yCorners[20] = -11;
        xCorners[21] = -14;
        yCorners[21] = -10;
        xCorners[22] = -14;
        yCorners[22] = -8;
        xCorners[23] = -12;
        yCorners[23] = -7;
        xCorners[24] = -10;
        yCorners[24] = -4;
        xCorners[25] = -11;
        yCorners[25] = -3;
        xCorners[26] = -11;
        yCorners[26] = -2;
        xCorners[27] = -12;
        yCorners[27] = -1;
        xCorners[28] = -12;
        yCorners[28] = 1;
        xCorners[29] = -11;
        yCorners[29] = 2;
        xCorners[30] = -11;
        yCorners[30] = 3;
        xCorners[31] = -10;
        yCorners[31] = 4;
        xCorners[32] = -12;
        yCorners[32] = 7;
        xCorners[33] = -14;
        yCorners[33] = 8;
        xCorners[34] = -14;
        yCorners[34] = 10;
        xCorners[35] = -12;
        yCorners[35] = 11;
        xCorners[36] = -11;
        yCorners[36] = 11;
        xCorners[37] = -11;
        yCorners[37] = 13;
        xCorners[38] = -6;
        yCorners[38] = 11;
        xCorners[39] = -5;
        yCorners[39] = 11;
        xCorners[40] = -1;
        yCorners[40] = 9;
        xCorners[41] = -5;
        yCorners[41] = 7;
        xCorners[42] = -7;
        yCorners[42] = -7;
        xCorners[43] = -6;
        yCorners[43] = 5;
        xCorners[44] = 12;
        yCorners[44] = 5;
        xCorners[45] = 12;
        yCorners[45] = 4;
        xCorners[46] = 13;
        yCorners[46] = 4;
        xCorners[47] = 13;
        yCorners[47] = 3;
        xCorners[48] = 14;
        yCorners[48] = 3;
        xCorners[49] = 14;
        yCorners[49] = 2;
        xCorners[50] = 15;
        yCorners[50] = 2;
        xCorners[51] = 15;
        yCorners[51] = 2;
        xCorners[52] = 8;
        yCorners[52] = 2;
        xCorners[53] = 8;
        yCorners[53] = 3;
        xCorners[54] = -4;
        yCorners[54] = 3;

        //Thruster 1
        corners2 = 5;
        xCorners2 = new int[corners2];
        yCorners2 = new int[corners2];
        xCorners2[0] = -14;
        yCorners2[0] = -8;
        xCorners2[1] = -14;
        yCorners2[1] = -10;
        xCorners2[2] = -17;
        yCorners2[2] = -12;
        xCorners2[3] = -25;
        yCorners2[3] = -9;
        xCorners2[4] = -17;
        yCorners2[4] = -6;

        //Thruster 2
        corners3 = 5;
        xCorners3 = new int[corners3];
        yCorners3 = new int[corners3];
        xCorners3[0] = -14;
        yCorners3[0] = 8;
        xCorners3[1] = -14;
        yCorners3[1] = 10;
        xCorners3[2] = -17;
        yCorners3[2] = 12;
        xCorners3[3] = -25;
        yCorners3[3] = 9;
        xCorners3[4] = -17;
        yCorners3[4] = 6;


        myColor = color(175);
        myCenterX = 300;
        myCenterY = 300;
        myDirectionX = 0;
        myDirectionY = 0;
        myPointDirection = 0;
    }

    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int) myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int) myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}
    public void setColor(color rgb) {myColor = rgb;}
    public color getColor() {return myColor;}

    public void accelerate(double dAmount) {

        double dRadians = myPointDirection * (Math.PI / 180);
        //change coordinates of direction of travel    
        myDirectionX += ((dAmount) * Math.cos(dRadians));
        myDirectionY += ((dAmount) * Math.sin(dRadians));
        if(myDirectionX > 10){
          myDirectionX = 10;
        }
        if(myDirectionY > 10){
          myDirectionY = 10;
        }
    }

    public void move() //move the floater in the current direction of travel
        {

            //change the x and y coordinates by myDirectionX and myDirectionY       
            myCenterX += myDirectionX;
            myCenterY += myDirectionY;

            //FIRST QUADRANT
            if (mouseX > ship.getX() && mouseY < ship.getY()) {
                myPointDirection = (-1) * (180 / Math.PI) * Math.atan(Math.abs((double) mouseY - (double) ship.getY()) / Math.abs((double) mouseX - (double) ship.getX()));
            }
            //SECOND QUADRANT
            if (mouseX < ship.getX() && mouseY < ship.getY()) {
                myPointDirection = 180 + (180 / Math.PI) * Math.atan(Math.abs((double) mouseY - (double) ship.getY()) / Math.abs((double) mouseX - (double) ship.getX()));
            }
            //THIRD QUADRANT
            if (mouseX < ship.getX() && mouseY > ship.getY()) {
                myPointDirection = 180 - (180 / Math.PI) * Math.atan(Math.abs((double) mouseY - (double) ship.getY()) / Math.abs((double) mouseX - (double) ship.getX()));
            }
            //FOURTH QUADRANT
            if (mouseX > ship.getX() && mouseY > ship.getY()) {
                myPointDirection = (180 / Math.PI) * Math.atan(Math.abs((double) mouseY - (double) ship.getY()) / Math.abs((double) mouseX - (double) ship.getX()));
            }

            //wrap around screen    
            if (myCenterX > width) {
                myCenterX = 0;
            } else if (myCenterX < 0) {
                myCenterX = width;
            }
            if (myCenterY > height) {
                myCenterY = 0;
            } else if (myCenterY < 0) {
                myCenterY = height;
            }
        }



    public void controls() {
        if (keyPressed && key == 'w') //accelerate
        {
            ship.accelerate(0.2);

            //Shows rockets
            double dRadians = myPointDirection * (Math.PI / 180);
            int xRotatedTranslated, yRotatedTranslated;
            fill((int)(Math.random()*255), 0, 0);
            noStroke();
            beginShape();
            for (int nI = 0; nI < corners3; nI++) {
                //rotate and translate the coordinates of the floater using current direction 
                xRotatedTranslated = (int)((xCorners3[nI] * Math.cos(dRadians)) - (yCorners3[nI] * Math.sin(dRadians)) + myCenterX);
                yRotatedTranslated = (int)((xCorners3[nI] * Math.sin(dRadians)) + (yCorners3[nI] * Math.cos(dRadians)) + myCenterY);
                vertex(xRotatedTranslated, yRotatedTranslated);
            }
            endShape(CLOSE);
            beginShape();
            for (int nI = 0; nI < corners2; nI++) {
                //rotate and translate the coordinates of the floater using current direction 
                xRotatedTranslated = (int)((xCorners2[nI] * Math.cos(dRadians)) - (yCorners2[nI] * Math.sin(dRadians)) + myCenterX);
                yRotatedTranslated = (int)((xCorners2[nI] * Math.sin(dRadians)) + (yCorners2[nI] * Math.cos(dRadians)) + myCenterY);
                vertex(xRotatedTranslated, yRotatedTranslated);
            }
            endShape(CLOSE);
        }
        if (keyPressed && key == 's') //decelerate
        {
            ship.accelerate(-0.2);
        }
        if (keyPressed && key == 'd') {
            ship.myDirectionX = 0;
            ship.myDirectionY = 0;
        }
        if (keyPressed && key == ' ') {
            ship.setX((int)(Math.random() * 600));
            ship.setY((int)(Math.random() * 600));

        }
    }


    public void show() {
        fill(myColor);
        stroke(myColor);
        super.show();
    }
}

class Laser extends Floater {
    public double dRadians;
    public Laser(UFO theUFO) {
        myCenterX = theUFO.getX();
        myCenterY = theUFO.getY();
        myPointDirection = theUFO.getPointDirection();
        dRadians = myPointDirection*(Math.PI/180);
        myDirectionX = 5*Math.cos(dRadians) + theUFO.getDirectionX();
        myDirectionY = 5*Math.sin(dRadians) + theUFO.getDirectionY();
    }
    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int) myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int) myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}

    public void move() {
        myCenterX += myDirectionX;    
        myCenterY += myDirectionY;
    }
    public void showLaser() {
        fill(255,0,0);
        ellipse((float)myCenterX, (float)myCenterY, 5, 5);
    }
}

class Bullet extends Floater {
    public double dRadians;
    public Bullet(SpaceShip theShip) {
        myCenterX = theShip.getX();
        myCenterY = theShip.getY();
        myPointDirection = theShip.getPointDirection();
        dRadians = myPointDirection*(Math.PI/180);
        myDirectionX = 5*Math.cos(dRadians) + theShip.getDirectionX();
        myDirectionY = 5*Math.sin(dRadians) + theShip.getDirectionY();
    }
    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int) myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int) myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}

    public void move() {
        myCenterX += myDirectionX;    
        myCenterY += myDirectionY;
    }
    public void showBullet() {
        fill(0,0,255);
        ellipse((float)myCenterX, (float)myCenterY, 5, 5);
    }
}
 //Do NOT modify the Floater class! Make changes in the SpaceShip class
abstract class Floater {
    protected int corners; //the number of corners, a triangular floater has 3   
    protected int[] xCorners;
    protected int[] yCorners;
    protected int corners2; //the number of corners, a triangular floater has 3   
    protected int[] xCorners2;
    protected int[] yCorners2;
    protected int corners3; //the number of corners, a triangular floater has 3   
    protected int[] xCorners3;
    protected int[] yCorners3;
    protected int myColor;
    protected double myCenterX, myCenterY; //holds center coordinates   
    protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
    protected double myPointDirection; //holds current direction the ship is pointing in degrees    
    abstract public void setX(int x);
    abstract public int getX();
    abstract public void setY(int y);
    abstract public int getY();
    abstract public void setDirectionX(double x);
    abstract public double getDirectionX();
    abstract public void setDirectionY(double y);
    abstract public double getDirectionY();
    abstract public void setPointDirection(int degrees);
    abstract public double getPointDirection();

    //Accelerates the floater in the direction it is pointing (myPointDirection)   
    public void accelerate(double dAmount) {
        //convert the current direction the floater is pointing to radians    
        double dRadians = myPointDirection * (Math.PI / 180);
        //change coordinates of direction of travel    
        myDirectionX += ((dAmount) * Math.cos(dRadians));
        myDirectionY += ((dAmount) * Math.sin(dRadians));
    }
    public void rotate(int nDegreesOfRotation) {
        //rotates the floater by a given number of degrees    
        myPointDirection += nDegreesOfRotation;
    }
    public void move() //move the floater in the current direction of travel
        {
            //change the x and y coordinates by myDirectionX and myDirectionY       
            myCenterX += myDirectionX;
            myCenterY += myDirectionY;

            //wrap around screen    
            if (myCenterX > width) {
                myCenterX = 0;
            } else if (myCenterX < 0) {
                myCenterX = width;
            }
            if (myCenterY > height) {
                myCenterY = 0;
            } else if (myCenterY < 0) {
                myCenterY = height;
            }
        }
    public void show() //Draws the floater at the current position  
        {
            fill(myColor);
            stroke(myColor);
            //convert degrees to radians for sin and cos         
            double dRadians = myPointDirection * (Math.PI / 180);
            int xRotatedTranslated, yRotatedTranslated;
            beginShape();
            for (int nI = 0; nI < corners; nI++) {
                //rotate and translate the coordinates of the floater using current direction 
                xRotatedTranslated = (int)((xCorners[nI] * Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians)) + myCenterX);
                yRotatedTranslated = (int)((xCorners[nI] * Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians)) + myCenterY);
                vertex(xRotatedTranslated, yRotatedTranslated);
            }
            endShape(CLOSE);
        }
}

class Star {
    private int x;
    private int y;
    public Star() {
        x = (int)(Math.random() * 800);
        y = (int)(Math.random() * 600);
    }

    public void show() {
        fill(255);
        noStroke();
        ellipse(x, y, 2, 2);
    }
}
