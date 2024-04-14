.syntax unified
.cpu    cortex-m4
.thumb

.global configure_led

configure_led:
	// Load the address of P2->DIR (0x40004C00 + 0x05 = 0x40004C05)
	ldr r0, =0x40004C05

	// Read the current value of P2->DIR
	ldrb r1, [r0]

	// Set P2.0, P2.1, and P2.2 as outputs (BIT0 | BIT1 | BIT2 = 0x07)
	orr r1, r1, #0x07

	// Write the updated value back to P2->DIR
	strb r1, [r0]

	// Load the address of P2->OUT (0x40004C00 + 0x03 = 0x40004C03)
	ldr r0, =0x40004C03

	// Read the current value of P2->OUT
	ldrb r1, [r0]

	// Clear P2.0, P2.1, and P2.2 (effectively turning off LEDs)
	bic r1, r1, #0x07

	// Write the updated value back to P2->OUT
	strb r1, [r0]

	bx lr // Return from the function

