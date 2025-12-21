/**
 * @file    system_startup.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Responsible for the TCM system startup sequence and interconnection of
 * logical modules. Initializes subsystems in a defined order and registers
 * callback mechanisms.
 */

/*
 * system_startup.c
 * System Startup & Top-Level Wiring (AVR XMEGA)
 *
 * Exact call sequence mirrors all.c:
 *   1) ctrl_irq_flag_setup()
 *   2) led_status_init()  (READY=ON, others OFF)
 *   3) power_supervision_init(callbacks)
 *   4) clock_register_callbacks(...) + twic_master_start()
 *   5) fpga_spic_init(callbacks)
 *   6) console_init(callbacks)
 *   7) Initial handshake: portc_handshake_twic_kick()
 *   8) Optionally enable PSU: power_enable_psu(true)
 *   9) Render LEDs at the original callpoints:
 *        gpi_or_flag_pa0_ctrl(); portd5_status_update();
 *
 * Notes:
 *  - PORTC.INTCTRL/INTFLAGS are also configured in clock_mgmt (ASM-aligned);
 *    we keep ctrl_irq_flag_setup() for other pinctrl/pull-up harmonization.
 *  - No LED logic here; we only set flags and invoke the same render points.
 *  - All callbacks are "thin": update flags and call the two renderers,
 *    exactly like all.c did after state changes.
 */

#include <avr/io.h>
#include <string.h>

#include "system_startup.h"
#include "led_status.h"
#include "power_supervision.h"
#include "clock_mgmt.h"
#include "fpga_spic.h"
#include "console.h"
#include "console_cmds.h"

/* ----------------------- Aggregated LED flags ---------------------------- */

static led_status_inputs_t g_led_flags = {
  .power_ok = false,
  .fpga_init_inactive = false,
  .fpga_done = false,
  .clk_selected_present = false
};

/* Re-render LEDs in the exact places (same names as in all.c) */
static inline void render_leds_now(void)
{
  gpi_or_flag_pa0_ctrl();   /* updates PA0 (SYS FAIL) */
  portd5_status_update();   /* updates PA5/PA6/PA7 (CLK IN/ERR, READY) */
}

/* ----------------------- POWER callbacks --------------------------------- */

static void cb_power_flag(bool power_ok)
{
  g_led_flags.power_ok = power_ok;
  led_status_set_flags(&g_led_flags);
  render_leds_now();
}

static void cb_power_fault(void)
{
  /* Nothing special here — LEDs are re-rendered via cb_power_flag().
     You can add logging/telemetry if needed. */
}

/* ----------------------- CLOCK callbacks --------------------------------- */

static void cb_clock_flags(const clock_flags_t* cf)
{
  if (!cf) return;
  g_led_flags.clk_selected_present = cf->clk_selected_present;
  led_status_set_flags(&g_led_flags);
  render_leds_now();
}

/* ----------------------- FPGA callbacks ---------------------------------- */

static void cb_fpga_status(const fpga_status_t* st)
{
  if (!st) return;
  g_led_flags.fpga_init_inactive = st->fpga_init_inactive; /* PD4==1 */
  g_led_flags.fpga_done          = st->fpga_done;          /* PD5==1 */
  led_status_set_flags(&g_led_flags);
  render_leds_now();
}

/* ----------------------- CONSOLE callbacks (optional) -------------------- */
/* Keep these minimal; real command handlers can live elsewhere. */

static bool cb_x36_packet(const uint8_t* pkt, size_t len)
{
  (void)pkt; (void)len;
  /* Hook for binary protocol; return true if consumed. */
  return true;
}

static void cb_rj_cmd(char cmd, const char* arg_str, uint16_t arg_val)
{
  (void)cmd; (void)arg_val;
  if (arg_str && *arg_str) {
    (void)console_cmds_handle_line(arg_str);
  }
}

/* ----------------------- ctrl_irq_flag_setup() --------------------------- */
/* Configure pin control for inputs to match original intent:
 *  - Enable pull-ups on key inputs (active-low lines) for defined idle level.
 *  - Keep port-level interrupt control consistent with ASM where known.
 *  - Do NOT duplicate settings already made in submodules (e.g., PORTC INTCTRL in clock_mgmt).
 *
 * XMEGA PINnCTRL bits of interest:
 *  - PULLUPEN (bit 3)
 *  - INVERT  (bit 2) — we keep default (no invert) and handle active-low in logic
 *  - ISC[2:0] input sense — leave default unless specific edges are required
 */
void ctrl_irq_flag_setup(void)
{
  /* POWER inputs on PORTE: PE1=IN_PWR_OK, PE3=PGOOD → enable pull-ups */
  PORTE.PIN1CTRL = (PORTE.PIN1CTRL & ~(_BV(3))) | _BV(3);  /* PULLUPEN */
  PORTE.PIN3CTRL = (PORTE.PIN3CTRL & ~(_BV(3))) | _BV(3);

  /* CLOCK INTR lines on PORTC: PC2=DD17_INTR, PC3=DD15_INTR (active low) → pull-ups */
  PORTC.PIN2CTRL = (PORTC.PIN2CTRL & ~(_BV(3))) | _BV(3);
  PORTC.PIN3CTRL = (PORTC.PIN3CTRL & ~(_BV(3))) | _BV(3);

  /* CLOCK LOS lines on PORTF: PF4=LOS1, PF5=LOS0 (0=present) → pull-ups to read stable '1' when floating */
  PORTF.PIN4CTRL = (PORTF.PIN4CTRL & ~(_BV(3))) | _BV(3);
  PORTF.PIN5CTRL = (PORTF.PIN5CTRL & ~(_BV(3))) | _BV(3);

  /* FPGA status lines on PORTD: PD4=INIT (active low), PD5=DONE (active high) → pull-ups for stable high idle */
  PORTD.PIN4CTRL = (PORTD.PIN4CTRL & ~(_BV(3))) | _BV(3);
  PORTD.PIN5CTRL = (PORTD.PIN5CTRL & ~(_BV(3))) | _BV(3);

  /* FPGA IRQ on PORTE: PE0 → pull-up */
  PORTE.PIN0CTRL = (PORTE.PIN0CTRL & ~(_BV(3))) | _BV(3);

  /* Note:
   * PORTC.INTCTRL and .INTFLAGS are configured inside clock_mgmt.twic_master_start()
   * based on ASM (INTCTRL=0x02, INTFLAGS=0x01). We do not overwrite them here.
   */
}

/* ----------------------- peripherals_bringup() --------------------------- */

void peripherals_bringup(void)
{
  /* 1) Top-level pin control / pull-ups */
  ctrl_irq_flag_setup();

  /* 2) LED init (bit-perfect default: READY=ON, others OFF) */
  led_status_init();
  led_status_set_flags(&g_led_flags);
  render_leds_now();

  /* 3) POWER supervision: init with callbacks; leave EN_PSU disabled initially */
  const power_callbacks_t pwr_cbs = {
    .on_power_flag  = cb_power_flag,
    .on_power_fault = cb_power_fault
  };
  power_supervision_init(&pwr_cbs);

  /* 4) CLOCK (TWIC) bring-up with callback; ASM-aligned BAUD/CTRL handled inside */
  const clock_callbacks_t clk_cbs = {
    .on_clock_flags = cb_clock_flags
  };
  clock_register_callbacks(&clk_cbs);
  twic_master_start();
  (void)twic_master_start_status();  /* optional logging/action based on status */

  /* 5) FPGA (SPIC) bring-up with status callback */
  const fpga_callbacks_t fpga_cbs = {
    .on_fpga_status = cb_fpga_status
  };
  fpga_spic_init(&fpga_cbs);

  /* 6) CONSOLES bring-up (X36 / RJ45) */
  const console_callbacks_t con_cbs = {
    .on_x36_packet   = cb_x36_packet,
    .on_rj_cmd       = cb_rj_cmd,
    .x36_tx_lowlevel = NULL
  };
  console_init(&con_cbs);

  /* 7) Initial clock handshake (clear device IRQs / finalize) */
  portc_handshake_twic_kick();

  /* 8) Enable downstream power rails (safe moment: after basic init) */
  power_enable_psu(true);

  /* 9) Final LED render at the same callpoints as original code */
  render_leds_now();
}

