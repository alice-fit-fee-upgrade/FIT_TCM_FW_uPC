/**
 * @file    console.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements communication interfaces for the TCM.
 * Handles command parsing and response generation.
 * Provides configuration and diagnostic access.
 * Supports runtime monitoring and control.
 */

/*
 * console.c — façade that wires old console API onto the new split parsers.
 *
 * Exposes the same functions declared in console.h:
 *   - console_init(const console_callbacks_t*)
 *   - console_service(void)
 *   - usartd0_rx_service(void)        [kept as alias to x36_parser_service]
 *   - uartd0_write_byte(uint8_t)
 *   - uartd0_send_S_u16_cr(uint16_t)
 *   - uartf0_service_task(void)       [alias to rj45_parser_service]
 *   - uartf0_write_hex_nibble(uint8_t)
 *   - uartf0_wait_for_cr_and_emit(void)
 *   - console_enter_pass_thru_to_d0_until_esc(void)
 *   - x36_buffer_enable(bool), x36_assert_fpga_reset(bool)  (unchanged)
 *
 * Hardware line init for PORTB remains here to preserve behavior.
 */

#include <avr/io.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "console.h"
#include "console_cmds.h"
#include "x36_parser.h"
#include "rj45_parser.h"

/* Callbacks registered at console_init() */
static console_callbacks_t g_cbs = { 0 };

/* -------- Low-level helpers (unchanged) -------- */
static inline void usart_d0_write_byte_hw(uint8_t b){
  while (!(USARTD0.STATUS & USART_DREIF_bm)) {}
  USARTD0.DATA = b;
}
static inline void usart_f0_write_byte_hw(uint8_t b){
  while (!(USARTF0.STATUS & USART_DREIF_bm)) {}
  USARTF0.DATA = b;
}

/* --------- RJ45 helpers kept ---------- */
void x36_buffer_enable(bool en){
  if (en) PORTB.OUTSET = X36_BUF_OE_bm;
  else    PORTB.OUTCLR = X36_BUF_OE_bm;
}
void x36_assert_fpga_reset(bool assert_low){
  if (assert_low) PORTB.OUTCLR = X36_FPGA_RST_bm;
  else            PORTB.OUTSET = X36_FPGA_RST_bm;
}

/* --------- Parser callbacks wiring --------- */
static void on_rj_line_obs(const char* line){
  (void)line; /* observer only; commands handled in rj45_parser */
}

/* --------- API: init/service --------- */
void console_init(const console_callbacks_t* cbs)
{
  if (cbs) g_cbs = *cbs; else memset(&g_cbs, 0, sizeof(g_cbs));

  /* X36 control lines: PB0..PB3 inputs; PB4 OE, PB7 RST outputs */
  PORTB.DIRCLR = (X36_DSR_bm | X36_CTS_bm | X36_RI_bm);
  PORTB.DIRSET = (X36_BUF_OE_bm | X36_FPGA_RST_bm);
  /* Defaults */
  PORTB.OUTCLR = X36_BUF_OE_bm;
  PORTB.OUTSET = X36_FPGA_RST_bm;

  /* Init parsers */
  x36_parser_init(g_cbs.on_x36_packet);
  rj45_parser_init(on_rj_line_obs);
}

void console_service(void)
{
  x36_parser_service();
  rj45_parser_service();
}

/* Backward-compat function names used elsewhere */
void usartd0_rx_service(void){ x36_parser_service(); }
void uartf0_service_task(void){ rj45_parser_service(); }
void console_enter_pass_thru_to_d0_until_esc(void){ rj45_enter_pass_thru_to_x36_until_esc(); }
