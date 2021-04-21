
/*------------------------------------------------------------------------------

For this project we used the Game Control Plus and the G4P libraries in order to
receive input from a bluetooth controller. 
The Gcp Configurator example was used to create the file "car_controller", which
hold the controller input and its values in order to be read by Processing

------------------------------------------------------------------------------*/

//libraries that allow the program to receive input from a bluetooth controller
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

//library for serial communication with arduino
import processing.serial.*;

//create a serial object
Serial myPort;

//create object to hold the controller files
ControlDevice car_controller;
//create objects to hold the controller commands
ControlIO control;

//variable to hold the input of the commands
float vertical_movement;


void setup()
{
  size(360, 200);

  //upload the files of the controller 
  control = ControlIO.getInstance(this);
  car_controller = control.getMatchedDevice("car_controller");

  //exit system in case there is no controller file 
  if (car_controller == null)
  {
    println("not today champ");
    System.exit(-1);
  }

  //establish serial connection 
  printArray(Serial.list());
  String portname=Serial.list()[0]; 
  println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw()
{
  //background(vertical_movement);
  
  //get the input of the bluetooth controller
  getInput();
}

public void getInput()
{
  //get input from the y axis of the slider and map it to a value between -255 and 255
  //by default, the configuration of the slider input is between -1 and 1
  vertical_movement = map(car_controller.getSlider("Y_slider").getValue(), -1, 1, -255, 255);
  println(vertical_movement);
}


//send information to processing
void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);

//send the mapped values from the input of the controller to Arduino
  myPort.write(vertical_movement + "\n");
}
