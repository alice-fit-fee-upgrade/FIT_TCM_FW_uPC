/**
 * @file    x36_parser.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the interface of the X36 binary protocol parser and auxiliary
 * transmission functions.
 */

#ifndef X36_PARSER_H
#define X36_PARSER_H

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

void x36_parser_init(bool (*on_packet)(const uint8_t* pkt, size_t len));
void x36_parser_service(void);

/* TX helpers preserved for compatibility */
void uartd0_write_byte(uint8_t b);
void uartd0_send_S_u16_cr(uint16_t v);

#ifdef __cplusplus
}
#endif

#endif /* X36_PARSER_H */
