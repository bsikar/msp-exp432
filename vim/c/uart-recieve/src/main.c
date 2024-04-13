#include <stdio.h>
#include <ti/devices/msp432p4xx/inc/msp432.h>

void configure_uart(void) {
  // Set P3.2 for UART RX
  P3->SEL0 |= BIT2;
  P3->SEL1 &= ~BIT2;

  // Configure UART
  EUSCI_A2->CTLW0 |= EUSCI_A_CTLW0_SWRST; // Put eUSCI in reset
  EUSCI_A2->CTLW0 =
      EUSCI_A_CTLW0_SWRST | EUSCI_A_CTLW0_SSEL__SMCLK; // Use SMCLK

  // Baud Rate calculation: Assuming SMCLK = 3MHz, Baud rate = 9600
  EUSCI_A2->BRW   = 312;
  EUSCI_A2->MCTLW = (8 << EUSCI_A_MCTLW_BRF_OFS) | EUSCI_A_MCTLW_OS16 | 0x2000;

  EUSCI_A2->CTLW0 &= ~EUSCI_A_CTLW0_SWRST; // Initialize eUSCI
}

void configure_led(void) {
  // Set P1.0 (Red LED) for output to indicate UART communication
  P2->DIR |= BIT0 | BIT1 | BIT2;
  P2->OUT &= ~(BIT0 | BIT1 | BIT2);
}

int main(void) {
  char rxC_char;

  WDT_A->CTL = 0x5A00 | 0x0080; // Stop watchdog timer
  configure_uart();
  configure_led();

  while (1) {
    if (EUSCI_A2->IFG & EUSCI_A_IFG_RXIFG) {
      rxC_char = EUSCI_A2->RXBUF; // Read the received character

      if (rxC_char == 'R') {
        P2->OUT = BIT0;
      } else if (rxC_char == 'G') {
        P2->OUT = BIT1;
      } else if (rxC_char == 'B') {
        P2->OUT = BIT2;
      } else {
        P2->OUT &= ~(0x07); // Turn off LED otherwise
      }
    }
  }
}
