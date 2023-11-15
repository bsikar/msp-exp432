
// this will blink the green led

#include "msp.h"
#include <stdint.h>

void delay_ms(volatile uint_fast32_t);

int  main(void) {
  // configure P2.1 as simple IO
  P2->SEL1 &= ~2;
  P2->SEL0 &= ~2;

  // set P2.1 as output pin
  P2->DIR  |= 2;

  while (1) {
    P2->OUT |= 2; // turn on P2.1 green LED
    delay_ms(500);
    P2->OUT &= ~2; // turn off P2.1 green LED
    delay_ms(500);
  }
}

// the clock speed is 3MHz so this will delay for X ms
void delay_ms(volatile uint_fast32_t n) {
  uint_fast8_t i;
  for (; n > 0; n--) {
    for (i = 0; i < 250; i++) {} // delay for 1 ms
  }
}
