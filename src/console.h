/**
 * @file    console.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the interface for handling two consoles: binary (X36 / USARTD0) and
 * text-based (RJ45 / USARTF0).
 */

/*
 * console.h
 * Dual-console support for X36 (USARTD0) and RJ45 (USARTF0)
 *
 * - X36 / USARTD0: binary protocol (framing pluggable).
 * - RJ45 / USARTF0: ASCII console, simple command set (e.g. "W <dec16><CR>").
 *
 * Hardware lines:
 *   X36: PD2=RX, PD3=TX; PORTB: PB0..PB3 control, PB4=OE, PB7=FPGA_RST (active-low assumed).
 *   RJ45: PF2=RX, PF3=TX; PF0/PF1 optional (ADM3232 second channel), PF4/PF5 LOS (read-only).
 *
 * Comments are in English.
 */

#ifndef CONSOLE_H
#define CONSOLE_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

/* ----------------- Hardware mapping (override if needed) ------------------ */

/* X36: USARTD0 */
#ifndef X36_USART
#  define X36_USART           USARTD0
#endif
#ifndef X36_RX_bm
#  define X36_RX_bm           PIN2_bm   /* PD2 = MCU_Att_Rx */
#endif
#ifndef X36_TX_bm
#  define X36_TX_bm           PIN3_bm   /* PD3 = MCU_Att_Tx */
#endif

/* RS232 control lines on PORTB */
#ifndef X36_PORTB
#  define X36_PORTB           PORTB
#endif
#ifndef X36_DSR_bm
#  define X36_DSR_bm          PIN0_bm   /* PB0 - DSR (input) */
#endif
#ifndef X36_RTS_bm
#  define X36_RTS_bm          PIN1_bm   /* PB1 - RTS (output if used) */
#endif
#ifndef X36_CTS_bm
#  define X36_CTS_bm          PIN2_bm   /* PB2 - CTS (input) */
#endif
#ifndef X36_RI_bm
#  define X36_RI_bm           PIN3_bm   /* PB3 - RI  (input) */
#endif
#ifndef X36_BUF_OE_bm
#  define X36_BUF_OE_bm       PIN4_bm   /* PB4 - OE for RS232 buffer (active-high assumed) */
#endif
#ifndef X36_FPGA_RST_bm
#  define X36_FPGA_RST_bm     PIN7_bm   /* PB7 - FPGA reset (active-low assumed) */
#endif

/* RJ45: USARTF0 */
#ifndef RJ_USART
#  define RJ_USART            USARTF0
#endif
#ifndef RJ_RX_bm
#  define RJ_RX_bm            PIN2_bm   /* PF2 = MCU_Console_Rx */
#endif
#ifndef RJ_TX_bm
#  define RJ_TX_bm            PIN3_bm   /* PF3 = MCU_Console_Tx */
#endif
#ifndef RJ_T2IN_bm
#  define RJ_T2IN_bm          PIN0_bm   /* PF0 - DD7_T2IN (optional TX2) */
#endif
#ifndef RJ_R2OUT_bm
#  define RJ_R2OUT_bm         PIN1_bm   /* PF1 - DD7_R2OUT (optional RX2) */
#endif
#ifndef RJ_LOS0_bm
#  define RJ_LOS0_bm          PIN5_bm   /* PF5 - LOS0 (read-only) */
#endif
#ifndef RJ_LOS1_bm
#  define RJ_LOS1_bm          PIN4_bm   /* PF4 - LOS1 (read-only) */
#endif

/* ----------------- Console callbacks/interfaces ------------------------- */

/* X36 binary protocol: deliver received packet bytes to upper layer.
 * Return true if packet consumed successfully; false => NACK/ignore.
 */
typedef bool (*x36_packet_handler_t)(const uint8_t* pkt, size_t len);

/* RJ45 ASCII callback: called when a recognized command is parsed.
 * Example: "W <dec16>" -> cmd == 'W', arg_value contains parsed number.
 */
typedef void (*rj_cmd_handler_t)(char cmd, const char* arg_str, uint16_t arg_value);

/* General console event callbacks (optional) */
typedef struct {
  /* Called when X36 receives a complete binary packet */
  x36_packet_handler_t on_x36_packet;

  /* Called when RJ45 console parses a command */
  rj_cmd_handler_t on_rj_cmd;

  /* Optional hook for sending low-level bytes via X36 from other modules */
  void (*x36_tx_lowlevel)(uint8_t b);
} console_callbacks_t;

/* ----------------- Public API ------------------------------------------- */

/* Initialize both console ports; sets UART registers to ASM-extracted values. */
void console_init(const console_callbacks_t* cbs);

/* Polling service: call frequently from scheduler / main loop. */
void console_service(void);

/* X36-specific helpers (also exposed for direct use) */
void usartd0_rx_service(void);             /* polled RX handler for X36 */
void uartd0_write_byte(uint8_t b);         /* transmit single byte on X36 */
void uartd0_send_S_u16_cr(uint16_t v);     /* convenience: "S %u<CR>" formatted send */

/* RJ45-specific helpers */
void uartf0_service_task(void);            /* poller for RJ45 ASCII console */
void uartf0_write_hex_nibble(uint8_t v);   /* helper to output hex nibble */
void uartf0_wait_for_cr_and_emit(void);    /* one-shot poll */

/* Lower-level control for RS232 lines (OE/Reset) */
void x36_buffer_enable(bool en);
void x36_assert_fpga_reset(bool assert_low);

#endif /* CONSOLE_H */

