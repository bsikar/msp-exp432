.syntax unified
.cpu    cortex-m4
.thumb

.extern set_led
.extern set_buzzer
.extern set_motor

.global process_rx_char

process_rx_char:
	push {lr} // Save return address

	ldr  r0, =0x4000180C // Load address of EUSCI_A2->RXBUF
	ldrb r1, [r0]        // Load the received character into r1

	ldr  r2, =0x4000180A // Load address of EUSCI_A2->IFG register
	ldrb r3, [r2]        // Load interrupt flags
	tst  r3, #0x01       // Test RX interrupt flag
	beq  end_process     // Skip processing if no RX interrupt

	// Directly branch to the appropriate function based on the input
	cmp r1, #'0'
	beq led_on
	cmp r1, #'1'
	beq led_off

	cmp r1, #'2'
	beq set_buzzer

	cmp r1, #'3'
	beq set_motor

	b end_process

end_process:
	pop {lr} // Restore the return address
	bx  lr   // Return from subroutine

