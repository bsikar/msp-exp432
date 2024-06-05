.syntax unified
.cpu    cortex-m4
.thumb

.global led1_on
.global led1_off

led1_on:
	ldr  r0, =0x40004C02 // Load the address of P1->OUT (0x40004C00 + 0x02 = 0x40004C02)
	ldrb r1, [r0]        // Read the current value of P1->OUT
	orr  r1, r1, #0x01   // Enable LED
	strb r1, [r0]        // Write the updated value back to P1->OUT

	bx lr // Return from the function

led1_off:
	ldr  r0, =0x40004C02 // Load the address of P1->OUT (0x40004C00 + 0x02 = 0x40004C02)
	ldrb r1, [r0]        // Read the current value of P1->OUT
	bic  r1, r1, #0x01   // Disable LED
	strb r1, [r0]        // Write the updated value back to P1->OUT

	bx lr // Return from the function

