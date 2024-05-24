.syntax unified
.cpu    cortex-m4
.thumb

.global handle_up
.global handle_down
.global handle_left
.global handle_right
.global handle_place

// r7 is used to store the bit of the correct CS pin to use
handle_up:
	mov r0, #0xFF  // Start with 0xFF
	lsl r0, r0, #1 // Shift left by 1 to make 0x1FE
	add r0, r0, #1 // Add 1 to make 0x1FF
	and r1, r7, r0 // Isolate the first 9 bits in r1 (the original bits)
	mov r2, r1     // Copy the isolated buts to r2
	lsr r1, r1, #3 // Shift right by 3
	lsl r2, r2, #6 // Shift left by (9 - 3) wrapping around
	orr r1, r1, r2 // Combine the shifted and wrapped around bits
	and r1, r1, r0 // Mask out the upper bits to keep only the first 9 bits
	bic r7, r7, r0 // Clear the original first 9 bits in r7
	orr r7, r7, r1 // Place the rotated bits back into r7
	b   tmp_save

handle_down:
	mov r0, #0xFF  // Start with 0xFF
	lsl r0, r0, #1 // Shift left by 1 to make 0x1FE
	add r0, r0, #1 // Add 1 to make 0x1FF
	and r1, r7, r0 // Isolate the first 9 bits in r1 (the original bits)
	mov r2, r1     // Copy the isolated bits to r2
	lsl r1, r1, #3 // Shift left by 3
	lsr r2, r2, #6 // Shift right by (9 - 3) wrapping around
	orr r1, r1, r2 // Combine the shifted and wrapped around bits
	and r1, r1, r0 // Mask out the upper bits to keep the first 9 bits
	bic r7, r7, r0 // Clear the original first 9 bits in r7
	orr r7, r7, r1 // Place the rotated bits back into r7
	b   tmp_save

handle_left:
	// Mask to isolate the 9 bits we care about
	mov r0, #0xFF  // Start with 0xFF
	lsl r0, r0, #1 // Shift left by 1 to make 0x1FE
	add r0, r0, #1 // Add 1 to make 0x1FF

	// Prepare new value for r1 (cleared for new bits)
	mov r4, #0

	// Top row: Rotate bits 8, 7, 6
	// Map: 0x1FE -> 0x1FB, 0x1FD -> 0x1FE, 0x1FB -> 0x1FD
	// Extract top row bits
	and r2, r1, #0x1C0 // Isolate bits 8, 7, 6

	// Rotate manually
	tst   r2, #0x100     // Check if bit 8 is set
	IT    NE
	orrne r4, r4, #0x080 // If set, move to position 7
	tst   r2, #0x080     // Check if bit 7 is set
	IT    NE
	orrne r4, r4, #0x040 // If set, move to position 6
	tst   r2, #0x040     // Check if bit 6 is set
	IT    NE
	orrne r4, r4, #0x100 // If set, move to position 8 (wrapped)

	// Middle row: Rotate bits 5, 4, 3
	// Map: 0x1F7 -> 0x1DF, 0x1EF -> 0x1F7, 0x1DF -> 0x1EF
	// Extract middle row bits
	and r2, r1, #0x038 // Isolate bits 5, 4, 3

	// Rotate manually
	tst   r2, #0x020     // Check if bit 5 is set
	IT    NE
	orrne r4, r4, #0x010 // If set, move to position 4
	tst   r2, #0x010     // Check if bit 4 is set
	IT    NE
	orrne r4, r4, #0x008 // If set, move to position 3
	tst   r2, #0x008     // Check if bit 3 is set
	IT    NE
	orrne r4, r4, #0x020 // If set, move to position 5 (wrapped)

	// Bottom row: Rotate bits 2, 1, 0
	// Map: 0x1BF -> 0x0FF, 0x17F -> 0x1BF, 0x0FF -> 0x17F
	// Extract bottom row bits
	and r2, r1, #0x007 // Isolate bits 2, 1, 0

	// Rotate manually
	tst   r2, #0x004     // Check if bit 2 is set
	IT    NE
	orrne r4, r4, #0x002 // If set, move to position 1
	tst   r2, #0x002     // Check if bit 1 is set
	IT    NE
	orrne r4, r4, #0x001 // If set, move to position 0
	tst   r2, #0x001     // Check if bit 0 is set
	IT    NE
	orrne r4, r4, #0x004 // If set, move to position 2 (wrapped)

	// Update r7 with the new rotated value
	bic r7, r7, r0 // Clear old bits in r7
	orr r7, r7, r4 // Set the new bits

	b tmp_save

handle_right:
	mov r0, #0xFF  // Start with 0xFF
	lsl r0, r0, #1 // Shift left by 1 to make 0x1FE
	add r0, r0, #1 // Add 1 to make 0x1FF
	and r1, r7, r0 // Isolate the first 9 bits in r1 (the original bits)

	// Rotate the top row (Bits 2, 1, 0)
	mov r4, r1         // Copy original bits
	and r4, r4, #0x007 // Isolate top row
	mov r5, r4         // Copy for manipulation
	lsl r4, r4, #1     // Shift left by 1
	and r4, r4, #0x6   // Keep only top two bits
	lsr r5, r5, #2     // Move leftmost bit to the rightmost position
	orr r4, r4, r5     // Combine the shifted bits with the wrapped bit

	// Rotate the middle row (Bits 5, 4, 3)
	mov r3, r1         // Copy original bits
	and r3, r3, #0x038 // Isolate middle row
	lsr r3, r3, #3     // Move bits into lsb position
	mov r4, r3         // Copy for manipulation
	lsl r3, r3, #1     // Shift left by 1
	and r3, r3, #0x6   // Mask off all but the lowest two bits
	lsr r4, r4, #2     // Move leftmost bit to the rightmost position
	orr r3, r3, r4     // Combine the shifted bits with the wrapped bit
	lsl r3, r3, #3     // Shift back to original positions (5, 4, 3)

	// Rotate the bottom row (Bits 8, 7, 6)
	mov r2, r1         // Copy original bits
	and r2, r2, #0x1C0 // Isolate bottom row
	lsr r2, r2, #6     // Bring to lsb position
	mov r3, r2         // Copy for manipulation
	lsl r2, r2, #1     // Shift left by 1
	and r2, r2, #0x6   // Keep only bottom two bits
	lsr r3, r3, #2     // Bring leftmost bit of original to the rightmost position
	orr r2, r2, r3     // Combine the shifted bits with the wrapped bit
	lsl r2, r2, #6     // Shift back to original positions (8, 7, 6)

	// Combine all rotated rows back into r1
	bic r1, r1, r0 // Clear old bits in r1
	orr r1, r1, r4 // Put in new rotated top row bits
	orr r1, r1, r3 // Put in new rotated middle row bits
	orr r1, r1, r2 // Put in new rotated bottom row bits

	// Update r7 with the new rotated value
	bic r7, r7, r0 // Clear old bits in r7
	orr r7, r7, r1 // Set the new bits

	b tmp_save

tmp_save:
	// Save the first 8 bits of r7 to r0
	ldr  r0, =0x40004C23 // P4->OUT (0x40004C00 + 0x023)
	and  r0, r7, #0xFF   // Mask to get the first 8 bits of r7
	strb r0, [r0]        // Store the lower byte into the ptr of r0

	// Save the second 8 bits of r7 to r0
	ldr  r0, =0x40004C42 // P5->OUT (0x40004C00 + 0x042)
	lsl  r0, r7, #8      // Shift r7 by 8 bits to get the 2nd set of 8
	and  r0, r0, #0xFF   // Mask to get only the new lower 8 bits
	strb r0, [r0]        // Store the lower byte into the ptr of r0
	bx   lr

handle_place:
	// Save the first 8 bits of r7 to r8 (P4->OUT)
	and  r0, r7, #0xFF // Mask to get the first 8 bits of r7
	strb r0, [r8]      // Store the lower byte into the ptr of r0

	// Save the second 8 bits of r7 to r9 (P5->OUT)
	lsl  r0, r7, #8    // Shift r7 by 8 bits to get the 2nd set of 8
	and  r0, r0, #0xFF // Mask to get only the new lower 8 bits
	strb r0, [r9]      // Store the lower byte into the ptr of r0

	mov r7, #0xFFEF
	bx  lr
