#pragma once

#include "drivers/port_driver.h"
#include "system.h"

#define PORTE_IN_PWR_OK_PIN_bp  (1)
#define PORTE_IN_PWR_OK_PIN_bm  (1 << PORTE_IN_PWR_OK_PIN_bp)
#define PORTE_EN_PSU_PIN_bp      (2)
#define PORTE_EN_PSU_PIN_bm      (1 << PORTE_EN_PSU_PIN_bp)
#define PORTE_LDO_OK_PIN_bp      (3)
#define PORTE_LDO_OK_PIN_bm      (1 << PORTE_LDO_OK_PIN_bp)

static inline bool io_is_12v_present(void)
{

    return PORT_GetPinValue(&PORTE, 2);
}

static inline void io_led_system_fail_update()
{
    if (system_status_get()->pwr_err)
    {
        PORT_ClearOutputBit(&PORTA, 0);
    }
    else
    {
        PORT_SetOutputBit(&PORTA, 0);
    }   
}

static inline void io_attenuator_port_set(uint8_t bit_mask)
{
    uint8_t portb_mask = PORT_GetPortValue(&PORTB);
    PORT_SetOutputValue(&PORTB, (bit_mask & 0x0F) | (portb_mask & 0x90));
    return;
}

static inline void io_psu_enable()
{
    PORT_SetOutputBit(&PORTE, 2);
    return;
}

static inline void io_psu_disable()
{
    PORT_ClearOutputBit(&PORTE, 2);
    return;
}

static inline void io_enable_pwr_interrupt(void)
{
    PORTE_INTCTRL = ( PORTE_INTCTRL & ~PORT_INT0LVL_gm ) | PORT_INT0LVL_LO_gc;
    return;
}

void io_init(void);