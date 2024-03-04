#include <WiFi.h>

const char* ssid = "IT313-Study";
const char* password = "checkout2";
#define LED 2
void setup(){
    pinMode(LED, OUTPUT);
    digitalWrite(LED, HIGH);
    Serial.begin(9600);

    while(Serial.available());

    WiFi.mode(WIFI_STA); //Optional
    WiFi.begin(ssid, password);
    Serial.println("\nConnecting");

    while(WiFi.status() != WL_CONNECTED){
        Serial.print(".");
        delay(100);
        digitalWrite(LED, HIGH);
    }

    Serial.println("\nConnected to the WiFi network");
    Serial.print("Local ESP32 IP: ");
    Serial.println(WiFi.localIP());
    digitalWrite(LED, HIGH);

}

void loop(){
    digitalWrite(LED, HIGH);
}