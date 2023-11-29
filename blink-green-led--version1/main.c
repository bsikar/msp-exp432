
// Using all 3, 2 buttons, 2 LEDs, 2 timers

#include "msp.h"

int main(void) {
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD; // stop watchdog timer
  /// There are 2 different LEDs that can be controlled
  /// Port 1 Pin 0 (RED led)
  /// Port 2 Pins 0-2
  /// There are 2 different buttons
  /// Port 1 Pin 1
  /// Port 1 Pin 4

  // Enable the output pins
  P1->SEL0 &= ~0x01;
  P1->SEL1 &= ~0x01;
  P2->SEL0 &= ~0x07; // 0x01 | 0x02 | 0x04
  P2->SEL1 &= ~0x07;
  // Set pins to output
  P1->DIR  |= 0x01;
  P2->DIR  |= 0x07;
  // Set LEDs to off
  P1->OUT  &= ~0x01;
  P2->OUT  &= ~0x07;

  // Enable the input pins
  P1->SEL0 &= ~0x09; // 0x01 | 0x08
  P1->SEL1 &= ~0x09;
  // Set pins to input
  P1->DIR  &= ~0x09;
  // Set pull-up/pull-down resistors
  P1->REN  |= 0x09;
  // enable pull-up resistors
  P1->OUT  |= 0x09;

  /// There are 2 timers that I will be using
  /// 1 will be SysTick in One-Shot Mode
  /// 1 will be Timer32_2 in Periodic Mode

  /// SysTick in One-Shot Mode
  /// The goal is to blink the all the LEDs for 3 seconds then stop
  SysTick->LOAD  = (3e6 * 3) - 1;
  SysTick->CTRL |= 0x04; // system CLK, no interrupt, and disabled
  SysTick->CTRL |= 0x01; // enable SysTick

  P1->OUT |= 0x01;
  uint32_t delay_duration, start_time;
  while ((SysTick->CTRL & 0x10000) == 0) {
    // Turn on LEDs randomly (adjust the mask as per your hardware)
    P2->OUT |= SysTick->VAL % (0x07 + 1);

    delay_duration = SysTick->LOAD / 17;
    start_time     = SysTick->VAL;
    while ((start_time - SysTick->VAL) < delay_duration)
      ;

    P2->OUT &= ~0x07;

    delay_duration = SysTick->LOAD / 25;
    start_time     = SysTick->VAL;
    while ((start_time - SysTick->VAL) < delay_duration)
      ;
  }
  SysTick->CTRL &= ~0x01; // disable SysTick (one-shot)

  // reset the LEDs
  P1->OUT &= ~0x01;
  P2->OUT &= ~0x07;

  while (1) {}
}
