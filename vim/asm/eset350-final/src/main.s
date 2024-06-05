.syntax unified
.cpu    cortex-m4
.thumb

.extern configure_uart
.extern configure_led1
.extern configure_led2
.extern configure_buzzer
.extern configure_ir
.extern configure_delay
.extern configure_ssd
.extern process_rx_char

.global main

main:
	bl configure_uart
	bl configure_led1
	bl configure_led2
	bl configure_buzzer
	bl configure_ir
	bl configure_delay
	bl configure_ssd

	bl buzzer_on

loop:
	b loop
