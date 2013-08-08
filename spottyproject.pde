/*
 * thespottyproject
 * Blanca A. Vargas Govea
 * blanca.vg@gmail.com
 *
 * Date August 5, 2013
 * 
 * Copyright notice
 *   thespottyproject is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   spottyproject is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *   http://www.gnu.org/licenses/gpl.html
 *   You should have received a copy of the GNU General Public License
 *   along with spottyproject.  If not, see <http://www.gnu.org/licenses/>.
 */

///*@pjs preload="apple.png,candy.png,cheese.png,cupcake.png,hamsterIcon1.png,inactiveNew.png,inactiveOrdered.png,intro.png";*/

int xArr[] = new int[9];
int yArr[] = new int[9];
int myPath[] = new int[9]; //it holds an index with the user's input
int itemCounter = 0;
int prevmyItem = 0;
int myItem = 0;

int index = 0;
int startX;  // Initial x-coordinate
int stopX;  // Final x-coordinate
int startY;  // Initial y-coordinate
int stopY;   // Final y-coordinate
float x;
float y;
float distance;
Maxim maxim;
AudioPlayer player2;
AudioPlayer player3;
Game game;
Button bNew;
Button bMypath;
Button bOrdered;
Button bCredits;
int itemcounter = 0;
boolean newgame = false;
//limits to place the images
int minX = 160;
int maxX = 600;
int minY = 20;
int maxY = 340;
String msg = "";  

void setup(){
  size(750, 500); //total area
  setBkg();
  maxim = new Maxim(this);
  player2 = maxim.loadFile("ding.wav");
  player2.setLooping(false);
  player3 = maxim.loadFile("childlaugh.wav");
  player3.setLooping(false); 
}

void setBkg(){
  //PImage imgIntro;
  
  background(200);  
  fill(230);                //arena color
  noStroke();
  rect(150, 10, 500, 380);  //central area
  rect(5, 10, 140, 380);    //left area
  rect(655, 10, 90, 380);  //right area
  rect(5, 395, 740, 100);  //bottom area  
 
  /*imgIntro = loadImage("intro.png");    
  noStroke();    
  image(imgIntro, 155, 12); */
  
  /* set buttons */
  bNew = new Button("New", 660, 20, 80, 30);
  PImage bNewInactive = loadImage("inactiveNew.png");
  bNew.setInactiveImage(bNewInactive);  
  
  bOrdered = new Button("Ordered", 660, 60, 80, 30);
  PImage bOrderedInactive = loadImage("inactiveOrdered.png");
  bOrdered.setInactiveImage(bOrderedInactive);
  
  bMypath = new Button("my Path", 660, 100, 80, 30);
  PImage bMyPathInactive = loadImage("inactiveMypath.png");
  bMypath.setInactiveImage(bMyPathInactive);    
}

void setMsgbottom(String msg){
  int xRan;
  int yRan;
  fill(230); //arena color
  noStroke();
  rect(5, 395, 740, 100);  //bottom area 
  textSize(24);        
  fill(201, 65, 81);
  text(msg, 10, 424);   
}

void setMsgSpotty(String msg, int tsize){  
  int rRan;
  int gRan;
  int bRan;
  int aRan;
     
  rRan = int(random(100,255));
  gRan = int(random(100,255));
  bRan = int(random(100,255));
 // aRan = int(random(150,255)); 
  fill(rRan, gRan, bRan); //message background color
  noStroke();
  rect(xArr[0] + 48, yArr[0] + 10, 100, 30);  //Spottie's area 
  textSize(tsize);        
  fill(100, 100, 100);
  text(msg, xArr[0] + 53, yArr[0] + 30);    
}
 
void draw() { 
 bNew.display();
 bMypath.display();
 bOrdered.display();
 
 if (mousePressed){
   for (int i = 0; i < xArr.length; i += 1 ){   // see which item was clicked
     if ((mouseX >= xArr[i]) && (mouseX <= xArr[i] + 50) && (mouseY >= yArr[i]) && (mouseY <= yArr[i] + 50)){
       print("You are over item:"+i+"\n");
       // escribir solamente los diferentes
       if (i != prevmyItem){
         itemCounter += 1; 
         print("Please, input this item\n");                    
         myItem = i;
         game.getmyPath(prevmyItem, myItem);
         prevmyItem = myItem;       
       } else{
           print("Repeated item, ignore it\n");
         }
       //myPath[myIndex] = i;
             
       if (i==8){
         setMsgSpotty("you tickled me!", 12);
         player3.stop();
         player3.play();
       }      
     }
   }//end for   
  }
 }
 
 void mousePressed(){    
  if(bNew.mousePressed()){
    println("New game - pressed");   
    newgame = true;
    setBkg();
    rect(150, 10, 500, 380);  //central area
    setMsgbottom("I want to get all the items at minimum cost\n");
    game = new Game();
    game.initPath();
    game.setSpotty();
    game.setFood();  
    game.startVars();  
    game.showPoints(); //Ready to order the points and traverse the path    
  } else if(bMypath.mousePressed()){
      println("Click the next item to eat\n");
      setMsgbottom("Click the next item to eat\n");      
  } else if(bMypath.mousePressed()){
      setMsgbottom("I have no items to eat, please press New\n");
  } else if(bOrdered.mousePressed() && newgame == true){
      println("Spotty follows a dummy strategy\n"); 
      setMsgbottom("Spotty follows a dummy strategy. She eats the food items \n according to their order of appearance\n");
      msg = game.ordered(); 
      player2.stop();
      player2.play();
      setMsgbottom(msg+"\n");
      setMsgSpotty("I finished!", 18);
  } else if(bOrdered.mousePressed() && newgame == false){
        setMsgbottom("I have no items to eat, please press New\n");
      }
    }

void mouseReleased(){
  if(bNew.mouseReleased()){
    println("New game - released");
    //newgame = false;     
  }
}
