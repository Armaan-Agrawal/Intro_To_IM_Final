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

//create motor objects
Motor motor1 = Motor(AIN1, AIN2, PWMA, offsetA, STBY);
Motor motor2 = Motor(BIN1, BIN2, PWMB, offsetB, STBY);

//variable to hold the analog input of the y slider
float vertical_movement = 0;
float horizontal_movement = 0;

void setup() {
  Serial.begin(9600);
  //Serial.println("0");

}

void loop()
{
  while (Serial.available()) {
    vertical_movement = Serial.parseFloat();

    if (Serial.read() == '\n') {
      //read value of vertical movement from Processing
      Serial.println(vertical_movement);

      //define constrains from the control input for the car to be stationary
      if (vertical_movement > -10 && vertical_movement < 10)
        brake(motor1, motor2);

      //if the vertical movement is below -10 then move the car forward
      else if (vertical_movement < -10 && vertical_movement >= -255)
      {
        forward(motor1, motor2, 150);
      }
      //if the vertical movement is above 10 then move the car backwards
      else if (vertical_movement > 10 && vertical_movement <= 255)
      {
        back(motor1, motor2, -150);
      }


      //   motor1.drive(255,1000);
      //   motor1.drive(-255,1000);
      //   motor1.brake();
      //   delay(1000);
      //
      //   motor2.drive(255,1000);
      //   motor2.drive(-255,1000);
      //   motor2.brake();
      //   delay(1000);
      //
      //   forward(motor1, motor2, 150);
      //   delay(1000);
      //
      //
      //   back(motor1, motor2, -150);
      //   delay(1000);
      //
      //   brake(motor1, motor2);
      //   delay(1000);

      //this is for the left and right controls with the X slider
      //   left(motor1, motor2, 100);
      //   delay(1000);
      //   right(motor1, motor2, 100);
      //   delay(1000);
      //
      //   brake(motor1, motor2);
      //   delay(1000);
    }
  }
}
