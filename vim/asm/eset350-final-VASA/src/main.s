// File: main.s
// Description: Toggles an LED connected to P2 on MSP432 with a delay loop.
// Target: MSP432P41111
// Author: Brighton Sikarskie
// Date: 2.4.2024

.thumb
.syntax unified

.equ PORT2_SEL0_ADDR, 0x40004c0b
.equ PORT2_SEL1_ADDR, 0x40004c0d
.equ PORT2_DIR_ADDR, 0x40004c05
.equ PORT2_OUT_ADDR, 0x40004c03
.equ RED_LED_ON, 0x0001
.equ DELAY_VALUE, 0x30d40

.global  main
.section .text

main:
	// SET P2->SEL0
	ldr  r0, =PORT2_SEL0_ADDR
	mov  r1, #0x0000
	strh r1, [r0]

	// SET P2->SEL1
	ldr  r0, =PORT2_SEL1_ADDR
	mov  r1, #0x0000
	strh r1, [r0]

	// SET P2->DIR
	ldr  r0, =PORT2_DIR_ADDR
	mov  r1, #RED_LED_ON        
	strh r1, [r0]

loop:
	// TOGGLE P2->OUT
	ldr  r0, =PORT2_OUT_ADDR // Assuming this is the output data register
	ldrh r1, [r0]            // Load current state of the output register
	eors r1, r1, #1          // Toggle the least significant bit
	strh r1, [r0]            // Write back to output data register

	// Load delay value
	ldr r2, =delay_value
	ldr r2, [r2]         // Load the value of delay_value into r2

delay_loop:
	subs r2, r2, #1 // Decrement delay counter
	bne  delay_loop // If not yet zero, loop

	b loop // Repeat the toggle and delay

	.section .data

delay_value:
	.word DELAY_VALUE

