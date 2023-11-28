#include "uart_helper.h"
#include "msp.h"
#include <stdint.h>

void uart_init(void) {
  EUSCI_A0->CTLW0 |= 0X1;
  EUSCI_A0->MCTLW = 0X0;
  EUSCI_A0->CTLW0 |= 0x80;
  EUSCI_A0->BRW = 0x34;
  EUSCI_A0->CTLW0 &= ~0x01;
  P1->SEL0 |= 0x0C;
  P1->SEL1 &= ~0x0C;
}

void uart_send_str(const char *str) {
  uint32_t i = 0;
  while (str[i] != '\0') {
    EUSCI_A0->TXBUF = str[i];
    while ((EUSCI_A0->IFG & 0x02) == 0) {
    }
    i++;
  }
}

int16_t uart_get_char(void) {
  uint32_t i = 0;
  char cmd[2], x;
  while (i < 2) {
    if ((EUSCI_A0->IFG & 0x01) != 0) {
        // data is in the RX buffer
        cmd[i] = EUSCI_A0->RXBUF;
        while ((EUSCI_A0->IFG & 0x02) == 0) {
        }

        if (cmd[i] == '\r') {
            cmd[i] = '\0';
            uart_send_str("\n\r");
            return (int16_t)atoi(cmd);
        }
        i++;
    }
  }
  return -1;
}

