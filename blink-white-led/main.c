
// this will blink the red, green, and blue led all together making white

#include "msp.h"
#include <stdint.h>

#define WHITE_LED BIT0 | BIT1 | BIT2 // red, green, blue bit's
#define DELAY_AMT 500                // in ms

void delay_ms(volatile uint_fast32_t);

int  main(void) {
  // configure P2.1-P2.3 as simple IO
  P2->SEL1 &= ~WHITE_LED;
  P2->SEL0 &= ~WHITE_LED;

  // set P2.1-P2.3 as output pin
  P2->DIR  |= WHITE_LED;
  P2->OUT  |= WHITE_LED; // turn on white

  while (1) {
    P2->OUT ^= WHITE_LED; // turn on P2.1-P2.3 LEDs
    delay_ms(DELAY_AMT);
  }
}

// the clock speed is 3MHz so this will delay for X ms
void delay_ms(volatile uint_fast32_t n) {
  uint_fast8_t i;
  for (; n > 0; n--) {
    for (i = 0; i < 250; i++) {} // delay for 1 ms
  }
}
