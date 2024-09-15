#include <WiFi.h>
#include <ESPAsyncWebServer.h>

#define FAN_PIN 3
#define WATER_PIN 6
#define CONDITION_PIN 7
#define TENT_PIN 10
#define LIGHT_PIN 11
const char *ssid = "Zaatari net 71503123(hijazi)"; // Change this
const char *password = "20003000"; 
AsyncWebServer server(80);




void setup() {
   pinMode(FAN_PIN, OUTPUT);
   pinMode(WATER_PIN, OUTPUT);
   pinMode(CONDITION_PIN, OUTPUT);
   pinMode(TENT_PIN, OUTPUT);
   pinMode(LIGHT_PIN, OUTPUT);
   digitalWrite(FAN_PIN,LOW);
   digitalWrite(WATER_PIN,LOW);
   digitalWrite(CONDITION_PIN,LOW);
   digitalWrite(TENT_PIN,LOW);
  digitalWrite(LIGHT_PIN, LOW);
    Serial.begin(9600);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }
    Serial.print("ESP32 Web Server's IP address: ");
    Serial.println(WiFi.localIP());

    
    server.on("/fan", HTTP_GET, [](AsyncWebServerRequest * request) {
     pinHandler(FAN_PIN);
        
    });
    server.on("/water", HTTP_GET, [](AsyncWebServerRequest * request) {
     pinHandler(WATER_PIN);
        
    });
    server.on("/condition", HTTP_GET, [](AsyncWebServerRequest * request) {
     pinHandler(CONDITION_PIN);
        
    });
    server.on("/tent", HTTP_GET, [](AsyncWebServerRequest * request) {
     pinHandler(TENT_PIN);
        
    });
    server.on("/light", HTTP_GET, [](AsyncWebServerRequest * request) {
     pinHandler(LIGHT_PIN);
        
    });

    server.begin();

}

void loop() {
  // put your main code here, to run repeatedly:

}
void pinHandler(int PIN){

  if(digitalRead(PIN)==HIGH){
      digitalWrite(PIN, LOW);
      }
      else{
        digitalWrite(PIN, HIGH);
      
      }
}
