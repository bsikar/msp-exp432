## Project Overview

NLP will be used on a RaspberryPi, then over UART 0, 1, 2 will be sent to the msp432p401r. 
This data will then turn on the LEDs, turn on/off a motor and turn on/off a buzzer if a sensor is active.
The LED will be set to a random value by using a noisy unconnected pin and reading ADC

## (Port.Pin)'s

PM_ == Peripheral Mode / Port Mapping
UCAx == eUSCI_Ax
UCBx == eUSCI_Bx

### Serial IO and Board-to-Board Communiation (UART)
- **P1.2**: UART RX (eUSCI_A0 / UCA0RXD) (internal) [used in uart_helper.c]
- **P1.3**: UART TX (eUSCI_A0 / UCA0TXD) (internal) [used in uart_helper.c]
- **P3.2**: UART RX (eUSCI_A2 / PM_UCA2RXD) [used in process_configure_uart.s]
- **P3.3**: UART TX (eUSCI_A2 / PM_UCA2TXD) [not used in this project]

### On board LEDs
- **P1.0**: RED LED (LED1) (internal)
- **P2.0**: RED LED (LED2) (internal) [used in configure_led.s]
- **P2.1**: GREEN LED (LED2) (internal) [used in configure_led.s]
- **P2.2**: BLUE LED (LED2) (internal) [used in configure_led.s]

### ADC (ADC14, 14 bit resolution)
- **P5.3**: ADC (ADC14MCTL2 / A2) (not connected to anything)

### Additional Peripherals
- **P5.4**: GPIO (IR Sensor)
- **P5.5**: GPIO (PIEZO Buzzer)
- **P4.7**: GPIO (Nano Wait Signal)

### 7-Segment-Display (SSD) Mapping
- **P4.0**: GPIO (SSD) 0
- **P4.1**: GPIO (SSD) 1
- **P4.2**: GPIO (SSD) 2
- **P4.3**: GPIO (SSD) 3
- **P4.4**: GPIO (SSD) 4
- **P4.5**: GPIO (SSD) 5
- **P4.6**: GPIO (SSD) 6

## UART (Universal Asynchronous Receiver/Transmitter)

### CTLW0 (Control Word Register 0)
- **Bit 15 - UCSWRST (Software Reset)**
  - `1` - UART held in reset state, useful during configuration.
  - `0` - UART operational, reset released.
- **Bits 14-10 - Reserved**
- **Bits 9-8 - UCSSELx (Clock Source Select)**
  - `00` - UCLKI (external clock).
  - `01` - ACLK (auxiliary clock).
  - `10` - SMCLK (sub-main clock).
  - `11` - SMCLK.
- **Bit 7 - UCTXBRK (Transmit Break)**
  - `1` - Send a break (low state) after transmitting the next character.
  - `0` - No break transmitted.
- **Bit 6 - UCTXADDR (Transmit Address)**
  - `1` - Next character transmitted is an address.
  - `0` - Normal data transmission.
- **Bit 5 - UCDORM (Dormant)**
  - `1` - Receiver ignores incoming data not addressing it.
  - `0` - Normal operation.
- **Bit 4 - UCBRKIE (Receive Break Character Interrupt Enable)**
  - `1` - Interrupt on received break character.
  - `0` - No interrupt for break character.
- **Bit 3 - UCRXEIE (Receive Erroneous-Character Interrupt Enable)**
  - `1` - Interrupt on erroneous character received.
  - `0` - No interrupt on erroneous characters.
- **Bits 2-1 - UC7BIT (Character Length)**
  - `00` - 8-bit data.
  - `01` - 7-bit data.
- **Bit 0 - UCPEN (Parity Enable)**
  - `1` - Parity enabled.
  - `0` - No parity.

### IFG (Interrupt Flag Register)
- **Bit 15-8 - Reserved**
- **Bit 7 - UCTXIFG (Transmit Buffer Empty Interrupt Flag)**
  - `1` - Transmit buffer is empty, ready for new data.
  - `0` - Transmit buffer not empty.
- **Bit 6 - UCRXIFG (Receive Buffer Full Interrupt Flag)**
  - `1` - Receive buffer is full, contains unread data.
  - `0` - Receive buffer not full.
- **Bits 5-0 - Reserved/Other Specific Flags**

### Additional Registers (Brief Overview)
- **BRW (Baud Rate Word)**
  - Sets the baud rate divisor based on the input clock.
- **MCTLW (Modulation Control Word)**
  - Fine-tunes the baud rate via modulation settings; includes bits for oversampling.
- **TXBUF (Transmit Buffer)**
  - Buffer for data to be transmitted.
- **RXBUF (Receive Buffer)**
  - Buffer holding received data.
- **IE (Interrupt Enable Register)**
  - Enables interrupts for specific UART events.
- **IV (Interrupt Vector Register)**
  - Indicates the vector of the highest priority interrupt.
- **ABCTL (Auto Baud Rate Control)**
  - Automatic baud rate detection feature.
- **IRCTL (Infrared Control Register)**
  - Configures UART for infrared communication.

## SPI (Serial Peripheral Interface)

### SPI Control Register (SPCR)
- **Bit 7 - SPIE (SPI Interrupt Enable)**
  - `1` - Enables the SPI interrupt when a serial transfer is complete.
  - `0` - Disables the SPI interrupt.
- **Bit 6 - SPE (SPI Enable)**
  - `1` - Enables the SPI bus; must be set to enable any SPI operations.
  - `0` - Disables the SPI bus.
- **Bit 5 - DORD (Data Order)**
  - `1` - LSB (Least Significant Bit) first.
  - `0` - MSB (Most Significant Bit) first.
- **Bit 4 - MSTR (Master/Slave Select)**
  - `1` - Sets the SPI bus configuration to Master.
  - `0` - Sets the SPI bus configuration to Slave.
- **Bit 3 - CPOL (Clock Polarity)**
  - `1` - The clock is high when idle.
  - `0` - The clock is low when idle.
- **Bit 2 - CPHA (Clock Phase)**
  - `1` - Data is sampled on the trailing edge of the clock.
  - `0` - Data is sampled on the leading edge of the clock.
- **Bits 1-0 - SPR1, SPR0 (SPI Clock Rate Select)**
  - `00` - f_osc/4 (where f_osc is the oscillator frequency).
  - `01` - f_osc/16.
  - `10` - f_osc/64.
  - `11` - f_osc/128.

### SPI Status Register (SPSR)
- **Bit 7 - SPIF (SPI Interrupt Flag)**
  - This bit is set by hardware when a serial transfer is complete. Used to handle interrupts.
- **Bit 6 - WCOL (Write Collision Flag)**
  - `1` - Indicates a write collision has occurred.
  - `0` - No collision.
- **Bit 0 - SPI2X (Double SPI Speed Bit)**
  - `1` - SPI speed is doubled.
  - `0` - Normal SPI speed.

### SPI Data Register (SPDR)
- **Functionality**
  - This register is used for data transmission and reception. Writing to this register starts data transmission. Reading from this register reads the data received.

### Additional SPI Features
- **SS Pin (Slave Select)**
  - In master mode, this pin must be managed (usually driven low) to select a slave device before starting communication.
- **MISO (Master In Slave Out)**
  - This is the data line for sending data from slave to master.
- **MOSI (Master Out Slave In)**
  - This is the data line for sending data from master to slave.
- **SCK (Serial Clock)**
  - Clock line controlled by the master, used to synchronize data transmission.

## IIC / I2C (Inter-Integrated Circuit)

### Control Register (I2C_CR)
- **Bit 7 - IEN (I2C Enable)**
  - `1` - Enables the I2C module.
  - `0` - Disables the I2C module.
- **Bit 6 - IRPT (Interrupt Enable)**
  - `1` - Enables the generation of interrupts.
  - `0` - Disables interrupts.
- **Bit 5 - ACK (Acknowledge Control)**
  - `1` - Sends acknowledge when the acknowledge bit is required.
  - `0` - Does not send an acknowledge.
- **Bit 4 - START (Start Condition)**
  - `1` - Generates a start condition.
  - `0` - Does not generate.
- **Bit 3 - STOP (Stop Condition)**
  - `1` - Generates a stop condition.
  - `0` - Does not generate.
- **Bit 2 - INT_FLAG (Interrupt Flag)**
  - This bit is set by hardware when an interrupt condition occurs. Must be cleared by software.
- **Bits 1-0 - MODE (Operating Mode)**
  - `00` - Standard mode (100 kHz)
  - `01` - Fast mode (400 kHz)
  - `10` - Fast mode plus (1 MHz)
  - `11` - High-speed mode (3.4 MHz)

### Status Register (I2C_SR)
- **Bit 7 - BUSY (Bus Busy)**
  - `1` - Indicates that the bus is busy.
  - `0` - Indicates that the bus is free.
- **Bit 6 - ARLO (Arbitration Lost)**
  - `1` - The device lost arbitration and control of the bus.
  - `0` - The device has control or arbitration not applicable.
- **Bit 5 - ACK_RECEIVED (Acknowledge Received)**
  - `1` - Acknowledge was received after sending a byte.
  - `0` - No acknowledge received.
- **Bit 4 - OVR (Overrun/Underrun)**
  - `1` - Data was lost because of an overrun or underrun.
  - `0` - No data was lost.
- **Bit 3 - PEC_ERR (PEC Error in Reception)**
  - `1` - Packet Error Checking code does not match.
  - `0` - No error detected.
- **Bit 2 - TIMEOUT (Timeout Error)**
  - `1` - Timeout error occurred.
  - `0` - No timeout error.
- **Bit 1-0 - Reserved**

### Data Register (I2C_DR)
- **Functionality**
  - This register holds the data to be transmitted or received. Data written to this register is queued for transmission; reading from this register gives the last received data.

### Address Register (I2C_AR)
- **Functionality**
  - Sets the device address in master mode or the response address in slave mode. Can usually be configured to use 7-bit or 10-bit addressing.

### Additional I2C Features
- **SCL (Serial Clock Line)**
  - The line over which the clock signal is transmitted. Controlled by the master.
- **SDA (Serial Data Line)**
  - The line over which data is transmitted. It’s bidirectional and used for both sending and receiving data.
- **Master/Slave Mode**
  - Devices on an I2C bus can act as either a master or a slave. The master controls the clock and initiates communication.

## ADC (Analog-to-Digital Converter)

### CTL0 (Control Register 0)
- **Bit 15-14 - ADC14PDIV (Pre-divider)**
  - `00` - Pre-divider of 1.
  - `01` - Pre-divider of 4.
  - `10` - Pre-divider of 32.
  - `11` - Pre-divider of 64.
- **Bits 13-12 - ADC14SHSx (Sample/Hold Source)**
  - `00` - ADC14SC bit (software trigger).
  - `01` - Timer trigger.
  - `10` - Other external triggers.
- **Bits 11-10 - ADC14SHP (Sample/Hold Pulse Mode)**
  - `0` - Sample-and-hold source determined by ADC14SHSx bits.
  - `1` - Sample-and-hold signal sourced from the sampling timer.
- **Bits 9-8 - ADC14DIVx (Clock Divider)**
  - `00` - Divider of 1.
  - `01` - Divider of 2.
  - `10` - Divider of 4.
  - `11` - Divider of 8.
- **Bits 7-5 - Reserved**
- **Bit 4 - ADC14SSELx (Clock Source Select)**
  - `0` - MODOSC (modulator oscillator).
  - `1` - SMCLK (sub-main clock).
- **Bit 3 - ADC14CONSEQx (Conversion Sequence Mode)**
  - `00` - Single-channel, single-conversion.
  - `01` - Sequence-of-channels.
  - `10` - Repeat-single-channel.
  - `11` - Repeat-sequence-of-channels.
- **Bit 2 - ADC14BUSY (ADC Busy)**
  - `1` - ADC is active.
  - `0` - ADC is inactive.
- **Bit 1 - Reserved**
- **Bit 0 - ADC14ON (ADC On/Off)**
  - `1` - ADC is on.
  - `0` - ADC is off.

### MCTL (Memory Control Register)
- **Bit 15-12 - ADC14WINCTH (Window Comparator High Threshold)**
- **Bit 11-8 - ADC14WINCCTL (Window Comparator Low Threshold)**
- **Bit 7 - ADC14DIF (Differential Mode)**
  - `1` - Differential mode enabled.
  - `0` - Single-ended mode.
- **Bits 6-5 - Reserved**
- **Bits 4-0 - ADC14INCHx (Input Channel Select)**
  - `00000` - A0.
  - `00001` - A1.
  - Various other codes for additional analog channels.

### Conversion Process
- **Start Conversion:** Triggered by software or a dedicated hardware signal.
- **Sampling:** The ADC samples the analog signal based on the selected input channel.
- **Conversion:** The sampled value is converted into a digital number, reflecting the signal's intensity.

### Additional Features
- **Interrupts:** The ADC can be configured to generate interrupts at the end of a conversion, when a certain threshold is reached, or if an error occurs.
- **Low-Power Modes:** Designed for efficient operation, the ADC can be shut down or operate in a reduced power mode when not actively converting, saving energy in battery-powered applications.

## RFID-RC522 
1. **VCC**: This is the power supply pin. It's connected to a positive voltage source. For the RFID-RC522, this is usually a 3.3V power supply.

2. **RST**: This stands for Reset. It is used to reset the RFID module. Applying a low signal to this pin resets the internal states of the module.

3. **GND**: This is the Ground pin. It is connected to the ground of the power supply and is used as a reference point for all signals.

4. **MISO**: This stands for Master In Slave Out. It is used in SPI (Serial Peripheral Interface) communication. This pin is used by the RFID module to send data back to the microcontroller.

5. **MOSI**: This stands for Master Out Slave In. It is also used in SPI communication. This pin is used by the microcontroller to send data to the RFID module.

6. **SCK**: This stands for Serial Clock. It is another pin used in SPI communication. This clock signal is provided by the microcontroller to synchronize data transmission between the microcontroller and the RFID module.

7. **NSS**: This stands for Negative Slave Select (also known as Chip Select or CS). It is used in SPI communication to activate the RFID module. It is typically active low, meaning the RFID module is selected for communication when this pin is pulled to a low logic level.

8. **IRQ**: This stands for Interrupt Request. This pin is used by the RFID module to alert the microcontroller of certain events (like the presence of an RFID tag in its vicinity). It is an optional connection, not always used in every project.
