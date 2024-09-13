#include <WiFi.h>
#include <ESPAsyncWebServer.h>

#define LED_PIN 2
const char *ssid = "Zaatari net 71503123(hijazi)"; // Change this
const char *password = "20003000"; 
AsyncWebServer server(80);
int LED_state = LOW;



void setup() {
   pinMode(LED_PIN, OUTPUT);
    digitalWrite(LED_PIN, LED_state);
    Serial.begin(9600);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }
    Serial.print("ESP32 Web Server's IP address: ");
    Serial.println(WiFi.localIP());

    server.on("/", HTTP_GET, [](AsyncWebServerRequest * request) {
        request->send(200, "text/html", getHTML());
    });

    
    server.on("/fan", HTTP_GET, [](AsyncWebServerRequest * request) {
      if(LED_state==HIGH){
      digitalWrite(LED_PIN, LOW);
        LED_state = LOW;}
      else{
        digitalWrite(LED_PIN, HIGH);
        LED_state = HIGH;
      }
        
    });

    server.begin();

}

void loop() {
  // put your main code here, to run repeatedly:

}
