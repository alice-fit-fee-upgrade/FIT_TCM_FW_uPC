/**
 * @file    main.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Main entry point for the TCM firmware.
 * Initializes hardware, peripherals, and subsystems.
 * Starts the main control and processing loops.
 * Coordinates overall firmware operation.
 */

/*
 * main.c
 * MAIN LOOP / FAIL-SAFE (AVR XMEGA)
 *
 * Responsibilities (mirrors all.c intent + ASM details we've extracted):
 *  - One-time bring-up: peripherals_bringup()
 *  - Cooperative scheduler loop calling short, non-blocking service steps
 *  - Watchdog integration (kept fed if system is healthy)
 *  - Fail-safe on critical conditions:
 *      * Power not OK  -> system_soft_deinit()
 *      * Both clocks lost -> keep selection, flag error; do not drive unsafe outputs
 *      * FPGA not DONE for too long after reconfig -> soft deinit or retry (policy hook)
 *  - LED rendering happens in the same callpoints as original:
 *      gpi_or_flag_pa0_ctrl(); portd5_status_update();
 *
 * Notes:
 *  - The loop is cooperative (no long blocking calls).
 *  - Timing is approximate via software ticks; if ASM used a HW timer for ticks,
 *    you can replace the software tick with a timer ISR incrementing 'g_tick_ms'.
 */

/* CPU clock per ASM bring-up:
 * OSC.CTRL enables 32 MHz RC; CLK.CTRL selects it; prescaler off.
 */
#define F_CPU 32000000UL

#include <avr/io.h>
#include <avr/wdt.h>
#include <util/delay.h>
#include <util/delay_basic.h>
#include <stdbool.h>
#include <string.h>

#include "system_startup.h"
#include "power_supervision.h"
#include "clock_mgmt.h"
#include "fpga_spic.h"
#include "console.h"
#include "led_status.h"

/* ----------------------------- Soft tick --------------------------------- */
/* If needed, replace with a HW timer ISR incrementing this counter. */
static volatile uint32_t g_tick_ms = 0;

/* crude software tick; ~1 ms per call (do not rely on precision) */
// static inline void soft_sleep_1ms(void) { _delay_ms(1); g_tick_ms++; }

/* crude software tick; ~1 ms per call (do not rely on precision)
 * For F_CPU = 32 MHz:
 *  - _delay_loop_2(N) = N * 4 cycles
 *  - 1 ms = 32,000 cycles -> N = 8000
 */
static inline void soft_sleep_1ms(void) {
  _delay_loop_2(8000);
  g_tick_ms++;
}

/* ----------------------------- Health model ------------------------------ */

typedef struct {
  bool power_ok;              /* IN_PWR_OK && PGOOD */
  bool clk_selected_present;  /* LOS for currently selected CLK == present */
  bool fpga_done;             /* PD5 == 1 */
  bool fpga_init_inactive;    /* PD4 == 1 */
} health_snapshot_t;

static inline void take_health_snapshot(health_snapshot_t* hs)
{
  clock_flags_t cf = clock_get_flags();
  fpga_status_t fs = fpga_get_status();
  bool pwr_ok = power_input_in_ok() && power_input_pgood();

  hs->power_ok              = pwr_ok;
  hs->clk_selected_present  = cf.clk_selected_present;
  hs->fpga_done             = fs.fpga_done;
  hs->fpga_init_inactive    = fs.fpga_init_inactive;
}

/* ----------------------------- Fail-safe policy -------------------------- */

/* Debounce / grace intervals (ms) — tune to match original behavior if needed */
#define GRACE_POWER_FAIL_MS   2      /* power faults act essentially immediately */
#define GRACE_CLOCK_LOSS_MS   50     /* brief LOS spikes ignored */
#define GRACE_FPGA_DONE_MS    500    /* wait after reconfig before flagging fail */

/* Internal timers (ms since condition started) */
static uint32_t t_power_bad_since    = 0;
static uint32_t t_clock_bad_since    = 0;
static uint32_t t_fpga_notdone_since = 0;

/* Track last observed state for edge/start timing */
static bool last_power_ok             = true;
static bool last_clk_selected_present = true;
static bool last_fpga_done            = true;

/* Called periodically; may call system_soft_deinit() on hard faults */
static void fail_safe_step(void)
{
  health_snapshot_t hs;
  take_health_snapshot(&hs);

  /* --- POWER --- */
  if (!hs.power_ok) {
    if (last_power_ok) t_power_bad_since = g_tick_ms; /* edge */
    if ((g_tick_ms - t_power_bad_since) >= GRACE_POWER_FAIL_MS) {
      system_soft_deinit();  /* disables EN_PSU, latches fault, updates LEDs via callbacks */
    }
  }
  last_power_ok = hs.power_ok;

  /* --- CLOCK presence for selected input --- */
  if (!hs.clk_selected_present) {
    if (last_clk_selected_present) t_clock_bad_since = g_tick_ms;
    /* No hard action by default; LED/error handled elsewhere */
  }
  last_clk_selected_present = hs.clk_selected_present;

  /* --- FPGA DONE --- */
  if (!hs.fpga_done) {
    if (last_fpga_done) t_fpga_notdone_since = g_tick_ms;
    if ((g_tick_ms - t_fpga_notdone_since) >= GRACE_FPGA_DONE_MS) {
      /* INIT inactive but DONE missing too long → go safe */
      system_soft_deinit();
    }
  }
  last_fpga_done = hs.fpga_done;
}

/* ----------------------------- Scheduler --------------------------------- */

static inline void scheduler_step(void)
{
  /* Power inputs sampling (PORTE lines) – may call system_soft_deinit() via callbacks */
  porte_inputs_service();

  /* Clock management: LOS/INTR read, CLK_SEL maintenance, flags callback */
  update_tables_and_io();

  /* Console servicing (RJ45 ASCII + X36 binary) */
  console_service();

  /* Post-IO LED render is done inside callbacks; if you require a periodic render anyway:
     gpi_or_flag_pa0_ctrl();
     portd5_status_update();
  */
}

/* ----------------------------- Main -------------------------------------- */

int main(void)
{
  /* Enable watchdog with a moderate timeout (e.g., 1s) */
  wdt_enable(WDTO_1S);

  /* One-time system bring-up (initializes and wires all modules) */
  peripherals_bringup();

  /* Small settle time to let rails/clock stabilize and callbacks fire */
  for (uint8_t i = 0; i < 20; i++) {
    wdt_reset();          /* feed WDT during settle window */
    soft_sleep_1ms();
  }

  /* Main cooperative loop */
  while (1) {
    scheduler_step();     /* perform short periodic services */
    fail_safe_step();     /* evaluate fault conditions and act if needed */
    wdt_reset();          /* system considered healthy if loop keeps running */
    soft_sleep_1ms();     /* ~1ms pacing; can be replaced by true timer tick */
  }
}

