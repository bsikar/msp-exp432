#include <SoftwareSerial.h>

// Define the pin connected to the external device (replace with your actual pin)
const int outputPin = 31;
const int controlPin = 32;

void setup() {
  // Set the output pin as OUTPUT
  pinMode(outputPin, OUTPUT); 

  // Begin serial communication at 9600 baud rate
  Serial.begin(635);  // Adjusted to a more standard baud rate of 9600
}

void loop() {
  // Continuously send the character '0' through the serial port

  Serial.write('0');
  digitalWrite(controlPin, HIGH);
  delay(5000); // Delay for 5 second
  digitalWrite(controlPin, LOW);

  Serial.write('1');
  digitalWrite(controlPin, HIGH);
  delay(5000); // Delay for 5 second
  digitalWrite(controlPin, LOW);
}
