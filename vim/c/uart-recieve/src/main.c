#include <stdint.h>
#include <ti/devices/msp432p4xx/inc/msp432.h>

#define ENABLE      0x0000
#define RED_LED     BIT0 // P2.0 is the Red LED
#define DEVELOPMENT (WDT_A_CTL_PW | WDT_A_CTL_HOLD)
#define DELAY       0x30D40

void UART2_init(void);
char UART2_getchar(void);
void blink_LED(void);

int main(void) {
  char received_char;

  WDT_A->CTL  = DEVELOPMENT; // Stop watchdog timer
  P2->SEL0    = ENABLE;      // Configure P2.0 as I/O
  P2->SEL1    = ENABLE;      // Configure P2.0 as I/O
  P2->DIR    |= RED_LED;     // Set P2.0 as output

  // Initialize UART2
  UART2_init();

  while (1) {
    received_char = UART2_getchar(); // Receive character from UART

    if (received_char == '1') {
      blink_LED(); // Blink LED if '1' is received
    } else if (received_char == '0') {
      P2->OUT &= ~RED_LED; // Ensure LED is off if '0' is received
    }
  }
}

void blink_LED(void) {
  volatile uint_fast16_t x;
  P2->OUT |= RED_LED;            // Turn red LED on
  for (x = 0; x < DELAY; x++) {} // Delay
  P2->OUT &= ~RED_LED;           // Turn red LED off
  for (x = 0; x < DELAY; x++) {} // Delay
}

void UART2_init(void) {
  EUSCI_A2->CTLW0 |= EUSCI_A_CTLW0_SWRST;      // Put eUSCI in reset
  EUSCI_A2->CTLW0  = EUSCI_A_CTLW0_SWRST |     // Remain eUSCI in reset
                    EUSCI_B_CTLW0_SSEL__SMCLK; // Use SMCLK

  // Baud Rate calculation
  // 3000000/(16*9600) = 19.53125
  EUSCI_A2->BRW   = 19; // 3000000/16/9600
  EUSCI_A2->MCTLW = (9 << EUSCI_A_MCTLW_BRS_OFS) | EUSCI_A_MCTLW_OS16;

  P3->SEL0 |= BIT2; // Set P3.2 for UART A2 RXD
  P3->SEL1 &= ~(BIT2);

  EUSCI_A2->CTLW0 &= ~EUSCI_A_CTLW0_SWRST; // Initialize eUSCI
}

// Function to receive a character over UART2
char UART2_getchar(void) {
  while (!(EUSCI_A2->IFG & EUSCI_A_IFG_RXIFG))
    ;                     // Wait for char
  return EUSCI_A2->RXBUF; // Read char
}
