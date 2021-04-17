int ledPin = 4;
 
float brightness = 0;
 
void setup() {
  Serial.begin(9600);
  Serial.println("0");
  pinMode(ledPin, OUTPUT);
}
 
void loop() {
  while (Serial.available()) {
    //get the brightness value from processing
    brightness = Serial.parseFloat();
    
    if (Serial.read() == '\n') {
    //turn on the LED with the given brightness
      analogWrite(ledPin, brightness);
      Serial.println(brightness);
    }
  }
}
