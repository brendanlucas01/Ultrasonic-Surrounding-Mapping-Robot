import processing.serial.*;

Serial my_port;
PrintWriter output;
String text1="";
int x_loc=0;
String right = "Right";
String left = "Left";
int[] dir_arr1 = new int[4];
int[] orient = new int[]{100,850,3}; // X=50, Y=550, direction = south; {0:north,1:east,2:south,3:west}
int i;
String[] arrOfStr;
int sensor_limit = 150;
String mouse_data="";
int prev_values=0;

void setup(){
 size(1600,1200);
 my_port = new Serial(this,"COM6",9600);
 my_port.bufferUntil('\n');
  background(0,0,0);
  output = createWriter ("mouse_data4.txt");
}

void serialEvent(Serial my_port){
  if(my_port.available()>0)
  {
    text1 = my_port.readStringUntil('\n'); 
    text1 = text1.substring(0, text1.length()-2);
  }
//output.println(text1);
}

void draw(){
 
 //while(x_loc<mouseX){
  
 //  line(x_loc,0,x_loc,height);
 //   x_loc+=10;
 //   //delay(10);
 //}
  if(text1.equals(""))
  {
    return;
  }
  if(left.equals(text1))
  {
    orient[2]--;
    if(orient[2]==-1)
    {
     orient[2]=3; 
    }
  }
  else if(right.equals(text1))
  {
    orient[2]++;
    if(orient[2]==4)
    {
     orient[2]=0; 
     
    }
  }
  else{
      println(text1);
       println(text1.length());
      arrOfStr = split(text1,",");
      println(arrOfStr);
      dir_arr1[0] = Integer.parseInt(arrOfStr[0])/50 - prev_values;
      prev_values = Integer.parseInt(arrOfStr[0])/50;
      for(i=1;i<4;i++)
      {
         dir_arr1[i]=Integer.parseInt(arrOfStr[i]); 
      }
  }

 if(orient[2]==0)
 {
   orient[1]-=dir_arr1[0];
   stroke(255, 255, 255);
   point(orient[0],orient[1]);
   mouse_data =""+orient[0]+","+orient[1]+",";
   stroke(255,0,255);
   if(dir_arr1[1]<sensor_limit)
   {
     point(orient[0]-dir_arr1[1],orient[1]);
     mouse_data+= (orient[0]-dir_arr1[1]) + ","+orient[1]+",";
   }
   else{
     mouse_data+="0,0,";
   }
   if(dir_arr1[2]<sensor_limit)
   {
     point(orient[0],orient[1]-dir_arr1[2]);
     mouse_data+= (orient[0]) + ","+(orient[1]-dir_arr1[2])+",";
   }
   else{
     mouse_data+="0,0,";
   }
   if(dir_arr1[3]<sensor_limit)
   {
    point(orient[0]+dir_arr1[3],orient[1]); 
    mouse_data+= (orient[0]+dir_arr1[3]) + ","+orient[1];
   }
   else{
     mouse_data+="0,0";
   }
 }
 else if(orient[2]==1)
 {
   orient[0]+=dir_arr1[0];
   stroke(255, 255, 255);
   point(orient[0],orient[1]);
   mouse_data =""+orient[0]+","+orient[1]+",";
   stroke(255,0,255);
   if(dir_arr1[1]<sensor_limit)
   {
     point(orient[0],orient[1]-dir_arr1[1]);
     mouse_data+= orient[0]+","+(orient[1]-dir_arr1[1])+",";
   }
   else{
     mouse_data+="0,0,";
   }
   if(dir_arr1[2]<sensor_limit)
   {
     point(orient[0]+dir_arr1[2],orient[1]);
     mouse_data+= (orient[0]+dir_arr1[2])+","+(orient[1])+",";
   }
   else{
     mouse_data+="0,0,";
   }
   if(dir_arr1[3]<sensor_limit)
   {
    point(orient[0],orient[1]+dir_arr1[3]);
    mouse_data+= orient[0]+","+(orient[1]+dir_arr1[3]);
   }
   else{
     mouse_data+="0,0";
   }
 }
 else if(orient[2]==2)
 {
   orient[1]+=dir_arr1[0];
   stroke(255, 255, 255);
   point(orient[0],orient[1]);
   mouse_data =""+orient[0]+","+orient[1]+",";
   stroke(255,0,255);
   if(dir_arr1[1]<sensor_limit)
   {
     point(orient[0]+dir_arr1[1],orient[1]);
     mouse_data+=(orient[0]+dir_arr1[1])+","+orient[1]+",";
   }
    else{
     mouse_data+="0,0,";
   }
   if(dir_arr1[2]<sensor_limit)
   {
     point(orient[0],orient[1]+dir_arr1[2]);
     mouse_data+=(orient[0])+","+(orient[1]+dir_arr1[2])+",";
   }
    else{
     mouse_data+="0,0,";
   }
   if(dir_arr1[3]<sensor_limit)
   {
    point(orient[0]-dir_arr1[3],orient[1]); 
    mouse_data+=(orient[0]-dir_arr1[3])+","+orient[1];
   }
    else{
     mouse_data+="0,0";
   }
 }
else if(orient[2]==3)
 {
   orient[0]-=dir_arr1[0];
   stroke(255, 255, 255);
   point(orient[0],orient[1]);
   mouse_data =""+orient[0]+","+orient[1]+",";
   stroke(255,0,255);
   if(dir_arr1[1]<sensor_limit)
   {
     point(orient[0],orient[1]+dir_arr1[1]);
     mouse_data+=orient[0]+","+(orient[1]+dir_arr1[1])+",";
   }
   else{
    mouse_data+="0,0,"; 
   }
    if(dir_arr1[2]<sensor_limit)
   {
     point(orient[0]-dir_arr1[2],orient[1]);
     mouse_data+=(orient[0]-dir_arr1[2])+","+(orient[1])+",";
   }
   else{
    mouse_data+="0,0,"; 
   }
   if(dir_arr1[3]<sensor_limit)
   {
    point(orient[0],orient[1]-dir_arr1[3]); 
    mouse_data+=orient[0]+","+(orient[1]+dir_arr1[3])+",";
   }
    else{
     mouse_data+="0,0";
   }
 }
  
 
 //if(mousePressed)
 //{
 //  stroke(255, 255, 255);
 //  point(mouseX,mouseY);
 //  if(mouseButton==LEFT){
 //    stroke(255, 0, 255);
 //    point(mouseX,mouseY+40);
 //    point(mouseX,mouseY-40);
 //  }
 //  if(mouseButton==RIGHT)
 //  {
 //    stroke(255,0,255);
 //    point(mouseX+40,mouseY);
 //    point(mouseX-40,mouseY);
 //  }
 //  String mouse_data = ""+mouseX+","+mouseY+"";
 //  output.println(mouse_data);
 //}
 output.println(mouse_data);
 mouse_data = "";
 text1 = "";
}

  void keyPressed(){
    output.flush();
    output.close();
    exit(); 
  }
