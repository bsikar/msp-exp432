
// Turn off red LED after 3 seconds

#include "msp.h"

/*
 * The system clock is 3MHz
 * The counter is 24-bits and each count is 0.333us
 * A full count is a delay of about 5.59s
 * Effective delay is (# of counts) / (CLK Frequency)
 * The # counts - 1 is the value that is loaded into the STRVR
 * The -1 is because zero gets a count
 * When STCVR register reaches 0, the COUNTFLAG is set to 1. It is 0 otherwise
 */
#define SYS_CLOCK_FREQ    3000000   // 3 MHz system clock
#define TIME_PER_COUNT    0.3333e-6 // Time per SysTick count in seconds
#define WATCHDOG_PASSWORD WDT_A_CTL_PW
#define WATCHDOG_HOLD     WDT_A_CTL_HOLD
#define GPIO_PIN0         0x01
#define SYSTICK_ENABLE    0x01
#define SYSTICK_CLKSOURCE 0x04
#define SYSTICK_COUNTFLAG 0x10000
#define DELAY_3_SEC       (3 / TIME_PER_COUNT) - 1

int main(void) {
  // Stop watchdog timer
  WDT_A->CTL = WATCHDOG_PASSWORD | WATCHDOG_HOLD;

  // Set up Port 1 Pin 0 as GPIO output
  P1->SEL0 &= ~GPIO_PIN0;
  P1->SEL1 &= ~GPIO_PIN0;
  P1->DIR  |= GPIO_PIN0;

  // Configure SysTick for 3-second delay
  SysTick->LOAD  = DELAY_3_SEC;
  SysTick->CTRL |= SYSTICK_CLKSOURCE; // Use system clock, no interrupt

  // Turn on Pin 0 and start SysTick
  P1->OUT       |= GPIO_PIN0;
  SysTick->CTRL |= SYSTICK_ENABLE;

  // Wait for SysTick COUNTFLAG
  while ((SysTick->CTRL & SYSTICK_COUNTFLAG) == 0) {}

  // Turn off Pin 0 and disable SysTick
  P1->OUT       &= ~GPIO_PIN0;
  SysTick->CTRL &= ~SYSTICK_ENABLE;

  while (1) {}
}
