#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <Adafruit_Sensor.h>
#include <ESPmDNS.h>
#include <DHT.h>
#include <ArduinoJson.h>

#define FAN_PIN 3
#define WATER_PIN 21
#define TENT_PIN 19
#define LIGHT_PIN 18
#define CONDITION_PIN 5
#define DHTPIN 26
#define soil 12
#define light 13
#define DHTTYPE    DHT11  
const char *ssid = "Zaatari net 71503123(hijazi)"; // Change this
const char *password = "20003000"; 
DHT dht(DHTPIN, DHTTYPE);
AsyncWebServer server(80);


String readDHTTemperature() {
  
  float t = dht.readTemperature();
  
  if (isnan(t)) {    
    Serial.println("Failed to read from DHT sensor!");
    return "--";
  }
  else {
    Serial.println(t);
    return String(t);
  }
}

String readDHTHumidity() {

  float h = dht.readHumidity();
  if (isnan(h)) {
    Serial.println("Failed to read from DHT sensor!");
    return "--";
  }
  else {
    Serial.println(h);
    return String(h);
  }
}

void setup() {
  Serial.begin(115200);
  pinMode(DHTPIN, INPUT);
  pinMode(FAN_PIN, OUTPUT);
  digitalWrite(FAN_PIN,LOW);
  pinMode(WATER_PIN, OUTPUT);
  digitalWrite(WATER_PIN,LOW);
   pinMode(TENT_PIN, OUTPUT);
  digitalWrite(TENT_PIN,LOW);
pinMode(LIGHT_PIN, OUTPUT);
digitalWrite(LIGHT_PIN,LOW);
pinMode(CONDITION_PIN, OUTPUT);
digitalWrite(CONDITION_PIN,LOW);

  WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }

    if(!MDNS.begin("plot")){
    Serial.println("Error starting mDNS");
    return;
  }

     Serial.print("ESP32 Web Server's IP address: ");
    Serial.println(WiFi.localIP());
    server.on("/register",HTTP_GET,[](AsyncWebServerRequest *request){
    JsonDocument doc;
    doc["IP"]= WiFi.localIP().toString();
    String Serial;
    serializeJson(doc, Serial);
    AsyncWebServerResponse *response = request->beginResponse(200, "application/json", Serial); 
    response->addHeader("Access-Control-Allow-Origin", "*"); 
    request->send(response);
    
  });
    server.on("/fan", HTTP_GET, [](AsyncWebServerRequest * request) {
    
     pinHandler(FAN_PIN);
     request->send(200, "text/plain", "Fan toggled");
    });
     server.on("/water", HTTP_GET, [](AsyncWebServerRequest * request) {
    
     pinHandler(WATER_PIN);
     request->send(200, "text/plain", "Water toggled");
    });
     server.on("/tent", HTTP_GET, [](AsyncWebServerRequest * request) {
    
     pinHandler(TENT_PIN);
     request->send(200, "text/plain", "Tent toggled");
    });
     server.on("/light", HTTP_GET, [](AsyncWebServerRequest * request) {
    
     pinHandler(LIGHT_PIN);
     request->send(200, "text/plain", "light toggled");
    });
    server.on("/condition", HTTP_GET, [](AsyncWebServerRequest * request) {
    
     pinHandler(CONDITION_PIN);
     request->send(200, "text/plain", "condition toggled");
    });
      server.on("/temperature", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", readDHTTemperature().c_str());
  });
  server.on("/humidity", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", readDHTHumidity().c_str());
  });
    server.on("/soil", HTTP_GET, [](AsyncWebServerRequest * request) {
      JsonDocument _soil;
      _soil["soil"]= String(analogRead(soil));
    String Serial;
    serializeJson( _soil, Serial);
     AsyncWebServerResponse *response = request->beginResponse(200, "application/json",Serial); 
    response->addHeader("Access-Control-Allow-Origin", "*"); 
    request->send(response);
    });
     server.on("/lux", HTTP_GET, [](AsyncWebServerRequest * request) {
      JsonDocument _light;
      _light["light"]= String(analogRead(light));
    String Serial;
    serializeJson( _light, Serial);
     AsyncWebServerResponse *response = request->beginResponse(200, "application/json",Serial); 
    response->addHeader("Access-Control-Allow-Origin", "*"); 
    request->send(response);
    });
    
    server.begin();

}

void loop() {
  // put your main code here, to run repeatedly:

}
void pinHandler(int pin) {
   digitalWrite(pin, !digitalRead(pin));
   }