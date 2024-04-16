// Packages
#include <WiFi.h>
#include <Arduino.h>
#include <SPI.h>
#include <ESPmDNS.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_AMG88xx.h>
#include <PubSubClient.h>           // MQTT support

// Sampling/Interval Constants
#define STATUSINTERVAL 30000 // Interval of the status messages
#define AMGSAMPLING 1000 // AMG8833 thermal camera sampling in milliseconds
#define SAMPLING 15000 

// Sampling/Interval Variables
unsigned long endTime, uptime, lastStatus, lastAMG;
int  vSTATUSINTERVAL, vAMGSAMPLING;

// AMG Thermal Sensor Constants
Adafruit_AMG88xx amg;
unsigned long delayTime;
#define AMG_COLS 8
#define AMG_ROWS 8
float pixels[AMG88xx_PIXEL_ARRAY_SIZE];

// Connection to Raspberry PI Constants
const char* ssid = "IT313-Study";
const char* password = "checkout2";
const char* mqtt_server = "192.168.25.10"; 
const char* mqtt_user = "Backend";
const char* mqtt_password = "Bestend";
const char* clientID = "IT313MQTT";
const char* topicStatus = "topicKing358";
const int halPin = 19;
WiFiClient espClient;
PubSubClient mqtt(mqtt_server, 1883, 0, espClient);

// Calculation Variables
double fahrenheit; // degrees in fahrenheit
boolean roomOccup;
boolean occup;
int count;
float roomBaseline;
unsigned long lastCal;
boolean interrupt = false;


// MQTT reconnect logic
void reconnect() {
  //String mytopic;
  // Loop until we're reconnected
  while (!mqtt.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    if (mqtt.connect(clientID, mqtt_user, mqtt_password)) {
      Serial.println(F("connected"));
      // ... and resubscribe
      // mqtt.subscribe(topicStatus);
    } else {
      Serial.print(F("failed, rc="));
      Serial.print(mqtt.state());
      Serial.println(F(" try again in 5 seconds"));
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

// Function for testing MQTT Connections
void callback(char* topic, byte* payload, unsigned int length) {
  // Convert the incoming byte array to a string
  String strTopic = String((char*)topic);
  payload[length] = '\0'; // Null terminator used to terminate the char array
  String message = (char*)payload;

  Serial.print(F("Message arrived on topic: ["));
  Serial.print(topic);
  Serial.print(F("], "));
  Serial.println(message);

}


// Testing Function for Sending MQTT Status  
void sendStatus() {
  Serial.print("Status | RSSI: ");
  Serial.print(WiFi.RSSI());
  Serial.print(", Uptime: ");
  Serial.println(millis()/ 60000);
  Serial.println();

String mqttStat = "";
  mqttStat = "{\"rssi\":";
  mqttStat += WiFi.RSSI();
  mqttStat += ",\"uptime\":";
  mqttStat += millis()/ 60000;
  mqttStat += "}";
  if (mqtt_server!="") {
    mqtt.publish(topicStatus, mqttStat.c_str());
  }
}

// Function to Calibrate the Thermal Camera
float calibrate() {
    float sum = 0.0;
    float average;
    for(int i = 0; i < 3; i++) {

        amg.readPixels(pixels);
        for(int j = 1; j <= AMG88xx_PIXEL_ARRAY_SIZE; j++) {
            fahrenheit = (pixels[j-1] * 9.0) / 5.0 + 32;
            sum = sum + fahrenheit;
        }
    }
    average = (sum/192.0) + 1;
    Serial.println(average);
    return average;
}

// Function to See if Room is Occupied or not Based on Calibration and Calculation of 
// how many "Pixels" are above the Calbrated Threshold
bool isRoomOccup(int x) {
    if(roomBaseline == 0.0) {
        roomBaseline = calibrate();
    } else if(!roomOccup && millis()-lastCal >= SAMPLING) {
        lastCal = millis();
        roomBaseline = calibrate();
    }
    amg.readPixels(pixels);
    // Serial.print("[");
    for(int i=1; i<=AMG88xx_PIXEL_ARRAY_SIZE; i++){
      fahrenheit = (pixels[i-1] * 9.0) / 5.0 + 32;
      Serial.print(fahrenheit);
      Serial.print(", ");
      if( i%8 == 0 ) Serial.println();
      if (fahrenheit > roomBaseline + 4) count++;
    }
    // Serial.println("]");
    if(count >= x) {
        Serial.println(roomBaseline);
        Serial.println("The room is occupied");
        roomOccup = true;
    } else if(count >= (x - 1)){
        mqtt.publish(topicStatus, "Not really sure you know man it is more like a vibe, ill try again");
        delay(5000);
        roomOccup = isRoomOccup(x - 2);
    } else {
        Serial.println(roomBaseline);
        Serial.println("The room is NOT occupied");
        roomOccup = false;
    }
    count = 0;
    return roomOccup;
}

// Function necessary for Interrupt 
// If it is any longer, or tries to do any sort of printing anywhere, the boards CPU cores will dump because of a watchdog timer
void magnet_detect() {
  interrupt = true;
}

// Setup Function for Arduino Style coding
void setup() {
  Serial.begin(9600);
  Serial.println("Booting");
  Serial.println(F("Connecting to Wifi"));
  // Connects to WiFi
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  while (WiFi.waitForConnectResult() != WL_CONNECTED) {
    Serial.println("Connection Failed! Rebooting...");
    delay(5000);
    ESP.restart();
  }


  // Outputs IP Address
  Serial.println("Ready");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  // Set up the MQTT server connection
  if (mqtt_server!="") {
    mqtt.setServer(mqtt_server, 1883);
    mqtt.setBufferSize(512);
    mqtt.setCallback(callback);
  }

  // Checks to see if Thermal camera is plugged in correctly
  if (!amg.begin()) {
    Serial.println("Could not find a valid AMG88xx sensor, check wiring!");
    while (1) { delay(1); }
  }
  vSTATUSINTERVAL = STATUSINTERVAL;
  vAMGSAMPLING = AMGSAMPLING;
  roomBaseline = 0.0;
  roomOccup = isRoomOccup(5);
  occup = false;
}

void loop() {
  ArduinoOTA.handle();
  // Handle MQTT connection/reconnection
  if (mqtt_server!="") {
    if (!mqtt.connected()) {
      Serial.println("MQTT Reconnecting");
      reconnect();
    }
    mqtt.loop();
  }
  // if about magnet sensor
  attachInterrupt(digitalPinToInterrupt(halPin), magnet_detect, FALLING);
  // Interrupt variable from before
  if (interrupt) {
    Serial.println("Interrupt hit");
    int counter = 0;
    delay(3000);
    // For loop to test if the room is occupied
    // Keeps repeating while someone is in the room
    // If no one is increase the counter (i)
    // This keeps false triggerings down in case of incorrect occupation status
    for(int i = 0; i <= 5; i++) {
      bool occupied = isRoomOccup(5);
      if(occupied) {
        counter++;
      }
    }
    Serial.println(counter);
    if(counter > 3) {
      Serial.println(roomOccup);
      if (occup == false) {
        occup = true;
        mqtt.publish(topicStatus, "true");
      } 
    } else {
      if(occup == true) {
        occup = false;
        mqtt.publish(topicStatus, "false");
      }
    }
    interrupt = false;
  }
}