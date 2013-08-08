
/* set spotty & food items in the arena */
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
      
      do {
      overlap = overlapP(xRan, yRan);
      
      if (overlap == true){
        //print("Overlap\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      }
      else{
        //print("no overlap\n");        
      }
     } while(overlap == true);               
            
      fill(204, 102, 0);
      rect(xRan, yRan, 50, 50);       
      
      /* set candies */
      PImage img;
      img = loadImage("candy.png");      
      noStroke();
      image(img, xRan, yRan, 50, 50);
      
     /* label */
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
      } else{
        //print("nooverlap\n");        
      }
     } while(overlap == true);   
      
      fill(198, 94, 94);
      rect(xRan, yRan, 50, 50);
      
      /* set apples */
      PImage img;
      img = loadImage("apple.png");      
      noStroke();
      image(img, xRan, yRan, 50, 50);
      
      /* label */
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
    
    do {
      overlap = overlapP(xRan, yRan);      
      if (overlap == true){
        //print("overlapX\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      } else{
        //print("no overlap\n");        
        }
      } while(overlap == true);
    
    /* set cheese */
    fill(250, 237, 169);
    rect(xRan, yRan, 50, 50);
    
    PImage img;
    img = loadImage("cheese.png");      
    noStroke();
    image(img, xRan, yRan, 50, 50);
    
    /* label */
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
    do {
      overlap = overlapP(xRan, yRan);      
      if (overlap == true){
        //print("overlap en X\n");
        xRan = int(random(minX, maxX));
        yRan = int(random(minY, maxY));        
      } else{
        //print("no overlap en X\n");        
        }
      } while(overlap == true);
    fill(111, 184, 216);
    rect(xRan, yRan, 50, 50);    
    
    PImage img;
    img = loadImage("cupcake.png");      
    noStroke();
    image(img, xRan, yRan, 50, 50);
    
    /* set label */
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
