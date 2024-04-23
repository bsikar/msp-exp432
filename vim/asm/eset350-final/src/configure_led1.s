.syntax unified
.cpu    cortex-m4
.thumb

.global configure_led1

// P1.0 (R)
configure_led1:
	// SEL0
	ldr  r0, =0x40004C0A // Load the adress of P1->SEL0 (0x40004C00 + 0x00A = 0x40004C0A)
	ldrb r1, [r0]        // Read the current value of P1->SEL0
	bic  r1, r1, #0x01   // Clear the 0st bit
	strb r1, [r0]        // Write the updated value back to P1->SEL0

	// SEL1
	ldr  r0, =0x40004C0C // Load the adress of P1->SEL1 (0x40004C00 + 0x00C = 0x40004C0C)
	ldrb r1, [r0]        // Read the current value of P1->SEL1
	bic  r1, r1, #0x01   // Clear the 0st bit
	strb r1, [r0]        // Write the updated value back to P1->SEL1

	// DIR
	ldr  r0, =0x40004C04 // Load the address of P1->DIR (0x40004C00 + 0x04 = 0x40004C04)
	ldrb r1, [r0]        // Read the current value of P1->DIR
	orr  r1, r1, #0x01   // Set P1.0
	strb r1, [r0]        // Write the updated value back to P1->DIR

	// Turn LED Off
	ldr  r0, =0x40004C02 // Load the address of P1->OUT (0x40004C00 + 0x02 = 0x40004C02)
	ldrb r1, [r0]        // Read the current value of P1->OUT
	bic  r1, r1, #0x01   // Clear P1.0
	strb r1, [r0]        // Write the updated value back to P1->OUT

	bx lr // Return from the function

