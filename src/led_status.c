/**
 * @file    led_status.c
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
 * led_status.c
 * LED Status System for AVR XMEGA — bit-perfect with all.c/ASM
 *
 * Key properties:
 *  - Uses only OUTSET/OUTCLR (atomic bit writes).
 *  - Does not read hardware inputs; it renders from flags provided by callers.
 *  - Init state matches peripherals_bringup(): READY=ON, others OFF.
 *  - Provides gpi_or_flag_pa0_ctrl() and portd5_status_update() entry points,
 *    just like the original code paths.
 */

#include <avr/io.h>
#include "led_status.h"

/* Active-high helpers */
static inline void led_on(uint8_t bm)  { LED_PORT.OUTSET = bm; }
static inline void led_off(uint8_t bm) { LED_PORT.OUTCLR = bm; }

/* Internal flag storage (reflects the latest system state) */
static volatile led_status_inputs_t g_led_in = {
  .power_ok = false,
  .fpga_init_inactive = false,
  .fpga_done = false,
  .clk_selected_present = false
};

void led_status_init(void)
{
  /* Configure LED pins as outputs */
  LED_PORT.DIRSET = (LED_SYS_FAIL_bm | LED_CLK_IN_bm | LED_CLK_ERR_bm | LED_READY_bm);

  /* Bit-perfect default: READY=ON, others OFF (as in peripherals_bringup()) */
  led_off(LED_SYS_FAIL_bm);
  led_off(LED_CLK_IN_bm);
  led_off(LED_CLK_ERR_bm);
  led_on(LED_READY_bm);
}

/* ---- Direct setters ------------------------------------------------------ */
void led_status_set_sys_fail(bool on) { on ? led_on(LED_SYS_FAIL_bm) : led_off(LED_SYS_FAIL_bm); }
void led_status_set_clk_in(bool on)   { on ? led_on(LED_CLK_IN_bm)   : led_off(LED_CLK_IN_bm);   }
void led_status_set_clk_err(bool on)  { on ? led_on(LED_CLK_ERR_bm)  : led_off(LED_CLK_ERR_bm);  }
void led_status_set_ready(bool on)    { on ? led_on(LED_READY_bm)    : led_off(LED_READY_bm);    }

void led_status_apply(bool sys_fail, bool clk_in, bool clk_err, bool ready)
{
  led_status_set_sys_fail(sys_fail);
  led_status_set_clk_in(clk_in);
  led_status_set_clk_err(clk_err);
  led_status_set_ready(ready);
}

/* ---- Flag management ----------------------------------------------------- */
void led_status_set_flags(const led_status_inputs_t* in)
{
  if (!in) return;
  /* Copy atomically enough for byte writes on AVR (bool promotes to uint8_t). */
  g_led_in.power_ok            = in->power_ok;
  g_led_in.fpga_init_inactive  = in->fpga_init_inactive;
  g_led_in.fpga_done           = in->fpga_done;
  g_led_in.clk_selected_present= in->clk_selected_present;
}

/* Render all LEDs from current flags (exact same boolean relations as all.c) */
void led_status_apply_from_flags(void)
{
  const bool clk_in_on  =  g_led_in.clk_selected_present;
  const bool clk_err_on = !g_led_in.clk_selected_present;

  const bool ready_on =
      g_led_in.power_ok &&
      g_led_in.fpga_init_inactive &&
      g_led_in.fpga_done &&
      (!clk_err_on);

  const bool sys_fail_on = !ready_on;

  led_status_apply(sys_fail_on, clk_in_on, clk_err_on, ready_on);
}

/* ---- Adapters with original names/points of invocation ------------------- */
/* Matches original: updates ONLY SYS_FAIL (PA0) from current flags */
void gpi_or_flag_pa0_ctrl(void)
{
  const bool clk_err_on = !g_led_in.clk_selected_present;
  const bool all_good =
      g_led_in.power_ok &&
      g_led_in.fpga_init_inactive &&
      g_led_in.fpga_done &&
      (!clk_err_on);

  led_status_set_sys_fail(!all_good);
}

/* Matches original: updates PA5/PA6/PA7 (CLK_IN, CLK_ERR, READY) */
void portd5_status_update(void)
{
  const bool clk_in_on  =  g_led_in.clk_selected_present;
  const bool clk_err_on = !g_led_in.clk_selected_present;

  const bool ready_on =
      g_led_in.power_ok &&
      g_led_in.fpga_init_inactive &&
      g_led_in.fpga_done &&
      (!clk_err_on);

  led_status_set_clk_in(clk_in_on);
  led_status_set_clk_err(clk_err_on);
  led_status_set_ready(ready_on);
}

