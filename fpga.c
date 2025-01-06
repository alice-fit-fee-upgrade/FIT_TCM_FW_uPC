#include <avr/interrupt.h>
#include <avr/io.h>
#include <stdbool.h>

#include "drivers/spi_driver.h"

#include "fpga.h"
#include "si5338.h"

volatile bool fpga_comm_request = false;

SPI_Master_t spiMasterC;
PORT_t *ssPort = &PORTD;

void fpga_init()
{
    PORT_SetPinsAsOutput(ssPort, PIN0_bm);
    PORT_SetPins(ssPort, PIN0_bm);

    SPI_MasterInit(
        &spiMasterC,
        &SPIC,
        &PORTC,
        false,
        SPI_MODE_0_gc,
        SPI_INTLVL_OFF_gc,
        true,
        SPI_PRESCALER_DIV16_gc);
    return;
}

void fpga_exchange_data(uint8_t addr, uint16_t *p_data)
{
    SPI_MasterSSLow(ssPort, PIN0_bm);

    spiMasterC.module->DATA = (addr >> 2) | 0x80;
    while(!(spiMasterC.module->STATUS & SPI_IF_bm)) {}

    spiMasterC.module->DATA = ((addr >> 1) << 7) | (uint8_t)((addr << 7 ) >> 1);
    while(!(spiMasterC.module->STATUS & SPI_IF_bm)) {}

    spiMasterC.module->DATA = (uint8_t)((*p_data >> 8) & 0xFF);
    while(!(spiMasterC.module->STATUS & SPI_IF_bm)) {}

    spiMasterC.module->DATA = (uint8_t)(*p_data & 0xFF);
    while(!(spiMasterC.module->STATUS & SPI_IF_bm)) {}

    *p_data = spiMasterC.module->DATA;

    SPI_MasterSSHigh(ssPort, PIN0_bm);

    return;
}

ISR(PORTD_INT0_vect)
{
    if (fpga_done_get())
    {
        /* FPGA DONE*/
        system_status_get()->b_fpga_done_ok = true;
        fpga_rst_clr();
        
        if (system_status_get()->b_si5338_fail)
        {
            system_timers_get()->ts_si5338.status = 5;
            system_timers_get()->ts_si5338.counter = 100;
            system_timers_get()->ts_fpga.status = 4;
        }
    }
    else
    {
        /* FPGA NOT DONE */
        system_status_get()->b_fpga_done_ok = false;
        PORTE_INTCTRL = 1;
        PORTB_OUTSET = 0b00010000;
        PORTA_OUTSET = 0b11000000;
    }
}

ISR(PORTE_INT1_vect)
{
    uint16_t data;
    //fpga_exchange_data(0xF2, &data);
    /* NOT in reset state */
    if (0 == (data & 0x800))
    {
        /* Reset counters active */
        if ((data & 0x200) != 0)
        {
            //fpga_comm_request = true;
        }
        // uVar2 = CONCAT11(DAT_mem_2158,(byte)in_R17R16 >> 4) & 0xfa07;
        // DAT_mem_2158 = (byte)uVar2 | (byte)(uVar2 >> 8);
    }
    /* Reset state ACTIVE */
    else
    {
        /* Auto clock source selection */
        if (0 == (data & 0x400))
        {
            //PORTF_INTCTRL = 0b00001010;
            // DAT_clk_frs = 0b0;
        }
        /* Locl clock usage after reset, don't care about LOS interrupts */
        else
        {
            //PORTF_INTCTRL = 0b00000010;
            // DAT_clk_frs = 0b00001000
        }
        // not originally here!
        //fpga_comm_request = true;
        //system_reset();
    }

    
}