.syntax unified
.cpu    cortex-m4
.thumb

.extern set_led
.extern set_buzzer
.extern set_motor

.global process_rx_char

// Jump table for function pointers
jump_table:
	.word set_led    // Address of set_led function
	.word set_buzzer // Address of set_buzzer function
	.word set_motor  // Address of set_motor function

	// Main routine to process received character
process_rx_char:
	ldr  r0, =0x4000180C // Load address of EUSCI_A2->RXBUF
	ldrb r1, [r0]        // Load the received character into r1

	ldr  r2, =0x40004C03 // Load address of P2->OUT
	ldrb r3, [r2]        // Load current state of P2->OUT into r3

	ldr  r4, =0x4000180A // Load address of EUSCI_A2->IFG register
	ldrh r5, [r4]        // Load interrupt flags
	tst  r5, #0x0001     // Test RX interrupt flag
	bne  rx_interrupt    // Branch if RX interrupt flag is set

	b end_process // Branch to end_process if no interrupt

rx_interrupt:
	// Handle character processing within valid range '0'-'3'
	cmp r1, #'0'
	blo end_process // Branch if character is below '0'
	cmp r1, #'3'
	bhi end_process // Branch if character is above '3'

	// Calculate function pointer from jump_table based on character
	sub r1, r1, #'0'         // Convert ASCII to index
	ldr r0, =jump_table      // Load the base address of the jump table
	ldr r0, [r0, r1, lsl #2] // Calculate offset, load function address
	blx r0                   // Branch to the function

end_process:
	bx lr // Return from subroutine

