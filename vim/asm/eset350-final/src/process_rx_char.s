.syntax unified
.cpu    cortex-m4
.thumb

.section .text
.global  process_rx_char
.extern  led_on
.extern  led_off
.extern  buzzer_on
.extern  buzzer_off
.extern  ssd0_on
.extern  ssd1_on
.extern  ssd2_on
.extern  ssd3_on
.extern  ssd4_on
.extern  ssd5_on

// Constant for 1-second delay loop counter
const_1second: .word 3000000

// Jump table for function pointers based on character input
jump_table:
    .word led_on     // Index 0 - Function for turning LED on
    .word led_off    // Index 1 - Function for turning LED off
    .word buzzer_on  // Index 2 - Function for turning buzzer on
    .word buzzer_off // Index 3 - Function for turning buzzer off

// SSD function table (addresses need to be filled in based on your function definitions)
ssd_functions:
    .word ssd5_on
    .word ssd4_on
    .word ssd3_on
    .word ssd2_on
    .word ssd1_on
    .word ssd0_on

process_rx_char:
    push {lr}         // Save context

    ldr  r0, =0x4000180C  // Address of EUSCI_A2->RXBUF
    ldrb r1, [r0]         // Load the received character into r1

    sub  r1, r1, #'0'     // Convert ASCII to integer
    cmp  r1, #3           // Check if character is within range 0 to 3
    bhi  skip_to_countdown // If invalid, skip to SSD countdown

    lsl  r1, r1, #2       // Multiply index by 4 to get offset in jump table
    ldr  r4, =jump_table  // Base address of jump table
    ldr  r5, [r4, r1]     // Load function address from jump table based on index
    blx  r5               // Call the function indirectly

skip_to_countdown:
    // SSD Countdown logic
    mov  r1, #6           // Initialize counter for SSD countdown (6 entries)

countdown_loop:
    lsl  r2, r1, #2       // Multiply counter by 4 to access correct SSD function
    ldr  r3, =ssd_functions // Base address of SSD function table
    ldr  r5, [r3, r2]     // Load SSD function address based on counter
    blx  r5               // Call the SSD function indirectly

    // Call delay (each function must properly return here after execution)
    bl   delay_1_second   // Call delay
    subs r1, r1, #1       // Decrement the counter
    bne  countdown_loop   // If not zero, repeat loop

end_process:
    pop  {lr}
    bx   lr               // Return from the process

// Define the 1-second delay function
delay_1_second:
    ldr  r0, =const_1second

delay_loop:
    subs r0, r0, #1       // Decrement the counter
    bne  delay_loop       // Continue looping until zero
    bx   lr               // Return from the function

