#include "drivers/usart_driver.h"
#include "drivers/port_driver.h"
#include "console.h"

#define USART USARTF0

USART_data_t USART_data;


void console_init(void)
{
    /* PF3 (TXD0) as output. */
	PORTF.DIRSET  = PIN3_bm;
    PORTF.OUTSET  = PIN3_bm;
	/* PF2 (RXD0) as input. */
	PORTF.DIRCLR = PIN2_bm;

    USART_InterruptDriver_Initialize(&USART_data, &USART, USART_DREINTLVL_MED_gc);
    USART_Format_Set(USART_data.usart, USART_CHSIZE_8BIT_gc, USART_PMODE_DISABLED_gc, false);
    USART_RxdInterruptLevel_Set(USART_data.usart, USART_RXCINTLVL_LO_gc);
    USART_Baudrate_Set(USART_data.usart, 131, 0x0d);
    USART_Tx_Enable(USART_data.usart);
    USART_Rx_Enable(USART_data.usart);

    return;
}

void console_send(char *p_msg)
{
    while (*p_msg != '\0')
    {
        bool b_sent_to_buf = false;
        b_sent_to_buf = USART_TXBuffer_PutByte(&USART_data, *p_msg);
        if(b_sent_to_buf)
        {
            ++p_msg;   
        }
    }

    return;
}

void console_cts_set(void)
{
    PORT_ClearPins(&PORTF, 0b00000001);

    return;
}

void console_debug(char *p_msg)
{
    #ifdef DEBUG
    console_send("DEBUG: ");
    console_send(p_msg);
    #endif
    return;
}

ISR(USARTF0_DRE_vect)
{
	USART_DataRegEmpty(&USART_data);
}

ISR(USARTF0_RXC_vect)
{
	USART_RXComplete(&USART_data);
}
