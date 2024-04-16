.syntax unified
.cpu    cortex-m4
.thumb

.global set_led

set_led:
	ldr r0, =0x40004C03 // Load the address of P2->OUT (0x40004C00 + 0x03 = 0x40004C03)
	ldrb r1, [r0]       // Read the current value of P2->OUT
    eor r1, #0x03       // Make LED yellow
	strb r1, [r0]       // Write the updated value back to P2->OUT

    bx lr               // Return from the function

