#pragma once

#include "drivers/twi_master_driver.h"

#define SI5338_SL0_ADDR     (0x70)
#define SI5338_SL1_ADDR     (0x71)

#define SI5338_STREAM_INIT      (0)
#define SI5338_STREAM_CONFIG    (1)
#define SI5338_STREAM_RESTART   (2)

struct si5338_state
{
    uint8_t stream;
    uint8_t step;
    uint8_t slave_cur;
};

struct si5338_streams_config
{
    void (*p_stream_f[4]) (uint8_t);
};

void si5338_bus_status_set(TWI_MASTER_BUSSTATE_t state);
struct si5338_state *si5338_state_get(void);

void si5338_init(void);