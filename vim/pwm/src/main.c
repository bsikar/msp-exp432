#include <ti/devices/msp432p4xx/driverlib/driverlib.h>

int main(void) {
  /* Stop Watchdog Timer */
  WDT_A_holdTimer();

  /* Set DCO (Digital Controlled Oscillator) to 12 MHz, this will be the source
   * for MCLK and SMCLK */
  CS_setDCOCenteredFrequency(CS_DCO_FREQUENCY_12);

  /* Set MCLK and SMCLK to use DCO as source, no division */
  CS_initClockSignal(CS_MCLK, CS_DCOCLK_SELECT, CS_CLOCK_DIVIDER_1);
  CS_initClockSignal(CS_SMCLK, CS_DCOCLK_SELECT, CS_CLOCK_DIVIDER_1);

  /* Set P2.4 as Timer_A output for PWM */
  GPIO_setAsPeripheralModuleFunctionOutputPin(GPIO_PORT_P2, GPIO_PIN4,
                                              GPIO_PRIMARY_MODULE_FUNCTION);

  /* Configure Timer_A for PWM */
  Timer_A_PWMConfig pwm_config = {
      TIMER_A_CLOCKSOURCE_SMCLK,     // SMCLK as clock source
      TIMER_A_CLOCKSOURCE_DIVIDER_1, // Divider = 1
      (12000000 / 100000.0) - 1,     // Period for 100 kHz PWM with 12MHz SMCLK
      TIMER_A_CAPTURECOMPARE_REGISTER_1,  // Use CCR1 for PWM
      TIMER_A_OUTPUTMODE_RESET_SET,       // PWM output mode
      ((12000000 / 100000.0) - 1) * 0.725 // Duty cycle = 72.5%
  };

  /* Generate PWM */
  Timer_A_generatePWM(TIMER_A0_BASE, &pwm_config);

  /* Enter low power mode */
  while (1) { PCM_gotoLPM0(); }
}
