.syntax unified
.cpu    cortex-m4
.thumb

.extern configure_uart
.extern configure_led
.extern configure_buzzer
.extern configure_ir
.extern configure_wait
.extern configure_ssd
.extern process_rx_char

.global main

main:
	bl configure_uart
	bl configure_led
	bl configure_buzzer
	bl configure_ir
	bl configure_wait
	bl configure_ssd

loop:
	bl process_rx_char
	b loop
