#include "devices/fpga.h"
#include "io.h"
#include "devices/si5338.h"
#include "timer.h"
#include "drivers/TC_driver.h"

volatile bool b_report_rdy = false;
volatile uint16_t report_cnt = 1000;

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
    p_ts->counter = timer;

    return;
}

ISR(TCC0_OVF_vect)
{
    /* Temporary counter */
    if (0 == report_cnt)
    {
        b_report_rdy = true;
    }
    else if (report_cnt > 0)
    {
        --report_cnt;
    }

    /* Check Si5338 state and timer */
    struct timer_state *p_ts_si5338 = &system_timers_get()->ts_si5338;
    switch (p_ts_si5338->state)
    {
        /* Do nothing, state 0 is a "nop" state */
        case 0:
        {
            break;
        }
        /* State 1 is just waiting for state 2 to happen - called from system_restart() only */
        case 1:
        {
            if (1 == --p_ts_si5338->counter)
            {
                timer_tc_set_state(p_ts_si5338, 2);
            }
            break;
        }
        /* Step 1 initialization */
        case 2:
        {
            timer_tc_set_state(p_ts_si5338, 0);
            /* TODO: FUN_code_000571(); */
            si5338_state_get()->step = 0x12; // restart step only?

            if (SI5338_STREAM_INIT == si5338_state_get()->stream)
            {
                si5338_state_get()->step = 0;

                // 0x00 + 0x00

            }
            si5338_state_get()->stream = SI5338_STREAM_CONFIG;
            si5338_state_get()->slave_cur = SI5338_SL0_ADDR;
            // DAT_mem_2165 = 0xe0;
            //TWIC_MASTER_ADDR = 0xE0;
            //TWIC_MASTER_CTRLA = 0x58;
            /* ID read operation to initiate interrupt driven configuration */
            uint8_t data[] = {0x00};
            TWI_MasterWriteRead(&TWIC, SI5338_SL0_ADDR, data, 1, 1);
            break;
        }
        /* Step 2 initialization called automatically after previous step is successful */
        case 3:
        {
            if (1 == --p_ts_si5338->counter)
            {
                timer_tc_set_state(p_ts_si5338, 0);
                si5338_state_get()->stream = SI5338_STREAM_RESTART;
                si5338_state_get()->slave_cur = SI5338_SL0_ADDR;
                si5338_state_get()->step = 0;
                // DAT_mem_2165 = 0xe0;
                //TWIC_MASTER_ADDR = 0xE0;
                //TWIC_MASTER_CTRLA = 0x58;
                /* ID read operation to initiate interrupt driven configuration */
                uint8_t data[] = {0x00};
                TWI_MasterWriteRead(&TWIC, SI5338_SL0_ADDR, data, 1, 1);
            }
            break;
        }
        /* Step 3 initialization called automatically after previous step is successful */
        case 4:
        {
            uint8_t portc_val = PORT_GetPortValue(&PORTC);
            PORTC_INTFLAGS = 1;
            PORTC_INTCTRL = 2;
            // bVar6 = 0;
            if ((portc_val & 0b00001100) == 0) 
            {
                si5338_state_get()->stream = 0x04; // new four, old one
                si5338_state_get()->step = 0x00;
                // DAT_mem_2165 = 0xe0;
                //TWIC_MASTER_ADDR = 0xE0;
                //TWIC_MASTER_CTRLA = 0x58;

                /* ID read operation to initiate interrupt driven configuration */
                uint8_t data[] = {0x00};
                TWI_MasterWriteRead(&TWIC, SI5338_SL0_ADDR, data, 1, 1);

                system_status_get()->b_si5338_fail = false;
                timer_tc_set_state(p_ts_si5338, 5);
                timer_tc_set_value_ms(p_ts_si5338, 75);
                //bVar6 = extraout_R18;
            }
            else 
            {
                timer_tc_set_state(p_ts_si5338, 0);
            }
            //DAT_clk_frs = DAT_clk_frs & 0xe | bVar6;
            break;
        }
        case 5:
        {
            if (1 == p_ts_si5338->counter)
            {
                bool b_fpga_timer_done = !!(system_timers_get()->ts_fpga.counter);
                uint8_t fpga_status = system_timers_get()->ts_fpga.state;
                if(fpga_done_get() && ((0 == fpga_status) || ((5 == fpga_status) && b_fpga_timer_done)))
                {
                    fpga_rst_set();
                    timer_tc_set_state(p_ts_si5338, 6);
                }
            }
            else
            {
                --p_ts_si5338->counter;
            }
            break;
        }
        case 6:
        {
            uint16_t data = 0;
            //fpga_exchange_data(0xF2, &data);
            if ((data & 0b00001111) == 0b00000011) 
            {
                PORTE_INTFLAGS = 2;
                PORTE_INTCTRL = 9;
                // fpga_send_msg_t2(0x18,CONCAT11(DAT_clk_frs,DAT_mem_2188) | 0x1000);
                PORTA_OUTCLR = 0x80;
            }
            else 
            {
                // No PLL locks in place
                system_status_get()->b_clk_err = true;
                PORTA_OUTCLR = 0x40;
            }

            timer_tc_set_state(p_ts_si5338, 0);
            break;
        }

        default:
        {
            break;
        }
    }

    /* Check FPGA status and timer */
    struct timer_state *p_ts_fpga = &system_timers_get()->ts_fpga;
    switch (p_ts_fpga->state)
    {
        /* Do nothing, state 0 is a "nop" state */
        case 0:
        {
            break;
        }
        /* If 5V is present, then enable (EN_PSU) 2x LM21212AMHX-1 & 1x LD49150PT10R */
        case 1:
        {
            if (0 == --p_ts_fpga->counter)
            {   
                /* TODO: if 21ad == 0 -> goto next timer */
                if(!system_status_get()->b_sys_fail)
                {
                    io_psu_enable();
                    timer_tc_set_state(p_ts_fpga, 2);
                    timer_tc_set_value_ms(p_ts_fpga, 1000);
                }
                else
                {
                    timer_tc_set_state(p_ts_fpga, 0);
                }
            }
            break;
        }
        /*  */
        case 2:
        {
            if (system_status_get()->b_pwr_ldo_ok)
            {
                if (PORT_GetPinValue(&PORTE, 4))    // CFG_FCS
                {
                    system_init();
                    /* TODO: USARTD0 status? DAT_mem_2185 = 0x1f; */
                    timer_tc_set_state(p_ts_fpga, 3); 
                    timer_tc_set_value_ms(p_ts_fpga, 1000);
                }
                else
                {
                    system_status_get()->b_sys_fail = true;
                    io_led_system_fail_update();
                    timer_tc_set_state(p_ts_fpga, 0);
                }
            }
            else
            {
                if (0 == --p_ts_fpga->counter)
                {   
                    io_psu_disable();
                    system_status_get()->b_sys_fail = true;
                    io_led_system_fail_update();
                    timer_tc_set_state(p_ts_fpga, 0);
                }
            }
            break;
        }
        case 3:
        {
            if (0 == --p_ts_fpga->counter)
            { 
                fpga_init_set();
                fpga_prog_clr();
                timer_tc_set_state(p_ts_fpga, 4);
                timer_tc_set_value_ms(p_ts_fpga, 5000);
                fpga_prog_set();
            }
            break;
        }
        case 4:
        {
            if (fpga_done_get())
            {
                fpga_done_intr_enable();
                timer_tc_set_state(p_ts_fpga, 5);
                timer_tc_set_value_ms(p_ts_fpga, 2560);
                system_status_get()->b_fpga_done_ok = true;
                /* TODO: Send MCU TS */
                /* TODO: Send IP ADDR */
            }
            else
            {
                if (0 == --p_ts_fpga->counter)
                {
                    system_status_get()->b_sys_fail = true;
                    io_led_system_fail_update();
                    timer_tc_set_state(p_ts_fpga, 0);
                }
            }
            break;
        }
        case 5:
        {
            if (p_ts_fpga->counter > 0)
            {
                --p_ts_fpga->counter;
            }
            else
            {
                if (fpga_rst_is_set())
                {
                    timer_tc_set_state(p_ts_fpga, 0);
                    /* TODO: FPGA send settings */
                    PORTB_OUTCLR = 0b00010000;
                    
                }
            }
            break;
        }
        default:
        {
            break;
        }
    }
}