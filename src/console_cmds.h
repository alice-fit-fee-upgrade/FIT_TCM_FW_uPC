/**
 * @file    console_cmds.h
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

#ifndef CONSOLE_CMDS_H
#define CONSOLE_CMDS_H

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize command layer (optional) */
void console_cmds_init(void);

/* Handle a full RJ45 line (null-terminated). Returns true if handled. */
bool console_cmds_handle_line(const char* line);

/* Utilities to print to RJ45 */
void rj_print_ok(void);
void rj_print_err(const char* code);
void rj_println(const char* s);

/* Exposed by console.c */
void console_enter_pass_thru_to_d0_until_esc(void);
/* Low-level TX on RJ45 (to send responses) */
void uartf0_write_hex_nibble(uint8_t v);
void uartd0_write_byte(uint8_t b);

#ifdef __cplusplus
}
#endif

#endif /* CONSOLE_CMDS_H */
