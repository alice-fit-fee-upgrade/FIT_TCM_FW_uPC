#include "timer.h"
#include "drivers/TC_driver.h"

struct timer_state ts_fpga = {0, 0};
struct timer_state ts_attenuator = {0, 0};
struct timer_state ts_si5338 = {0, 0};

void timer_init(void)
{
    // 32MHZ / 256 divider & 125 ticks period => 1ms
    TC_SetPeriod(&TCC0, 125);
    TC0_ConfigWGM(&TCC0, 0);
    TCC0.CTRLE = 0;
    TC0_ConfigClockSource(&TCC0, TC_CLKSEL_DIV256_gc);
    TC0_SetOverflowIntLevel(&TCC0, TC_OVFINTLVL_LO_gc);

    return;
}

void timer_tc_set_state(struct timer_state *p_ts, uint8_t state)
{
    p_ts->state = state;

    return;
}

void timer_tc_set_value_ms(struct timer_state *p_ts, uint16_t timer)
{
    p_ts->timer = timer;

    return;
}

ISR(TCC0_OVF_vect)
{

}