import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import processing.serial.*;

Serial myPort;

ControlDevice cont;
ControlIO control;

float press;

void setup()
{


  size(360, 200);
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice("LED_Input");

  if (cont == null)
  {
    println("not today champ");
    System.exit(-1);
  }
  
  
   printArray(Serial.list());
  String portname=Serial.list()[0]; 
  println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw()
{
  background(press);
  getInput();
}

public void getInput()
{
  press = map(cont.getSlider("analog").getValue(), -1, 1, 0, 255);
  println(press);
}


 
void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
 
  //write brightness so that Arduino can use it
  myPort.write(press + "\n");
}
