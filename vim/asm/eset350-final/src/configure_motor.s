.syntax unified
.cpu    cortex-m4
.thumb

.global configure_motor

// P5.6
configure_motor:
	// Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldr r0, =0x40004C44

	// Read the current value of P5->DIR
	ldrb r1, [r0]

	// Set P5.6
	orr r1, r1, #0x20

	// Write the updated value back to P5->DIR
	strb r1, [r0]

	bx lr // Return from the function
