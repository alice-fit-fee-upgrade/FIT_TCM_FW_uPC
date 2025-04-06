#pragma once

#include "drivers/twi_master_driver.h"

struct si5338_state
{
    uint8_t case_pri_state;
    uint8_t case_sec_state;
    uint8_t current_sl;
    uint16_t msg;
};

void si5338_init(void);
struct si5338_state *si5338_state_get(void);