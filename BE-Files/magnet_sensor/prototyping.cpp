#include <Arduino.h>

const int HalPin = 5;
const int TempPin = 7;
#define LED 2

void setup() {
  // put your setup code here, to run once:
  pinMode(HalPin, INPUT);
  pinMode(TempPin, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  mag = DigitalRead(HalPin);
  temp = DigitalRead(TempPin);
  DigitalWrite(LED, OFF);
  if (mag == HIGH) {
    DigitalWrite(LED, HIGH);
  }
}
