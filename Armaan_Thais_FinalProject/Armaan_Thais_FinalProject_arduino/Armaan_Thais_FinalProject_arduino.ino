#include <SparkFun_TB6612.h>
#define AIN1 2
#define BIN1 7
#define AIN2 4
#define BIN2 8
#define PWMA 5
#define PWMB 6
#define STBY 9

const int offsetA = 1;
const int offsetB = 1;

int Red_Light = 10;
int Green_Light = 3;
int Blue_Light = 11;
int Yellow_Light = 12;

//create motor objects
Motor motor1 = Motor(AIN1, AIN2, PWMA, offsetA, STBY);
Motor motor2 = Motor(BIN1, BIN2, PWMB, offsetB, STBY);

//variable to hold the analog input of the y slider
long timer = 0;
int timerLength = 1000;
int red = 0;
int blue = 0;
int green = 0;
int yellow = 0;
int triangle = 0;
int cross = 0;
int circle = 0;
int _square = 0;
bool red_on = false;
int play_game = 0;

void setup() {
  Serial.begin(9600);
  //Serial.println("0,0,0,0");
  Serial.println("0,0,0,0,0,0,0,0,0"); 
  pinMode(Red_Light,OUTPUT);
  pinMode(Blue_Light,OUTPUT);
  pinMode(Green_Light,OUTPUT);
  pinMode(Yellow_Light,OUTPUT);
}

void loop()
{
 // digitalWrite(Red_Light,HIGH);
  while (Serial.available()) {
    red = Serial.parseInt();
    blue = Serial.parseInt();
    green = Serial.parseInt();
    yellow = Serial.parseInt();
    triangle = Serial.parseInt();
    cross = Serial.parseInt();
    circle = Serial.parseInt();
    _square =Serial.parseInt();
    play_game = Serial.parseInt();
    
    if (Serial.read() == '\n') {
      //read value of vertical movement from Processing
      //Serial.println("red: " + red);
//      if(red!=0)
//     {
//
//
//
//        digitalWrite(Red_Light,HIGH);
//        digitalWrite(Blue_Light,LOW);
//        digitalWrite(Green_Light,LOW);
//        digitalWrite(Yellow_Light,LOW);
//      }
    if(play_game!=0){
       if(red != 0)
        digitalWrite(Red_Light,HIGH);
        else
        digitalWrite(Red_Light,LOW);

//        if(red != 0)
//          red_on =!red_on;
//        
//        digitalWrite(Red_Light,red_on);

        if(blue != 0)
        digitalWrite(Blue_Light,HIGH);
        else
        digitalWrite(Blue_Light,LOW);

         if(green != 0)
        digitalWrite(Green_Light,HIGH);
        else
        digitalWrite(Green_Light,LOW);

        if(yellow != 0)
        digitalWrite(Yellow_Light,HIGH);
        else
        digitalWrite(Yellow_Light,LOW);


        


        
        if(triangle != 0)
        {
          motor1.drive(-255,5);
          motor2.drive(255,5);
        if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }
        else if (triangle == 0 && cross == 0 && circle == 0 && _square == 0){
        brake(motor1, motor2);
         if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }

         if(cross != 0)
        {
          motor1.drive(255,5);
          motor2.drive(-255,5);
        if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }
        else if (triangle == 0 && cross == 0 && circle == 0 && _square == 0){
        brake(motor1, motor2);
         if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }

          if(circle != 0)
        {
          motor2.drive(255,5);
         // motor2.drive(-255,5);
//        if (millis()>timer){
////              onOff = !onOff;
////              digitalWrite(ledPin, onOff);
//              timer = millis() + timerLength;
//             }
        }
        else if (triangle == 0 && cross == 0 && circle == 0 && _square == 0){
        brake(motor1, motor2);
         if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }


        if(_square != 0)
        {
          motor1.drive(-255,5);
         // motor2.drive(-255,5);
        if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }
        else if (triangle == 0 && cross == 0 && circle == 0 && _square == 0){
        brake(motor1, motor2);
         if (millis()>timer){
//              onOff = !onOff;
//              digitalWrite(ledPin, onOff);
              timer = millis() + timerLength;
             }
        }

        
      //define constrains from the control input for the car to be stationary
//      if (vertical_movement > -10 && vertical_movement < 10)
//        brake(motor1, motor2);
//
//      //if the vertical movement is below -10 then move the car forward
//      else if (vertical_movement < -10 && vertical_movement >= -255)
//      {
//        forward(motor1, motor2, 150);
//      }
//      //if the vertical movement is above 10 then move the car backwards
//      else if (vertical_movement > 10 && vertical_movement <= 255)
//      {
//        back(motor1, motor2, -150);
//      }
    }
      Serial.print(red);
      Serial.print(',');
      Serial.print(blue);
      Serial.print(',');
      Serial.print(green);
      Serial.print(',');
      Serial.print(yellow);
      Serial.print(',');
      Serial.print(triangle);
      Serial.print(',');
      Serial.print(cross);
      Serial.print(',');
      Serial.print(circle);
      Serial.print(',');
      Serial.print(_square);
      Serial.print(',');
      Serial.println(play_game);
     

    }
    
  }
}
