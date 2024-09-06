#pragma once

#include "drivers/usart_driver.h"

void console_init(void);
void console_rts_clr(void);
void console_send(char *p_msg);
void console_cts_enable(void);
void console_parse_prompt(void);
