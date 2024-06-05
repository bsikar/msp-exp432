.syntax unified
.cpu    cortex-m4
.thumb

.global configure_input

configure_input:
	// P2.3 is input, up      | 34 -> 19
	// P2.4 is input, down    | 38 -> 21
	// P2.5 is input, left    | 19 -> 22
	// P2.6 is input, right   | 39 -> 23
	// P2.7 is input, place   | 40 -> 18
	// 0b11111000 -> 0xF8

	// SEL0
	ldr  r0, =0x40004C0B // P2->SEL0 (0x40004C00 + 0x00B)
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0xF8   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// SEL1
	ldr  r0, =0x40004C0D // P2->SEL1 (0x40004C00 + 0x00D)
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0xF8   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// DIR
	ldr  r0, =0x40004C05 // P2->DIR (0x40004C00 + 0x005)
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0xF8   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// REN (pull-up)
	ldr  r0, =0x40004C07 // P2->REN (0x40004C00 + 0x07)
	ldrb r1, [r0]        // Read the value
	orr  r1, r1, #0xF8   // Enable the proper bits
	strb r1, [r0]        // Write the updated value

	// OUT
	ldr  r0, =0x40004C03 // P2->OUT (0x40004C00 + 0x03)
	ldrb r1, [r0]        // Read the value
	orr  r1, r1, #0xF8   // Enable the proper bits
	strb r1, [r0]        // Write the updated value

	bx lr // Return from the function
