// // Wiring:
// // ESP32       | AMG8833      
// // 3V3 (3.3V)  | 3VO           
// // GND         | GND           
// // D21         | SDA          
// // D22         | SCL           
// //
// #include <WiFi.h>
// #include <Arduino.h>
// #include <SPI.h>
// #include <ESPmDNS.h>
// #include <WiFiUdp.h>
// #include <ArduinoOTA.h>
// #include <Wire.h>
// #include <Adafruit_Sensor.h>
// #include <Adafruit_AMG88xx.h>
// #include <PubSubClient.h>           // MQTT support

// #define SEALEVELPRESSURE_HPA (1013.25)
// #define STATUSINTERVAL 30000 // Interval of the status messages
// #define AMGSAMPLING 1000 // AMG8833 thermal camera sampling in milliseconds

// Adafruit_AMG88xx amg;
// unsigned long delayTime;

// #define AMG_COLS 8
// #define AMG_ROWS 8
// float pixels[AMG_COLS * AMG_ROWS];
// int counter;
// double fahrenheit; // Degrees in fahrenheit
// int count; // Counter for pixels that are above threshold
// // maybe use #define to make static variables for threshold and how many pixels

// // Variables needed for magnetic integration
// // I don't think we need this, but commenting in case | int val = 0;  // variable to store hall sensor measurement
// const int halPin = 19;
// #define LED 2 // ask what this is about
// // int counter = 0;

// const char* ssid = "IT313-Study";
// const char* password = "checkout2";
// const char* mqtt_server = "192.168.25.10"; 
// const char* mqtt_user = "";
// const char* mqtt_password = "";
// const char* clientID = "";
// const char* topicStatus = "/thermal/status";
// const char* topicThermal = "armtronix_mqtt";

// WiFiClient espClient;
// PubSubClient mqtt(mqtt_server, 1883, 0, espClient);

// unsigned long endTime, uptime, lastStatus, lastAMG;
// int  vSTATUSINTERVAL, vAMGSAMPLING;



// void sendStatus() {
//   Serial.print("Status | RSSI: ");
//   Serial.print(WiFi.RSSI());
//   Serial.print(", Uptime: ");
//   Serial.println(millis()/ 60000);
//   Serial.println();

// String mqttStat = "";
//   mqttStat = "{\"rssi\":";
//   mqttStat += WiFi.RSSI();
//   mqttStat += ",\"uptime\":";
//   mqttStat += millis()/ 60000;
//   mqttStat += "}";
//   if (mqtt_server!="") {
//     mqtt.publish(topicStatus, mqttStat.c_str());
//   }
// }

// void sendAMGImage() {
//   //read all the pixels
//   String image = "";
//   amg.readPixels(pixels);  
//   Serial.print("[");
//   for(int i=1; i<=AMG88xx_PIXEL_ARRAY_SIZE; i++){
//     image = image + pixels[i-1] + ",";
//     // Turns pixels into fahrenheit, might need to change image variable because that is what is sent to MQTT
//     fahrenheit = (pixels[i-1] * 9.0) / 5.0 + 32;
//     Serial.print(fahrenheit);
//     Serial.print(", ");
//     if( i%8 == 0 ) Serial.println();
//     // Adds to counter for each pixel above threshold
//     // THRESHOLD HERE
//     if (fahrenheit >= 73.00) count++;
//   }
//   image = image.substring(0, image.length() - 1);
//   Serial.println("]");
//   // Compares pixels that reached over threshold to counter max
//   // COUNT
//   if (count >= 4) Serial.println("Person Detected");
//   Serial.println();
//   count = 0;
// }

// boolean test_function(boolean test) {
//     Serial.println("Working");
//     return test;
// }

// void magnet_detect() {
//     counter++;
//     test_function(true);
//     Serial.println(counter);
// }

// void setup() {
//   Serial.begin(9600);


//   // Port defaults to 3232
//   // ArduinoOTA.setPort(3232);

//   // Hostname defaults to esp3232-[MAC]
//   // ArduinoOTA.setHostname("myesp32");

//   // No authentication by default
//   // ArduinoOTA.setPassword("admin");

//   // Password can be set with it's md5 value as well
//   // MD5(admin) = 21232f297a57a5a743894a0e4a801fc3
//   // ArduinoOTA.setPasswordHash("21232f297a57a5a743894a0e4a801fc3");



//   // Unsure if this is what is needed for magnetic integration, but putting here
//   //while(Serial.available());
//   pinMode(halPin, INPUT);
//   pinMode(LED, OUTPUT);
//   attachInterrupt(halPin, magnet_detect, FALLING);

//   digitalWrite(LED, HIGH);

//   // Side note about magnet stuff, ask if this would all work work with our current wiring and if any code needs to change due to new wiring

//   if (!amg.begin()) {
//     Serial.println("Could not find a valid AMG88xx sensor, check wiring!");
//     while (1) { delay(1); }
//   }

// }

// void loop() {

// }