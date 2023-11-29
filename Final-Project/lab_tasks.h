#ifndef LAB_TASKS_H_
#define LAB_TASKS_H_

// Option 1:
/* Amount of time to toggle blinking of LED in seconds, how many seconds the LED
 * is ON and how many seconds the LED is OFF number of blinks is an entire cycle
 * ON and OFF Must use Timer32
 */
// Enter Combination of RGB (1 - 7):
// Enter Toggle Time:
// Enter Number of Blinks:
// Blinking LED...
// Done

// Option 2:
// No Button pressed, Button 2 pressed, include all buttons that are pressed

// Option 3:
/* Delay must be with SysTick Timer */
// Enter Number of Temperature Reading (1 - 5):
// Reading 1:
// Reading 2:
// ...

// INVALID DATA:
// any invalid menu option will display an error msg
// An invalid RGB value will default to 7
// An invalid temp reading # will default to 5

void rgb_control(void);
void digital_input(void);
void temp_reading(void);

#endif /* LAB_TASKS_H_ */
