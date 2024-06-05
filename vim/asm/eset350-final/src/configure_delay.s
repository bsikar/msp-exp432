.syntax unified
.cpu    cortex-m4
.thumb

.global configure_delay

// P4.7
configure_delay:
	// SEL0
	ldr  r0, =0x40004C2B // Load the adress of P4->SEL0 (0x40004C00 + 0x02B = 0x40004C2B)
	ldrb r1, [r0]        // Read the current value of P4->SEL0
	bic  r1, r1, #0x08   // Clear the 3rd bit
	strb r1, [r0]        // Write the updated value back to P4->SEL0

	// SEL1
	ldr  r0, =0x40004C2D // Load the adress of P4->SEL1 (0x40004C00 + 0x02D = 0x40004C2D)
	ldrb r1, [r0]        // Read the current value of P4->SEL1
	bic  r1, r1, #0x08   // Clear the 3rd bit
	strb r1, [r0]        // Write the updated value back to P4->SEL1

	// DIR
	ldr  r0, =0x40004C25 // Load the address of P4->DIR (0x40004C00 + 0x025 = 0x40004C25)
	ldrb r1, [r0]        // Read the current value of P4->DIR
	bic  r1, r1, #0x08   // Clear P4.7 (for input you clear)
	strb r1, [r0]        // Write the updated value back to P4->DIR

	// REN
	ldr  r0, =0x40004C27 // Load the adress of P4->REN (0x40004C00 + 0x027 = 0x40004C27)
	ldrb r1, [r0]        // Read the current value of P4->REN
	orr  r1, r1, #0x08   // Set P4.7
	strb r1, [r0]        // Write the updated value back to P4->REN

	// OUT
	ldr  r0, =0x40004C23 // Load the adress of P4->OUT (0x40004C00 + 0x023 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	orr  r1, r1, #0x08   // Set P4.7
	strb r1, [r0]        // Write the updated value back to P4->OUT

	bx lr // Return from the function
