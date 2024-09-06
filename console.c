#include <stdio.h>

#include "drivers/usart_driver.h"
#include "drivers/port_driver.h"
#include "console.h"

#define USART USARTF0
#define PRINTF_BUF_LEN  (256)

USART_data_t USART_data;

static char vsprintf_buf[PRINTF_BUF_LEN];

void console_init(void)
{
    /* PF0(RTS) & PF3(TXD0) as output. */
    PORT_SetPinsAsOutput(&PORTF, PIN0_bm | PIN3_bm);
    /* PF1(CST) & PF2(RXD0) as input. */
    PORT_SetPinsAsInput(&PORTF, PIN1_bm | PIN2_bm);

    USART_InterruptDriver_Initialize(&USART_data, &USART, USART_DREINTLVL_MED_gc);
    USART_FlowControl_Initialize(&USART_data, &PORTF, 1, 0);
    USART_Format_Set(USART_data.usart, USART_CHSIZE_8BIT_gc, USART_PMODE_DISABLED_gc, false);
    USART_RxdInterruptLevel_Set(USART_data.usart, USART_RXCINTLVL_LO_gc);
    USART_Baudrate_Set(USART_data.usart, 103, 0x00);
    USART_Tx_Enable(USART_data.usart);
    USART_Rx_Enable(USART_data.usart);

    USART_CTS_Read(&USART_data);
    
    PORTF_INTCTRL = 0x2;
    return;
}

void console_rts_clr(void)
{
    USART_RTS_Set(&USART_data, true);

    return;
}

void console_rts_set(void)
{
    USART_RTS_Set(&USART_data, false);

    return; 
}

void console_cts_enable(void)
{
    USART_CTS_Enable(&USART_data);

    return;
}

__attribute__((format(printf, 1, 2))) void console_print(const char *fmt, ...)
{
    va_list args;

    va_start(args, fmt);
    vsnprintf(vsprintf_buf, PRINTF_BUF_LEN, fmt, args);
    char *p_msg = vsprintf_buf;

    while(*p_msg)
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

ISR(PORTF_INT0_vect)
{
	USART_ClearToSend(&USART_data);
}
