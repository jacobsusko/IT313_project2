// /***************************************************************************
//   This is a library for the AMG88xx GridEYE 8x8 IR camera

//   This sketch tries to read the pixels from the sensor

//   Designed specifically to work with the Adafruit AMG88 breakout
//   ----> http://www.adafruit.com/products/3538

//   These sensors use I2C to communicate. The device's I2C address is 0x69

//   Adafruit invests time and resources providing this open source code,
//   please support Adafruit andopen-source hardware by purchasing products
//   from Adafruit!

//   Written by Dean Miller for Adafruit Industries.
//   BSD license, all text above must be included in any redistribution
//  ***************************************************************************/

// #include <Wire.h>
// #include <Adafruit_AMG88xx.h>
// #include <Arduino.h>
// #include <SPI.h>

// Adafruit_AMG88xx amg;

// float pixels[AMG88xx_PIXEL_ARRAY_SIZE];
// double fahrenheit; // degrees in fahrenheit
// int count; //counter for how many pixels


// void setup() {
//     Serial.begin(9600);
//     while(Serial.available());
//     Serial.println(F("AMG88xx pixels"));

//     bool status;
    
//     // default settings
//     status = amg.begin();
//     if (!status) {
//         Serial.println("Could not find a valid AMG88xx sensor, check wiring!");
//         while (1);
//     }
    
//     Serial.println("-- Pixels Test --");

//     Serial.println();

//     delay(100); // let sensor boot up
// }


// void loop() { 
//     //read all the pixels
//     amg.readPixels(pixels);
//     Serial.print("[");
//     for(int i=1; i<=AMG88xx_PIXEL_ARRAY_SIZE; i++){
//       fahrenheit = (pixels[i-1] * 9.0) / 5.0 + 32;
//       Serial.print(fahrenheit);
//       Serial.print(", ");
//       if( i%8 == 0 ) Serial.println();
//       if (fahrenheit >= 73.00) count++;
//     }
//     Serial.println("]");
//     Serial.println(count);
//     if (count >= 4) Serial.println("Person Detected");
//     Serial.println();
//     count = 0;
//     //delay a second
//     delay(1000);
// }
