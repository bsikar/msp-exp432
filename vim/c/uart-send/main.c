// MSP432 Menu
// 1. RGB Control
// 2. Digital Input
// 3. Temperature Reading

#include "adc_helper.h"
#include "lab_tasks.h"
#include "lab_tasks_helper.h"
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
  lab_tasks_init();
  int16_t op = -1;

  while (1) {
    uart_send_str(MENU);
    op = uart_get_char();
    if (op == -1 || op > 3) {
      uart_send_str("\r\nError: Invalid Menu Input\r\n");
      continue;
    }
    handle_task[op - 1]();
  }
}
