/**
 * @file    power_supervision.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements power supervision for the TCM module. Monitors power-good signals
 * and controls the power-up sequence and safe system shutdown.
 */

/*
 * power_supervision.c
 * AVR XMEGA Power Supervision — reconstructed from all.c/ASM
 *
 * Responsibilities (as in the original):
 *  - Sample PE1 (IN_PWR_OK) and PE3 (PGOOD)
 *  - Drive PE2 (EN_PSU) to start/stop downstream converters
 *  - On fault => perform system_soft_deinit() (safe state)
 *  - Expose callbacks instead of touching LEDs directly
 */

#include <avr/io.h>
#include "power_supervision.h"

/* --- internal state ------------------------------------------------------- */

static power_callbacks_t g_cb = { 0 };

static volatile bool g_en_psu = false;     /* last commanded state for EN_PSU */
static volatile bool g_power_ok = false;   /* last computed (IN_OK && PGOOD) */
static volatile bool g_fault_latched = false;

/* --- helpers -------------------------------------------------------------- */

static inline bool in_is_set(volatile PORT_t* p, uint8_t bm)   { return (p->IN & bm) != 0; }
static inline void out_set(volatile PORT_t* p, uint8_t bm)     { p->OUTSET = bm; }
static inline void out_clr(volatile PORT_t* p, uint8_t bm)     { p->OUTCLR = bm; }

/* --- API ------------------------------------------------------------------ */

void power_supervision_init(const power_callbacks_t* cbs)
{
  if (cbs) g_cb = *cbs;

  /* Configure pins: PE2 as output (EN_PSU), PE1/PE3 as inputs */
  PWR_PORT.DIRSET = PWR_EN_PSU_bm;
  PWR_PORT.DIRCLR = (PWR_IN_OK_bm | PWR_PGOOD_bm);

  /* Safe defaults (bit-perfect intent): keep converters disabled */
  out_clr(&PWR_PORT, PWR_EN_PSU_bm);
  g_en_psu = false;

  /* Initialize sampled state */
  const bool in_ok  = in_is_set(&PWR_PORT, PWR_IN_OK_bm);
  const bool pgood  = in_is_set(&PWR_PORT, PWR_PGOOD_bm);
  g_power_ok = (in_ok && pgood);
  g_fault_latched = false;

  if (g_cb.on_power_flag) g_cb.on_power_flag(g_power_ok);
}

void power_enable_psu(bool enable)
{
  if (enable) {
    out_set(&PWR_PORT, PWR_EN_PSU_bm);
    g_en_psu = true;
  } else {
    out_clr(&PWR_PORT, PWR_EN_PSU_bm);
    g_en_psu = false;
  }
}

bool power_input_in_ok(void)  { return in_is_set(&PWR_PORT, PWR_IN_OK_bm); }
bool power_input_pgood(void)  { return in_is_set(&PWR_PORT, PWR_PGOOD_bm); }
bool power_is_enabled(void)   { return g_en_psu; }

/* Soft deinit mirrors original safe fallback:
 *  - Disable EN_PSU (low)
 *  - Latch fault
 *  - Notify higher layers
 */
void system_soft_deinit(void)
{
  out_clr(&PWR_PORT, PWR_EN_PSU_bm);
  g_en_psu = false;
  g_fault_latched = true;

  if (g_cb.on_power_fault) g_cb.on_power_fault();

  /* Also refresh power_ok flag (after disabling) */
  const bool in_ok = in_is_set(&PWR_PORT, PWR_IN_OK_bm);
  const bool pgood = in_is_set(&PWR_PORT, PWR_PGOOD_bm);
  g_power_ok = (in_ok && pgood);
  if (g_cb.on_power_flag) g_cb.on_power_flag(g_power_ok);
}

/* Periodic service, called from main loop (same name as in all.c):
 *  - Sample inputs
 *  - Update g_power_ok
 *  - If not OK => soft deinit (once; further calls keep EN_PSU low)
 */
void porte_inputs_service(void)
{
  const bool in_ok = in_is_set(&PWR_PORT, PWR_IN_OK_bm);
  const bool pgood = in_is_set(&PWR_PORT, PWR_PGOOD_bm);

  const bool new_power_ok = (in_ok && pgood);
  if (new_power_ok != g_power_ok) {
    g_power_ok = new_power_ok;
    if (g_cb.on_power_flag) g_cb.on_power_flag(g_power_ok);
  }

  /* Fault handling: any drop => safe deinit (matches original behavior) */
  if (!g_power_ok && !g_fault_latched) {
    system_soft_deinit();  /* disables EN_PSU, latches fault, notifies */
  }
}

