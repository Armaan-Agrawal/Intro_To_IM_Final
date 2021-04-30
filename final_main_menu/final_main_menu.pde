
color c1, c2, black, b1;
int Y_AXIS = 1;
int X_AXIS = 0;
int chosen_square = 1;

Menu_Square[] menu_squares = new Menu_Square[4];
void setup()
{
  fullScreen();

  c1 = color(0, 51, 102);
  c2 = color(143, 183, 204);
  b1 = color(255,0,0);
  black = color(0);


  menu_squares[0] = new Menu_Square(-212, 0, -106, -106, 0, 0, -106, 106, 'L');
  menu_squares[1] = new Menu_Square(0, -212, -106, -106, 0, 0, 106, -106, 'U');
  menu_squares[2] = new Menu_Square(212, 0, 106, -106, 0, 0, 106, 106, 'R');
  menu_squares[3] = new Menu_Square(0, 212, 106, 106, 0, 0, -106, 106, 'D');
}

void draw()
{
  background(255);

  setGradient(0, 0, width, height/2, c1, c2, Y_AXIS);
  setGradient(0, height/2, width, height, c2, black, Y_AXIS);

  fill(0);
  //translate(width/2,0);
  int x = mouseX - 330;
  int y = mouseY- 410;
  text("mouseX: "+ x + "mouseY: "+ y, 1100, 800, 1200, 950);

  //pushMatrix();
  //translate(330, 410);
  //rotate(PI/4);
  //fill(255, 0, 255);
  //rect(0, 0, 300, 300);

  ////rotate(PI/4);
  //rectMode(CENTER);
  ////rect(120,120,100,100);
  ////rect(100,0,100,100);
  //popMatrix();

  pushMatrix();
  translate(330, 410);
  stroke(0);
  fill(255);
  //quad(-212,0,-106,-106,0,0,-106,106);
  //quad(212,0,106,-106,0,0,106,106);
  //quad(0,-212,-106,-106,0,0,106,-106);
  //quad(0,212,106,106,0,0,-106,106);
  for (int i =0; i<4; i++)
  {
    menu_squares[i].display();
    menu_squares[i].update();
    color_changer();
    if(menu_squares[i].clicked == true)
    {
      char opp_direction;
      
      switch(menu_squares[i].direction) {

      case 'L': 
        opp_direction = 'R';  
        break;

      case 'R':
        opp_direction = 'L';
        break;

      case 'U':
        opp_direction = 'D';
        break;

      case 'D':
        opp_direction = 'U';
        break;
      default:
        opp_direction = 'U';

      }
      int j;
      for (j = 0; j<4; j++)
      {
        if(j != i)
        {
          move_squares(menu_squares[j],opp_direction);
        }
      } 
    }
  }
  popMatrix();
}





void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}



void move_squares( Menu_Square square, int direction)
{
  switch(direction) {

      case 'L': 
        {
          square.x1 += (square.speed*-1);
          square.x2 += (square.speed*-1);
          square.x3 += (square.speed*-1);
          square.x4 += (square.speed*-1);
        }
        break;

      case 'R':
        {
          square.x1 += (square.speed);
          square.x2 += (square.speed);
          square.x3 += (square.speed);
          square.x4 += (square.speed);
        }
        break;

      case 'U':
        {
          square.y1 += (square.speed*-1);
          square.y2 += (square.speed*-1);
          square.y3 += (square.speed*-1);
          square.y4 += (square.speed*-1);
        }
        break;

      case 'D':
        {
          square.y1 += (square.speed);
          square.y2 += (square.speed);
          square.y3 += (square.speed);
          square.y4 += (square.speed);
        }
        break;
      }
   
}


void color_changer()
{
  menu_squares[chosen_square].c = b1;
  int j;
  for (j = 0; j<4; j++)
  {
    if(j != chosen_square)
    {
      menu_squares[j].c = color(255);
    }
  }
}



class Menu_Square {
  float x1, y1, x2, y2, x3, y3, x4, y4, centerX, centerY;
  char direction;
  int speed = 40;
  boolean clicked;
  color c;

  Menu_Square(float _x1, float _y1, float _x2, float _y2, float _x3, float _y3, float _x4, float _y4, char ch)
  {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
    x3 = _x3;
    y3 = _y3;
    x4 = _x4;
    y4 = _y4;
    direction = ch;
    center_calculator();
    clicked = false;
    c = color(255);
  }


  void display()
  {
    fill(c);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    //check_click();
  }



  void center_calculator()
  {
    if (direction == 'L') 
    {
      centerX = 330-106;
      centerY = 410-0;
    } else if (direction == 'R') 
    {
      centerX = 330+106;
      centerY = 410-0;
    } else if (direction == 'U') 
    {
      centerX = 330-0;
      centerY = 410-106;
    } else if (direction == 'D') 
    {
      centerX = 330-0;
      centerY = 410+106;
    }
  }
  void check_click()
  {
    //println((dist(mouseX,mouseY,centerX,centerY)));
    //println("C_X:" + centerX + "C_Y:" + centerY);
    if (dist(mouseX, mouseY, centerX, centerY) <= 106 && mousePressed == true)
    {
      clicked = true;
      //print(direction);
      //update();
    }
  }

  void update()
  {
    check_click();
    if (clicked)
    {
      switch(direction) {

      case 'L': 
        {
          x1 += (speed*-1);
          x2 += (speed*-1);
          x3 += (speed*-1);
          x4 += (speed*-1);
        }
        break;

      case 'R':
        {
          x1 += (speed);
          x2 += (speed);
          x3 += (speed);
          x4 += (speed);
        }
        break;

      case 'U':
        {
          y1 += (speed*-1);
          y2 += (speed*-1);
          y3 += (speed*-1);
          y4 += (speed*-1);
        }
        break;

      case 'D':
        {
          y1 += (speed);
          y2 += (speed);
          y3 += (speed);
          y4 += (speed);
        }
        break;
      }
    }
  }
}


void keyPressed()
{
  if (key == 's')
  {
    chosen_square = (chosen_square+1)%4;
  }
}
