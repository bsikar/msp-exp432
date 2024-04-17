#include "uart_helper.h"
#include <stdio.h>
#include <ti/devices/msp432p4xx/inc/msp432.h>

void configureUART(void) {
  // Set P3.3 for UART TX
  P3->SEL0 |= BIT3;
  P3->SEL1 &= ~BIT3;

  // Configure UART
  EUSCI_A2->CTLW0 |= EUSCI_A_CTLW0_SWRST; // Put eUSCI in reset
  EUSCI_A2->CTLW0  = EUSCI_A_CTLW0_SWRST |
                    EUSCI_A_CTLW0_SSEL__SMCLK; // Use SMCLK as clock source

  // Baud Rate calculation: Assuming SMCLK = 3MHz, Baud rate = 9600
  EUSCI_A2->BRW    = 312;
  EUSCI_A2->MCTLW  = (8 << EUSCI_A_MCTLW_BRF_OFS) | EUSCI_A_MCTLW_OS16 | 0x2000;
  EUSCI_A2->CTLW0 &= ~EUSCI_A_CTLW0_SWRST; // Initialize eUSCI
}

void sendUART(char *msg) {
  int i = 0;
  while (msg[i] != '\0') {
    while (!(EUSCI_A2->IFG & EUSCI_A_IFG_TXIFG)) {}
    EUSCI_A2->TXBUF = msg[i++];
  }
}

int main(void) {
  WDT_A->CTL = 0x5A00 | 0x0080; // Stop watchdog timer
  configureUART();
  uart_init();

  while (1) {
    sendUART("0");
    uart_send_str("'0'\r\n");
    for (volatile int i = 1000000; i > 0; i--) {}
    sendUART("1");
    uart_send_str("'1'\r\n");
    for (volatile int i = 1000000; i > 0; i--) {}
    sendUART("2");
    uart_send_str("'2'\r\n");
    for (volatile int i = 1000000; i > 0; i--) {}
    sendUART(" ");
    uart_send_str("' '\r\n");
    for (volatile int i = 1000000; i > 0; i--) {}
  }
}
