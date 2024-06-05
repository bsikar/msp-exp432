#include <SoftwareSerial.h>

// Define the pin connected to the external device (replace with your actual pin)
const int outputPin = 31;

void setup() {
  // Set the output pin as OUTPUT
  pinMode(outputPin, OUTPUT); 

  // Begin serial communication at 9600 baud rate
  Serial.begin(635);
}

void loop() {
  // Send the character '0' through the serial port
  // Serial.write('0');
  if (Serial.available() > 0) {
    int incomingByte = Serial.read();  // Read the incoming byte
    Serial.write(incomingByte);  // Relay the byte back out through the serial port
  }

  // Add a delay (adjust as needed)
  delay(1000); // Delay for 1 second
}
