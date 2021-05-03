import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import processing.video.*;

import processing.serial.*;

//create a serial object
Serial myPort;

//create object to hold the controller files
ControlDevice joystick_configuration;
//create objects to hold the controller commands
ControlIO control;

color black, b1;
PShape rhombus;
int x = 330;
int y = 410;
int x1 = 216;
int y1 = 410;
int x2 = 330; 
int y2 = 296;
int x3 = 444;
int y3 =410;
int x4 = 330;
int y4 = 524;

int o_x = 330;
int o_y = 410;
int o_x1 = 216;
int o_y1 = 410;
int o_x2 = 330; 
int o_y2 = 296;
int o_x3 = 444;
int o_y3 =410;
int o_x4 = 330;
int o_y4 = 524;


int player_x;
int player_y;
int p_t;


int spaceship_c_x;
int spaceship_c_y;
int s_c_t;

int title_x;
int title_y;

boolean back = false;
boolean go = false;
int menu_square_size = 200;  
int speed = 150;
boolean right = false;
boolean left = false;
boolean down = false;
boolean up = false;

float left_horizontal_slider;
float left_vertical_slider;
float right_horizontal_slider;
float right_vertical_slider;
boolean triangle;
boolean square;
boolean circle;
boolean cross;
boolean save;
boolean clear;
boolean menu;


boolean red;
boolean yellow;
boolean green;
boolean blue;


boolean red_OnOff;
boolean yellow_OnOff;
boolean green_OnOff;
boolean blue_OnOff;

boolean show_instruction = false;
boolean show_c = false;
boolean stop;
boolean play_game; 

PImage[] menu_images = new PImage[8];
PImage[] menu_images_ori = new PImage[4];

int chosen_square = 1;

PImage play;
PImage story;
PImage quit;
PImage setting;
PImage title;
PImage player;
PImage spaceship_cartoon;
PImage spaceship_cartoon_2;
PImage lines;
PImage instructions;
PImage Character_I;

PImage quit_text;
PImage[] quit_hovers = new PImage[2];
int quit_hover;

PImage savedIMG;

Movie gameAnimation;

ArrayList<Stroke> brush = new ArrayList<Stroke>();
int lifeSpan;
float sizeOfPoint;
color backgroundColor = 0;


//position of spaceship
PVector pos = new PVector(300, 300, 0);

float velocity = 0;

boolean[] keys = new boolean[4];

int brushPos_X;
int brushPos_Y;

boolean sI;

PGraphics background, sketch, rhombus_menu;

Table picture_number;

int numPic;

PImage spacecraft;

void setup()
{
  fullScreen();
  c1 = color(0, 51, 102);
  c2 = color(143, 183, 204);
  b1 = color(255, 0, 0);
  black = color(0);
  right = false;
  left = false;
  up = false;
  down = false;
  stop = false;

  x = int(width*0.1964);
  y = int(height*0.3904);
  x1 = int(width*0.1285);
  y1 = int(height*0.3904);
  x2 = int(width*0.1964); 
  y2 = int(height*0.2819);
  x3 = int(width*0.2642); 
  y3 = int(height*0.3904);
  x4 = int(width*0.1964);
  y4 = int(height*0.4990);

  o_x = int(width*0.1964);
  o_y = int(height*0.3904);
  o_x1 = int(width*0.1285);
  o_y1 = int(height*0.3904);
  o_x2 = int(width*0.1964); 
  o_y2 = int(height*0.2819);
  o_x3 = int(width*0.2642); 
  o_y3 = int(height*0.3904);
  o_x4 = int(width*0.1964);
  o_y4 = int(height*0.4990);


  player_x = 950;
  player_y = 615;

  spaceship_c_x = 1445;
  spaceship_c_y = 805;
  s_c_t = 255;
  p_t = 226;

  title_x =  width *3/4- 100;
  title_y = height * 1/4 - 100;


  menu_images[0] = loadImage("setting.png");
  menu_images[1] = loadImage("play.png");
  menu_images[2] = loadImage("story.png");
  menu_images[3] = loadImage("quit.png");
  menu_images[4] = loadImage("setting_hover.png");
  menu_images[5] = loadImage("play_hover.png");
  menu_images[6] = loadImage("story_hover.png");
  menu_images[7] = loadImage("quit_hover.png");


  menu_images_ori[0] = loadImage("setting.png");
  menu_images_ori[1] = loadImage("play.png");
  menu_images_ori[2] = loadImage("story.png");
  menu_images_ori[3] = loadImage("quit.png");


  title = loadImage("title.PNG");
  player = loadImage("player.PNG");
  spaceship_cartoon = loadImage("s_c_c.PNG");
  spaceship_cartoon_2 = loadImage("s_c_c_2.png");
  lines = loadImage("lines.png");
  Character_I = loadImage("Character_I.png");
  instructions = loadImage("controller_img.png");
  quit_text = loadImage("quit_text.png");

  quit_hovers[0] = loadImage("quit_hoverYes.png");
  quit_hovers[1] = loadImage("quit_hoverNo.png");
  quit_hover = 0;

  savedIMG =  loadImage("saved.png");

  gameAnimation = new Movie(this, "animation.mp4");
  gameAnimation.noLoop();

  setting = menu_images[0];
  play = menu_images[1];
  story = menu_images[2];
  quit = menu_images[3];
  println(width);
  println(height);


  control = ControlIO.getInstance(this);
  joystick_configuration = control.getMatchedDevice("joystick_configuration");

  //exit system in case there is no controller file 
  if (joystick_configuration == null)
  {
    println("not today champ");
    System.exit(-1);
  }

  background = createGraphics(width, height);
  sketch = createGraphics(width, height);
  rhombus_menu = createGraphics(width, height);

  loadBackgroundComponents();

  sI = true;
  lifeSpan = (int)random(15, 30);
  sizeOfPoint = (float)random(15, 30);

  red_OnOff = false;
  green_OnOff = false;
  blue_OnOff = false;

  spacecraft = loadImage("spaceship.png");

  loadData();
  printArray(Serial.list());
  String portname=Serial.list()[0]; 
  println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw()
{
  background(255);
  
  background.beginDraw();

  // Foreground
  setGradient(0, 0, width, height, c1, c2, Y_AXIS);
  
  //display stars in the background
  drawStars();

  background.endDraw();
  imageMode(CORNER);
  image(background, 0, 0);

  getInput();

  //fill(0);
  ////translate(width/2,0);
  //int _x = mouseX;
  //int _y = mouseY;
  //fill(255);
  //textSize(32);
  //text("mouseX: "+ _x + "mouseY: "+ _y, 100, 800, 1200, 950);


  //if (back == true) {
  //  bring_back();
  //  go = false;
  //} 
  //if (go){
  //  update();
  //  back = false;}
  if (back == true) {
    bring_back();
    go = false;
  } 
  if (go) {
    update();
    back = false;
  }

  hover();
  //hover();
  rhombus_menu.beginDraw();
  imageMode(CENTER);
  image(menu_images[0], x1, y1, menu_square_size, menu_square_size);
  image(menu_images[1], x2, y2, menu_square_size, menu_square_size);
  image(menu_images[2], x3, y3, menu_square_size, menu_square_size);
  image(menu_images[3], x4, y4, menu_square_size, menu_square_size);
  rhombus_menu.endDraw();


  //image(title, title_x, title_y , title.width/2.5, 100);
  //image(player, player_x, player_y, player.width/1.5, player.height/1.5);
  ////println("PLayer: " + player.width + player.height);
  //image(spaceship_cartoon, spaceship_c_x, spaceship_c_y , spaceship_cartoon.width/3.5,spaceship_cartoon.height/3.5);
  home_screen();
  character_info();
  show_instructions();
  game_play();


  button();
}

//display the information of the character
void character_info()
{
  if (show_c)
  {
    //for(int i = 0; i< 255; i++){
    //tint(255,i);
    image(Character_I, width/2, height/2, Character_I.width * 1.5, Character_I.height * 1.5);
    //}
  }
  //noTint();
}

// display the instructions
void show_instructions()

{
  if (show_instruction)
  {
    //for(int i = 0; i< 255; i++){
    //tint(255,i);
    image(instructions, width/2, height/2);
    //}
  }
  //noTint();
}

// play the game 
void game_play()
{
  if (play_game)
  {
    if (menu) {
      if (sI == true) {
        sI = false;
      }

      checkColor();

      color pointColor = color(getRed(), getGreen(), getBlue());
      if (yellow)
      {
        pointColor = color(255, 255, getBlue());
      }

      /* UNCOMMENT to have more variety on the shades of yellow
       //yellow requires specific conditions to make it more varied because it is a composition of various rgb values
       if (yellow)
       {
       pointColor = color(random(200, 255), random(200, 255), getBlue());
       }
       */

      //pos_X = mouseX;
      //pos_Y = mouseY;

      //create the Point objects
      println("Stroke = "+ pos.x + "," + pos.y);
      //Stroke p = new Stroke((pos.x) - spacecraft.width/2, (pos.y) , random(sizeOfPoint), pointColor, int(random(lifeSpan)));
      Stroke p = new Stroke(0, 0, random(sizeOfPoint), pointColor, int(random(lifeSpan)));

      brush.add(p);
    }
      /* DRAW ON THE SKETCH ------------------------------------------------------------------------------------------ */
      sketch.beginDraw();

      for (int index=0; index<brush.size(); index++) {
        if (brush.get(index).status()==false) {
          brush.remove(index);
        } else {

          brush.get(index).update();
          brush.get(index).display();
        }
      } 

      sketch.endDraw(); 
      
      imageMode(CORNER);
      image(sketch, 0, 0);
      imageMode(CENTER);

      //SPACECRAFT

      moveUpdate();
      show();
    
    if (save)
    {
      numPic += 1;

      saveFrame("drawings/sketch"+ numPic + ".png");

      pushStyle();
      pushMatrix();
      //textSize(32);
      //textAlign(CENTER);
      //text("Sketch Saved", width/2, 50);
      
      imageMode(CENTER);
      image(savedIMG, width/2, 100);

      popMatrix();
      popStyle();

      save = !save;
      println("Sketch saved");

      saveSkecthNumber();

      loadData();
    }



    checkClear();
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

//get input from the controller using the game control library
public void getInput()
{
  //get input from the y axis of the slider and map it to a value between -255 and 255
  //by default, the configuration of the slider input is between -1 and 1
  left_horizontal_slider = map(joystick_configuration.getSlider("L_H_slider").getValue(), -1, 1, -255, 255);
  left_vertical_slider = map(joystick_configuration.getSlider("L_V_slider").getValue(), -1, 1, -255, 255);
  right_horizontal_slider = map(joystick_configuration.getSlider("R_H_slider").getValue(), -1, 1, -255, 255);
  right_vertical_slider = map(joystick_configuration.getSlider("R_V_slider").getValue(), -1, 1, -255, 255);
  triangle = boolean(int(joystick_configuration.getButton("Triangle").getValue()));
  circle = boolean(int(joystick_configuration.getButton("Circle").getValue()));
  cross = boolean(int(joystick_configuration.getButton("Cross").getValue()));
  square = boolean(int(joystick_configuration.getButton("Square").getValue()));
  save = boolean(int(joystick_configuration.getButton("Save").getValue()));
  menu = boolean(int(joystick_configuration.getButton("Menu").getValue()));
  blue = boolean(int(joystick_configuration.getButton("Blue").getValue()));
  green = boolean(int(joystick_configuration.getButton("Green").getValue()));
  red = boolean(int(joystick_configuration.getButton("Red").getValue()));
  yellow = boolean(int(joystick_configuration.getButton("Yellow").getValue()));
  clear = boolean(int(joystick_configuration.getButton("Clear").getValue()));

  //if (triangle != 0)
  //println("cheeky");
  //println("red: " + red);
  //println("blue: " + blue);
  //println("green: " + green);
  //println("yellow: " + yellow);
  //println("triangle: " + triangle);
  //println("cross: " + cross);
  //println("circle: " + circle);
  //println("square: " + square);
}



//display home screen
void home_screen()
{

  //imageMode(CENTER);
  //image(menu_images[0], x1, y1, menu_square_size, menu_square_size);
  //image(menu_images[1], x2, y2, menu_square_size, menu_square_size);
  //image(menu_images[2], x3, y3, menu_square_size, menu_square_size);
  //image(menu_images[3], x4, y4, menu_square_size, menu_square_size);

  if (!stop) {
    imageMode(CENTER);
    //println("PLayer: " + player.width + player.height);
    tint(255, s_c_t);
    image(spaceship_cartoon, width/2, height/2+65);
    image(title, title_x, title_y, title.width/2.5, 100);
    image(lines, width/2, height/2);
    tint(255, p_t);
    image(player, player_x, player_y, player.width/1.5, player.height/1.5);

    noTint();
    //, spaceship_cartoon.width/3.5,spaceship_cartoon.height/3.5  spaceship_c_x
  } else {
    image(quit_text, width/2, height/2);
    image(quit_hovers[quit_hover], width/2, height/2);
    if (square)
    {
      if (quit_hover != 0)
      {
        stop = false;
        //bring_back();
        back = true;
        println("K");
      } else
        exit();
    }
  }
}


//void keyPressed()
//{
//  //if (key == 'd')
//  //{
//  //  right = true;

//  //}

//  //if (key == 'w')
//  //{
//  //  up = true;

//  //}

//  //if (key == 'a')
//  //{
//  //  left = true;

//  //}

//  //if (key == 's')
//  //{
//  //  down = true;

//  //}

/*Cases for the button */
void button() {
  //if (key == 'g')
  if (cross && !play_game)
  {
    for (int i = 0; i< 4; i++)
    {
      if (menu_images[i] != menu_images_ori[i])
      {
        switch(i) {
        case 0: 
          {
            left = true;
            right = false;
            up = false;
            down = false;
          }
          break;
        case 1: 
          {
            left = false;
            right = false;
            up = true;
            down = false;
          }
          break;
        case 2: 
          {
            left = false;
            right = true;
            up = false;
            down = false;
          }
          break;
        case 3: 
          {
            left = false;
            right = false;
            up = false;
            down = true;
          }
          break;
        }
      }
    }
    go = true;
    back = false;
  }
  //right = !right;
  //left = !left;
  //up = !up;
  //down = !down;
  //}

  //if ( key == 'h')
  if (circle && !play_game)
  {
    back = !back;
    go = false;
    //right = !right;
    //left = !left;
    //up = !up;
    //down = !down;
  }




  // if (key == 'k')
  if (triangle && !play_game)
  {
    chosen_square = (chosen_square+1)%4;
  }

  //if (key == 'i')
  if (menu && !play_game)
  {
    quit_hover = (quit_hover+1)%2;
  }
}

/* update position of the spacecraft */

void update() {
  if (right) {

    if (x1 + menu_square_size/2 <= 0)
      x1 = 0-menu_square_size/2;
    else
    {
      x1 -= speed;
    }

    if (x2 + menu_square_size/2 <= 0)
      x2 = 0-menu_square_size/2;
    else
    {
      x2 -= speed;
    }

    if (x3 - menu_square_size/2 >= width)
      x3 = width+menu_square_size/2;
    else
    {
      x3 += speed;
    }


    if (x4 + menu_square_size/2 <= 0)
      x4 = 0-menu_square_size/2;
    else
    {
      x4 -= speed;
    }

    //x1 -= speed;
    //x2 -= speed;
    //x3 += speed;
    //x4 -= speed;
    //speed *=.99;
    show_c = true;
  }

  if (left) {

    if (x1 + menu_square_size/2 <= 0)
      x1 = 0-menu_square_size/2;
    else
    {
      x1 -= speed;
    }

    if (x2 - menu_square_size/2 >= width)
      x2 = width+menu_square_size/2;
    else
    {
      x2 += speed;
    }

    if (x3 - menu_square_size/2 >= width)
      x3 = width+menu_square_size/2;
    else
    {
      x3 += speed;
    }


    if (x4 - menu_square_size/2 >= width)
      x4 = width+menu_square_size/2;
    else
    {
      x4 += speed;
    }

    //x1 -= speed;
    //x2 += speed;
    //x3 += speed;
    //x4 += speed;
    show_instruction = true;
  }

  if (up) {
    if (y1 - menu_square_size/2 >= height)
      y1 = height+menu_square_size/2;
    else
    {
      y1 += speed;
    }

    if (y2 + menu_square_size/2 <= 0)
      y2 = 0-menu_square_size/2;
    else
    {
      y2 -= speed;
    }

    if (y3 - menu_square_size/2 >= height)
      y3 = height+menu_square_size/2;
    else
    {
      y3 += speed;
    }


    if (y4 - menu_square_size/2 >= height)
      y4 = height+menu_square_size/2;
    else
    {
      y4 += speed;
    }
    play_game = true;

    //y1 += speed;
    //y2 -= speed;
    //y3 += speed;
    //y4 += speed;
  }

  if (down) {
    if (y1 + menu_square_size/2 <= 0)
      y1 = 0-menu_square_size/2;
    else
    {
      y1 -= speed;
    }

    if (y2 + menu_square_size/2 <= 0)
      y2 = 0-menu_square_size/2;
    else
    {
      y2 -= speed;
    }

    if (y3 + menu_square_size/2 <= 0)
      y3 = 0-menu_square_size/2;
    else
    {
      y3 -= speed;
    }




    if (y4 - menu_square_size/2 >= height)
      y4 = height+menu_square_size/2;
    else
    {
      y4 += speed;
    }
    //y1 -= speed;
    //y2 -= speed;
    //y3 -= speed;
    //y4 += speed;
    stop = true;
  }


  if (p_t <= 0)
    p_t = 0;
  else
    p_t -=speed;

  if (s_c_t <= 0)
    s_c_t = 0;
  else
    s_c_t -=speed;
}

// bring the UI elements from the selection of the main menu back to their original position

void bring_back() {

  if (right) {
    //if (x1 + menu_square_size/2 < 0)
    //  x1 = 0-menu_square_size/2;

    if (x1 >= o_x1)
      x1 = o_x1;
    else {
      x1 += speed;
    }

    if (x2 >= o_x2)
      x2 = o_x2;
    else {
      x2 += speed;
    }

    if (x3 <= o_x3)
      x3 = o_x3;
    else {
      x3 -= speed;
    }

    if (x4 >= o_x4)
      x4 = o_x4;
    else {
      x4 += speed;
    }  
    //x2 -= speed;
    //x3 += speed;
    //x4 -= speed;
    //speed *=.99;
    show_c = false;
  }

  if (left) {
    //x1 -= speed;
    //x2 += speed;
    //x3 += speed;
    //x4 += speed;

    if (x1 >= o_x1)
      x1 = o_x1;
    else {
      x1 += speed;
    }

    //}

    if (x2 <= o_x2)
      x2 = o_x2;
    else {
      x2 -= speed;
    }

    if (x3 <= o_x3)
      x3 = o_x3;
    else {
      x3 -= speed;
    }

    if (x4 <= o_x4)
      x4 = o_x4;
    else {
      x4 -= speed;
    }
    show_instruction = false;
  }

  if (up) {
    //y1 += speed;
    //y2 -= speed;
    //y3 += speed;
    //y4 += speed;

    if (y1 <= o_y1)
      y1 = o_y1;
    else {
      y1 -= speed;
    }

    //}

    if (y2 >= o_y2)
      y2 = o_y2;
    else {
      y2 += speed;
    }

    if (y3 <= o_y3)
      y3 = o_y3;
    else {
      y3 -= speed;
    }

    if (y4 <= o_y4)
      y4 = o_y4;
    else {
      y4 -= speed;
    }
    play_game = false;
  }

  if (down) {

    if (y1 < o_y1)
      y1 += speed;
    else {

      y1 = o_y1;
    }

    //}

    if (y2 >= o_y2)
      y2 = o_y2;
    else {
      y2 += speed;
    }

    if (y3 >= o_y3)
      y3 = o_y3;
    else {
      y3 += speed;
    }

    if (y4 <= o_y4)
      y4 = o_y4;
    else {
      y4 -= speed;
    }
    //stop = false;
  }


  if (p_t >= 226)
    p_t = 226;
  else
    p_t +=5;

  if (s_c_t >= 255)
    s_c_t = 255;
  else
    s_c_t +=5;
}


void hover()
{
  //println(chosen_square);
  menu_images[chosen_square] = menu_images[4+chosen_square]; 
  for (int i =0; i<4; i++)
  {
    if (i != chosen_square)
    {
      menu_images[i] = menu_images_ori[i];
    }
  }
}


void loadData() {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  picture_number = loadTable("numpics.csv", "header");

  // You can access iterate over all the rows in a table
  for (int i = 0; i < picture_number.getRowCount(); i++) {
    TableRow row = picture_number.getRow(i);
    // You can access the fields via their column name (or index)
    numPic = row.getInt("numpics");
  }

  println("NumPic = " + numPic);
}

void saveSkecthNumber()
{
  // Create a new row
  TableRow row =  picture_number.addRow();
  // Set the values of that row
  row.setFloat("numpics", numPic);

  // If the table has more than 10 rows
  if (picture_number.getRowCount() > 10) {
    // Delete the oldest row
    picture_number.removeRow(0);
  }
  //save new circles in the data/table.csv
  // Writing the CSV back to the same file
  saveTable(picture_number, "data/numpics.csv");
  // And reloading it
}

/*----------------------------------------------------------------------------------------------------------------*/

/* Get colors to paint ------------------------------------------------------------------------------ */

int getRed() {
  if (red == true) {
    return 255;
  } else {
    return (int)random(0, 255);
  }
}

int getGreen() {
  if (green == true) {
    return 255;
  } else {
    return (int)random(0, 255);
  }
}

int getBlue() {
  if (blue == true) {
    return 255;
  } else {
    return (int)random(0, 255);
  }
}

void show()
{
  pushMatrix();

  println("Spacecraft = "+ pos.x + "," + pos.y + ',' + pos.z);
  imageMode(CENTER);
  translate(pos.x, pos.y);
  rotate(pos.z);
  image(spacecraft, 0, 0);

  popMatrix();

  //noStroke();
  //fill(0, 128, 0);
  //rect(-10, -10, 20, 20);
  //stroke(0);
  //noFill();
  //triangle(-8, -8, 7, 0, -8, 8);
}

void moveUpdate()
{
  //pos.z += (keys[1]?.1:0) - (keys[0]?.1:0);

  //velocity += (keys[2]?.1:0)-(keys[3]?.1:0);
  pos.z += (circle?.1:0) - (square?.1:0);

  velocity += ((triangle?.1:0)-(cross?.1:0)) * 2;

  pos.x = (pos.x+width+velocity*cos(pos.z))%width;
  pos.y = (pos.y+height+velocity*sin(pos.z))%height;

  velocity *=.99;
}



void checkColor()
{
  if (red_OnOff)
  {
    if (!red) 
    {
      red = true;
    } 
    green = false;
    blue = false;
    yellow = false;
  }

  if (green_OnOff)
  {
    if (!green) 
    {
      green = true;
    } 
    red = false;
    blue = false;
    yellow = false;
  }

  if (blue_OnOff)
  {
    if (!blue)
    {
      blue = true;
    } 
    green = false;
    red = false;
    yellow = false;
  }

  if (yellow_OnOff)
  {
    if (!yellow) 
    {
      yellow = true;
    } 
    green = true;
    red = true;
    blue = false;
  }

  if (red_OnOff && green_OnOff && blue_OnOff && yellow_OnOff)
  {
    red = false;
    blue = false;
    green = false;
    yellow = false;
  }


  println("red: " + red);
  println("blue: " + blue);
  println("green: " + green);
  println("yellow: " + yellow);
}

void checkClear()
{
  if (int(clear) != 0) {
    background(backgroundColor);
    sketch.beginDraw();
    brush.clear();
    sketch.clear();
    sketch.endDraw();
    sI = true;
    back = true;
  }
}

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  println(s);
  //send the mapped values from the input of the controller to Arduino
  //myPort.write(int(red) +',' + blue + ',' + green + ',' + yellow + "\n");
  //println("Game:" + play_game);

  myPort.write(int(red) + "," + int(blue) + "," + int(green) + "," + int(yellow) + "," + int(triangle) + "," + int(cross) + "," + int(circle) + "," + int(square)  + ","  + int(play_game) +"\n");
}
