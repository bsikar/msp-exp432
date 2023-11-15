
// this will blink the green led

#include "msp.h"
#include <stdint.h>

#define GREEN_LED BIT2
#define DELAY_AMT 500 // in ms

void delay_ms(volatile uint_fast32_t);

int  main(void) {
  // configure P2.1 as simple IO
  P2->SEL1 &= ~GREEN_LED;
  P2->SEL0 &= ~GREEN_LED;

  // set P2.1 as output pin
  P2->DIR  |= GREEN_LED;

  while (1) {
    P2->OUT |= GREEN_LED; // turn on P2.1 green LED
    delay_ms(DELAY_AMT);
    P2->OUT &= ~GREEN_LED; // turn off P2.1 green LED
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
