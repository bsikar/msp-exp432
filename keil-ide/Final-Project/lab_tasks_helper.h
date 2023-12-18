#ifndef LAB_TASKS_HELPER_H_
#define LAB_TASKS_HELPER_H_

#include "msp.h"
#include <stdint.h>

typedef struct {
  DIO_PORT_Odd_Interruptable_Type  **odd;
  DIO_PORT_Even_Interruptable_Type **even;
} DIO_PORT_WRAPPER;

// the array must be null-terminated
void set_io_defaults(DIO_PORT_WRAPPER p, uint16_t *odd_pins,
                     uint16_t *even_pins, uint8_t *io_odd, uint8_t *io_even);
void lab_tasks_init(void);

#endif /* LAB_TASKS_HELPER_H_ */
