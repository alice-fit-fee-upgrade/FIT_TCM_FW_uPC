#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdbool.h>


#include "avr_compiler.h"
#include "drivers/clksys_driver.h"
#include "drivers/eeprom_driver.h"
#include "drivers/pmic_driver.h"

#include "console.h"
#include "io.h"
#include "timer.h"

extern struct timer_state ts_fpga;
extern struct timer_state ts_attenuator;
extern struct timer_state ts_si5338;

struct eeprom_params {
  uint8_t ip_addr[4];
  uint8_t mac_addr[6];
};

struct eeprom_params *p_params = (struct eeprom_params *)MAPPED_EEPROM_START;

static void sysclk_init(void)
{
    CLKSYS_XOSC_Config(OSC_FRQRANGE_12TO16_gc, false, OSC_XOSCSEL_XTAL_16KCLK_gc);
    CLKSYS_Enable(OSC_RC2MEN_bm | OSC_XOSCEN_bm);
    do {} while (CLKSYS_IsReady(OSC_XOSCRDY_bm) == 0);

    /* PLL: 16MHz x 2 */
    CLKSYS_PLL_Config(OSC_PLLSRC_XOSC_gc, 2);
    CLKSYS_Enable(OSC_PLLEN_bm);
    do {} while (CLKSYS_IsReady(OSC_PLLRDY_bm) == 0);

    CPU_CCP = CCP_IOREG_gc;
    /* Set PLL as sysclk */
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

  TWIC_MASTER_BAUD = 0x23;
  TWIC_MASTER_CTRLA = 0x48;
  TWIC_MASTER_STATUS = 1;

  USARTD0_BAUDCTRLB = 0x40;
  USARTD0_BAUDCTRLA = 0xc;
  USARTD0_CTRLC = 3;

  console_init();
  timer_init();

  EEPROM_EnableMapping();

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

  // TODO: Enable PORTE INTCTRL level LOW
  console_cts_enable();

  /* Enable PMIC interrupt level low & med. */
  PMIC_EnableLowLevel();
  PMIC_EnableMediumLevel();
  sei();

  // TODO: Set ADT7311
  // TODO: Get settings from EEPROM
  // TODO: Set PORTB according to EEPROM

  /* Send welcome message */ 
  console_print("\r\nINR TCM control interface ready\r\n");

  console_print(
    "MAC ADDRESS: %02X:%02X:%02X:%02X:%02X:%02X\r\n", 
    p_params->mac_addr[0],
    p_params->mac_addr[1],
    p_params->mac_addr[2],
    p_params->mac_addr[3],
    p_params->mac_addr[4],
    p_params->mac_addr[5]
    );

  console_print(
    "IP ADDRESS: %d.%d.%d.%d\r\n", 
    p_params->ip_addr[0],
    p_params->ip_addr[1],
    p_params->ip_addr[2],
    p_params->ip_addr[3]
    );
  
  console_rts_clr();

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
