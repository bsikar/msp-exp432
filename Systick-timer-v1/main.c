
// Turn off red LED after 3 seconds

#include "msp.h"

int main(void) {
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD; // stop watchdog timer

  // Set up Port 1 Pin 0
  P1->SEL0  = 0x00;
  P1->SEL1  = 0x00;
  P1->DIR  |= 0x01;

  SysTick->LOAD  = 9000000 - 1; // somehow a delay of 3 seconds??
  SysTick->CTRL |= 0x04;        // system CLK, no interrupt, and disabled

  P1->OUT       |= 0x01; // turn on Pin 0
  SysTick->CTRL |= 0x01; // Enable SysTick

  while ((SysTick->CTRL & 0x10000) == 0) {} // wait while COUNTFLAG not set

  P1->OUT       &= ~0x01; // Turn off Pin 0
  SysTick->CTRL &= ~0x01; // disable SysTick

  while (1) {}
}
