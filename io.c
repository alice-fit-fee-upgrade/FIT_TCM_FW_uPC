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
    PORT_ConfigureInterrupt0(&PORTD, PORT_INT0LVL_OFF_gc, 0b00100000);

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