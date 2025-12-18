/**
 * @file    rj45_parser.h
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

#ifndef RJ45_PARSER_H
#define RJ45_PARSER_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Optional observer for raw ASCII lines (before command handling) */
typedef void (*rj_line_observer_t)(const char* line);

void rj45_parser_init(rj_line_observer_t on_line_optional);
void rj45_parser_service(void);

/* Pass-through */
void rj45_enter_pass_thru_to_x36_until_esc(void);

/* Kept for compatibility with old callsites */
void uartf0_write_hex_nibble(uint8_t v);
void uartf0_wait_for_cr_and_emit(void);

#ifdef __cplusplus
}
#endif

#endif /* RJ45_PARSER_H */
