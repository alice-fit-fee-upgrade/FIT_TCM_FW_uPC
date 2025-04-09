#include <avr/eeprom.h>

#include "drivers/port_driver.h"
#include "drivers/spi_driver.h"
#include "drivers/clksys_driver.h"

#include "devices/console.h"
#include "devices/attenuator.h"
#include "devices/fpga.h"
#include "devices/si5338.h"
#include "system.h"

struct system_eeprom *p_ee_params = (struct system_eeprom *)MAPPED_EEPROM_START;
struct system_status system_status = {0};
struct system_timers system_timers = {0};

void system_clock_init(void)
{
  CLKSYS_XOSC_Config(OSC_FRQRANGE_12TO16_gc, false, OSC_XOSCSEL_XTAL_16KCLK_gc);
  CLKSYS_Enable(OSC_RC2MEN_bm | OSC_XOSCEN_bm);
  do
  {

  } while (CLKSYS_IsReady(OSC_XOSCRDY_bm) == 0);

  /* PLL: 16MHz x 2 */
  CLKSYS_PLL_Config(OSC_PLLSRC_XOSC_gc, 2);
  CLKSYS_Enable(OSC_PLLEN_bm);
  do
  {

  } while (CLKSYS_IsReady(OSC_PLLRDY_bm) == 0);

  CPU_CCP = CCP_IOREG_gc;
  /* Set PLL as sysclk */
  CLK_CTRL = CLK_SCLKSEL_PLL_gc;
  CLKSYS_Disable(OSC_RC2MEN_bm);

  return;
}

void system_init()
{
    /* Set FPGA_RST high, configure SPI lines */
    fpga_rst_set();
    PORT_SetPinsAsOutput(&PORTB, 0b10000000);
    PORT_SetPinsAsOutput(&PORTC, 0b10110000);
    fpga_cs_deselect();
    PORT_SetPinsAsOutput(&PORTD, 0b00000001);
    
    /* Enable attenuator communication */
    attenuator_uart_enable();

    /* Configure FPGA SPI */
    fpga_init();

    /* TODO: Si5338 settings */
    si5338_bus_status_set(TWI_MASTER_BUSSTATE_IDLE_gc);
    si5338_state_get()->stream = SI5338_STREAM_INIT;
    si5338_state_get()->step = 0;
    si5338_state_get()->slave_cur = SI5338_SL0_ADDR;
    system_status_get()->b_si5338_fail = false;
    
    /*
    ZERO SI5338 ERRORS
    bVar1 = GPIO_GPIOR0;
    GPIO_GPIOR0 = bVar1 & 0b11000111;
    */
    /* Dummy read operation to initiate interrupt driven configuration */
    uint8_t data[] = {0x00};
    TWI_MasterWriteRead(&TWIC, SI5338_SL0_ADDR, data, 1, 1);

    console_print("System init complete!\r\n");

    return;
}

void system_deinit()
{
    /*
  DAT_mem_215c = 0;
  DAT_mem_215d = 0;
  DAT_mem_215b = 0;
  DAT_fpga_comm_request = 0;
  DAT_mem_2185 = 0;
  DAT_mem_2159 = 0;
  DAT_clk_frs = 0;
  PORTE_INTCTRL = 1;
  PORTF_INTCTRL = 2;
  PORTC_INTCTRL = 0;
  PORTD_INTCTRL = 0;
  USARTD0_CTRLB = 0;
  USARTD0_CTRLA = 0;
  PORTB_DIRCLR = 0x80;
  PORTB_OUTSET = 0x10;
  SPIC = 0;
  PORTC_DIRCLR = 0xb0;
  PORTD_DIRCLR = 9;
  PORTD_OUTCLR = 0x10;
  PORTF_DIRCLR = 0x30;
  DAT_mem_2157 = DAT_mem_2157 & 0xef;
  PORTA_OUTSET = 0xa0;
  TWIC_MASTER_CTRLA = 0x48;
  TWIC_MASTER_STATUS = 1;
  */

    return;
}

void system_restart()
{
    system_status.b_si5338_fail = true;
    PORTC_INTCTRL = 0;
    PORTE_INTCTRL = 1;
    PORTA_OUTSET = 0x80;
    PORTB_OUTCLR = 0x80;

    //DAT_clk_frs = DAT_clk_frs & 0b00001110;

    system_timers.ts_si5338.state = 1;
    system_timers.ts_si5338.counter = 100;

    return;
}

struct system_eeprom *system_eeprom_get(void)
{
    return p_ee_params;
}

struct system_status *system_status_get(void)
{
    return &system_status;
}

struct system_timers *system_timers_get(void)
{
    return &system_timers;
}

