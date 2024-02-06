#include <ti/devices/msp432p4xx/inc/msp432.h>

#include <ctype.h>
#include <stdio.h>
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

#define uart_send_str_formatted(format, ...)                                   \
  do {                                                                         \
    char formatted_string[500];                                                \
    snprintf(formatted_string, sizeof(formatted_string), format,               \
             ##__VA_ARGS__);                                                   \
    uart_send_str(formatted_string);                                           \
  } while (0)

int main(void) {
  uart_init();
  // SET SEL0
  __asm__ volatile("ldr r0, =0x40004c0b\n\t"
                   "mov r1, #0x0000\n\t"
                   "strh r1, [r0]\n\t");
  uart_send_str_formatted("P2->SEL0 <%p> = 0x%x\r\n", &(P2->SEL0), P2->SEL0);

  // SET SEL1
  __asm__ volatile("ldr r0, =0x40004c0d\n\t"
                   "mov r1, #0x0000\n\t"
                   "strh r1, [r0]\n\t");
  uart_send_str_formatted("P2->SEL1 <%p> = 0x%x\r\n", &(P2->SEL1), P2->SEL1);

  // SET DIR
  __asm__ volatile("ldr r0, =0x40004c05\n\t"
                   "mov r1, #0x0001\n\t" // 0x0001 is red
                   "strh r1, [r0]\n\t");
  uart_send_str_formatted("P2->DIR <%p> = 0x%x\r\n", &(P2->DIR), P2->DIR);

  // SET OUT
  while (1) {
    __asm__ volatile("ldr r0, =0x40004c03\n\t"
                     "mov r1, #0x00FE\n\t" // 0x00FE is off 0x0001 is on
                     "strh r1, [r0]\n\t");
    uart_send_str_formatted("P2->OUT <%p> = 0x%x\r\n\r\n", &(P2->OUT), P2->OUT);

    for (int i = 0; i < 100000; i++) {}

    __asm__ volatile("ldr r0, =0x40004c03\n\t"
                     "mov r1, #0x0001\n\t" // 0x00FE is off 0x0001 is on
                     "strh r1, [r0]\n\t");
    uart_send_str_formatted("P2->OUT <%p> = 0x%x\r\n\r\n", &(P2->OUT), P2->OUT);

    for (int i = 0; i < 100000; i++) {}
  }
}
