
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
