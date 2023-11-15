
// This program will blink a red LED when a button is pressed

#include "msp.h"
#include <stdint.h>

#define RED         0x0001
#define ENABLE      0x0000
#define RED_OFF     0x0000
#define DEVELOPMENT (WDT_A_CTL_PW | WDT_A_CTL_HOLD)
#define DELAY       0x30D40
#define BUTTON1     0x0002

#define ACLK        TIMER_A_CTL_SSEL__ACLK
#define UP          TIMER_A_CTL_MC__UP
#define TAIFG       TIMER_A_CTL_IFG

int main(void) {
  WDT_A->CTL = DEVELOPMENT; // Disables some security features
  P1->SEL0   = ENABLE;      // Enables the pins to the outside world
  P1->SEL1   = ENABLE;      // Enables the pins to the outside world
  P1->DIR    = RED;         // Make a pin an output
  P1->OUT    = RED;         // Turn on red LED

  volatile uint_fast8_t inteverals = 0;

  TIMER_A0->CCR0 = 20000; // how to do this!?!??!!?!? TODO : this doesnt work
  TIMER_A0->CTL  = ACLK | UP;

  while (1) {
    if (TIMER_A0->CTL & TAIFG) { // If the timer has counted to 20,000
      inteverals    += 1;        // Update the number of 20,000 counts
      TIMER_A0->CTL &= ~TAIFG;   // Count again

      if (inteverals == 3) {
        P1->OUT = RED_OFF;
        while (1) {} // Stay
      }
    }
  }
}
