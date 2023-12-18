#ifndef REDIRECT_IO_H_
#define REDIRECT_IO_H_

#include "msp.h"
#include <stdio.h>

void output_init(void);

/* Receive from PC */
unsigned char read_input(void);

/* Send to PC */
int send_output(unsigned char c);

int fgetc(FILE *f);

int fputc(int c, FILE *f);
#endif
