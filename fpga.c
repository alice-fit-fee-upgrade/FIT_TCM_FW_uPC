#include <avr/interrupt.h>
#include <avr/io.h>
#include <stdbool.h>

#include "fpga.h"

volatile bool fpga_comm_request = false;

ISR(PORTE_INT1_vect)
{
    fpga_comm_request = true;
}