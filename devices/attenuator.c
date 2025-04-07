#include "attenuator.h"

#include "drivers/usart_driver.h"
#include "drivers/port_driver.h"

#define USART USARTD0

USART_data_t USART_data;

void attenuator_uart_enable(void)
{
    /* PD3(TXD0) as output. */
    PORT_SetPinsAsOutput(&PORTD, PIN3_bm);
    /* PD2(RXD0) as input. */
    PORT_SetPinsAsInput(&PORTD, PIN2_bm);

    USART_RxdInterruptLevel_Set(USART_data.usart, USART_RXCINTLVL_LO_gc);
    USART_Tx_Enable(USART_data.usart);
    USART_Rx_Enable(USART_data.usart);
}

void attenuator_init(void)
{
    USART_InterruptDriver_Initialize(&USART_data, &USART, USART_DREINTLVL_MED_gc);
    USART_Baudrate_Set(USART_data.usart, 12, 4);
    USART_Format_Set(USART_data.usart, USART_CHSIZE_8BIT_gc, USART_PMODE_DISABLED_gc, false);

    return;
}
