#include "redirect_io.h"

void output_init(void) {
  EUSCI_A0->CTLW0 |= 1;
  EUSCI_A0->MCTLW  = 0;
  EUSCI_A0->CTLW0  = 0x0081;
  EUSCI_A0->BRW    = 26;
  P1->SEL0        |= 0x0C;
  P1->SEL1        &= ~0x0C;
  EUSCI_A0->CTLW0 &= ~1;
}

/* Receive from PC */

unsigned char read_input(void) {
  char c;
  while (!(EUSCI_A0->IFG & 0x01))
    ;
  c = EUSCI_A0->RXBUF;
  return c;
}

/* Send to PC */
int send_output(unsigned char c) {
  while (!(EUSCI_A0->IFG & 0x02))
    ;
  EUSCI_A0->TXBUF = c;

  return c;
}

int fgetc(FILE *f) {
  int c = read_input();
  if (c == '\r') {
    send_output(c);
    c = '\n';
  }
  send_output(c);
  return c;
}

int fputc(int c, FILE *f) { return send_output(c); }
