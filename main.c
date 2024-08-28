#include <avr/io.h>
#include <util/delay.h>
#include <stdbool.h>

#include "avr_compiler.h"
#include "drivers/clksys_driver.h"

#include "console.h"
#include "io.h"
#include "timer.h"

extern struct timer_state ts_fpga;
extern struct timer_state ts_attenuator;
extern struct timer_state ts_si5338;

static void sysclk_init(void)
{
    CLKSYS_XOSC_Config(OSC_FRQRANGE_12TO16_gc, false, OSC_XOSCSEL_XTAL_16KCLK_gc);
    CLKSYS_Enable(OSC_RC2MEN_bm | OSC_XOSCEN_bm);
    do {} while (CLKSYS_IsReady(OSC_XOSCRDY_bm) == 0);

    // PLL: 16MHz x 2
    CLKSYS_PLL_Config(OSC_PLLSRC_XOSC_gc, 2);
    CLKSYS_Enable(OSC_PLLEN_bm);
    do {} while (CLKSYS_IsReady(OSC_PLLRDY_bm) == 0);

    // Set PLL as sysclk
    CPU_CCP = CCP_IOREG_gc;
    CLK_CTRL = CLK_SCLKSEL_PLL_gc;
    CLKSYS_Disable(OSC_RC2MEN_bm);
    
    return;
}

/*! \brief Main loop of the TCM ATxmega MCU code
 *
 * This function:
 * 1. Configures the MCU (io, usart, twi, etc.),
 * 2. Sets up configuration structs
 * 3. Sets up ADT7311
 * 4. Loads configuration from EEPROM
 * 5. Sends interface ready message via USART
 * 6. Starts main loop consisting of:
 *   a. communicating with FPGA (on FPGA request)
 *   b. parsing incoming USART msgs
 */
int main(void)
{
    sysclk_init();
    io_init();

    //TWIC_MASTER_BAUD = 0x23;
    //TWIC_MASTER_CTRLA = 0x48;
    //TWIC_MASTER_STATUS = 1;

    //USARTD0_BAUDCTRLB = 0x40;
    //USARTD0_BAUDCTRLA = 0xc;
    //USARTD0_CTRLC = 3;

    timer_init();
    console_init();

    NVM_CTRLB = 0b00001000;

    /* Check 5V supply status */
    if(io_is_5v_present())
    {
        timer_tc_set_state(&ts_fpga, 1);
        timer_tc_set_value_ms(&ts_fpga, 2000);
    }
    else
    {

    }
    
    /* Set attenuator timer */
    timer_tc_set_value_ms(&ts_fpga, 1000);

    // Enable PORTE INTCTRL level LOW
    // Enable PORTF INTCTRL level MED

    /* Enable PMIC interrupt level low & med. */
	PMIC.CTRL |= (PMIC_LOLVLEX_bm | PMIC_MEDLVLEX_bm);
    sei();
    nop();

    // Set ADT7311
    // Get settings from EEPROM
    // Set PORTB according to EEPROM

    /* Send welcome message */ 
    console_send("INR TCM control interface ready\r\n");
    console_cts_set();

    do 
    {
        do 
        {
            nop();
        }
        while (true);
        
    }
    while(true);

    /* Should never get here */
    return 0;
}
