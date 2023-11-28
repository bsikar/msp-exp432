#ifndef UART_HELPER_H_
#define UART_HELPER_H_

void uart_init(void);
void uart_send_str(const char *);
uint8_t uart_get_char(void);

#endif /* UART_HELPER_H_ */
