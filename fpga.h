#pragma once

#include "drivers/port_driver.h"

static inline void fpga_enable_interrupt(void)
{
    PORTE_INTCTRL = ( PORTE_INTCTRL & ~PORT_INT1LVL_gm ) | PORT_INT1LVL_LO_gc;
    return;
}