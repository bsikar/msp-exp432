.syntax unified
.cpu    cortex-m4
.thumb

.global configure_ir

// P5.4
configure_ir:
	// SEL0
	ldr  r0, =0x40004C4A // Load the adress of P5->SEL0 (0x40004C00 + 0x04A = 0x40004C4A)
	ldrb r1, [r0]        // Read the current value of P5->SEL0
	bic  r1, r1, #0x10   // Clear the 4th bit
	strb r1, [r0]        // Write the updated value back to P5->SEL0

	// SEL1
	ldr  r0, =0x40004C4C // Load the adress of P5->SEL1 (0x40004C00 + 0x04C = 0x40004C4C)
	ldrb r1, [r0]        // Read the current value of P5->SEL1
	bic  r1, r1, #0x10   // Clear the 4th bit
	strb r1, [r0]        // Write the updated value back to P5->SEL1

	// DIR
	ldr  r0, =0x40004C44 // Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldrb r1, [r0]        // Read the current value of P5->DIR
	bic  r1, r1, #0x10   // Clear P5.4 (for input you clear)
	strb r1, [r0]        // Write the updated value back to P5->DIR

	// REN (pull-up)
	ldr  r0, =0x40004C46 // Load the adress of P5->REN (0x40004C00 + 0x046 = 0x40004C46)
	ldrb r1, [r0]        // Read the current value of P5->REN
	orr  r1, r1, #0x10   // Set P5.4
	strb r1, [r0]        // Write the updated value back to P5->REN

	// OUT
	ldr  r0, =0x40004C42 // Load the adress of P5->OUT (0x40004C00 + 0x042 = 0x40004C42)
	ldrb r1, [r0]        // Read the current value of P5->OUT
	orr  r1, r1, #0x10   // Set P5.4
	strb r1, [r0]        // Write the updated value back to P5->OUT

	bx lr // Return from the function
