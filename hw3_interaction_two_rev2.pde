//Soucrces: https://www.geeksforgeeks.org/breadth-first-search-or-bfs-for-a-graph/
//Sources: https://docs.google.com/presentation/d/1_PFcKPQS5BDTEpIdGvDIW9M-vm2EWYxohHyCRSrWw1M/edit#
//Sources: BFS code from class
//Sources: https://www.youtube.com/watch?v=mhjuuHl6qHM

//multiple agents follow and a mouse click generates a new obstacle and creates a new path

        float steeringx;
        float steeringy;

AGENT[] agent1;
int numAgents = 5;
int radiusOfPercep = 250;//500; //50;
float agentxposit = 50;
float agentyposit = 750;

float goalx = 750;
float goaly = 50;
int radius = 100;
int agentAndTargetRadius = 25;
float xsphere = 400;
float ysphere = 400;
float xpoint;
float ypoint;
//int numpoints = 13; //first two elements are agents; the last 1 elment is the goal. The other 10 are the nodes //play around with num of points; more points leads to possibility of finding the ideal path
int numpoints = 25;//10;
float[] xpoints = new float[numpoints]; 
float[] ypoints = new float[numpoints];

int circlesTotal = 0;
CIRCLE[] circles;


void setup(){
    size(800, 800, P3D);
    agent1 = new AGENT[numAgents];
    circles = new CIRCLE[1000]; //max size of circles is 100
    
    findpoints();
  
    for(int i = 0; i < numAgents; i++){
      //agent1[i] = new AGENT(xpoints, ypoints, agentxposit, agentyposit);
      //agent1[i] = new AGENT(xpoints, ypoints, random(50,750), random(50, 750));
      //agent1[i] = new AGENT(xpoints, ypoints, random(50,750), random(400, 750));
      //println(agent1[i].xP);
      //println(agent1[i].yP);
      //println(agent1[i].arrayofXpoints);
      
      if(i == 0){    
         agent1[i] = new AGENT(xpoints, ypoints, agentxposit, agentyposit);
         agent1[i].c = #3FD61E;
         agent1[i].bfs();
         agent1[i].nextNode = agent1[i].path.size()-2;
         
     }
     else{
         agent1[i] = new AGENT(xpoints, ypoints, random(50,300), random(500, 750));
     }
  }
}


void draw() {
        //align();


  background(255, 255, 255);
  
   for(int i = 1; i < numAgents; i++){
     
      //agent1[i].updateposit(1/frameRate, agent1[i].nextNode);
      
               agent1[i].edges();
              align(agent1[i]); 
              cohesion(agent1[i]);
              separation(agent1[i]);
              agent1[i].updateposit(1/frameRate);
                //agent1[i].updatevelocity(1/frameRate, agent1[i].nextNode);
   //}
  }
  
  
  agent1[0].edges();
  if(mousePressed){
    
    delay(100);//ensure we only create one circle per click
    circles[circlesTotal]  = new CIRCLE(mouseX, mouseY, 100, #F919FA);
    circlesTotal++;

    agent1[0].arrayofXpoints[0] = agent1[0].xP;
    agent1[0].arrayofYpoints[0] = agent1[0].yP;
    agent1[0].path = new ArrayList(); //now the path is empty
    
    
    
    agent1[0].bfs();
    agent1[0].nextNode = agent1[0].path.size()-2;
    //separation(agent1[0]);
   
   }  
     
    
    if(distance(agent1[0].xP, agent1[0].yP, xsphere, ysphere) < 110){
      

        separation(agent1[0]);
        agent1[0].updateposit(1/frameRate);
        //agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
        //agent1[0].bfs();
        //agent1[0].nextNode = agent1[0].path.size()-2;
        
    
    }
    
    else{
       
        agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
        agent1[0].updateposit(1/frameRate);

    }
   for(int k = 0; k<circlesTotal; k++){
   
               if(distance(agent1[0].xP, agent1[0].yP, circles[k].xp, circles[k].yp) < circles[k].radius + 5){
      
                    separation(agent1[0]);
                    agent1[0].updateposit(1/frameRate);

               }
   
 
 
 }
 
agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
agent1[0].updateposit(1/frameRate);

    
   //draw the circles
   for(int i = 0; i < circlesTotal; i++){
     
      pushMatrix();
      fill(circles[i].c);
      circle(circles[i].xp, circles[i].yp, circles[i].radius);
      popMatrix();
     
   }
   


 // draw the paths
  //for(int h = 0; h < numAgents; h++)
         //{
        for (int i = 0; i < numpoints; i++)
        {
      
          
            //for (int j = 0; j < agent1[0].neighbors[i].size(); j++)
           for (int j = 0; j < agent1[0].neighbors[i].size(); j++)
            {
             
              //if(h == 0){
                 pushMatrix();
                 fill(200);
                 line(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agent1[0].arrayofXpoints[agent1[0].neighbors[i].get(j)], agent1[0].arrayofYpoints[agent1[0].neighbors[i].get(j)]);
                 popMatrix();
              //}
              //else{
                 //pushMatrix();
                 //fill(100);
                 //line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
                 //popMatrix();
              //}  
              //line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  
              //line(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agent1[0].arrayofXpoints[agent1[0].neighbors[i].get(j)], agent1[0].arrayofYpoints[agent1[0].neighbors[i].get(j)]);
            
          }

       }
 // }      
  for (int i = 1; i < numpoints-1; i++) {

    pushMatrix();
    fill(0, 0, 255);
    circle(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agentAndTargetRadius*.5);
    popMatrix();
  }

  
  pushMatrix();
  fill(0, 0, 255);
  //translate(mouseX-xsphere, mouseY-ysphere);
  //circle(xsphere, ysphere, radius);
  circle(xsphere, ysphere, radius);
  popMatrix();

  //first agent is RED
  for(int i = 0; i < numAgents; i ++){
     if(i == 0){
       //  fill(0,0,255);
      pushMatrix();
      fill(agent1[i].c);
      translate(agent1[i].xP, agent1[i].yP);
      circle(0,0, agentAndTargetRadius*.5);
      popMatrix();
     } else{  
        pushMatrix();
        fill(agent1[i].c);
        translate(agent1[i].xP, agent1[i].yP);
        circle(0,0, agentAndTargetRadius*.5);
        popMatrix();
     }
 
}
  


  //Draw the Goal
  pushMatrix();
  fill(0, 255, 0);
  circle(750, 50, agentAndTargetRadius);
  popMatrix();
 

}

//this finds the points and includes the goal in the last index
void findpoints() {
  
  xpoints[numpoints-1] = goalx;
  ypoints[numpoints-1] = goaly;  
  println(xpoints[numpoints-1]);
  println(ypoints[numpoints-1]);

  for (int i = 0; i < numpoints-1; i++)
  {
    
    xpoint = random(0, 800);
    ypoint = random(0, 800);

    while((xpoint - xsphere)*(xpoint - xsphere) + (ypoint - ysphere)*(ypoint - ysphere) <= (radius)*(radius))
    {

      xpoint += 5;
      ypoint += 5;
    }

    xpoints[i] = xpoint;
    ypoints[i] = ypoint;

    println(xpoints[i]);
    println(ypoints[i]);
  }
}
float distance(float x, float y, float u, float v)
{
  
 return sqrt((x-u)*(x-u) + (y-v)*(y-v));
  
}
                    
void align(AGENT agent){
        //int radiusOfPercep = 100;  //align for radius within this distance
        float xavg = 0;
        float yavg = 0;
        int total = 0;
        agent.xAcc = 0;
        agent.yAcc= 0;
        
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
    
                xavg += agent1[i].vx;
                yavg += agent1[i].vy;
                total++;
              }             
        }  
        
       if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
             
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;
       }
        //println("the agvg is:", xavg, yavg); 
        agent.xAcc = steeringx;
        agent.yAcc = steeringy;
        
}

//cohesion is the same concept as align, but it uses position instead of velocity
void cohesion(AGENT agent){
        ////int radiusOfPercep = 100;  //align for radius within this distance

        float xavg = 0;
        float yavg = 0;
        int total = 0;
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep ){
    
                xavg += agent1[i].xP;
                yavg += agent1[i].yP; 
                total++;
              }             
        }  
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.xP;
            steeringy = yavg - agent.yP;

        }
     
        agent.xAcc += steeringx;
        agent.yAcc += steeringy;
  
}

void separation(AGENT agent){
  
      float xavg = 0;
      float yavg = 0;
      int total = 0;

      float d;
      for(int i = 0; i < numAgents; i++){
           d = distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP); 
           if( d <= radiusOfPercep && agent != agent1[i]){
           //if( d <= radiusOfPercep){
                      float diffx;
                      float diffy;    
                      //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
                      //stay away from a closer boid than a farther boid.
                      diffx = (agent.xP - agent1[i].xP)/d; 
                      diffy = (agent.yP - agent1[i].yP)/d;

                      xavg += diffx;
                      yavg += diffy;
  
                      total++;      
         }    
        // the separation from the sphere used to be in the for loop      
      }
      
      
      d = distance(agent.xP, agent.yP, xsphere, ysphere);
      //if(d < 75 && agent.atEnd == true){
      if(d < 105){
                float diffx;
                float diffy; 
                
                diffx = (agent.xP - xsphere)/d;
                diffy = (agent.yP - ysphere)/d;

                xavg += diffx;
                yavg += diffy;

                total++;
          
        }
        
        
        for(int k = 0; k < circlesTotal; k++){
            d = distance(agent.xP, agent.yP, circles[k].xp, circles[k].yp);
            //if(d < 75 && agent.atEnd == true){
            if(d < circles[k].radius + 5){
                      float diffx;
                      float diffy; 
                      
                      diffx = (agent.xP - circles[k].xp)/d;
                      diffy = (agent.yP - circles[k].yp)/d;
      
                      xavg += diffx;
                      yavg += diffy;
      
                      total++;
                
              }
        
            }
        
        
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;        
        }

        //agent.xAcc += 50*(steeringx);
        //agent.yAcc += 50*(steeringy);  
        
        agent.xAcc += 25*(steeringx);
        agent.yAcc += 25*(steeringy);
        
        //agent.xAcc += (steeringx);
        //agent.yAcc += (steeringy);     
      
}
