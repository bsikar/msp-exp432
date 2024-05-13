.syntax unified
.cpu    cortex-m4
.thumb

.global configure_motor

// P5.6
configure_motor:
	// SEL0
	ldr  r0, =0x40004C4A // Load the adress of P5->SEL0 (0x40004C00 + 0x04A = 0x40004C4A)
	ldrb r1, [r0]        // Read the current value of P5->SEL0
	bic  r1, #0x40       // Clear the 6th bit
	strb r1, [r0]        // Write the updated value back to P5->SEL0

	// SEL1
	ldr  r0, =0x40004C4C // Load the adress of P5->SEL1 (0x40004C00 + 0x04C = 0x40004C4C)
	ldrb r1, [r0]        // Read the current value of P5->SEL1
	bic  r1, #0x40       // Clear the 6th bit
	strb r1, [r0]        // Write the updated value back to P5->SEL1

	// DIR
	ldr  r0, =0x40004C44 // Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldrb r1, [r0]        // Read the current value of P5->DIR
	orr  r1, r1, #0x40   // Set P5.6
	strb r1, [r0]        // Write the updated value back to P5->DIR

	// Turn off the Motor
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldrb r1, [r0]        // Read the current value of P5->OUT
	bic  r1, r1, #0x40   // Disable the 6th bit
	strb r1, [r0]        // Store the modified value back to P5->OUT

	bx lr // Return from the function
