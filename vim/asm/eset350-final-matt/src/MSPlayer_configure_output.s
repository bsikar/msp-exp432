.syntax unified
.cpu    cortex-m4
.thumb

.global configure_output

configure_output:
	// NOTE: The dotboards are LOW enabled
	// So to turn them off the need to be high

	// P4.0 is output, display board 1 (top left)        | 24 -> 39 (VN)
	// P4.1 is output, display board 2 (top middle)      | 5  -> 36 (VP)
	// P4.2 is output, display board 3 (top right)       | 25 -> 35
	// P4.3 is output, display board 4 (middle left)     | 6  -> 34
	// P4.4 is output, display board 5 (middle middle)   | 26 -> 33
	// P4.5 is output, display board 6 (middle right)    | 27 -> 32
	// P4.6 is output, display board 7 (bottom left)     | 8  -> 27
	// P4.7 is output, display board 8 (bottom middle)   | 28 -> 26
	// P5.0 is output, display board 9 (bottom right)    | 13 -> 25
	// P5.1 is output that goes to the dotboard esp      | 33 -> 23
	//      This is used to send a high signal that says
	//      To lock in the players move and switch to the
	//      next player
	//
	// The esp will try and set an X or an O to all the
	// dotboards, but by using P4.0-P5.0 the correct
	// board will be active and all others will be inactive.
	// This will place the correct X or O on the right spot

	////////////////////////////////////////
	// P4.x
	////////////////////////////////////////
	// 0b11111111 -> 0xFF
	// SEL0
	ldr  r0, =0x40004C2B // P4->SEL0 (0x40004C00 + 0x02B)
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0xFF   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// SEL1
	ldr  r0, =0x40004C2D // P4->SEL1 (0x40004C00 + 0x02D)
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0xFF   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// DIR
	ldr  r0, =0x40004C25 // P4->DIR (0x40004C00 + 0x025)
	ldrb r1, [r0]        // Read the value
	orr  r1, r1, #0xFF   // Set the proper bits
	strb r1, [r0]        // Write the updated value

	// Disable CS for the boards
	ldr  r0, =0x40004C23 // P4->OUT (0x40004C00 + 0x023)
	ldrb r1, [r0]        // Read the value
	orr  r1, r1, #0xFF   // disbale
	strb r1, [r0]        // Write the updated value

	////////////////////////////////////////
	// P5.x
	////////////////////////////////////////
	// 0b00000011 -> 0x03
	// SEL0
	ldr  r0, =0x40004C4A // P5->SEL0 (0x40004C00 + 0x04A)
	ldrb r1, [r0]        // Read the value
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0x03   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// SEL1
	ldr  r0, =0x40004C4C // P5->SEL1 (0x40004C00 + 0x04C)
	ldrb r1, [r0]        // Read the value
	ldrb r1, [r0]        // Read the value
	bic  r1, r1, #0x03   // Clear the proper bits
	strb r1, [r0]        // Write the updated value

	// DIR
	ldr  r0, =0x40004C44 // P5->DIR (0x40004C00 + 0x044)
	ldrb r1, [r0]        // Read the value
	orr  r1, r1, #0x03   // Set the proper bits
	strb r1, [r0]        // Write the updated value

	// Disable CS for the boards
	ldr  r0, =0x40004C42 // P5->OUT (0x40004C00 + 0x042)
	ldrb r1, [r0]        // Read the value
	orr  r1, r1, #0x03   // disbale
	strb r1, [r0]        // Write the updated value

	bx lr // Return from the function
