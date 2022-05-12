import java.lang.*;

String[] lines;
String text1;
String right = "Right";
String left = "Left";
String forward = "Front";
int[] dir_arr1 = new int[5];
int[] orient = new int[]{100, 850, 1};
String[] arrOfStr;
int sensor_limit = 150;
String mouse_data="";
int i;
int prev_values=0;
int prev_orient=0;
int prev_ticks=0;
String curr_state = "";
int x;
int y;
double theta;
int ini_angle;


void setup() {
  lines = loadStrings("console_data.txt");
  //println("there are " + lines.length + " lines");
  size(1600, 1200);
  background(0, 0, 0);
  //draw_circuit();
  for (int j = 0; j < lines.length; j++) {
    //
    if (lines[j].equals("")) {
      continue;
    } else {
      //println(lines[j]);
      draw_circuit(lines[j]);
    }
  }
}


void draw_circuit(String text1) {

  {
    stroke(255, 255, 255);

    //println(text1);
    //String[] mouse_coord = split(lines[i], ',');
    //int mousX = Integer.parseInt(mouse_coord[0]);
    //int mousY = Integer.parseInt(mouse_coord[1]);
    //point(mousX,mousY);
    if (text1.equals(""))
    {
      return;
    }
    if (left.equals(text1))
    {
      curr_state = text1;
      prev_orient = orient[2]--;
      if (orient[2]==-1)
      {
        orient[2]=3;
      }
    } else if (right.equals(text1))
    {
      curr_state = text1;
      prev_orient = orient[2]++;
      if (orient[2  ]==4)
      {
        orient[2]=0;
      }
    } else if (forward.equals(text1)) {
      curr_state=text1;
    } else if (curr_state.equals(left)) {
      //println(text1);
      //println(text1.length());
      arrOfStr = split(text1, ",");
      //println(arrOfStr);
      dir_arr1[0] = Integer.parseInt(arrOfStr[0])/50 - prev_values;
      prev_values = Integer.parseInt(arrOfStr[0])/50;
      for (i=1; i<5; i++)
      {
        dir_arr1[i]=Integer.parseInt(arrOfStr[i]);
      }
      //println(orient);
      if (prev_orient==0)
      {
        ini_angle=90;
      } else if (prev_orient==1)
      {
        ini_angle=0;
      } else if (prev_orient==2)
      {
        ini_angle=270;
      } else if (prev_orient==3)
      {
        ini_angle=180;
      }

      
      if(dir_arr1[2]<sensor_limit)
      {
        theta = Math.toRadians(ini_angle+dir_arr1[4]-90);
        x = orient[0]+(int)(dir_arr1[2]*Math.cos(theta));
        y = orient[1]+(int)(dir_arr1[2]*Math.sin(theta));
        stroke(0, 255, 255);
        point(x, y);
        println(2,x,y,theta);
      }
      
      if(dir_arr1[1]<sensor_limit)
      {
       theta = Math.toRadians(ini_angle+dir_arr1[4]-180);
        x = orient[0]+(int)(dir_arr1[1]*Math.cos(theta));
        y = orient[1]+(int)(dir_arr1[1]*Math.sin(theta));
        stroke(255, 255, 0);
        point(x, y);
        println(1,x,y,theta); 
      }
      
      if(dir_arr1[3]<sensor_limit)
      {
        theta = Math.toRadians(ini_angle+dir_arr1[4]);
        x = orient[0]+(int)(dir_arr1[3]*Math.cos(theta));
        y = orient[1]+(int)(dir_arr1[3]*Math.sin(theta));
        stroke(255, 0, 255);
        point(x, y);
        println(3,x,y,theta);
      }
      
    } else if (curr_state.equals(right)) {
      //println(text1);
      //println(text1.length());
      arrOfStr = split(text1, ",");
      //println(arrOfStr);
      dir_arr1[0] = Integer.parseInt(arrOfStr[0])/50 - prev_values;
      prev_values = Integer.parseInt(arrOfStr[0])/50;
      for (i=1; i<5; i++)
      {
        dir_arr1[i]=Integer.parseInt(arrOfStr[i]);
      }
      //println(orient);
      if (prev_orient==0)
      {
        ini_angle=90;
      } else if (prev_orient==1)
      {
        ini_angle=0;
      } else if (prev_orient==2)
      {
        ini_angle=270;
      } else if (prev_orient==3)
      {
        ini_angle=180;
      }

      
      if(dir_arr1[2]<sensor_limit)
      {
        theta = Math.toRadians(ini_angle+dir_arr1[4]-90);
        x = orient[0]+(int)(dir_arr1[2]*Math.cos(theta));
        y = orient[1]+(int)(dir_arr1[2]*Math.sin(theta));
        stroke(0, 255, 255);
        point(x, y);
        println(2,x,y,theta);
      }
      
      if(dir_arr1[1]<sensor_limit)
      {
       theta = Math.toRadians(ini_angle+dir_arr1[4]+180);
        x = orient[0]+(int)(dir_arr1[1]*Math.cos(theta));
        y = orient[1]+(int)(dir_arr1[1]*Math.sin(theta));
        stroke(255, 255, 0);
        point(x, y);
        println(1,x,y,theta); 
      }
      
      if(dir_arr1[3]<sensor_limit)
      {
        theta = Math.toRadians(ini_angle+dir_arr1[4]);
        x = orient[0]+(int)(dir_arr1[3]*Math.cos(theta));
        y = orient[1]+(int)(dir_arr1[3]*Math.sin(theta));
        stroke(255, 0, 255);
        point(x, y);
        println(3,x,y,theta);
      }
    } else {
      //println(text1);
      //println(text1.length());
      arrOfStr = split(text1, ",");
      //println(arrOfStr);
      dir_arr1[0] = Integer.parseInt(arrOfStr[0])/50 - prev_values;
      prev_values = Integer.parseInt(arrOfStr[0])/50;
      for (i=1; i<5; i++)
      {
        dir_arr1[i]=Integer.parseInt(arrOfStr[i]);
      }

      if (orient[2]==0)
      {
        orient[1]-=dir_arr1[0];
        stroke(255, 255, 255);
        point(orient[0], orient[1]);
        mouse_data =""+orient[0]+","+orient[1]+",";
        if (dir_arr1[1]<sensor_limit)
        {
          stroke(255, 255, 0);
          point(orient[0]-dir_arr1[1], orient[1]);
          mouse_data+= (orient[0]-dir_arr1[1]) + ","+orient[1]+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[2]<sensor_limit)
        {
          stroke(0, 255, 255);  
          point(orient[0], orient[1]-dir_arr1[2]);
          mouse_data+= (orient[0]) + ","+(orient[1]-dir_arr1[2])+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[3]<sensor_limit)
        {
          stroke(255, 0, 255);
          point(orient[0]+dir_arr1[3], orient[1]); 
          mouse_data+= (orient[0]+dir_arr1[3]) + ","+orient[1];
        } else {
          mouse_data+="0,0";
        }
      } else if (orient[2]==1)
      {
        orient[0]+=dir_arr1[0];
        stroke(255, 255, 255);
        point(orient[0], orient[1]);
        mouse_data =""+orient[0]+","+orient[1]+",";
        //stroke(255,0,255);
        if (dir_arr1[1]<sensor_limit)
        {
          stroke(255, 255, 0);
          point(orient[0], orient[1]-dir_arr1[1]);
          mouse_data+= orient[0]+","+(orient[1]-dir_arr1[1])+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[2]<sensor_limit)
        {
          stroke(0, 255, 255);
          point(orient[0]+dir_arr1[2], orient[1]);
          mouse_data+= (orient[0]+dir_arr1[2])+","+(orient[1])+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[3]<sensor_limit)
        {
          stroke(255, 0, 255);
          point(orient[0], orient[1]+dir_arr1[3]);
          mouse_data+= orient[0]+","+(orient[1]+dir_arr1[3]);
        } else {
          mouse_data+="0,0";
        }
      } else if (orient[2]==2)
      {
        orient[1]+=dir_arr1[0];
        stroke(255, 255, 255);
        point(orient[0], orient[1]);
        mouse_data =""+orient[0]+","+orient[1]+",";
        //stroke(255,0,255);
        if (dir_arr1[1]<sensor_limit)
        {
          stroke(255, 255, 0);
          point(orient[0]+dir_arr1[1], orient[1]);
          mouse_data+=(orient[0]+dir_arr1[1])+","+orient[1]+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[2]<sensor_limit)
        {
          stroke(0, 255, 255);
          point(orient[0], orient[1]+dir_arr1[2]);
          mouse_data+=(orient[0])+","+(orient[1]+dir_arr1[2])+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[3]<sensor_limit)
        {
          stroke(255, 0, 255);
          point(orient[0]-dir_arr1[3], orient[1]); 
          mouse_data+=(orient[0]-dir_arr1[3])+","+orient[1];
        } else {
          mouse_data+="0,0";
        }
      } else if (orient[2]==3)
      {
        orient[0]-=dir_arr1[0];
        stroke(255, 255, 255);
        point(orient[0], orient[1]);
        mouse_data =""+orient[0]+","+orient[1]+",";
        //stroke(255,0,255);
        if (dir_arr1[1]<sensor_limit)
        {
          stroke(255, 255, 0);
          point(orient[0], orient[1]+dir_arr1[1]);
          mouse_data+=orient[0]+","+(orient[1]+dir_arr1[1])+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[2]<sensor_limit)
        {
          stroke(0, 255, 255);
          point(orient[0]-dir_arr1[2], orient[1]);
          mouse_data+=(orient[0]-dir_arr1[2])+","+(orient[1])+",";
        } else {
          mouse_data+="0,0,";
        }
        if (dir_arr1[3]<sensor_limit)
        {
          stroke(255, 0, 255);
          point(orient[0], orient[1]-dir_arr1[3]); 
          mouse_data+=orient[0]+","+(orient[1]+dir_arr1[3])+",";
        } else {
          mouse_data+="0,0";
        }
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
    //output.println(mouse_data);
    mouse_data = "";
    text1 = "";
  }
}
void draw() {
}
