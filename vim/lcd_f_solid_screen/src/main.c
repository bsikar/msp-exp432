#include <stdint.h>
#include <ti/devices/msp432p4xx/driverlib/driverlib.h>
#include <ti/devices/msp432p4xx/inc/msp432p4111.h>

static void show_char(char c, uint8_t pos);

int main(void) {
  WDT_A_holdTimer(); // stop watchdog
}
