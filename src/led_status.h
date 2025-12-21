/**
 * @file    led_status.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the interface for controlling status LEDs and mapping them to the
 * appropriate GPIO lines.
 */

/*
 * led_status.h
 * LED Status System for AVR XMEGA — bit-perfect with all.c/ASM
 *
 * LEDs (Port A, active-high):
 *   PA0 = LED_SYS_FAIL
 *   PA5 = LED_CLK_IN
 *   PA6 = LED_CLK_ERR
 *   PA7 = LED_READY
 *
 * This module DOES NOT read hardware pins. It only renders LEDs based on
 * precomputed system flags supplied by higher-level modules (Power/Clocks/FPGA).
 * That mirrors the original firmware where LED control was driven by flags.
 */

#ifndef LED_STATUS_H
#define LED_STATUS_H

#include <stdbool.h>
#include <stdint.h>

/* ----------------- Override these if your board differs ------------------- */
#ifndef LED_PORT
#  define LED_PORT          PORTA
#endif
#ifndef LED_SYS_FAIL_bm
#  define LED_SYS_FAIL_bm   PIN0_bm   /* PA0 */
#endif
#ifndef LED_CLK_IN_bm
#  define LED_CLK_IN_bm     PIN5_bm   /* PA5 */
#endif
#ifndef LED_CLK_ERR_bm
#  define LED_CLK_ERR_bm    PIN6_bm   /* PA6 */
#endif
#ifndef LED_READY_bm
#  define LED_READY_bm      PIN7_bm   /* PA7 */
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Inputs driving the LEDs — computed by other subsystems */
typedef struct {
  bool power_ok;             /* IN_PWR_OK && PGOOD */
  bool fpga_init_inactive;   /* PD4 == 1 (not in init/reset) */
  bool fpga_done;            /* PD5 == 1 (FPGA configured) */
  bool clk_selected_present; /* selected clock present (LOSx == 0 for selected input) */
} led_status_inputs_t;

/* Initialize LED pins and DEFAULT STATES (bit-perfect to all.c):
 * READY=ON, others OFF.
 */
void led_status_init(void);

/* Set LED state directly (atomic OUTSET/OUTCLR). */
void led_status_set_sys_fail(bool on);
void led_status_set_clk_in(bool on);
void led_status_set_clk_err(bool on);
void led_status_set_ready(bool on);

/* Apply all four LEDs at once. */
void led_status_apply(bool sys_fail, bool clk_in, bool clk_err, bool ready);

/* Set the internal copy of driving flags (stored inside this module). */
void led_status_set_flags(const led_status_inputs_t* in);

/* Render LEDs from the CURRENT internal flags (no return). */
void led_status_apply_from_flags(void);

/* --- Adapters with the SAME names/roles as in all.c/ASM -------------------
 * Call these at the same places as the original firmware:
 *
 *   gpi_or_flag_pa0_ctrl()   → updates ONLY SYS_FAIL (PA0)
 *   portd5_status_update()   → updates CLK_IN (PA5), CLK_ERR (PA6), READY (PA7)
 *
 * Both read the internal flags previously set via led_status_set_flags(...).
 */
void gpi_or_flag_pa0_ctrl(void);
void portd5_status_update(void);

#ifdef __cplusplus
}
#endif

#endif /* LED_STATUS_H */

