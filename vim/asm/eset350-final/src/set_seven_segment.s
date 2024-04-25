.syntax unified
.cpu    cortex-m4
.thumb

.extern delay1_s
.extern led1_on
.extern led1_off

.global ssd_count_down

// **P4.0**: GPIO (SSD) 0
// **P4.1**: GPIO (SSD) 1
// **P4.2**: GPIO (SSD) 2
// **P4.3**: GPIO (SSD) 3
// **P4.4**: GPIO (SSD) 4
// **P4.5**: GPIO (SSD) 5
// **P4.6**: GPIO (SSD) 6
// **P4.7**: Wait Signal

/// NOTE: The 7-Segments are LOW enabled, when "Clear" a HIGH is sent
/// When a LOW is sent the SSD is ON

ssd_count_down:
	push {lr}

	bl led1_on
	bl ssd5_on
	bl delay1_s

	bl led1_off
	bl ssd4_on
	bl delay1_s

	bl led1_on
	bl ssd3_on
	bl delay1_s

	bl led1_off
	bl ssd2_on
	bl delay1_s

	bl led1_on
	bl ssd1_on
	bl delay1_s

	bl led1_off
	bl ssd0_on
	bl delay1_s

	bl led1_on
	bl ssd_clear

	pop {lr}
	bx  lr

ssd_clear:
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	orr  r1, #0x7F       // Clear the 0->6 Bits
	strb r1, [r0]        // Write the updated value back to P4->OUT
	bx   lr              // Return from the function

ssd0_on:
	push {lr}
	bl   ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x7E   // Enable
	strb r1, [r0]        // Write the updated value back to P4->OUT
	pop  {lr}
	bx   lr              // Return from the function

ssd1_on:
	push {lr}
	bl   ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x60   // Enable
	strb r1, [r0]        // Write the updated value back to P4->OUT
	pop  {lr}
	bx   lr              // Return from the function

ssd2_on:
	push {lr}
	bl   ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x3D   // Enable
	strb r1, [r0]        // Write the updated value back to P4->OUT
	pop  {lr}
	bx   lr              // Return from the function

ssd3_on:
	push {lr}
	bl   ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x79   // Enable
	strb r1, [r0]        // Write the updated value back to P4->OUT
	pop  {lr}
	bx   lr              // Return from the function

ssd4_on:
	push {lr}
	bl   ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x63   // Enable
	strb r1, [r0]        // Write the updated value back to P4->OUT
	pop  {lr}
	bx   lr              // Return from the function

ssd5_on:
	push {lr}
	bl   ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x5B   // Enable
	strb r1, [r0]        // Write the updated value back to P4->OUT
	pop  {lr}
	bx   lr              // Return from the function
