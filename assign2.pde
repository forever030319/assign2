final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState;
float speed = 5;

PImage start2, start1, end2, end1;
int hp_initial=20;
int hp;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage hpImg,treasureImg,fighterImg,enermyImg;
PImage bg1,bg2;
int width=640, height=480;
int treasure_width=41, treasure_height=41; //treasure's size
int treasure_x,treasure_y; //treasure's position
int enermy_height=61, enermy_width=61; //enermy's size
float enermy_x,enermy_y; //enermy's position
int x_flood, rand_flood;
int bg1_x,bg1_y;
int bg2_x,bg2_y;
int flighter_x,flighter_y;
int flighter_width=51, flighter_height=51;

int EnermyToFlighter;
float enermy_count;
void setup () {
  size(640, 480) ;
  background(0);
  
  start2 = loadImage("img/start2.png");//default
  start1 = loadImage("img/start1.png");//cursor
  
  end2 = loadImage("img/end2.png");
  end1 = loadImage("img/end1.png");
  
  hpImg = loadImage("img/hp.png");
  treasureImg = loadImage("img/treasure.png");
  fighterImg = loadImage("img/fighter.png");
  enermyImg = loadImage("img/enemy.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  
  flighter_x=580;
  flighter_y=240;

  treasure_x = floor(random(width-treasure_width/2));
  treasure_y = floor(random(height-treasure_height/2));
  
  enermy_x = 0;
  enermy_y = floor(random(height-enermy_height));
  
  x_flood = 200;
  bg1_x = -640;
  bg1_y = 0;
  bg2_x = 0;
  bg2_y = 0;
  
  gameState = GAME_START;
  enermy_count = 2;
}

void draw() {

background(0); // clear scene

  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if( mouseY<410 && mouseY>375 && mouseX>200 && mouseX<450){
        image(start1,0,0);
        if (mousePressed){
          gameState = GAME_RUN;
        }
      }
      break;
    
    case GAME_RUN:
      image(bg1,bg1_x,0); 
      image(bg2,bg2_x,0);
      
      hp = (x_flood/100)*hp_initial;
      if(hp>=200){
        hp_initial = 100;
        hp = 200;
      }
      if(hp<=0){
        hp_initial = 0;
        hp = 0;
        gameState = GAME_LOSE;
      }
      
      //HP
      stroke(0);
      fill(255,0,0);
      rect(5,4,hp,20);
      
      image(hpImg,0,0);
      
      image(fighterImg,flighter_x,flighter_y);
      image(treasureImg,treasure_x,treasure_y);
      image(enermyImg,enermy_x,enermy_y);
    
      //enermy
      enermy_x = enermy_x +3;
      enermy_x %= 640;
      
   
      if(enermy_y > flighter_y ){
        enermy_y = enermy_y - enermy_count;
      }
      if(enermy_y < flighter_y ){
        enermy_y = enermy_y + enermy_count;
      }
      if(enermy_x == flighter_x){
        if(enermy_y > flighter_y){
          EnermyToFlighter = 0;
        }
        if(enermy_y < flighter_y){
          EnermyToFlighter = 1;
        }
      }
     
      //background image movement
      bg2_x++;
      bg1_x++;
    
      if(bg2_x==640){
        bg2_x = -640;
      }
      if(bg1_x == 640){
       bg1_x =-640; 
      }
   
      if (upPressed) {
        flighter_y -= speed;
      }
      if (downPressed) {
        flighter_y += speed;
      }
      if (leftPressed) {
        flighter_x -= speed;
      }
      if (rightPressed) {
        flighter_x += speed;
      }
      
      //boundary detection
      if(flighter_x >= width-flighter_width){
        flighter_x = width-flighter_width;
      }
      if( flighter_x<0 ){
        flighter_x = 0;
      }
      
      if(flighter_y> height-flighter_height){
        flighter_y=height-flighter_height;
      }
      if(flighter_y<0){
        flighter_y=0;
      }
       
      //flighter to treasure
      if(flighter_x+flighter_width >= treasure_x && flighter_x <= treasure_x+treasure_width && flighter_y+flighter_height >= treasure_y && flighter_y <= treasure_y+treasure_height){
        treasure_x = floor(random(width-treasure_width/2));
        treasure_y = floor(random(height-treasure_height/2));
        hp_initial = hp_initial+10;
      }
  
      //flighter to enermy
      if(flighter_x+flighter_width >= enermy_x && flighter_x <= enermy_x+enermy_width && flighter_y+flighter_height >= enermy_y && flighter_y <= enermy_y+enermy_height){
        enermy_x = 0;
        enermy_y = floor(random(height-enermy_height));
        hp_initial = hp_initial-20;
      }
      break;
    
    case GAME_LOSE:
      image(end2,0,0);
      if( mouseY<350 && mouseY>300 && mouseX>200 && mouseX<430){
        image(end1,0,0);
        if (mousePressed){
          background(0);
          hp_initial = 20;
          flighter_x=580;
          flighter_y=240;
          gameState = GAME_RUN;
        }
      }
      break;
  }
}
void keyPressed(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
