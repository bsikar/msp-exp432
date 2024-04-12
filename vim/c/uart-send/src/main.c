#include <ti/devices/msp432p4xx/inc/msp432.h>

void UART_init(void);
void UART_send_byte(uint8_t data);

int main(void) {
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD; // Stop watchdog timer

  // Initialize UART
  UART_init();

  // Variable to send over UART
  uint8_t count = 0;

  while (1) {
    // Send the current value of count
    UART_send_byte(count);

    // Increment count and reset if it exceeds 30
    count = (count + 1) % 31;

    // Delay for 500 ms
    __delay_cycles(1500000); // Assuming a 3MHz clock, adjust if different
  }
}

void UART_init(void) {
  // Configure UART pins
  P3->SEL0 |= (1 << 2) | (1 << 3); // P3.2 UCA2RXD, P3.3 UCA2TXD
  P3->SEL1 &= ~(1 << 2) | (1 << 3);

  // Configure UART
  EUSCI_A2->CTLW0 |= EUSCI_A_CTLW0_SWRST;      // Put eUSCI in reset
  EUSCI_A2->CTLW0  = EUSCI_A_CTLW0_SWRST |     // Remain eUSCI in reset
                    EUSCI_A_CTLW0_SSEL__SMCLK; // SMCLK
  EUSCI_A2->BRW   = 1;                         // 3MHz / 115200 = ~26 (UCAxBR0)
  EUSCI_A2->MCTLW = (10 << EUSCI_A_MCTLW_BRF_OFS) | // First mod reg
                    EUSCI_A_MCTLW_OS16;             // Oversampling mode
  EUSCI_A2->CTLW0 &= ~EUSCI_A_CTLW0_SWRST;          // Initialize eUSCI

  // Enable global interrupts (optional if using interrupts)
  __enable_irq();
}

void UART_send_byte(uint8_t data) {
  // Wait for the transmitter to be ready
  while (!(EUSCI_A2->IFG & EUSCI_A_IFG_TXIFG))
    ;

  // Load data onto the buffer
  EUSCI_A2->TXBUF = data;
}
