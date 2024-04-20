.syntax unified
.cpu    cortex-m4
.thumb

.global configure_ssd

// **P4.0**: GPIO (SSD) 0
// **P4.1**: GPIO (SSD) 1
// **P4.2**: GPIO (SSD) 2
// **P4.3**: GPIO (SSD) 3
// **P4.4**: GPIO (SSD) 4
// **P4.5**: GPIO (SSD) 5
// **P4.6**: GPIO (SSD) 6

configure_ssd:
	// SEL0
	ldr  r0, =0x40004C2B // Load the adress of P4->SEL0 (0x40004C00 + 0x02B = 0x40004C2B)
	ldrb r1, [r0]        // Read the current value of P2->SEL0
	bic  r1, r1, #0x7F   // Clear 0->6 bits
	strb r1, [r0]        // Write the updated value back to P4->SEL0

	// SEL1
	ldr  r0, =0x40004C2D // Load the adress of P2->SEL1 (0x40004C00 + 0x02D = 0x40004C2D)
	ldrb r1, [r0]        // Read the current value of P2->SEL1
	bic  r1, r1, #0x7F   // Clear the 0->6 bits
	strb r1, [r0]        // Write the updated value back to P4->SEL1

	// DIR
	ldr  r0, =0x40004C25 // Load the address of P4->DIR (0x40004C00 + 0x25 = 0x40004C25)
	ldrb r1, [r0]        // Read the current value of P4->DIR
	orr  r1, r1, #0x7F   // Set 0->6 bits as IO
	strb r1, [r0]        // Write the updated value back to P4->DIR

	// Turn SSD Off
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	orr  r1, r1, #0x7F   // Clear 0->6 bits, must use orr not bic
	strb r1, [r0]        // Write the updated value back to P4->OUT

	bx lr // Return from the function
