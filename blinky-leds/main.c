#include "msp.h"
#include <stdint.h>
#include <stddef.h>

enum ColorCode {
  OFF = (uint16_t)0x0,           /* 0x0 */
  RED = BIT0,                    /* 0x1 */
  GREEN = BIT1,                  /* 0x2 */
  YELLOW = BIT0 | BIT1,          /* 0x3 */
  BLUE = BIT2,                   /* 0x4 */
  PURPLE = BIT0 | BIT2,          /* 0x5 */
  TURQUOISE = BIT1 | BIT2,       /* 0x6 */
  WHITE = BIT0 | BIT1 | BIT2,    /* 0x7 */
  RGB_PINS = BIT0 | BIT1 | BIT2, /* 0x7 */
};

enum ButtonCode {
  BUTTON1 = BIT1,            /* 0x2 */
  BUTTON2 = BIT4,            /* 0x5 */
  BUTTON_PINS = BIT1 | BIT4, /* 0x7 */
};

void delay_ms(uint32_t n); // clock speed is 3MHz

typedef struct {
  DIO_PORT_Odd_Interruptable_Type **odd;
  DIO_PORT_Even_Interruptable_Type **even;
} DIO_PORT_WRAPPER;

// the array must be null-terminated
void set_io_defaults(DIO_PORT_WRAPPER p, uint16_t *odd_pins,
  uint16_t *even_pins);

int main(void) {
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD; // stop watchdog timer

  // enable P1 (for button) and P2 (for led)
  set_io_defaults((DIO_PORT_WRAPPER){
    .odd = (DIO_PORT_Odd_Interruptable_Type *[]){ P1, NULL },
    .even = (DIO_PORT_Even_Interruptable_Type *[]){ P2, NULL }
  },
  (uint16_t []){ BUTTON_PINS, NULL },
  (uint16_t []){ RGB_PINS, NULL });

  uint8_t colors[8] = {RED, GREEN, YELLOW, BLUE, PURPLE, TURQUOISE, WHITE, OFF};

  P2->OUT = colors[7]; // start off

  while (1) {
    for (uint_fast8_t i = 0; i < 8; i++) {
      P2->OUT = colors[i];
      delay_ms(1000);
    }
  }

  // no need to return from main
}

// the clock speed is 3MHz so this will delay for X ms
void delay_ms(volatile uint_fast32_t n) {
    uint_fast8_t i;
    for (; n > 0; n--) {
        for (i = 0; i < 250; i++) {} // delay for 1 ms
    }
}

void set_io_defaults(DIO_PORT_WRAPPER p, uint16_t *odd_pins,
                     uint16_t *even_pins) {
  for (DIO_PORT_Odd_Interruptable_Type **ptr = p.odd; *ptr != NULL; ptr++) {
    for (uint16_t *pins = odd_pins; *pins != NULL; pins++) {
      (*ptr)->SEL0 &= ~(*pins); // select GPIO function
      (*ptr)->SEL1 &= ~(*pins); // make sure to not select analog function
      (*ptr)->DIR &= ~(*pins);  // set input pins
      (*ptr)->REN |= (*pins);   // enable pull-up / pull-down resistors
      (*ptr)->OUT |= (*pins);   // select pull-up mode
    }
  }

  for (DIO_PORT_Even_Interruptable_Type **ptr = p.even; *ptr != NULL; ptr++) {
    for (uint16_t *pins = even_pins; *pins != NULL; pins++) {
      (*ptr)->SEL0 &= ~(*pins); // select GPIO function
      (*ptr)->SEL1 &= ~(*pins); // make sure to not select analog function
      (*ptr)->DIR |= (*pins);   // set output pins
      (*ptr)->OUT &= ~(*pins);  // start with all pins off
    }
  }
}

