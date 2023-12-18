
// This program will turn off a red LED when a button is pressed

#include "msp.h"
#include <assert.h>
#include <stdint.h>

int main(void) {
  // configure P1.0 and P1.1 as GPIO
  P1->SEL0 &= ~(BIT0 | BIT1);
  P1->SEL1 &= ~(BIT0 | BIT1);

  // set P1.0 as output and P1.1 as input
  P1->DIR |= BIT0;  // set P1.0 as output
  P1->DIR &= ~BIT1; // set P1.1 as input

  // enable pull-up/pull-down resistors for P1.1
  P1->REN |= BIT1;

  // enable pull-up resistor for P1.1
  P1->OUT |= BIT1; // textbook says P1->OUT &= ~BIT1;

  while (1) {
    // check if the button connected to P1.1 is pressed
    if ((P1->IN & BIT1) == BIT1) {
      // if the button is not pressed, turn on the red LED connected to P1.0
      P1->OUT |= BIT0;
    } else {
      // if the button is pressed, turn off the red LED connected to P1.0
      P1->OUT &= ~BIT0;
    }
  }
}
