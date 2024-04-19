.syntax unified
.cpu    cortex-m4
.thumb

.extern led_on
.extern led_off
.extern buzzer_on
.extern buzzer_off
.extern motor_on
.extern motor_off

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
	beq buzzer_on
	cmp r1, #'3'
	beq buzzer_off

	cmp r1, #'4'
	beq motor_on
	cmp r1, #'5'
	beq motor_off

	b end_process

end_process:
	pop {lr} // Restore the return address
	bx  lr   // Return from subroutine

