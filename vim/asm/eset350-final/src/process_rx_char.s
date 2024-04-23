.syntax unified
.cpu    cortex-m4
.thumb

.extern led2_on
.extern led2_off
.extern buzzer_on
.extern buzzer_off
.extern ssd0_on
.extern ssd1_on
.extern ssd2_on
.extern ssd3_on
.extern ssd4_on
.extern ssd5_on

.global process_rx_char

process_rx_char:
	ldr  r0, =0x4000180C // Load address of EUSCI_A2->RXBUF
	ldrb r1, [r0]        // Load the received character into r1

	ldr  r2, =0x4000180A // Load address of EUSCI_A2->IFG register (STATUS)
	ldrb r3, [r2]        // Load interrupt flags
	tst  r3, #0x01       // Test RX interrupt flag
	beq  end_process     // Skip processing if no RX interrupt

	// Directly branch to the appropriate function based on the input
	cmp r1, #'0'
	beq led2_on
	cmp r1, #'1'
	beq led2_off

	cmp r1, #'2'
	beq buzzer_on
	cmp r1, #'3'
	beq buzzer_off

	bx lr

end_process:
	bx lr // Return from subroutine

