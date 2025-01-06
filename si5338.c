#include "drivers/port_driver.h"

#include "si5338.h"

#define SI5338_SL1_ADDR     (0xE0)
#define SI5338_SL2_ADDR     (0xE2)

/*! CPU speed 32MHz, BAUDRATE 400kHz and Baudrate Register Settings */
#define CPU_SPEED           32000000
#define BAUDRATE            400000
#define TWI_BAUDSETTING     TWI_BAUD(CPU_SPEED, BAUDRATE)

TWI_Master_t twiMaster;    /*!< TWI master module. */

struct si5338_state si5338_state = {};

void si5338_init()
{
    TWI_MasterInit(&twiMaster,
	               &TWIC,
	               TWI_MASTER_INTLVL_LO_gc,
	               TWI_BAUDSETTING);

    TWIC_MASTER_CTRLA = 0x48;

    return;
}

struct si5338_state *si5338_state_get()
{
    return &si5338_state;
}

/*! TWIC Master Interrupt vector. */
ISR(TWIC_TWIM_vect)
{
    PORT_TogglePins(&PORTA, 0b01000000);
	TWI_MasterInterruptHandler(&twiMaster);
}