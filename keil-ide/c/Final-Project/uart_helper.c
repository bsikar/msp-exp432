#include "uart_helper.h"
#include "msp.h"
#include <ctype.h>
#include <stdlib.h>

void uart_init(void) {
  EUSCI_A0->CTLW0 |= 0X1;
  EUSCI_A0->MCTLW  = 0X0;
  EUSCI_A0->CTLW0 |= 0x80;
  EUSCI_A0->BRW    = 0x34;
  EUSCI_A0->CTLW0 &= ~0x01;
  P1->SEL0        |= 0x0C;
  P1->SEL1        &= ~0x0C;
}

void uart_send_str(const char *str) {
  uint32_t i = 0;
  while (str[i] != '\0') {
    EUSCI_A0->TXBUF = str[i];
    while ((EUSCI_A0->IFG & 0x02) == 0) {}
    i++;
  }
}
int16_t uart_get_char(void) {
  uint8_t i = 0;
  char    command[3]; // 'c\r\0'

  while (1) {
    if ((EUSCI_A0->IFG & 0x01) != 0) { // data in RX buffer
      command[i]      = EUSCI_A0->RXBUF;
      EUSCI_A0->TXBUF = command[i];          // echo
      while ((EUSCI_A0->IFG & 0x02) == 0) {} // wait

      if (command[i] == '\r') {
        command[i] = '\0';
        break;
      } else {
        i++;
      }
    }
  }

  if (!isdigit(command[0])) { // check if the character is a digit
    uart_send_str("\n\rError: Non-numeric input\r\n");
    return -1;
  }

  uart_send_str("\n\r");
  return atoi(command);
}