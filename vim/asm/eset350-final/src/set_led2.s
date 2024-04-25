.syntax unified
.cpu    cortex-m4
.thumb

.extern ssd_count_down

.global led2_on
.global led2_off

led2_on:
	ldr  r0, =0x40004C03 // Load the address of P2->OUT (0x40004C00 + 0x03 = 0x40004C03)
	ldrb r1, [r0]        // Read the current value of P2->OUT
	orr  r1, r1, #0x03   // Enable LED yellow
	strb r1, [r0]        // Write the updated value back to P2->OUT
	b    ssd_count_down

led2_off:
	ldr  r0, =0x40004C03 // Load the address of P2->OUT (0x40004C00 + 0x03 = 0x40004C03)
	ldrb r1, [r0]        // Read the current value of P2->OUT
	bic  r1, r1, #0x03   // Disable LED yellow
	strb r1, [r0]        // Write the updated value back to P2->OUT
	b    ssd_count_down

