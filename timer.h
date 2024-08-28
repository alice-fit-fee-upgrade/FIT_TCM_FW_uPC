#pragma once

#include <stdint.h>

struct timer_state
{
    volatile uint8_t state;
    volatile uint16_t timer;    
};

void timer_init(void);
void timer_tc_set_state(struct timer_state *p_ts, uint8_t state);
void timer_tc_set_value_ms(struct timer_state *p_ts, uint16_t timer);