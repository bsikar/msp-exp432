
// This program will turn off a red LED when a button is pressed

#include "msp.h"
#include <assert.h>
#include <stdint.h>

int main(void) {
  // configure P1.0 and P1.1 as GPIO
  P1->SEL0 &= ~0x03;
  P1->SEL1 &= ~0x03;

  // set P1.0 as output and P1.1 as input
  P1->DIR |= 0x1;  // set P1.0 as output
  P1->DIR &= ~0x2; // set P1.1 as input

  // enable pull-up/pull-down resistors for P1.1
  P1->REN |= 0x2;

  // enable pull-up resistor for P1.1
  P1->OUT |= 0x2; // textbook says P1->OUT &= ~0x2;

  while (1) {
    // check if the button connected to P1.1 is pressed
    if ((P1->IN & 0x2) == 0x2) {
      // if the button is not pressed, turn on the red LED connected to P1.0
      P1->OUT |= 0x1;
    } else {
      // if the button is pressed, turn off the red LED connected to P1.0
      P1->OUT &= ~0x1;
    }
  }
}
