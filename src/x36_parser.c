/**
 * @file    x36_parser.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements core functionality of the TCM subsystem.
 * Handles control and coordination tasks.
 * Interfaces with other firmware modules.
 * Supports configuration and monitoring features.
 */

/*
 * x36_parser.c
 * Binary packet parser for X36 (USARTD0) — refactored from console.c
 */

#include <avr/io.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include "x36_parser.h"

/* ---------------- Internal state ---------------------- */
static bool (*g_on_pkt)(const uint8_t*, size_t) = 0;

#define X36_RX_BUF_SIZE 256
static uint8_t  x36_rx_buf[X36_RX_BUF_SIZE];
static uint16_t x36_rx_wr = 0;
static uint16_t x36_rx_rd = 0;

/* ---------------- Low-level helpers ------------------- */
static inline bool usart_d0_data_available(void) {
  return (USARTD0.STATUS & USART_RXCIF_bm) != 0;
}
static inline uint8_t usart_d0_read_byte(void) {
  return USARTD0.DATA;
}
static inline void usart_d0_write_byte_hw(uint8_t b) {
  while (!(USARTD0.STATUS & USART_DREIF_bm)) { /* spin */ }
  USARTD0.DATA = b;
}

/* ---------------- API: init / wiring ------------------ */
void x36_parser_init(bool (*on_packet)(const uint8_t*, size_t))
{
  g_on_pkt = on_packet;

  /* ASM-derived values from original console.c */
  USARTD0.BAUDCTRLB = 0x40;
  USARTD0.BAUDCTRLA = 0x0C;
  USARTD0.CTRLC     = 0x03;  /* async, 8N1 */
  USARTD0.CTRLB     = 0x18;  /* RXEN | TXEN */
  USARTD0.CTRLA     = 0x10;  /* flags per ASM */

  /* Clear ring */
  x36_rx_wr = x36_rx_rd = 0;
}

/* ---------------- API: RX service (polled) ------------ */
void x36_parser_service(void)
{
  while (usart_d0_data_available()) {
    uint8_t b = usart_d0_read_byte();

    uint16_t next_wr = (uint16_t)((x36_rx_wr + 1) % X36_RX_BUF_SIZE);
    if (next_wr == x36_rx_rd) {
      /* overflow: drop oldest */
      x36_rx_rd = (uint16_t)((x36_rx_rd + 1) % X36_RX_BUF_SIZE);
    }
    x36_rx_buf[x36_rx_wr] = b;
    x36_rx_wr = next_wr;

    /* Attempt parse: [LEN][DATA...] (temporary framing kept) */
    if (x36_rx_wr != x36_rx_rd) {
      uint8_t len = x36_rx_buf[x36_rx_rd];
      uint16_t available = (uint16_t)((x36_rx_wr + X36_RX_BUF_SIZE - x36_rx_rd) % X36_RX_BUF_SIZE);
      if (len != 0 && available >= (uint16_t)(1 + len)) {
        /* Extract */
        uint8_t pkt[255];
        uint16_t idx = (uint16_t)((x36_rx_rd + 1) % X36_RX_BUF_SIZE);
        for (uint8_t i = 0; i < len; i++) {
          pkt[i] = x36_rx_buf[idx];
          idx++; if (idx >= X36_RX_BUF_SIZE) idx = 0;
        }
        /* Advance read pointer */
        x36_rx_rd = (uint16_t)((x36_rx_rd + 1 + len) % X36_RX_BUF_SIZE);

        if (g_on_pkt) {
          (void)g_on_pkt(pkt, len);
        }
      }
    }
  }
}

/* ---------------- API: TX helpers --------------------- */
void uartd0_write_byte(uint8_t b) { usart_d0_write_byte_hw(b); }

void uartd0_send_S_u16_cr(uint16_t v)
{
  char tmp[12];
  uint8_t i = 0;
  tmp[i++] = 'S'; tmp[i++] = ' ';

  char d[6]; uint8_t n = 0; uint16_t t = v;
  do { d[n++] = (char)('0' + (t % 10)); t /= 10; } while (t);
  while (n--) tmp[i++] = d[n];

  tmp[i++] = '\r';
  for (uint8_t j = 0; j < i; j++) usart_d0_write_byte_hw((uint8_t)tmp[j]);
}
