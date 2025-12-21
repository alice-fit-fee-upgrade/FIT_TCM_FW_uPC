/**
 * @file    power_supervision.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the API of the power supervision module and interfaces for
 * signaling valid and fault states.
 */

/*
 * power_supervision.h
 * AVR XMEGA Power Supervision — bit-perfect to all.c/ASM roles
 *
 * Pins (PORTE):
 *   PE1 = IN_PWR_OK  (input; 1 = rails OK)      — from LTC2906 monitor
 *   PE3 = PGOOD      (input; 1 = downstream OK) — PG chain for converters
 *   PE2 = EN_PSU     (output; 1 = enable)       — start/stop sequence
 *
 * This module does NOT touch LEDs directly. It exposes callbacks so the
 * higher layer can update LED/status modules without tight coupling.
 */

#ifndef POWER_SUPERVISION_H
#define POWER_SUPERVISION_H

#include <stdbool.h>
#include <stdint.h>

/* -------- Default pin mapping (override if needed) ------------------------ */
#ifndef PWR_PORT
#  define PWR_PORT             PORTE
#endif
#ifndef PWR_IN_OK_bm
#  define PWR_IN_OK_bm         PIN1_bm  /* PE1: IN_PWR_OK (input, 1=OK) */
#endif
#ifndef PWR_PGOOD_bm
#  define PWR_PGOOD_bm         PIN3_bm  /* PE3: PGOOD (input, 1=OK) */
#endif
#ifndef PWR_EN_PSU_bm
#  define PWR_EN_PSU_bm        PIN2_bm  /* PE2: EN_PSU (output, 1=enable) */
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Optional callback interface to keep this module independent of LEDs. */
typedef struct {
  /* Called whenever power_ok may have changed (after sampling). */
  void (*on_power_flag)(bool power_ok);

  /* Called when a power fault is detected and a soft deinit is executed. */
  void (*on_power_fault)(void);
} power_callbacks_t;

/* Initialize directions and default levels.
 *  - PE2 (EN_PSU) is driven LOW (disabled) by default — safe state.
 *  - PE1/PE3 are inputs.
 * Pass NULL if you don't want callbacks.
 */
void power_supervision_init(const power_callbacks_t* cbs);

/* Enable or disable EN_PSU explicitly (higher-level control). */
void power_enable_psu(bool enable);

/* Read instantaneous sampled inputs (no debounce). */
bool power_input_in_ok(void);   /* PE1 == 1 ? */
bool power_input_pgood(void);   /* PE3 == 1 ? */
bool power_is_enabled(void);    /* EN_PSU output state (latched) */

/* Soft de-initialization:
 * - Forces EN_PSU LOW (disable converters)
 * - Latches internal fault
 * - Notifies on_power_fault()
 */
void system_soft_deinit(void);

/* Periodic service (matches all.c naming):
 * - Samples IN_PWR_OK and PGOOD
 * - Updates power_ok flag
 * - If any fault -> calls system_soft_deinit()
 * - Notifies on_power_flag(power_ok)
 */
void porte_inputs_service(void);

#ifdef __cplusplus
}
#endif

#endif /* POWER_SUPERVISION_H */

