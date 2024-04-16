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
    //b configure_uart
    //b configure_led
    b configure_buzzer
    //b configure_motor

    //b set_led
    b set_buzzer
    //b set_motor

loop:
    //b process_rx_char
    b loop
