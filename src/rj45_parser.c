/**
 * @file    rj45_parser.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements a parser for ASCII text commands received via the RJ45 interface.
 * Responsible for input line parsing and forwarding commands to the command
 * handling layer.
 */

/*
 * rj45_parser.c
 * ASCII line parser + pass-through for RJ45 (USARTF0) — refactored from console.c
 */

#include <avr/io.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include "rj45_parser.h"

/* External hooks */
extern bool console_cmds_handle_line(const char* line);
extern void uartd0_write_byte(uint8_t b); /* from x36_parser.c */

/* ------------- Internal state ------------- */
#define RJ_LINE_BUF_SZ 160
static char    rj_line_buf[RJ_LINE_BUF_SZ];
static uint8_t rj_line_len = 0;

typedef enum { RJ_MODE_LINE = 0, RJ_MODE_PASS_THRU = 1 } rj_mode_t;
static volatile rj_mode_t rj_mode = RJ_MODE_LINE;

static rj_line_observer_t g_line_obs = 0;

/* ------------- Low-level helpers ---------- */
static inline bool usart_f0_data_available(void) { return (USARTF0.STATUS & USART_RXCIF_bm) != 0; }
static inline uint8_t usart_f0_read_byte(void)   { return USARTF0.DATA; }
static inline void usart_f0_write_byte_hw(uint8_t b) {
  while (!(USARTF0.STATUS & USART_DREIF_bm)) { /* spin */ }
  USARTF0.DATA = b;
}

static void rj_puts(const char* s){ while(*s){ usart_f0_write_byte_hw((uint8_t)*s++); } }

/* ------------- Public helpers ------------- */
void uartf0_write_hex_nibble(uint8_t v)
{
  uint8_t nib = v & 0x0F;
  char c = (nib < 10) ? ('0' + nib) : ('A' + (nib - 10));
  usart_f0_write_byte_hw((uint8_t)c);
}

/* ------------- API: init ------------------- */
void rj45_parser_init(rj_line_observer_t on_line_optional)
{
  g_line_obs = on_line_optional;

  /* ASM-derived values from original console.c */
  USARTF0.BAUDCTRLB = 0xD0;
  USARTF0.BAUDCTRLA = 0x83;
  USARTF0.CTRLC     = 0x03;  /* async, 8N1 */
  USARTF0.CTRLB     = 0x18;  /* RXEN | TXEN */
  USARTF0.CTRLA     = 0x10;  /* flags per ASM */

  rj_line_len = 0;
  rj_mode     = RJ_MODE_LINE;
}

/* ------------- API: mode control ---------- */
void rj45_enter_pass_thru_to_x36_until_esc(void)
{
  rj_mode = RJ_MODE_PASS_THRU;
}

/* ------------- API: RX service ------------ */
void rj45_parser_service(void)
{
  while (usart_f0_data_available()) {
    uint8_t b = usart_f0_read_byte();

    if (rj_mode == RJ_MODE_PASS_THRU) {
      if (b == 0x1B) { /* ESC ends pass-through */ 
        rj_mode = RJ_MODE_LINE;
        rj_puts("OK\r\n");
      } else {
        usart_f0_write_byte_hw(b); /* echo */
        uartd0_write_byte(b);      /* forward to X36 */
      }
      continue;
    }

    /* LINE mode */
    usart_f0_write_byte_hw(b); /* echo */

    if (b == '\r' || b == '\n') {
      if (rj_line_len > 0) {
        rj_line_buf[rj_line_len] = '\0';
        if (g_line_obs) g_line_obs(rj_line_buf);
        (void)console_cmds_handle_line(rj_line_buf);
      }
      rj_line_len = 0;
    } else {
      if (rj_line_len < RJ_LINE_BUF_SZ - 1) {
        rj_line_buf[rj_line_len++] = (char)b;
      } else {
        rj_line_len = 0; /* overflow -> reset */
      }
    }
  }
}

/* ------------- Compatibility ------------- */
void uartf0_wait_for_cr_and_emit(void)
{
  rj45_parser_service();
}
