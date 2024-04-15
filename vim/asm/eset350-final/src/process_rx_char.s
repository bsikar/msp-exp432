.syntax unified
.cpu    cortex-m4
.thumb

.extern set_rgb
.extern set_buzzer
.extern set_motor

.global process_rx_char

jump_table:
// Instead of .word in keil dcd would have been used
    .word set_rgb
    .word set_buzzer
    .word set_motor

process_rx_char:
	ldr  r0, =0x4000180C // Address of EUSCI_A2->RXBUF
	ldrb r1, [r0]        // Load the received character into r1

	ldr  r2, =0x40004C03 // Address of P2->OUT, corrected to proper address
	ldrb r3, [r2]        // Load current state of P2->OUT into r3

	// Check if RX interrupt flag is set
	ldr  r4, =0x4000180A // Address of EUSCI_A2->IFG register
	ldrh r5, [r4]        // Load interrupt flags
	tst  r5, #0x0001     // Test RX interrupt flag
	bne  rx_interrupt    // If RX interrupt flag is set, handle it

	b end_process // Branch to end_process

rx_interrupt:
	// Handle normal character processing here
	cmp r1, #'0'        // Compare received character with '0'
	blo end_process     // If its lower end the process
    cmp r1, #'3'        // Compare recived character with '3'
    bhi end_process     // If its higher end the process
    
	// None of the conditions met, call the jumptable
    ldr  r0, =jump_table        // Load the base address of the jump table
    ldr  r0, [r0, r1, lsl #2]   // Multiply index by 4, add to base address, and load the function address

    blx  r0              // Branch to the loaded address

end_process:
	bx lr // Return from the subroutine

