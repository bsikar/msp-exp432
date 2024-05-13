.syntax unified
.cpu    cortex-m4
.thumb

.extern configure_uart
.extern configure_led
.extern configure_buzzer
.extern configure_motor
.extern configure_ir
.extern process_rx_char

.global main

main:
	bl configure_uart
	bl configure_led
	bl configure_buzzer
	bl configure_motor
	bl configure_ir

loop:
	bl process_rx_char
	b  loop
