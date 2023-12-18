#include <ti/devices/msp432p4xx/driverlib/driverlib.h>
#include <stdint.h>

static void show_char(char c, uint8_t pos);

int main(void) {
  WDT_A_holdTimer(); // stop watchdog

}

