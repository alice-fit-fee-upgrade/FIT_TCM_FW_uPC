/**
 * @file    fpga_spic.h
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
 * fpga_spic.h
 * FPGA CONFIG & STATUS over SPIC (AVR XMEGA)
 *
 * Pins:
 *   PC5 = SPIC MOSI
 *   PC6 = SPIC MISO
 *   PC7 = SPIC SCK
 *   PD0 = MCU_CS        (active low)  — FPGA SPI chip-select
 *   PD1 = RECONFIG      (active low)  — trigger FPGA reconfiguration
 *   PD4 = FPGA INIT     (active low)  — 0: resetting/initializing
 *   PD5 = FPGA DONE     (high when configured)
 *   PE0 = MCU_IRQ       (input from FPGA)
 *   PB7 = FPGA_RST      (optional: FPGA reset)
 *
 * Public callpoints:
 *   - spic_write_header_u16(uint16_t hdr)
 *   - spic_packed_write(const uint8_t* data, uint16_t len)
 *   - spic_send_cmd_3c_then_tbl2189(void)
 *   - spic_upload_table_from_2B7C(void)
 *   - spic_post_write_update(void)
 *
 * Data payloads (exact bytes) are provided via weak hooks:
 *   - fpga_tbl2189_data(out_len)
 *   - fpga_table_2B7C_data(out_len)
 */

#ifndef FPGA_SPIC_H
#define FPGA_SPIC_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#ifndef SPIC_IF
#  define SPIC_IF              SPIC
#endif

#ifndef FPGA_PORTC
#  define FPGA_PORTC           PORTC
#endif
#ifndef FPGA_PORTD
#  define FPGA_PORTD           PORTD
#endif
#ifndef FPGA_PORTE
#  define FPGA_PORTE           PORTE
#endif
#ifndef FPGA_PORTB
#  define FPGA_PORTB           PORTB
#endif

#ifndef FPGA_CS_bm
#  define FPGA_CS_bm           PIN0_bm  /* PD0 */
#endif
#ifndef FPGA_RECONF_bm
#  define FPGA_RECONF_bm       PIN1_bm  /* PD1 */
#endif
#ifndef FPGA_INIT_bm
#  define FPGA_INIT_bm         PIN4_bm  /* PD4 (active low) */
#endif
#ifndef FPGA_DONE_bm
#  define FPGA_DONE_bm         PIN5_bm  /* PD5 (active high) */
#endif
#ifndef FPGA_IRQ_bm
#  define FPGA_IRQ_bm          PIN0_bm  /* PE0 */
#endif
#ifndef FPGA_RST_bm
#  define FPGA_RST_bm          PIN7_bm  /* PB7 */
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  bool fpga_init_inactive;  /* PD4 == 1 */
  bool fpga_done;           /* PD5 == 1 */
  bool irq_active;          /* PE0 sampled level */
  bool cs_active;           /* PD0 == 0 while CS asserted */
} fpga_status_t;

typedef struct {
  void (*on_fpga_status)(const fpga_status_t* st);
} fpga_callbacks_t;

/* Init SPIC + control pins; default CS=1, RECONF=1, RST=1; emit initial status. */
void fpga_spic_init(const fpga_callbacks_t* cbs);

/* CS control */
void fpga_cs_low(void);
void fpga_cs_high(void);

/* Write 16-bit header (big-endian on wire). */
void spic_write_header_u16(uint16_t hdr);

/* Write packed payload under one CS window (no header). */
void spic_packed_write(const uint8_t* data, uint16_t len);

/* Send CMD 0x3C then stream tbl2189 bytes (from hook). */
void spic_send_cmd_3c_then_tbl2189(void);

/* Stream the big/singular table located at 0x2B7C in original firmware (from hook). */
void spic_upload_table_from_2B7C(void);

/* Post-write settle + status emit. */
void spic_post_write_update(void);

/* Active-low short pulse on PD1 to trigger FPGA reconfig. */
void fpga_trigger_reconfig_pulse(void);

/* Optional external reset (PB7). */
void fpga_reset_assert(bool assert_line);

/* Status/IRQ helpers */
fpga_status_t fpga_get_status(void);
void fpga_poll_irq(void);

/* Weak hooks — paste exact bytes from ASM/ELF to be bit-perfect. */
__attribute__((weak)) const uint8_t* fpga_tbl2189_data(uint16_t* out_len);
__attribute__((weak)) const uint8_t* fpga_table_2B7C_data(uint16_t* out_len);

#ifdef __cplusplus
}
#endif

#endif /* FPGA_SPIC_H */

