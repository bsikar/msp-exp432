import serial
import time

# Initialize the serial connection
ser = serial.Serial('COM6', 635)  # Adjust as necessary

try:
    while True:
        # Send the character '0' to the serial port
        ser.write(b'0')  # Ensure the data is in bytes
        time.sleep(1)  # Delay for 1 second
except KeyboardInterrupt:
    print("Program terminated by user")
finally:
    ser.close()  # Ensure the serial connection is closed
