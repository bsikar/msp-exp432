.syntax unified
.cpu    cortex-m4
.thumb

.extern configure_input
.extern configure_output
.extern handle_up
.extern handle_down
.extern handle_left
.extern handle_right
.extern handle_place

.global main

main:
	bl configure_input
	bl configure_output

	// r7 is going to be reserved
	// r7 will have the bit of the dotboard
	// that will be selected for the player to
	// place onto, this is the LOW CS pin
	mov r7, #0xFFEF

	// r8 is going to be reserved
	// r8 is going to have the data for P4->OUT
	ldr r8, =0x40004C23 // P4->OUT (0x40004C00 + 0x023)

	// r9 is going to be reserved
	// r9 is going to have the data for P5->OUT
	ldr r9, =0x40004C42 // P5->OUT (0x40004C00 + 0x042)

loop:
	// Check input and update boards
	// P2.3 to P2.7 is input
	// 0b00001000 -> 0x08 (up)
	// 0b00010000 -> 0x10 (down)
	// 0b00100000 -> 0x20 (left)
	// 0b01000000 -> 0x40 (right)
	// 0b10000000 -> 0x80 (place)
	ldr  r0, =0x40004C01 // P2->IN (0x40004C00 + 0x001)
	ldrb r1, [r0]        // Read the value
	cmp  r1, #0x08       // Check up
	bne  check_down
	bl   handle_up

continue:
	b loop

check_down:
	cmp r1, #0x10
	bne check_left
	bl  handle_down
	b   loop

check_left:
	cmp r1, #0x20
	bne check_right
	bl  handle_left
	b   loop

check_right:
	cmp r1, #0x40
	bne check_place
	bl  handle_right
	b   loop

check_place:
	cmp r1, #0x80
	bne loop
	bl  handle_place
	b   continue
