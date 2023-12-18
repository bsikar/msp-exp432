#include "lab_tasks_helper.h"
#include <stddef.h>

// the array must be null-terminated
void set_io_defaults(DIO_PORT_WRAPPER p, uint16_t *odd_pins,
                     uint16_t *even_pins, uint8_t *io_odd, uint8_t *io_even) {
  for (DIO_PORT_Odd_Interruptable_Type **ptr = p.odd; *ptr != NULL; ptr++) {
    uint8_t *io = io_odd;
    for (uint16_t *pins = odd_pins; *pins != NULL; pins++) {
      (*ptr)->SEL0 &= ~(*pins); // select GPIO function
      (*ptr)->SEL1 &= ~(*pins); // make sure to not select analog function
      if ((*io)++) {
        // output
        (*ptr)->DIR |= *pins; // set as output pins
        (*ptr)->OUT |= *pins; // set pins to high
      } else {
        // input
        (*ptr)->DIR &= ~(*pins); // set as input pins
        (*ptr)->REN |= *pins;    // resistor
        (*ptr)->OUT |= *pins;    // set pins to high,  pull-up resistor
      }
    }
  }

  for (DIO_PORT_Even_Interruptable_Type **ptr = p.even; *ptr != NULL; ptr++) {
    uint8_t *io = io_even;
    for (uint16_t *pins = even_pins; *pins != NULL; pins++) {
      (*ptr)->SEL0 &= ~(*pins); // select GPIO function
      (*ptr)->SEL1 &= ~(*pins); // make sure to not select analog function
      if ((*io)++) {
        // output
        (*ptr)->DIR |= *pins;    // set as output pins
        (*ptr)->OUT &= ~(*pins); // set pins to low
      } else {
        // input
        (*ptr)->DIR &= ~(*pins); // set as input pins
        (*ptr)->REN |= *pins;    // resistor
        (*ptr)->OUT |= *pins;    // set pins to high,  pull-up resistor
      }
    }
  }
}

void lab_tasks_init(void) {
  // The lab requires:
  // Port 2 Pins 0-2
  // Port 1 Pins 1, 4
  set_io_defaults(
      (DIO_PORT_WRAPPER){.odd = (DIO_PORT_Odd_Interruptable_Type *[]){P1, NULL},
                         .even =
                             (DIO_PORT_Even_Interruptable_Type *[]){P2, NULL}},
      (uint16_t[]){BIT1 | BIT4, NULL}, (uint16_t[]){BIT0 | BIT1 | BIT2, NULL},
      (uint8_t[]){0, NULL}, (uint8_t[]){1, NULL});
}
