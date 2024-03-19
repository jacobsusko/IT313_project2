// #include <Wire.h>
// #include <Adafruit_AMG88xx.h>
// #include <Arduino.h>
// #include <SPI.h>
 
//  void I2Cscanner() {
//   Serial.println ();
//   Serial.println ("I2C scanner. Scanning ...");
//   byte count = 0;

//   Wire.begin();
//   for (byte i = 8; i < 120; i++)
//   {
//     Wire.beginTransmission (i);          // Begin I2C transmission Address (i)
//     if (Wire.endTransmission () == 0)  // Receive 0 = success (ACK response) 
//     {
//       Serial.print ("Found address: ");
//       Serial.print (i, DEC);
//       Serial.print (" (0x");
//       Serial.print (i, HEX);     // PCF8574 7 bit address
//       Serial.println (")");
//       count++;
//     }
//   }
//   Serial.print ("Found ");      
//   Serial.print (count, DEC);        // numbers of devices
//   Serial.println (" device(s).");
// }

// void setup() {
//     Serial.begin(9600);
// }

// void loop() {
//     I2Cscanner();
// }