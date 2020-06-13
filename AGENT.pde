class AGENT{

    float speed = 35; //50;
    int num = numpoints + 1;
     color c;
     boolean atEnd = false;
  
    float xP = 50; float yP = 750; float vx = 0; float vy= 0; float xAcc; float yAcc;
    float[] arrayofXpoints = new float[num]; 
    float[] arrayofYpoints = new float[num];
    
    
    //For BFS
    //array of booleans to determine if visited
    boolean visited[]  = new boolean[num]; 
    ArrayList<Integer>[] neighbors = new ArrayList[num];  //A list of neighbors can can be reached from a given node
    int[] parent = new  int[num];
    //To store the path
    ArrayList<Integer> path = new ArrayList(); 
    
    int nextNode; //keeps track of the next path

  
    AGENT(float[] arrayx , float[] arrayy, float i_xp, float i_yp ){
            
           xP = i_xp; yP = i_yp;
           arrayofXpoints[0] = xP;
           arrayofYpoints[0] = yP;
           
           vx = random(-20, 20);
           vy = random(-20, 20);
        
        
           //copy the points onto the array for the agent
           for(int i = 1; i < num; i++)
           {
             arrayofXpoints[i] = arrayx[i-1];
             arrayofYpoints[i] = arrayy[i-1];     
           }
           //nextNode = path.size()-2;
    }
    
    
     void edges(){
    
     if(xP  > width){
         xP = 0;}
     else if(xP < 0){
         xP = width;}
         
     if(yP  > height){
         yP = 0;}
     else if(yP < 0){
         yP = height;}

    }
      
      //Implement BFS
      
      void bfs() {
        //initialize the arrays to represent the graph
        for (int i = 0; i < num; i++)
        { 
          neighbors[i] = new ArrayList<Integer>(); 
          visited[i] = false;
          parent[i] = -1; //No partent yet
        }
        
        connect();
        println("List of Neghbors:");
        println(neighbors);
      
        int start = 0;
        int goal = num - 1;
      
      
        ArrayList<Integer> fringe = new ArrayList(); 
        println("\nBeginning Search");
      
        visited[start] = true;
        fringe.add(start);
        println("Adding node", start, "(start) to the fringe.");
        println(" Current Fring: ", fringe);
      
        while (fringe.size() > 0) {
          int currentNode = fringe.get(0);
          fringe.remove(0);
          if (currentNode == goal) {
            println("Goal found!");
            break;
          }
          for (int i = 0; i < neighbors[currentNode].size(); i++) {
            int neighborNode = neighbors[currentNode].get(i);
            if (!visited[neighborNode]) {
              visited[neighborNode] = true;
              parent[neighborNode] = currentNode;
              fringe.add(neighborNode);
              println("Added node", neighborNode, "to the fringe.");
              println(" Current Fringe: ", fringe);
            }
          }
        }
        
        
        print("\nReverse path: ");
        int prevNode = parent[goal];
        path.add(goal);
        print(goal, " ");
        while (prevNode >= 0) {
          print(prevNode, " ");
          path.add(prevNode);
          prevNode = parent[prevNode];
        }
        print("\n");
        println("The path is:");
        println(path);
        print("\n");
      }
      
      void updateposit(float dt){
        
         float len = sqrt(vx*vx + vy*vy);
          
          vx = vx/len;
          vy = vy/len;
          
          xP += vx*speed*dt;
          yP += vy*speed*dt;
         
          vx += xAcc*dt;
          vy += yAcc*dt;
          
      }  
      
      void updatevelocity(float dt, int count)
      //void updateposit(float dt)
      {
        
        if(count == -1){
          
          count = 0;
            
        }

         
        // Head to the first stop in the path
        //if(count == path.size()-2)if(count == path.size()-2 && count > 0)
        if(count == path.size()-2)
        { 
          
          //println(count);
          //println(path.size());
          //println(path);
          //vx = arrayofXpoints[path.get(count)] - agentxposit;
          //SOMETIMES CODE BREAKS HERE
          vx = arrayofXpoints[path.get(count)] - xP;
          //vy = arrayofYpoints[path.get(count)] - agentyposit;
          vy = arrayofYpoints[path.get(count)] - yP;
          
          //float len = sqrt(vx*vx + vy*vy);          
          //vx = vx/len;
          //vy = vy/len;
          
          //agentxposit += vx*speed*dt;
          ////agentyposit += vy*speed*dt;
          //xP += vx*speed*dt;
          //yP += vy*speed*dt;
          
        }
        //check if we are close enough to head towards the next stop
       if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 1 & count > 0)
        {  
      
           print("too close");
           vx = arrayofXpoints[path.get(count-1)] - xP;
           vy = arrayofXpoints[path.get(count-1)] - yP;
          //float len = sqrt(vx*vx + vy*vy);          
          //vx = vx/len;
          //vy = vy/len;
           //xP += vx*dt;
           //yP += vy*dt; 
           //if(count > 1 ){
             nextNode--;
           //}  
        }
       
       //if(distance(agentxposit, agentyposit, xpoints[path.get(count)], ypoints[path.get(count)]) < 1 & count == 0 )
       //check if near the gaol
       if(count == 0)
       {           
         if(atEnd == false){
             vx = arrayofXpoints[path.get(count)] - xP;
             vy = arrayofYpoints[path.get(count)] - yP;
          
             ////xP += vx*dt;
             ////yP += vy*dt;
           if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 10){
              //if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 25){
              
                    atEnd = true;
                    c = #4BDCF7;
               
                   //vx = 0;
                   //vx = 0;
                   
                                
                     vx = random(-20, 20);
                     vy = random(-20, 20);
               
               //xP += vx*dt;
               //yP += vy*dt;
             }
          
         }   
            //if(atEnd == true){
              
              
           //}  
      
    
       }  
        
  
      
        //println("The next node is:");
        //println(nextNode);
        //println(xP);
        //println(yP);
      }
      
      
      
      
      
      
      //void updateposit(float dt, int count)
      ////void updateposit(float dt)
      //{
        
      //  //added after check-in
      //  if(count == -1){
      //     count = 0;
      //  }
        
      //  if(count == path.size()-2)
      //  { 
      //    //vx = agent1.arrayofXpoints[agent1.path.get(count)] - agentxposit;
      //    //SOMETIMES CODE BREAKS HERE
      //    vx = arrayofXpoints[path.get(count)] - xP;
      //    //vy = agent1.arrayofYpoints[agent1.path.get(count)] - agentyposit;
      //    vy = arrayofYpoints[path.get(count)] - yP;

          
      //    float len = sqrt(vx*vx + vy*vy);
          
      //    vx = vx/len;
      //    vy = vy/len;
          
      //    //agentxposit += vx*speed*dt;
      //    //agentyposit += vy*speed*dt;
      //    xP += vx*speed*dt;
      //    yP += vy*speed*dt;
          
      //  }
      // if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 1 & count > 0)
      //  {  
      
      //     print("too close");
      //     vx = arrayofXpoints[path.get(count-1)] - xP;
      //     vy = arrayofXpoints[path.get(count-1)] - yP;
      //     xP += vx*dt;
      //     yP += vy*dt; 
      //     //if(count > 1 ){
      //       nextNode--;
      //     //}  
      //  }
       
      // //if(distance(agentxposit, agentyposit, xpoints[path.get(count)], ypoints[path.get(count)]) < 1 & count == 0 )     
      // if(count == 0)
      // {      
      //       vx = arrayofXpoints[path.get(count)] - xP;
      //       vy = arrayofYpoints[path.get(count)] - yP;
          
      //       xP += vx*dt;
      //       yP += vy*dt;
             
      //       if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 1){
      //         vx = 0;
      //         vx = 0;
               
      //         xP += vx*dt;
      //         yP += vy*dt;
      //       }
      //  }  
      
      //  //println("The next node is:");
      //  //println(nextNode);
      //  //println(xP);
      //  //println(yP);
      //}
      
      
      void connect()
      {
        //boolean collide = false;
        for (int i = 0; i < num; i++)
        {
      
          float pocx;
          float pocy;
          pocx = arrayofXpoints[i] - xsphere;
          pocy = arrayofYpoints[i] - ysphere;
      
          float c; 
          c = (pocx*pocx) + (pocy*pocy) - (radius*radius);
          // This should avoid connecting with oneself and also checking twice for the same pair of points
         
          for ( int j = i+1; j < num; j++)
          {
            boolean collide = false;
            float vx;
            float vy;
      
            vx = arrayofXpoints[i] - arrayofXpoints[j];
            vy = arrayofYpoints[i] - arrayofYpoints[j];
      
            float a; 
            a = vx*vx + vy*vy;
      
            float b;
            b = (2*vx*pocx) + (2*vy*pocy);
            
            for(int k = 0; k < circlesTotal; k++){
            
                float pocxk;
                float pocyk;
                pocxk = arrayofXpoints[i] - circles[k].xp;
                pocyk = arrayofYpoints[i] - circles[k].yp;
   
                float ck; 
                ck = (pocxk*pocxk) + (pocyk*pocyk) - (circles[k].radius*circles[k].radius);
                
                      
                float ak; 
                ak = vx*vx + vy*vy;
          
                float bk;
                bk = (2*vx*pocxk) + (2*vy*pocyk);
                
                if (sqrt(bk*bk - 4*ak*ck) > 0)
                {
                  collide = true;
                  //break;
                  
                } 
                else
                {
                 // neighbors[i].add(j);
                }

              println(k);
              print(collide);
          
        }
           
            
            //checking for j = 2 should avoid connecting the agents
            //if (sqrt(b*b - 4*a*c) > 0 && (collide == false))
            if (sqrt(b*b - 4*a*c) > 0 )
            {
              collide = true;
            } 
            else if( collide == false)
            {
              neighbors[i].add(j);
            }
          }
  
        }//outerloop
      }
      
      //float distance(float x, float y, float u, float v)
      //{
        
      // return sqrt((x-u)*(x-u) + (y-v)*(y-v));
        
      //}
          
      

}//class
