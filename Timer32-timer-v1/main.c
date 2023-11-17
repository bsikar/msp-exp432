
// Turn off red LED after 3 seconds

#include "msp.h"

int main(void) {
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD; // stop watchdog timer

  // Set up Port 2 Pin 0
  P2->SEL0  = 0x00;
  P2->SEL1  = 0x00;
  P2->DIR  |= 0x01;

  TIMER32_1->LOAD     = 3 * 3e6 - 1; // 3 seconds
  TIMER32_1->CONTROL |= 0x42; // periodic mode (restart timer), no interrupt or
                              // prescale, 32-bit state, wrapping mode

  P2->OUT            |= 0x01; // turn on pin 0
  TIMER32_1->CONTROL |= 0x80; // enable timer bit7

  while ((TIMER32_1->RIS & 1) != 1) {} // while count is not done, wait

  TIMER32_1->INTCLR  &= ~0x01; // set INTCLR to 0 after count is reached
  P2->OUT            &= ~0x01; // Turn off Pin 0
  TIMER32_1->CONTROL &= ~0x80; // disable Timer32

  while (1) {}
}
