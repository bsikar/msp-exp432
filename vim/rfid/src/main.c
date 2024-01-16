#include <ti/devices/msp432p4xx/driverlib/driverlib.h>

// investigate the values
// for GPIO_write -> GPIO_init -> GPIOMSP432_config ->
//
// typedef struct {
//    /*! Pointer to the board's GPIO_PinConfig array */
//    GPIO_PinConfig  *pinConfigs;
//
//    /*! Pointer to the board's GPIO_CallbackFxn array */
//    GPIO_CallbackFxn  *callbacks;
//
//    /*! number of GPIO_PinConfigs defined */
//    uint32_t numberOfPinConfigs;
//
//    /*! number of GPIO_Callbacks defined */
//    uint32_t numberOfCallbacks;
//
//    /*!
//     *  Interrupt priority used for call back interrupts
//     *
//     *  intPriority is the interrupt priority, as defined by the
//     *  underlying OS.  It is passed unmodified to the underlying OS's
//     *  interrupt handler creation code, so you need to refer to the OS
//     *  documentation for usage.  If the driver uses the ti.dpl
//     *  interface instead of making OS calls directly, then the HwiP port
//     *  handles the interrupt priority in an OS specific way.  In the case
//     *  of the SYS/BIOS port, intPriority is passed unmodified to
//     Hwi_create().
//     *
//     *  A setting of ~0 will configure the lowest possible priority.
//     */
//    uint32_t intPriority;
// } GPIOMSP432_Config;
//
// -> .pinConfigs
// inside that struct find the values and see where they point
// then find what in lib/mfrc522.h (CONFIG_GPIO_CS_PIN) is it 7 or 5 or
// something else (gdb)

int main(void) {}
