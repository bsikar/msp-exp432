.syntax unified
.cpu    cortex-m4
.thumb

.extern configure_uart
.extern configure_led
.extern configure_buzzer
.extern configure_motor
.extern process_rx_char

.global main

main:
    bl configure_uart
    bl configure_led
    bl configure_buzzer
    bl configure_motor

loop:
    bl process_rx_char
    b loop
