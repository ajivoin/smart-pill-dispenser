// Written by Jon Zimmerman

//Initialize libraries for servo
#include <Stepper.h>
#include <VarSpeedServo.h>
VarSpeedServo servo3;
VarSpeedServo servo4;
//setup libraries for stepper motorsconst int steps_per_revolution = 2048;
Stepper stepperMotor2(steps_per_revolution, 41, 37, 39, 35);
Stepper stepperMotor1(steps_per_revolution, 43, 47, 45, 49);
//set pins and variables for ultrasonic sensor
#define trigPin 10
#define echoPin  9
long duration;
int distance;

void setup()
{
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  // Open serial communications and wait for port to open:
  Serial.begin(115200);
  Serial2.begin(9600);
  // attach servos and set initial condition
  servo3.attach(5, 400, 2400);
  servo4.attach(6, 400, 2400);
  stepperMotor1.setSpeed(10);
  stepperMotor2.setSpeed(10);
  servo3.write(10);
  servo4.write(10);
}
//Create global scoped variables
int distanceCount = 0;
bool pillsRemoved = false;
bool dispense = false;
unsigned long lastConnectionTime = 0;
const unsigned long postInterval = 10 * 1000;  // posting interval of 10 minutes  (10L * 1000L; 10 seconds delay for testing)
void loop() 
{
  // compute distance to cup using ultrasonic sensor
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
  // Calculating the distance
  distance = duration * 0.034 / 2;
  //track if the cup is present and include debouncing interval for false positives
  bool triggered = false;
  if ((millis() - lastConnectionTime) > postInterval) {
    lastConnectionTime = millis();
    if (distance > 20) {
      distanceCount++;
      //Send data to ESP wifi module
      Serial2.print("$");
      Serial.print("$");
      bool triggered = true;
    }
  }
  int servoSpeed = 30;
  int dispenseCount1 = 0;
  int dispenseCount2 = 0;
  int dispenseCount3 = 0;
  int dispenseCount4 = 0;
  if ( Serial2.available() > 0)   {
    if (Serial2.read() != '.') {
      //This is a poor data parsing method, but hackathon speed matters
      dispense = true;
      String str = Serial2.readStringUntil(']');
      int startIndex = str.indexOf('[');
      int commaIndex = str.indexOf(',');
      //  Search for the next comma just after the first
      int secondCommaIndex = str.indexOf(',', commaIndex + 1);
      int thirdCommaIndex = str.indexOf(',', secondCommaIndex + 1);
      int endIndex = str.indexOf(']');
      String firstValue = str.substring(startIndex + 1, commaIndex);
      String secondValue = str.substring(commaIndex + 1, secondCommaIndex);
      String thirdValue = str.substring(secondCommaIndex + 1, thirdCommaIndex);
      String fourthValue = str.substring(thirdCommaIndex + 1, endIndex);
      Serial.print(firstValue);
      Serial.print(secondValue);
      Serial.print(thirdValue);
      Serial.println(fourthValue);
      dispenseCount1 = firstValue.toInt();
      dispenseCount2 = secondValue.toInt();
      dispenseCount3 = thirdValue.toInt();
      dispenseCount4 = fourthValue.toInt();
      Serial.println("dispenseCount2#1");
      Serial.println(dispenseCount2);
      Serial.println("\n");
      Serial.println("dispenseCount2#2");
      Serial.println(dispenseCount2);
      Serial.println("\n");
      Serial.println("\n");
      if (dispenseCount1 != -1) {
        for (int i = 0; i < dispenseCount1; i++) {
          stepperMotor1.step(341);
        }
      }
      if (dispenseCount2 != -1) {
        for (int x = 0; x < dispenseCount2; x++ ) {
          Serial.println("SecondValue");
          stepperMotor2.step(341);
        }
      }
      if (dispenseCount3 != -1) {
        for (int i = 0; i < dispenseCount3; i++) {
          //Serial.print(85*(1+i));
          servo3.slowmove(50 * (1 + i), servoSpeed);
        }
      }
      if (dispenseCount4 != -1) {
        for (int i = 0; i < dispenseCount4; i++) {
          //Serial.print(85*(1+i));
          servo4.slowmove(50 * (1 + i), servoSpeed);
        }
      }
    }
  }
  else {
  }
}
