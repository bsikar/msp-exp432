.syntax unified
.cpu    cortex-m4
.thumb

.global configure_buzzer

// P5.5
configure_buzzer:
	// Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldr r0, =0x40004C44
	ldrb r1, [r0]     // Read the current value of P5->DIR
    orr r1, r1, #0x20 // Set P5.5
	strb r1, [r0]     // Write the updated value back to P5->DIR

    bx lr // Return from the function