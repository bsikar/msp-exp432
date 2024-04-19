from torchHelper import AudioProcessor
from uartHelper import UARTHelper
from fuzzywuzzy import process
import time

# Dictionary for voice commands
command_dict = {
    "light": '0',
    "sensor toggle": '2',
    "buzzer toggle": '3'
}


def process_model_output(transcription):
    # Get the string from the list output
    rawString = transcription[0]
    # Convert to lower case
    rawString = rawString.lower()

    foundCommand = findCommand(rawString, 75)
    print(f"Processed Keyword: {foundCommand}")
        
    return foundCommand # return the command value

def findCommand(keyword, threshold=75):
    # Use fuzzy matching to find the closest command
    # `process.extractOne` returns the best match, its score, and its index
    best_match, score = process.extractOne(keyword, command_dict.keys())

    if score >= threshold:
        return command_dict[best_match]
    return '0' # Return None if no command closely matches
    
# Initialize Audio Processor and UART
audio_processor = AudioProcessor()
uart = UARTHelper(port='COM6', baud_rate=635)

def main():
    try:
        while True:
            # Get transcription from audio input
            transcription = audio_processor.get_transcription()

            if transcription:
                print(transcription)
                processedTranscription = process_model_output(transcription)
                
                # Enable to debug types
                # print(F"TRANSCRIPTION TYPE: {type(transcription)}\n AFTER: {type(processedTranscription)} \n")

                # Send transcription to the microcontroller
                # uart.send_data(str(processedTranscription))
                
                # # Verified what the MCU recieved
                # received_data = uart.receive_data()
                # if received_data:
                #     print(f"Received from MCU: {received_data}")
                #     print("------------------------------------")

                # Sending the command repeatedly for 2 seconds
                start_time = time.time()
                while time.time() - start_time < 2:
                    uart.send_data(str("9"))
                    time.sleep(0.1)  # Adjust this as needed for the rate of sending
                
        # time.sleep(2)        
    except KeyboardInterrupt:
        print("Exiting...")
    finally:
        audio_processor.close()
        uart.close()  # Close the UART connection

if __name__ == '__main__':
    main()
