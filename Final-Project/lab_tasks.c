#include "lab_tasks.h"
#include "adc_helper.h"
#include "msp.h"
#include "uart_helper.h"
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

// Must use Timer32
void rgb_control(void) {
  uart_send_str("Enter Combination of RGB (1 - 7): ");
  int16_t rgb, op;
  rgb = op = uart_get_char();
  if (op == -1 || op > 7) {
    op = 7;
  }
  uart_send_str("Enter Toggle Time: ");
  int16_t toggle_time = uart_get_char();
  op                  = toggle_time;
  if (op == -1) {
    uart_send_str("\r\nError: Invalid Toggle Time Input\r\n");
  }
  uart_send_str("Enter Number of Blinks: ");
  op = uart_get_char();
  if (op == -1) {
    uart_send_str("\r\nError: Invalid Number of Blinks\r\n");
  }
  uart_send_str("Blinking LED\r\n");
  P2->OUT &= ~0x7; // disable the LED

  TIMER32_1->LOAD     = toggle_time * 3e6 - 1;
  TIMER32_1->CONTROL |= 0x42; // periodic mode (restart timer), no interrupt or
                              // prescale, 32-bit state, wrapping mode
  TIMER32_1->CONTROL |= 0x80; // enable timer (bit7)
  for (; op > 0; op--) {
    // Enable the LED (MAKE IT ON)
    P2->OUT |= rgb;

    while ((TIMER32_1->RIS & 1) != 1) {} // while count is not done, wait
    TIMER32_1->INTCLR &= ~0x01; // set INTCLR to 0 after count is reached
    // DISABLE THE LED (MAKE IT OFF)
    P2->OUT           &= ~rgb;

    while ((TIMER32_1->RIS & 1) != 1) {} // while count is not done, wait
    TIMER32_1->INTCLR &= ~0x01; // set INTCLR to 0 after count is reached
  }
  TIMER32_1->CONTROL &= ~0x80; // disable Timer32
  uart_send_str("Done\r\n");
}

void digital_input(void) {
  bool button1 = (P1->IN & BIT1) == 0;
  bool button2 = (P1->IN & BIT4) == 0;
  if (button1 && button2) {
    uart_send_str("Buttons 1 and 2 are pressed\r\n");
  } else if (button1) {
    uart_send_str("Buttons 1 is pressed\r\n");
  } else if (button2) {
    uart_send_str("Button 2 is pressed\r\n");
  } else {
    uart_send_str("No Buttons are pressed\r\n");
  }
}

// Must use SysTick, wait every second
void temp_reading(void) {
  uart_send_str("Enter Number of Temperature Readings (1 - 5): ");
  int16_t num_reads = uart_get_char();
  if (num_reads == -1 || num_reads > 5) {
    num_reads = 5;
  }
  SysTick->LOAD  = 3e6 - 1;
  SysTick->CTRL |= 0x05; // system CLK, no interrupt, and disabled, then enable
  for (uint8_t i = 0; i < num_reads; i++) {
    char  s[200]   = {'\0'};
    float tempf_c  = temp_read();
    float tempf_f  = (tempf_c * 9.0 / 5.0) + 32;
    tempf_c       *= 100;
    tempf_f       *= 100;
    sprintf(s, "Reading %d: %d.%02d C & %d.%02d F\r\n", i, (int)tempf_c / 100,
            (int)tempf_c % 100, (int)tempf_f / 100, (int)tempf_f % 100);

    uart_send_str(s);
    while ((SysTick->CTRL & 0x10000) == 0) {} // wait while COUNTFLAG not set
  }
  SysTick->CTRL &= ~0x01; // disable SysTick
}
