.syntax unified
.cpu    cortex-m4
.thumb

.global buzzer_on
.global buzzer_off

// P5.5 for buzzer
// P5.4 for IR
buzzer_on:
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldrb r1, [r0]        // Read the current value of P5->OUT

	// Check if IR is on
	tst r1, #0x20
	bne end_process

	orr  r1, r1, #0x20 // Enable the 5th bit of R1 using Exclusive OR
	strb r1, [r0]      // Store the modified value back to P5->OUT

    push {lr}
    bl ssd_count_down
    pop {lr}

	bx lr // Return from the function

buzzer_off:
	ldr  r0, =0x40004C42 // Address of P5->OUT
	ldrb r1, [r0]        // Read the current value of P5->OUT

	// Check if IR is on
	tst r1, #0x20
	bne end_process

	bic  r1, #0x20 // Disable the 5th bit of R1 using Exclusive OR
	strb r1, [r0]  // Store the modified value back to P5->OUT

    push {lr}
    bl ssd_count_down
    pop {lr}

	bx lr // Return from the function

end_process:
	bx lr // Return from the function
