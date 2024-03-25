// #include <Arduino.h>

// int val = 0;  // variable to store hall sensor measurement
// const int halPin = 19;
// #define LED 2
// int counter = 0;

// void magnet_detect() {
//     counter++;
//     Serial.println("Detect");
//     Serial.println(counter);
// }

// void setup() {
//     Serial.begin(9600);
//     while(Serial.available());
//     pinMode(halPin, INPUT);
//     // pinMode(LED, OUTPUT);
//     attachInterrupt(halPin, magnet_detect, RISING);
//     // digitalWrite(LED, HIGH);
// }

// void loop() {  // Put your main code here to run repeatedly
//     delay(1000);
//     // digitalWrite(LED, LOW);
//     int val = digitalRead(halPin);  // variable to store value of hall sensor

// }