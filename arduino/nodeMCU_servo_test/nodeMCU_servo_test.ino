// Written by Jon Zimmerman

#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266HTTPClient.h>
//fake passwords
char ssid[] = "Super WiFi";
char pass[] = "Super Secure";
WiFiClient client;

const char dataServer[] = "http://0.tcp.ngrok.io";
int portNumber 15;
String text;
int jsonEnd = 0;
boolean startJson = false;
int status = WL_IDLE_STATUS;

#define JSON_BUFF_DIMENSION 2500

unsigned long lastConnectionTime = 10 * 1000;     // last time you connected to the server, in milliseconds
const unsigned long postInterval = 10 * 1000;  // posting interval of 10 minutes  (10L * 1000L; 10 seconds delay for testing)

void setup() {
  Serial.begin(9600);
  text.reserve(JSON_BUFF_DIMENSION);
  WiFi.begin(ssid, pass);
  Serial.println("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi Connected");
  printWiFiStatus();
}
void loop() {
  char node_char = Serial.read();
  if (node_char != -1) {
    //Serial.println(node_char);
    if (node_char == '$') {
      makehttpRequest2();
    }
  }
    if (millis() - lastConnectionTime > postInterval) {
      Serial.print("RR");
      // note the time that the connection was made:
      lastConnectionTime = millis();
      //Serial.print("request");
      makehttpRequest();
    }

  }
  void printWiFiStatus() {
    // print the SSID of the network you're attached to:
    Serial.print("SSID: ");
    Serial.println(WiFi.SSID());
    // print your WiFi shield's IP address:
    IPAddress ip = WiFi.localIP();
    Serial.print("IP Address: ");
    Serial.println(ip);
    // print the received signal strength:
    long rssi = WiFi.RSSI();
    Serial.print("signal strength (RSSI):");
    Serial.print(rssi);
    Serial.println(" dBm");
  }
  // to request data from OWM
  void makehttpRequest() {
    // close any connection before send a new request to allow client make connection to server
    client.stop();
    // if there's a successful connection:
    if (client.connect(dataServer, portNumber)) {
      Serial.println("REQUEST...");
      client.println("GET /pill/counts HTTP/1.1");
      client.println("Host: http://0.tcp.ngrok.io");
      client.println("User-Agent: ArduinoWiFi/1.1");
      delay(1);
      client.println("Connection: close");
      client.println();
      unsigned long timeout = millis();
      while (client.available() == 0) {
        if (millis() - timeout > 6000) {
          Serial.println(">>> Client Timeout !");
          client.stop();
          return;
        }
      }
      char c = 0;
      while (client.available()) {
        c = client.read();
        delay(10);
        // since json contains equal number of open and close curly brackets,
        //this means we can determine when a json is completely received  by counting
        // the open and close occurences
        //Serial.print(c);
        if (c == '[') {
          startJson = true;         // set startJson true to indicate json message has started
          jsonEnd++;
        }
        if (c == ']') {
          jsonEnd--;
        }
        if (startJson == true) {
          text += c;
        }
        // if jsonend = 0 then we have have received equal number of curly braces
        if (jsonEnd == 0 && startJson == true) {
          Serial.print(text.c_str());
          Serial.print("\n");
          parseJson(text.c_str());  // parse c string text in parseJson function

          text = "";                // clear text string for the next time
          startJson = false;        // set startJson to false to indicate that a new message has not yet started
        }
      }
    }
    else {
      // if no connction was made:
      Serial.println("connection failed");
      return;
    }
  }
  void makehttpRequest2() {
    // close any connection before send a new request to allow client make connection to server
    client.stop();
    // if there's a successful connection:
    if (client.connect(dataServer, portNumber)) {
      Serial.println("REQUEST...");
      // send the HTTP PUT request:
      client.println("GET /pill/taken/1 HTTP/1.1");
      client.println("Host: http://0.tcp.ngrok.io");
      client.println("User-Agent: ArduinoWiFi/1.1");
      delay(1);
      client.println("Connection: close");
      client.println();

      unsigned long timeout = millis();
      while (client.available() == 0) {
        if (millis() - timeout > 6000) {
          Serial.println(">>> Client Timeout !");
          client.stop();
          return;
        }
      }
      char c = 0;
      while (client.available()) {
        c = client.read();
        delay(10);
        // since json contains equal number of open and close curly brackets,
        // this means we can determine when a json is completely received  by counting
        // the open and close occurences,
        //Serial.print(c);
        if (c == '[') {
          startJson = true;         // set startJson true to indicate json message has started
          jsonEnd++;
        }
        if (c == ']') {
          jsonEnd--;
        }
        if (startJson == true) {
          text += c;
        }
        // if jsonend = 0 then we have have received equal number of curly braces
        if (jsonEnd == 0 && startJson == true) {
          Serial.print(text.c_str());
          Serial.print("\n");
          parseJson(text.c_str());  // parse c string text in parseJson function
          text = "";                // clear text string for the next time
          startJson = false;        // set startJson to false to indicate that a new message has not yet started
        }
      }
    }
    else {
      // if no connction was made:
      Serial.println("connection failed");
      return;
    }
  }
  //to parse json data recieved from OWM
  void parseJson(const char * jsonString) {
    const size_t bufferSize = 2 * JSON_ARRAY_SIZE(1) + JSON_ARRAY_SIZE(2) + 4 * JSON_OBJECT_SIZE(1) + 3 * JSON_OBJECT_SIZE(2) + 3 * JSON_OBJECT_SIZE(4) + JSON_OBJECT_SIZE(5) + 2 * JSON_OBJECT_SIZE(7) + 2 * JSON_OBJECT_SIZE(8) + 720;
    DynamicJsonBuffer jsonBuffer(bufferSize);

    // FIND FIELDS IN JSON TREE
    JsonArray& root = jsonBuffer.parseArray(jsonString);
    if (!root.success()) {
      Serial.println("parseObject() failed");
      return;
    }
  }
