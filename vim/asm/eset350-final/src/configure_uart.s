.syntax unified
.cpu    cortex-m4
.thumb

.global configure_uart

/* P3->SEL0 |= 0x04
 * P3->SEL1 &= ~0x04
 */
configure_uart:
	ldr r0, =0x40004C20 // Load base address of Port 3 GPIO registers

	// Modify P3SEL0
	ldrb r1, [r0, #0x0A] // Load current value of P3SEL0 as byte
	orr  r1, r1, #0x04   // Set bit 2 (P3.2) to 1 in P3SEL0
	strb r1, [r0, #0x0A] // Store modified value back to P3SEL0 as byte

	// Modify P3SEL1
	ldrb r1, [r0, #0x0C] // Load current value of P3SEL1 as byte
	bic  r1, r1, #0x04   // Clear bit 2 (P3.2) in P3SEL1
	strb r1, [r0, #0x0C] // Store modified value back to P3SEL1 as byte

	// Configure UART
	ldr  r0, =0x40001804 // Load the address of EUSCI_A2->CTLW0 into R0
	ldrb r1, [r0]        // Load the value at EUSCI_A2->CTLW0 into R1
	orr  r1, r1, #0x0001 // Set the SWRST bit (bit 0)
	strb r1, [r0]        // Store the modified value back to EUSCI_A2->CTLW0

	ldr  r0, =0x40001800 // Load the address of EUSCI_A2->CTLW0 into R0
	ldrh r1, [r0]        // Load the halfword value from CTLW0 into R1
	orr  r1, r1, #0x0001 // Set the SWRST bit
	orr  r1, r1, #0x0080 // Set the clock source to SMCLK
	strh r1, [r0]        // Store the modified value back to CTLW0

	// Baud Rate calculation: Assuming SMCLK = 3MHz, Baud rate = 9600
	ldr  r0, =0x40001806 // Load the address of EUSCI_A2->BRW into R0
	movs r1, #312        // Move the value 312 into R1
	str  r1, [r0]        // Store the value from R1 into the address stored in R0

	ldr  r0, =0x40001808 // Load the address of EUSCI_A2->MCTLW into R0
	mov  r1, #8          // Load the number 8 into R1 (BRF value)
	lsl  r1, r1, #4      // Left shift R1 by 4 bits to place it in the BRF field
	orr  r1, r1, #0x0001 // OR R1 with 0x0001 to set the OS16 bit
	orr  r1, r1, #0x2000 // OR R1 with 0x2000 to set the additional configuration bits
	strh r1, [r0]        // Store the halfword in R1 to MCTLW

	// Initialize eUSCI
	ldr  r0, =0x40001800 // Load the address of EUSCI_A2->CTLW0 into R0
	ldrh r1, [r0]        // Load the halfword value from CTLW0 into R1
	bic  r1, r1, #0x0001 // Clear the SWRST bit in R1
	strh r1, [r0]        // Store the modified halfword value back to CTLW0

	bx lr // Return from the subroutine
