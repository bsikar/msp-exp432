.syntax unified
.cpu cortex-m4
.thumb

.global process_rx_char

process_rx_char:
    ldr r0, =0x4000180C        // Address of EUSCI_A2->RXBUF
    ldrb r1, [r0]              // Load the received character into r1

    ldr r2, =0x40004C03        // Address of P2->OUT, corrected to proper address
    ldrb r3, [r2]              // Load current state of P2->OUT into r3

    // Check if RX interrupt flag is set
    ldr r4, =0x4000180A        // Address of EUSCI_A2->IFG register
    ldrh r5, [r4]              // Load interrupt flags
    tst r5, #0x0001            // Test RX interrupt flag
    bne rx_interrupt           // If RX interrupt flag is set, handle it

    b end_process              // Branch to end_process

rx_interrupt:
    // Handle normal character processing here
    cmp r1, #'R'               // Compare received character with 'R'
    beq set_R                  // If equal, branch to set_R
    cmp r1, #'G'               // Compare received character with 'G'
    beq set_G                  // If equal, branch to set_G
    cmp r1, #'B'               // Compare received character with 'B'
    beq set_B                  // If equal, branch to set_B

    // None of the conditions met, clear all LEDs
    movs r3, #0                // Prepare r3 to clear the bits
    strb r3, [r2]              // Store the cleared state to P2->OUT

    b end_process              // Branch to end_process

set_R:
    movs r3, #0x01             // Set only BIT0 for Red LED (P2.0)
    strb r3, [r2]              // Store the result to P2->OUT
    b end_process              // Branch to end_process

set_G:
    movs r3, #0x02             // Set only BIT1 for Green LED (P2.1)
    strb r3, [r2]              // Store the result to P2->OUT
    b end_process              // Branch to end_process

set_B:
    movs r3, #0x04             // Set only BIT2 for Blue LED (P2.2)
    strb r3, [r2]              // Store the result to P2->OUT

end_process:
    bx lr                      // Return from the subroutine

