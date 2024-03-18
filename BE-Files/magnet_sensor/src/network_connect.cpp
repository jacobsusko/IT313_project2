// #include <WiFi.h>
// #include <Arduino.h>
// //Author: Rafael Margary
// // This file will allow ESP-32 to connect to RPi via wifi
// // The LED will turn on if a connection is established
// // This code has been exercised
// const char* ssid = "";
// const char* password = "checkout3";
// const int LED = 5;

// void setup(){
//     pinMode (LED, OUTPUT);

//     Serial.begin(9600);

//     while(Serial.available());

//     WiFi.mode(WIFI_STA); //Optional
//     WiFi.begin(ssid, password);
//     Serial.println("\nConnecting");

//     while(WiFi.status() != WL_CONNECTED){
//         digitalWrite(LED, LOW);
//         Serial.print(".");
//         delay(100);
//     }

//     Serial.println("\nConnected to the WiFi network");
//     Serial.print("Local ESP32 IP: ");
//     Serial.println(WiFi.localIP());
//     digitalWrite(LED, HIGH);

// }

// void loop(){

// }
