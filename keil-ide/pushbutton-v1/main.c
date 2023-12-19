
// This program will turn on a red LED when a button is pressed

#include "msp.h"
#include <stdint.h>

#define RED         0x0001
#define ENABLE      0x0000
#define RED_OFF     0x00FE
#define DEVELOPMENT (WDT_A_CTL_PW | WDT_A_CTL_HOLD)
#define DELAY       0x30D40
#define BUTTON1     0x0002

int main(void) {
  WDT_A->CTL = DEVELOPMENT; // Disables some security features
  P1->SEL0   = ENABLE;      // Enables the pins to the outside world
  P1->SEL1   = ENABLE;      // Enables the pins to the outside world
  P1->DIR    = RED;         // Make a pin an output
  P1->OUT    = BUTTON1;     // Enable button
  P1->REN    = BUTTON1;     // Button needs a pull-up resistor

  while (1) {
    while ((BUTTON1 & P1->IN) == 0) { P1->OUT |= RED; }
    P1->OUT &= RED_OFF;
  }
}
