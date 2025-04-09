#include "si5338.h"

#include "drivers/port_driver.h"

#include "system.h"

/*! CPU speed 32MHz, BAUDRATE 400kHz and Baudrate Register Settings */
#define CPU_SPEED           32000000
#define BAUDRATE            400000
#define TWI_BAUDSETTING     TWI_BAUD(CPU_SPEED, BAUDRATE)

TWI_Master_t twiMaster;    /*!< TWI master module. */

static void si5338_stream_init(uint8_t p_step);
static void si5338_stream_config(uint8_t p_step);
static void si5338_stream_restart(uint8_t p_step);
static void si5338_stream_(uint8_t p_step);

struct si5338_state state = {};
struct si5338_streams_config stream_cfg = 
    {
        .p_stream_f = {
            si5338_stream_init,
            si5338_stream_config,
            si5338_stream_restart, 
            si5338_stream_
        },
    };

void si5338_bus_status_set(TWI_MASTER_BUSSTATE_t state)
{
    twiMaster.interface->MASTER.STATUS = state;

    return;
}

struct si5338_state *si5338_state_get()
{
    return &state;
}

static void si5338_stream_init(uint8_t step)
{
    uint8_t data[] = {0x06, 0x0C};

    switch(step)
    {
        case 0:
        {
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 2);
            state.slave_cur = SI5338_SL1_ADDR;
            break;
        }
        case 1: 
        {
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 2);
            break;
        }
        case 2:
        {
            PORTF_INTFLAGS = 0b00000010;
            PORTF_INTCTRL = 0b00001010;
            system_restart();
            break;
        }
        default:
        {
            state.stream = 0;
            state.step = 0;
            break;
        }
    }
    
    return;
}

static void si5338_stream_config(uint8_t step)
{
    switch(step)
    {
        case 0:
        case 6:
        {
            /* PAUSE LOL */
            uint8_t data[] = {0xF1, 0xE5};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 2);
            break;
        }
        case 1:
        case 7:
        {
            uint8_t data1 = 0x0B;
            if ((DAT_clk_frs & 6) != 0)
            {
                data1 = 0x03;
            }
            uint8_t data2 = 0x08;
            if ((DAT_clk_frs & 6) != 0)
            {
                data2 = 0x00;
            }
            uint8_t data[] = {0x1C, data1, data2};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 3);
            break;
        }
        case 2:
        case 8:
        {
            uint8_t data[] = {0x31, 0x00};
            if (SI5338_SL1_ADDR == state.slave_cur)
            {
                data[1] = 0x10;
            }
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 2);
            break;
        }
        case 3:
        {
            uint8_t data[] = {0x6B, DAT_mem_216b, DAT_mem_216c & 0x7F};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 3);
            break;
        }
        case 4:
        {
            uint8_t data[] = {0x6F, DAT_mem_2167, DAT_mem_2168 & 0x7f};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 3);
            break;
        }
        case 4:
        {
            uint8_t data[] = {0x73, DAT_mem_2169, DAT_mem_216a | 0x80};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 3);
            break;
        }
        case 5:
        {
            /* Perform SOFT RESET */
            uint8_t data[] = {0xF6, 0x02};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 2);
            state.slave_addr = SI5338_SL1_ADDR;
            break;
        }
        default:
        {
            state.stream = 0;
            state.step = 0;
            break;
        }
    }

    return;
}

static void si5338_stream_restart(uint8_t step)
{
    switch (step)
    {
        case 0:
        case 1:
        {
            /* LOL restart */
            uint8_t data[] = {0xF1, 0x65};
            TWI_MasterWrite(&twiMaster, state.slave_cur, data, 2);
            state.slave_addr = SI5338_SL1_ADDR;
            break;
        }
        case 2:
        {
            timer_tc_set_state(p_ts_si5338, 4);
            timer_tc_set_value_ms(p_ts_si5338, 0);
            break;
        }
        default:
        {
            state.stream = 0;
            state.step = 0;
        }
    }

    return;
}

static void si5338_stream_(uint8_t step)
{
    switch(step)
    {
        case 0:
        {

            break;
        }
        default:
        {
            state.stream = 0;
            state.step = 0;
        }
    }

    return;
}

static void si5338_parse_state()
{
    stream_cfg.p_stream_f[state.stream](state.step++);
    return;
}

void si5338_init()
{
    TWI_MasterInit(&twiMaster,
	               &TWIC,
	               TWI_MASTER_INTLVL_LO_gc,
	               TWI_BAUDSETTING);

    return;
}

/*! TWIC Master Interrupt vector. */
ISR(TWIC_TWIM_vect)
{
    TWI_MasterInterruptHandler(&twiMaster);
    if(TWIM_RESULT_OK == twiMaster.result)
    {
        si5338_parse_state();
    }
}