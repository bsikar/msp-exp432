.syntax unified
.cpu    cortex-m4
.thumb

.extern ssd_count_down

.global buzzer_on
.global buzzer_off

// P5.5 for buzzer
// P5.4 for IR
buzzer_on:
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldr  r1, =0x40004C40 // Address of P5->IN
	ldrb r2, [r0]        // Read the current value of P5->OUT
	ldrb r3, [r1]        // Read the current value of P5->IN

	// Check if IR is on
	// tst r3, #0x10
	// bne end_process

	orr  r2, r2, #0x20  // Enable the 5th bit
	strb r2, [r0]       // Store the modified value back to P5->OUT
	b    ssd_count_down

buzzer_off:
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldr  r1, =0x40004C40 // Address of P5->IN
	ldrb r2, [r0]        // Read the current value of P5->OUT
	ldrb r3, [r1]        // Read the current value of P5->IN

	// Check if IR is on
	// tst r3, #0x10
	// bne end_process

	bic  r2, r2, #0x20  // Disable the 5th bit
	strb r2, [r0]       // Store the modified value back to P5->OUT
	b    ssd_count_down

end_process:
	bx lr // Return from the function
