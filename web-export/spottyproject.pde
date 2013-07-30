// spotty the hungry hamster
/*@pjs preload="apple.png,candy.png,cheese.png,cupcake.png,hamsterIcon1.png,inactiveNew.png,inactiveOrdered.png,intro.png";*/

int xArr[] = new int[9];
int yArr[] = new int[9];
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
   PImage imgIntro;
  
  background(200);  
  fill(230); //arena color
  noStroke();
  rect(150, 10, 500, 380);  //central area
  rect(5, 10, 140, 380);    //left area
  rect(655, 10, 90, 380);  //right area
  rect(5, 395, 740, 100);  //bottom area
  
 
    imgIntro = loadImage("intro.png");    
    noStroke();    
    image(imgIntro, 155, 12); 
  
  //set buttons    
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
 //bMypath.display();
 bOrdered.display();
 
 if(mousePressed){
   for (int i = 0; i < xArr.length; i += 1 ){
     if ((mouseX >= xArr[i]) && (mouseX <= xArr[i] + 50) && (mouseY >= yArr[i]) && (mouseY <= yArr[i] + 50)){
       print("You are over item:"+i+"\n");
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
    
    
}

  if(bMypath.mousePressed() && newgame == true){
    println("Click the next item to eat\n");
    setMsgbottom("Click the next item to eat\n");
  }
  else if(bMypath.mousePressed() && newgame == false){
    setMsgbottom("I have no items to eat, please press New\n");
  }
  else if(bOrdered.mousePressed() && newgame == true){
    println("Spotty follows a dummy strategy\n"); 
    setMsgbottom("Spotty follows a dummy strategy. She eats the food items \n according to their order of appearance\n");
    msg = game.ordered(); 
    player2.stop();
    player2.play();
    setMsgbottom(msg+"\n");
    setMsgSpotty("I finished!", 18);
  }
  else if(bOrdered.mousePressed() && newgame == false){
    setMsgbottom("I have no items to eat, please press New\n");
  }    
}

void mouseReleased(){
  if(bNew.mouseReleased()){
    println("New game - released");
    //newgame = false;     
  }
}

int HORIZONTAL = 0;
int VERTICAL   = 1;
int UPWARDS    = 2;
int DOWNWARDS  = 3;

class Widget
{

  
  PVector pos;
  PVector extents;
  String name;

  //color inactiveColor = color(60, 60, 100);
  color inactiveColor = color(230, 230, 230);
  color activeColor = color(200, 200, 200); //100, 100, 160
  color bgColor = inactiveColor;
  color lineColor = color(255); 
  
  
  void setInactiveColor(color c)
  {
    inactiveColor = c;
    bgColor = inactiveColor;
  }
  
  color getInactiveColor()
  {
    return inactiveColor;
  }
  
  void setActiveColor(color c)
  {
    activeColor = c;
  }
  
  color getActiveColor()
  {
    return activeColor;
  }
  
  void setLineColor(color c)
  {
    lineColor = c;
  }
  
  color getLineColor()
  {
    return lineColor;
  }
  
  String getName()
  {
    return name;
  }
  
  void setName(String nm)
  {
    name = nm;
  }


  Widget(String t, int x, int y, int w, int h)
  {
    pos = new PVector(x, y);
    extents = new PVector (w, h);
    name = t;
    //registerMethod("mouseEvent", this);
  }

  void display()
  {
  }

  boolean isClicked()
  {
    
    if (mouseX > pos.x && mouseX < pos.x+extents.x 
      && mouseY > pos.y && mouseY < pos.y+extents.y)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  public void mouseEvent(MouseEvent event)
  {
    //if (event.getFlavor() == MouseEvent.PRESS)
    //{
    //  mousePressed();
    //}
  }
  
  
  boolean mousePressed()
  {
    return isClicked();
  }
  
  boolean mouseDragged()
  {
    return isClicked();
  }
  
  
  boolean mouseReleased()
  {
    return isClicked();
  }
}

class Button extends Widget
{
  PImage activeImage = null;
  PImage inactiveImage = null;
  PImage currentImage = null;
  color imageTint = color(255);
  
  Button(String nm, int x, int y, int w, int h)
  {
    super(nm, x, y, w, h);
  }
  
  void setImage(PImage img)
  {
    setInactiveImage(img);
    setActiveImage(img);
  }
  
  void setInactiveImage(PImage img)
  {
    if(currentImage == inactiveImage || currentImage == null)
    {
      inactiveImage = img;
      currentImage = inactiveImage;
    }
    else
    {
      inactiveImage = img;
    }
  }
  
  void setActiveImage(PImage img)
  {
    if(currentImage == activeImage || currentImage == null)
    {
      activeImage = img;
      currentImage = activeImage;
    }
    else
    {
      activeImage = img;
    }
  }
  
  void setImageTint(float r, float g, float b)
  {
    imageTint = color(r,g,b);
  }

  void display()
  {
    if(currentImage != null)
    {
      //float imgHeight = (extents.x*currentImage.height)/currentImage.width;
      float imgWidth = (extents.y*currentImage.width)/currentImage.height;
      
      
      pushStyle();
      imageMode(CORNER);
      tint(imageTint);
      image(currentImage, pos.x, pos.y, imgWidth, extents.y);
      stroke(bgColor); //removed the border
      noFill();
      rect(pos.x, pos.y, imgWidth,  extents.y);
      noTint();
      popStyle();
    }
    else
    {
      pushStyle();
      stroke(lineColor);
      fill(bgColor);
      rect(pos.x, pos.y, extents.x, extents.y);
  
      fill(lineColor);
      textAlign(CENTER, CENTER);
      text(name, pos.x + 0.5*extents.x, pos.y + 0.5* extents.y);
      popStyle();
    }
  }
  
  boolean mousePressed()
  {
    if (super.mousePressed())
    {
      if (bgColor == activeColor)
      {
        bgColor = inactiveColor;
      } else
      {
        bgColor = activeColor;
      }
      
      if(activeImage != null)
        currentImage = activeImage;
      return true;
    }
    return false;
  }
  
  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      bgColor = inactiveColor;
      if(inactiveImage != null)
        currentImage = inactiveImage;
      return true;
    }
    return false;
  }
}

class Toggle extends Button
{
  boolean on = false;

  Toggle(String nm, int x, int y, int w, int h)
  {
    super(nm, x, y, w, h);
  }


  boolean get()
  {
    return on;
  }

  void set(boolean val)
  {
    on = val;
    if (on)
    {
      bgColor = activeColor;
      if(activeImage != null)
        currentImage = activeImage;
    }
    else
    {
      bgColor = inactiveColor;
      if(inactiveImage != null)
        currentImage = inactiveImage;
    }
  }

  void toggle()
  {
    set(!on);
  }

  
  boolean mousePressed()
  {
    return super.isClicked();
  }

  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      toggle();
      return true;
    }
    return false;
  }
}

class RadioButtons extends Widget
{
  public Toggle [] buttons;
  
  RadioButtons (String [] names,int numButtons, int x, int y, int w, int h, int orientation)
  {
    super("", x, y, w*numButtons, h);
    buttons = new Toggle[numButtons];
    for (int i = 0; i < buttons.length; i++)
    {
      int bx, by;
      if(orientation == HORIZONTAL)
      {
        bx = x+i*(w+5);
        by = y;
      }
      else
      {
        bx = x;
        by = y+i*(h+5);
      }
      buttons[i] = new Toggle(names[i], bx, by, w, h);
    }
  }
  
  void setNames(String [] names)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(i >= names.length)
        break;
      buttons[i].setName(names[i]);
    }
  }
  
  void setImage(int i, PImage img)
  {
    setInactiveImage(i, img);
    setActiveImage(i, img);
  }
  
  void setAllImages(PImage [] img)
  {
    setAllInactiveImages(img);
    setAllActiveImages(img);
  }
  
  void setInactiveImage(int i, PImage img)
  {
    buttons[i].setInactiveImage(img);
  }

  
  void setAllInactiveImages(PImage [] img)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      buttons[i].setInactiveImage(img[i]);
    }
  }
  
  void setActiveImage(int i, PImage img)
  {
    
    buttons[i].setActiveImage(img);
  }
  
  
  
  void setAllActiveImages(PImage [] img)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      buttons[i].setActiveImage(img[i]);
    }
  }

  void set(String buttonName)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].getName().equals(buttonName))
      {
        buttons[i].set(true);
      }
      else
      {
        buttons[i].set(false);
      }
    }
  }
  
  int get()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].get())
      {
        return i;
      }
    }
    return -1;
  }
  
  String getString()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].get())
      {
        return buttons[i].getName();
      }
    }
    return "";
  }

  void display()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      buttons[i].display();
    }
  }

  boolean mousePressed()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].mousePressed())
      {
        return true;
      }
    }
    return false;
  }
  
  boolean mouseDragged()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].mouseDragged())
      {
        return true;
      }
    }
    return false;
  }

  boolean mouseReleased()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].mouseReleased())
      {
        for(int j = 0; j < buttons.length; j++)
        {
          if(i != j)
            buttons[j].set(false);
        }
        //buttons[i].set(true);
        return true;
      }
    }
    return false;
  }
}

class Slider extends Widget
{
  float minimum;
  float maximum;
  float val;
  int textWidth = 60;
  int orientation = HORIZONTAL;

  Slider(String nm, float v, float min, float max, int x, int y, int w, int h, int ori)
  {
    super(nm, x, y, w, h);
    val = v;
    minimum = min;
    maximum = max;
    orientation = ori;
    if(orientation == HORIZONTAL)
      textWidth = 60;
    else
      textWidth = 20;
    
  }

  float get()
  {
    return val;
  }

  void set(float v)
  {
    val = v;
    val = constrain(val, minimum, maximum);
  }

  void display()
  {
    
    float textW = textWidth;
    if(name == "")
      textW = 0;
    pushStyle();
    textAlign(LEFT, TOP);
    fill(lineColor);
    text(name, pos.x, pos.y);
    stroke(lineColor);
    noFill();
    if(orientation ==  HORIZONTAL){
      rect(pos.x+textW, pos.y, extents.x-textWidth, extents.y);
    } else {
      rect(pos.x, pos.y+textW, extents.x, extents.y-textW);
    }
    noStroke();
    fill(bgColor);
    float sliderPos; 
    if(orientation ==  HORIZONTAL){
        sliderPos = map(val, minimum, maximum, 0, extents.x-textW-4); 
        rect(pos.x+textW+2, pos.y+2, sliderPos, extents.y-4);
    } else if(orientation ==  VERTICAL || orientation == DOWNWARDS){
        sliderPos = map(val, minimum, maximum, 0, extents.y-textW-4); 
        rect(pos.x+2, pos.y+textW+2, extents.x-4, sliderPos);
    } else if(orientation == UPWARDS){
        sliderPos = map(val, minimum, maximum, 0, extents.y-textW-4); 
        rect(pos.x+2, pos.y+textW+2 + (extents.y-textW-4-sliderPos), extents.x-4, sliderPos);
    };
    popStyle();
  }

  
  boolean mouseDragged()
  {
    if (super.mouseDragged())
    {
      float textW = textWidth;
      if(name == "")
        textW = 0;
      if(orientation ==  HORIZONTAL){
        set(map(mouseX, pos.x+textW, pos.x+extents.x-4, minimum, maximum));
      } else if(orientation ==  VERTICAL || orientation == DOWNWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-4, minimum, maximum));
      } else if(orientation == UPWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-4, maximum, minimum));
      };
      return true;
    }
    return false;
  }

  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      float textW = textWidth;
      if(name == "")
        textW = 0;
      if(orientation ==  HORIZONTAL){
        set(map(mouseX, pos.x+textW, pos.x+extents.x-10, minimum, maximum));
      } else if(orientation ==  VERTICAL || orientation == DOWNWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-10, minimum, maximum));
      } else if(orientation == UPWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-10, maximum, minimum));
      };
      return true;
    }
    return false;
  }
}

class MultiSlider extends Widget
{
  Slider [] sliders;
  /*
  MultiSlider(String [] nm, float min, float max, int x, int y, int w, int h, int orientation)
  {
    super(nm[0], x, y, w, h*nm.length);
    sliders = new Slider[nm.length];
    for (int i = 0; i < sliders.length; i++)
    {
      int bx, by;
      if(orientation == HORIZONTAL)
      {
        bx = x;
        by = y+i*h;
      }
      else
      {
        bx = x+i*w;
        by = y;
      }
      sliders[i] = new Slider(nm[i], 0, min, max, bx, by, w, h, orientation);
    }
  }
  */
  MultiSlider(int numSliders, float min, float max, int x, int y, int w, int h, int orientation)
  {
    super("", x, y, w, h*numSliders);
    sliders = new Slider[numSliders];
    for (int i = 0; i < sliders.length; i++)
    {
      int bx, by;
      if(orientation == HORIZONTAL)
      {
        bx = x;
        by = y+i*h;
      }
      else
      {
        bx = x+i*w;
        by = y;
      }
      sliders[i] = new Slider("", 0, min, max, bx, by, w, h, orientation);
    }
  }
  
  void setNames(String [] names)
  {
    for (int i = 0; i < sliders.length; i++)
    {
      if(i >= names.length)
        break;
      sliders[i].setName(names[i]);
    }
  }

  void set(int i, float v)
  {
    if(i >= 0 && i < sliders.length)
    {
      sliders[i].set(v);
    }
  }
  
  float get(int i)
  {
    if(i >= 0 && i < sliders.length)
    {
      return sliders[i].get();
    }
    else
    {
      return -1;
    }
    
  }

  void display()
  {
    for (int i = 0; i < sliders.length; i++)
    {
      sliders[i].display();
    }
  }

  
  boolean mouseDragged()
  {
    for (int i = 0; i < sliders.length; i++)
    {
      if(sliders[i].mouseDragged())
      {
        return true;
      }
    }
    return false;
  }

  boolean mouseReleased()
  {
    for (int i = 0; i < sliders.length; i++)
    {
      if(sliders[i].mouseReleased())
      {
        return true;
      }
    }
    return false;
  }
}


public class Game{

  Hamster spotty;
  Candy candies;
  Apple apples;
  Cheese roquefort;
  Cupcake minicup;
  
  void initPath(){
    for(int i = 0; i < xArr.length; i += 1 ){
      xArr[i] = 0;
      yArr[i] = 0;
    }
  }

  void setSpotty(){   
    
    spotty = new Hamster();
    index = spotty.put(index,1);
  }

  void setFood(){
    candies = new Candy();
    index = candies.put(index, 3);
    apples = new Apple();
    index = apples.put(index, 3);
    roquefort = new Cheese();
    index = roquefort.put(index, 2);
    minicup = new Cupcake();
    index = minicup.put(index, 3);
  }

  void startVars(){    
    xArr[index] = xArr[0]; //set Hamster's position in the last index of the array
    yArr[index] = yArr[0];
    startX = xArr[0];  // Initial x-coordinate
    startY = yArr[0];  // Initial y-coordinate
    stopX = xArr[1];  // Final x-coordinate  
    stopY = yArr[1];   // Final y-coordinate
    x = startX;  // Current x-coordinate
    y = startY;  // Current y-coordinate  
    index = 0;
    distance = 0.0;
    fill(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)), 200);
    itemcounter = 0;
    newgame = true;
  }
  
  void showPoints(){
   //float xyDist;
   textSize(12); 
   fill(0);
   text("Food items", 10, 25);
   text("index       X         Y", 10, 50);
   //text("Path lenght -> " + xArr.length, 10, 22);
   for (int i = 0; i < xArr.length; i += 1 ){  
     text(str(i)+"  ->     "+str(xArr[i])+",    "+str(yArr[i])+"\n", 10, 75+i*20);     
   }
   //xyDist = dist(xArr[0],yArr[0],xArr[1],yArr[1]);
   //xyDist = dist(xArr[0],yArr[0],xArr[2],yArr[2]);   
 }
   
   String ordered(){ 
       float dxy = 0;
       String msg = "";
       strokeWeight(4);
       stroke(148, 107, 132, 100); //same color as its button
       for (int i = 0; i < xArr.length-1; i += 1 ){  
         line(xArr[i], yArr[i], xArr[i+1], yArr[i+1]);
         dxy += dist(xArr[i], yArr[i], xArr[i+1], yArr[i+1]);        
       }
       print("Total distance = "+round(dxy)+"\n");
       msg = "Total distance = "+round(dxy)+"\n";
      return msg;              
   } 
 }

//set spotty & food items in the arena
public class Hamster{
  int xRan;
  int yRan;
  float step = 1;  // Size of each step (0.0 to 1.0) step = 0.01
  float pct = 0.0;  // Percentage traveled (0.0 to 1.0)    
   
  int put(int index, int quantity){
   xRan = int(random(minX, maxX));
   yRan = int(random(minY, maxY));
       
    fill(250, 197, 216);
    rect(xRan, yRan, 50, 50);
    
    PImage img;
    img = loadImage("hamsterIcon1.png");    
    noStroke();    
    image(img, xRan, yRan, 50, 50);    
    xArr[index] = xRan;   // save position
    yArr[index] = yRan;
    index += 1;    
   return index;
  }    
    
}


public class Food{
  int xRan, yRan;   
  boolean overlap = false;  
  int himgSize = 50;
  int wimgSize = 50;
}

boolean overlapP(int xRan, int yRan){
  boolean occupied = false;
  
  for (int i = 0; i < xArr.length; i += 1 ){
   if (xArr[i]!=0){
    if ((xRan >= (xArr[i]-60)) && (xRan<= (xArr[i] + 60))&&(yRan >= (yArr[i]-60)) && (yRan<= (yArr[i] + 60))){
      //print("Intersection");  
      occupied = true;
      xRan = int(random(minX, maxX));
      break;
    } else{
      occupied = false;
    }
  }
} //end for
return occupied;
}

public class Candy extends Food{   
  
  int put(int index, int quantity){ //inheritance & method overriding  
    boolean overlap = false;
    
    for (int i = 1; i < quantity; i += 1 ){      
      xRan = int(random(minX, maxX));
      yRan = int(random(minY, maxY));
      
      do{
      overlap = overlapP(xRan, yRan);
      
      if (overlap == true){
        //print("Overlap\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      }
      else{
        //print("no overlap\n");        
      }
      }
      while(overlap == true);      
           
            
      fill(204, 102, 0);
      rect(xRan, yRan, 50, 50);  
      
      
      // set candies
      PImage img;
      img = loadImage("candy.png");      
      noStroke();
      image(img, xRan, yRan, 50, 50);
      
     //label
      itemcounter += 1;
      fill(191, 94, 94,200);
      rect(xRan + 20, yRan + 17, 10,10);
      textSize(11);
      fill(250); 
      text(str(itemcounter), xRan + 21, yRan + 25);   
      xArr[index] = xRan;   // save position
      yArr[index] = yRan;
      index += 1;
    }
    return index;
  }
}

public class Apple extends Food{
  
  int put(int index, int quantity){
    for (int i = 1; i < quantity; i += 1 ){
      xRan = int(random(minX, maxX));
      yRan = int(random(minY, maxY));
      
      do{
      overlap = overlapP(xRan, yRan);
      
      if (overlap == true){
        //print("overlap\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      }
      else{
        //print("nooverlap\n");        
      }
      }
      while(overlap == true);   
      
      fill(198, 94, 94);
      rect(xRan, yRan, 50, 50);
      //set apples
      PImage img;
      img = loadImage("apple.png");      
      noStroke();
      image(img, xRan, yRan, 50, 50);
      
      //label
      itemcounter += 1;
      fill(61, 152, 62,250);
      rect(xRan + 11, yRan + 11, 10,10);
      textSize(11);
      fill(255); 
      text(str(itemcounter), xRan + 12, yRan + 20);  
      xArr[index] = xRan;   // save position
      yArr[index] = yRan;
      index += 1;
  }
    return index;
  }
}

public class Cheese extends Food{
  
  int put(int index, int quantity){
    for (int i = 1; i < quantity; i += 1 ){
    xRan = int(random(minX, maxX));
    yRan = int(random(minY, maxY));
    
    do{
      overlap = overlapP(xRan, yRan);
      
      if (overlap == true){
        //print("overlapX\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      }
      else{
        //print("no overlap\n");        
      }
      }
      while(overlap == true);
    //set cheese
    
    fill(250, 237, 169);
    rect(xRan, yRan, 50, 50);
    
    PImage img;
    img = loadImage("cheese.png");      
    noStroke();
    image(img, xRan, yRan, 50, 50);
    
    //label
    itemcounter += 1;
    fill(247, 221, 72,200);
    rect(xRan + 24, yRan + 15, 11,11);
    textSize(11);
    fill(0); 
    text(str(itemcounter), xRan + 25, yRan + 25); 
    xArr[index] = xRan;   // save position
    yArr[index] = yRan;
    index += 1;
  }
    return index;
  }
}

public class Cupcake extends Food{
  
  int put(int index, int quantity){
    for (int i = 1; i < quantity; i += 1 ){
    xRan = int(random(minX, maxX));
    yRan = int(random(minY, maxY));
    do{
      overlap = overlapP(xRan, yRan);
      
      if (overlap == true){
        //print("overlap en X\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      }
      else{
        //print("no overlap en X\n");        
      }
      }
      while(overlap == true);
    fill(111, 184, 216);
    rect(xRan, yRan, 50, 50);
    
    
    PImage img;
    img = loadImage("cupcake.png");      
    noStroke();
    image(img, xRan, yRan, 50, 50);
    //label
    itemcounter += 1;
    fill(112, 165, 185,250);
    rect(xRan + 20, yRan + 30, 11,11);
    textSize(11);
    fill(255); 
    text(str(itemcounter), xRan + 23, yRan + 40);
    xArr[index] = xRan;   // save position
    yArr[index] = yRan;   
    index = index + 1; 
  }
    return index;
  }  
  
}

