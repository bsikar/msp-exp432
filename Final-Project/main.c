// MSP432 Menu
// 1. RGB Control
// 2. Digital Input
// 3. Temperature Reading

// Option 1:
/* Amount of time to toggle blinking of LED in seconds, how many seconds the LED
 * is ON and how many seconds the LED is OFF number of blinks is an entire cycle
 * ON and OFF Must use Timer32
 */
// Enter Combination of RGB (1 - 7):
// Enter Toggle Time:
// Enter Number of Blinks:
// Blinking LED...
// Done

// Option 2:
// No Button pressed, Button 2 pressed, include all buttons that are pressed

// Option 3:
/* Delay must be with SysTick Timer */
// Enter Number of Temperature Reading (1 - 5):
// Reading 1:
// Reading 2:
// ...

// INVALID DATA:
// any invalid menu option will display an error msg
// An invalid RGB value will default to 7
// An invalid temp reading # will default to 5

#include "adc_helper.h"
#include "lab_tasks.h"
#include "msp.h"
#include "uart_helper.h"
#include <stdint.h>

#define MENU                                                                   \
  "MSP432 Menu\r\n"                                                            \
  "1. RGB Control\r\n"                                                         \
  "2. Digital Input\r\n"                                                       \
  "3. Temperature Reading\r\n"

static void (*handle_task[3])(void) = {rgb_control, digital_input,
                                       temp_reading};

int main(void) {
  uart_init();
  adc_init();
  int16_t op = -1;

  while (1) {
    uart_send_str(MENU);
    op = uart_get_char();
    if (op == -1 || op > 3) {
      uart_send_str(
          "Error: Failed to parse input for Menu selection, invalid input\r\n");
      continue;
    }
    handle_task[op - 1]();
  }
}
