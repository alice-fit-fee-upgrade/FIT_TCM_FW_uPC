#include <avr/eeprom.h>

#include "system.h"

struct system_eeprom *p_ee_params = (struct system_eeprom *)MAPPED_EEPROM_START;
struct system_status system_status = {};
struct system_timers system_timers = {};

struct system_eeprom *system_eeprom_get(void)
{
    return p_ee_params;
}

struct system_status *system_status_get(void)
{
    return &system_status;
}

struct system_timers *system_timers_get(void)
{
    return &system_timers;
}

void system_init()
{
    
}