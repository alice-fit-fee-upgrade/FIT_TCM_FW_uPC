#include "io.h"

void io_init(void)
{
    // PORTA
    PORT_SetDirection(&PORTA, 0b11111011);
    PORT_SetPins(&PORTA, 0b11110011);
    PORT_ConfigurePins(&PORTA, 0b00011010, true, false, 0, 0);
    PORT_ConfigurePins(&PORTA, 0b00000100, false, false, PORT_OPC_PULLUP_gc, 0);

    // PORTB
    PORT_SetDirection(&PORTB, 0b00011111);
    PORT_SetPins(&PORTB, 0b00010000);
    PORT_ConfigurePins(&PORTB, 0b01100000, false, false, PORT_OPC_PULLDOWN_gc, 0);

    // PORTC
    PORT_ConfigurePins(&PORTC, 0b00000011, false, false, PORT_OPC_WIREDAND_gc, 0);
    PORT_ConfigurePins(&PORTC, 0b00011000, false, false, 0, 0);
    PORT_ConfigureInterrupt0(&PORTC, PORT_INT0LVL_OFF_gc, 0b00001100);

    // PORTD
    PORT_SetDirection(&PORTD, 0b00010010);
    PORT_SetPins(&PORTD, 0b00000010);
    PORT_ClearPins(&PORTD, 0b00010000);
    PORT_ConfigurePins(&PORTD, 0b00010010, false, false, PORT_OPC_WIREDAND_gc, 0);
    PORT_ConfigurePins(&PORTD, 0b00100000, false, false, 0, 0);
    PORT_ConfigurePins(&PORTD, 0b11000000, false, false, PORT_OPC_PULLDOWN_gc, 0);
    PORT_ConfigureInterrupt0(&PORTD, PORT_INT0LVL_OFF_gc, PIN5_bm);

    // PORTE
    PORT_SetDirection(&PORTE, 0b00000100);
    PORT_ConfigurePins(&PORTE, 0b00000001, false, false, 0, PORT_ISC_RISING_gc);
    PORT_ConfigurePins(&PORTE, 0b00001010, false, false, 0, 0);
    PORT_ConfigurePins(&PORTE, 0b00000100, true, false, 0, 0);
    PORT_ConfigureInterrupt0(&PORTE, PORT_INT0LVL_OFF_gc, 0b00001010);
    PORT_ConfigureInterrupt1(&PORTE, PORT_INT0LVL_OFF_gc, 0b00000001);

    // PORTF
    PORT_SetDirection(&PORTF, 0b00001001);
    PORT_SetPins(&PORTF, 0b00000001);
    PORT_ConfigurePins(&PORTF, 0b00110010, false, false, 0, 0);
    PORT_ConfigurePins(&PORTF, 0b11000000, false, false, PORT_OPC_PULLDOWN_gc, 0);
    PORT_ConfigureInterrupt0(&PORTF, PORT_INT0LVL_OFF_gc, 0b00000010);
    PORT_ConfigureInterrupt1(&PORTF, PORT_INT0LVL_OFF_gc, 0b00110000);

    return;
}

/* Handling input power & LDO presence */
ISR(PORTE_INT0_vect)
{
    uint8_t port_e_val = PORT_GetPortValue(&PORTE);
    uint8_t port_e_tgl = system_status_get()->porte_status ^ port_e_val;
    system_status_get()->porte_status = port_e_val;

    /* 12V unchanged */
    if (0 == (port_e_tgl & PORTE_IN_PWR_OK_PIN_bm))
    {
        /* nothing changed */
        if(0 == (port_e_tgl & PORTE_LDO_OK_PIN_bm))
        {
            return;
        }

        /* LDO turned on */
        if (port_e_val & PORTE_LDO_OK_PIN_bm)
        {
            system_status_get()->b_pwr_ldo_ok =  true;
            return;
        }

        /* LDO turned off */
        system_status_get()->b_pwr_ldo_ok =  false;
        system_deinit();

        /* PSU not enabled */
        if (0 == (port_e_val & PORTE_EN_PSU_PIN_bm))
        {
            return;
        }
        system_status_get()->b_sys_fail = true;
    }
    /* 12V turned off */
    else if (0 == (port_e_val & PORTE_IN_PWR_OK_PIN_bm))
    {
        io_psu_disable();
        system_status_get()->b_sys_fail =  true;
        system_status_get()->b_pwr_in_ok =  false;
        system_deinit();
    }
    /* 12V turned on*/
    else
    {
        timer_tc_set_state(&system_timers_get()->ts_fpga, 1);
        timer_tc_set_value_ms(&system_timers_get()->ts_fpga, 2000);
        system_status_get()->b_sys_fail =  false;
    }

    io_led_system_fail_update();
}
