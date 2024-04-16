.syntax unified
.cpu    cortex-m4
.thumb

.global set_buzzer

// P5.5
set_buzzer:
	<<<<<<< Updated upstream

	// Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	ldr  r0, =0x40004C44
	ldrb r1, [r0]        // Read the current value of P5->DIR
	orr  r1, r1, #0x20   // Set P5.5
	strb r1, [r0]        // Write the updated value back to P5->DIR

	=======
	<<<<<<< Updated upstream
	bx      lr

	=======

	// Load the address of P5->DIR (0x40004C00 + 0x044 = 0x40004C44)
	>>>>>>> Stashed changes
	ldr     r0, =0x40004C42 // Address of P5->OUT
	ldrb    r1, [r0]        // Read the current value of P5->OUT

	// Invert the current value of P5.5
	eor  r1, r1, 0x20 // Toggle the 5th bit of R1 using Exclusive OR
	strb r1, [r0]     // Store the modified value back to P5->OUT

	bx      lr               // Return from the function
	<<<<<<< Updated upstream
	=======
	>>>>>>> Stashed changes
	>>>>>>> Stashed changes
