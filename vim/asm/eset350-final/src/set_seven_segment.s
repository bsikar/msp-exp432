.syntax unified
.cpu    cortex-m4
.thumb

.global ssd_clear
.global ssd0_on
.global ssd1_on
.global ssd2_on
.global ssd3_on
.global ssd4_on
.global ssd5_on

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

ssd_clear:
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	orr  r1, #0x7F       // Clear the 0->6 Bits
	strb r1, [r0]        // Write the updated value back to P4->OUT

	bx lr // Return from the function

ssd0_on:
    push {lr}
    bl ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x3F   // Enable 0b0111111 = 0x3F
	strb r1, [r0]        // Write the updated value back to P4->OUT
    pop {lr}
	bx lr // Return from the function

ssd1_on:
    push {lr}
    bl ssd_clear
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x3    // Enable 0b0000011 = 0x3
	strb r1, [r0]        // Write the updated value back to P4->OUT
    pop {lr}
	bx lr // Return from the function

ssd2_on:
    push {lr}
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x5E   // Enable 0b1011110 = 0x5E
	strb r1, [r0]        // Write the updated value back to P4->OUT
    pop {lr}
	bx lr // Return from the function

ssd3_on:
    push {lr}
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x4F   // Enable 0b1001111 = 0x4F
	strb r1, [r0]        // Write the updated value back to P4->OUT
    pop {lr}
	bx lr // Return from the function

ssd4_on:
    push {lr}
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x63   // Enable 0b1100011 = 0x63
	strb r1, [r0]        // Write the updated value back to P4->OUT
    pop {lr}
	bx lr // Return from the function

ssd5_on:
    push {lr}
	ldr  r0, =0x40004C23 // Load the address of P4->OUT (0x40004C00 + 0x23 = 0x40004C23)
	ldrb r1, [r0]        // Read the current value of P4->OUT
	bic  r1, r1, #0x6D   // Enable 0b1101101 = 0x6D
	strb r1, [r0]        // Write the updated value back to P4->OUT
    pop {lr}
	bx lr // Return from the function
