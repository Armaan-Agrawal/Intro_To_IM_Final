ArrayList<Stroke> brush = new ArrayList<Stroke>();
int lifeSpan;
float sizeOfPoint;
color backgroundColor = 0;
boolean red;
boolean green;
boolean blue;
boolean yellow;
boolean sI;

PGraphics background, sketch;

boolean save = false;

Table picture_number;

int numPic;

PImage spacecraft;

void setup() {
  fullScreen();
  // size(900, 900);

  background = createGraphics(width, height);
  sketch = createGraphics(width, height);

  loadBackgroundComponents();


  sI = true;
  lifeSpan = (int)random(15, 30);
  sizeOfPoint = (float)random(15, 30);

  red = false;
  green = false;
  blue = false;

  spacecraft = loadImage("spaceship.png");

  loadData();
}

void draw() {
  background(0);

  /* GAME BACKGROUND ---------------------------------------------------------------------------------------------- */
  background.beginDraw();

  // Foreground
  setGradient(0, 0, width, height, c1, c2, Y_AXIS);
  //display stars in the background
  drawStars();

  background.endDraw();

  image(background, 0, 0);

  /*INSTURCTIONS -------------------------------------------------------------------------------------------------- */
  //I think this is the part that should be activated with the main menu option of PLAY GAME

  //DISPLAY INSTRUCTIONS
  if (sI==true) {
    instructions();
  }

  /* GAME ON ------------------------------------------------------------------------------------------------------ */

  /*I think for this part, we should have the true statement turn on as long as the player does not press the  command 
   to draw. So basically one button turn on the draw and the program keep drawing until that button is pressed again */

  if (mousePressed==true) {
    if (sI == true) {
      sI = false;
    }
    color pointColor = color(getRed(), getGreen(), getBlue());

    /* UNCOMMENT to have more variety on the shades of yellow
     //yellow requires specific conditions to make it more varied because it is a composition of various rgb values
     if (yellow)
     {
     pointColor = color(random(200, 255), random(200, 255), getBlue());
     }
     */
    //create the Point objects 
    Stroke p = new Stroke(mouseX, mouseY, random(sizeOfPoint), pointColor, int(random(lifeSpan)));
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

  image(sketch, 0, 0);

  //SPACECRAFT
  pushMatrix();
  pushStyle();
  
  imageMode(CENTER);
  image(spacecraft, mouseX + spacecraft.width/4, mouseY);

  popStyle();
  popMatrix();


  /* CHECK FOR THE COMMAND TO SAVE THE SKECTH  ----------------------------------------------------------------- */

  if (save)
  {
    numPic += 1;

    saveFrame("drawings/sketch"+ numPic + ".png");
    pushStyle();
    pushMatrix();
    textSize(32);
    textAlign(CENTER);

    text("Sketch Saved", width/2, 50);

    popMatrix();
    popStyle();

    save = !save;
    println("Sketch saved");

    saveSkecthNumber();

    loadData();
  }
}

void keyPressed() {
  if (key=='c') {
    background(backgroundColor);
    brush.clear();
    sI = true;
  }

  if (key=='r') {
    if (!red) {
      red = true;
    } 
    green = false;
    blue = false;
    yellow = false;
  }

  if (key=='g') {
    if (!green) {
      green = true;
    } 
    red = false;
    blue = false;
    yellow = false;
  }

  if (key=='b') {
    if (!blue) {
      blue = true;
    } 
    green = false;
    red = false;
    yellow = false;
  }

  if (key=='y') {
    if (!yellow) {
      yellow = true;
    } 
    green = true;
    red = true;
    blue = false;
  }

  if (key=='m') {
    red = false;
    blue = false;
    green = false;
    yellow = false;
  }

  if (key == 's')
  {
    save = true;
  }
}

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


/*----------------------------------------------------------------------------------------------------------------*/
//Table data is used to save the numerous sketches that the player can make
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

void instructions() {
  //background(255);

  pushStyle();
  pushMatrix();

  textSize(32);
  textAlign(CENTER);
  fill(255);
  text("CONTROLS:\n Left Mouse Click = Draw \n C = Clear\n R = Toggle Red\n B = Toggle Blue\n G = Toggle Green\n Y = Toggle Yellow\n M = Multi-Coloured", width/2, height/2);

  popStyle();
  popMatrix();
}
