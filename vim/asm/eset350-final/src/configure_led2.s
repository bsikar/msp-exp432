.syntax unified
.cpu    cortex-m4
.thumb

.global configure_led2

// P2.0 (R), P2.1 (G), P2.2 (B)
configure_led2:
	// SEL0
	ldr  r0, =0x40004C0B // Load the adress of P2->SEL0 (0x40004C00 + 0x00B = 0x40004C0B)
	ldrb r1, [r0]        // Read the current value of P2->SEL0
	bic  r1, r1, #0x07   // Clear the (0-2)nd bit
	strb r1, [r0]        // Write the updated value back to P2->SEL0

	// SEL1
	ldr  r0, =0x40004C0D // Load the adress of P2->SEL1 (0x40004C00 + 0x00D = 0x40004C0D)
	ldrb r1, [r0]        // Read the current value of P2->SEL1
	bic  r1, r1, #0x07   // Clear the (0-2)nd bit
	strb r1, [r0]        // Write the updated value back to P2->SEL1

	// DIR
	ldr  r0, =0x40004C05 // Load the address of P2->DIR (0x40004C00 + 0x05 = 0x40004C05)
	ldrb r1, [r0]        // Read the current value of P2->DIR
	orr  r1, r1, #0x07   // Set P2.0, P2.1, and P2.2 as outputs (BIT0 | BIT1 | BIT2 = 0x07)
	strb r1, [r0]        // Write the updated value back to P2->DIR

	// Turn LED Off
	ldr  r0, =0x40004C03 // Load the address of P2->OUT (0x40004C00 + 0x03 = 0x40004C03)
	ldrb r1, [r0]        // Read the current value of P2->OUT
	bic  r1, r1, #0x07   // Clear P2.0, P2.1, and P2.2 (effectively turning off LEDs)
	strb r1, [r0]        // Write the updated value back to P2->OUT

	bx lr // Return from the function

