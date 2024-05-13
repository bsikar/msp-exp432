// Define the pin connected to the external device (replace with your actual pin)
const int outputPin = 31;

void setup() {
  // Set the output pin as OUTPUT
  pinMode(outputPin, OUTPUT); 

  // Begin serial communication at 9600 baud rate
  Serial.begin(9600);
}

void loop() {
  // Send the character '0' through the serial port
  Serial.write('0');
  // Serial.println("0");
  // Serial.println("'0' sent"); // Optional: print a message for confirmation

  // Add a delay (adjust as needed)
  delay(1000); // Delay for 1 second
}
