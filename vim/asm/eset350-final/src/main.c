extern void configure_uart(void);
extern void configure_led(void);
extern void process_rx_char(void);

int main(void) {
  configure_uart();
  configure_led();

  for (;;) { process_rx_char(); }
}
