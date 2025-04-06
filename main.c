#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdbool.h>

#include "avr_compiler.h"

#include "drivers/adt_spi_driver.h"
#include "drivers/clksys_driver.h"
#include "drivers/eeprom_driver.h"
#include "drivers/pmic_driver.h"

#include "devices/console.h"
#include "devices/adt7311.h"
#include "devices/attenuator.h"
#include "devices/fpga.h"
#include "devices/si5338.h"

#include "io.h"
#include "system.h"

extern bool fpga_comm_request;

extern volatile bool b_report_rdy;
extern volatile uint16_t report_cnt;

struct adt_spi_desc adt7311_spi_desc =
{
  .cs_port = &PORTA,
  .cs_pin = PIN4_bm,
  .spi_port = &PORTA,
  .miso_pin = PIN2_bp,
  .mosi_pin = PIN3_bm,
  .clk_pin = PIN1_bm
};

uint8_t adt7311_config_reg = 
  ((ADT7311_FLTQ_1_FAULT << ADT7311_CF_REG_FLTQ_bp) & ADT7311_CF_REG_FLTQ_bm) |\
  ((ADT7311_CTPP_LO << ADT7311_CF_REG_CTPP_bp) & ADT7311_CF_REG_CTPP_bm) |\
  ((ADT7311_INTPP_LO << ADT7311_CF_REG_INTPP_bp) & ADT7311_CF_REG_INTPP_bm) |\
  ((ADT7311_ICMODE_COMP << ADT7311_CF_REG_ICMODE_bp) & ADT7311_CF_REG_ICMODE_bm) |\
  ((ADT7311_OP_MODE_1_SPS << ADT7311_CF_REG_OPMODE_bp) & ADT7311_CF_REG_OPMODE_bm) |\
  ((ADT7311_RES_13BIT << ADT7311_CF_REG_RES_bp) & ADT7311_CF_REG_RES_bm);


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
  system_clock_init();

  io_init();

  si5338_init();

  attenuator_init();

  console_init();

  timer_init();

  EEPROM_EnableMapping();

  /* Check 5V supply status */
  if (io_is_12v_present())
  {
    system_status_get()->b_sys_fail = false;
    timer_tc_set_state(&system_timers_get()->ts_fpga, 1);
    timer_tc_set_value_ms(&system_timers_get()->ts_fpga, 2000);
  }
  else
  {
    system_status_get()->b_sys_fail = true;
    io_led_system_fail_update();
  }

  /* Set attenuator timer */
  timer_tc_set_value_ms(&system_timers_get()->ts_attenuator, 1000);

  /* Enable FPGA PORTE.0 INT1 level LOW */
  fpga_req_intr_enable();

  /* Enable PWR status INT0 level LOW */
  io_enable_pwr_interrupt();

  /* Enable console CTS interrupt level MED */
  console_cts_enable();

  /* Enable PMIC interrupt level low & med. */
  PMIC_EnableLowLevel();
  PMIC_EnableMediumLevel();
  sei();

  adt7311_init(&adt7311_spi_desc, adt7311_config_reg);

  /* Set attenuator PORTB according to EEPROM settings*/
  io_attenuator_port_set(system_eeprom_get()->attenuator_portb_config);

  /* Send welcome message */
  console_print("\r\nINR TCM control interface ready\r\n");
  console_rts_clr();

  do
  {
    do
    {
      if (b_report_rdy)
      {
        b_report_rdy = false;
        console_print("FPGA: %d, %d\r\n", system_timers_get()->ts_fpga.state, system_timers_get()->ts_fpga.counter);
        console_print("Si5338: %d, %d\r\n", system_timers_get()->ts_si5338.state, system_timers_get()->ts_si5338.counter);
        //uint16_t data;
        //fpga_exchange_data(0xF2, &data);
        //console_print("MSG: %x \r\n", data);
        float temp = 0;
        uint8_t temp_flags = 0;
        temp = adt7311_temperature_get(&temp_flags);
        console_print("TEMP: %f, flags: %x \r\n\r\n", temp, temp_flags);
        report_cnt = 2000;
      }
    } while (true);

  } while (true);

  /* Should never get here */
  return 0;
}
