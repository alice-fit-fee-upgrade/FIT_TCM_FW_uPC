#pragma once

#include "drivers/port_driver.h"

static inline bool io_is_5v_present(void)
{
    return PORT_GetPinValue(&PORTE, 1);
}

void io_init(void);