.syntax unified
.cpu    cortex-m4
.thumb

.section .text
.global  delay1_s

delay1_s:
	mov r4, #1000 // Outer loop counter (about 1000 loops)

outer_loop:
	mov r5, #1000 // Inner loop counter (about 1000 * 1000 = 1,000,000 cycles)

inner_loop:
	subs r5, #1     // Decrement inner loop counter
	bne  inner_loop // Branch if not equal to zero

	subs r4, #1     // Decrement outer loop counter
	bne  outer_loop // Branch if not equal to zero

	bx lr // Return from function

