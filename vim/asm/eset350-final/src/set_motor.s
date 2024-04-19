.syntax unified
.cpu    cortex-m4
.thumb

.global motor_on
.global motor_off

// P5.6
motor_on:
	// Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldrb r1, [r0]        // Read the current value of P5->OUT

	orr  r1, r1, #0x40 // Enable the 5th bit of R1 using Exclusive OR
	strb r1, [r0]      // Store the modified value back to P5->OUT

	bx lr // Return from the function

motor_off:
	// Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldrb r1, [r0]        // Read the current value of P5->OUT

	bic  r1, #0x40 // Disable the 5th bit of R1 using Exclusive OR
	strb r1, [r0]  // Store the modified value back to P5->OUT

	bx lr // Return from the function
