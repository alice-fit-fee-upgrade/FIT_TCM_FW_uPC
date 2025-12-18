/**
 * @file    clock_mgmt.c
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
 * clock_mgmt.c
 * CLOCK MANAGEMENT for Si5338A/B + Si53301 (AVR XMEGA, TWIC on Port C)
 *
 * ASM-aligned specifics:
 *  - TWIC_MASTER_BAUD = 0x23
 *  - TWIC_MASTER_CTRLA = 0x48 (master enable)
 *  - PORTC_INTCTRL = 0x02 ; PORTC_INTFLAGS = 0x01 (INT0)
 *  - Selection policy in update_tables_and_io():
 *      if LOS0==0 → PC4=0 ; else if LOS1==0 → PC4=1 ; else keep current
 *  - PC4 direction set to output at bring-up, but level not forced in start()
 *    (update_tables_and_io() decides, matching the original flow).
 */

#include <avr/io.h>
#include <string.h>
#include "clock_mgmt.h"

/* -------- Internal state -------------------------------------------------- */
static volatile clock_flags_t g_flags = {
  .clk_sel_is_1 = false,
  .los0_present = false,
  .los1_present = false,
  .clk_selected_present = false,
  .dd15_intr_active = false,
  .dd17_intr_active = false
};

static clock_callbacks_t g_cb = { 0 };
static volatile uint8_t g_status = 0;     /* 0=OK; non-zero if init hooks failed */
static volatile bool g_twi_ready = false;

/* -------- Helpers --------------------------------------------------------- */
static inline bool  in_set(volatile PORT_t* p, uint8_t bm) { return (p->IN & bm) != 0; }
static inline void out_set(volatile PORT_t* p, uint8_t bm) { p->OUTSET = bm; }
static inline void out_clr(volatile PORT_t* p, uint8_t bm) { p->OUTCLR = bm; }

static inline void set_clk_sel(uint8_t sel)
{
  if (sel) out_set(&CLK_PORTC, CLK_SEL_bm);
  else     out_clr(&CLK_PORTC, CLK_SEL_bm);
  g_flags.clk_sel_is_1 = (sel != 0);
}

static inline void sample_lines(void)
{
  /* LOS: 0=present */
  g_flags.los0_present     = !in_set(&CLK_PORTF, LOS0_bm);
  g_flags.los1_present     = !in_set(&CLK_PORTF, LOS1_bm);

  /* INTR: active-low */
  g_flags.dd15_intr_active = !in_set(&CLK_PORTC, DD15_INTR_bm);
  g_flags.dd17_intr_active = !in_set(&CLK_PORTC, DD17_INTR_bm);

  /* selected presence */
  g_flags.clk_selected_present = g_flags.clk_sel_is_1 ? g_flags.los1_present
                                                      : g_flags.los0_present;
}

static inline void emit_flags(void)
{
  if (g_cb.on_clock_flags) {
    clock_flags_t copy = clock_get_flags();
    g_cb.on_clock_flags(&copy);
  }
}

/* -------- TWI minimal primitives (blocking, enough for init/ack) --------- */
static inline void twic_force_idle(void)
{
  /* Set Master bus state to IDLE (XMEGA TWI) */
  TWIC_IF.MASTER.STATUS = TWI_MASTER_BUSSTATE_IDLE_gc;
}

static void twic_enable_master_baud(uint8_t baud)
{
  TWIC_IF.MASTER.BAUD  = baud;          /* ASM: 0x23 */
  TWIC_IF.MASTER.CTRLA = 0x48;          /* enable master, standard mode per ASM */
  twic_force_idle();                    /* ASM: STATUS=0x01 (IDLE) after CTRLA */
}

clock_flags_t clock_get_flags(void)
{
  clock_flags_t f = g_flags;            /* byte-wise copy is atomic enough */
  return f;
}

void clock_register_callbacks(const clock_callbacks_t* cbs)
{
  if (cbs) g_cb = *cbs; else memset(&g_cb, 0, sizeof(g_cb));
}

/* Weak hooks — replace with your exact ASM tables (reg,val...) if needed. */
bool si5338_dd15_apply_init_table(void) { (void)SI5338_DD15_ADDR; return true; }
bool si5338_dd17_apply_init_table(void) { (void)SI5338_DD17_ADDR; return true; }

static bool si5338_clear_intr(uint8_t addr7)
{
  /* If ASM clears specific status regs, implement here (write reg→val via TWIC).
     Left as success stub to keep callpoints; fill with your exact sequence. */
  (void)addr7;
  return true;
}

/* -------- Public API ------------------------------------------------------ */

void twic_master_start(void)
{
  /* Directions: PC4 output; PC2/PC3 inputs; PF4/PF5 inputs. */
  CLK_PORTC.DIRSET = CLK_SEL_bm;
  CLK_PORTC.DIRCLR = (DD15_INTR_bm | DD17_INTR_bm);
  CLK_PORTF.DIRCLR = (LOS0_bm | LOS1_bm);

  /* Setup PORTC INT (as in ASM): INT0 enabled; clear flags. */
  PORTC.INTCTRL  = 0x02;    /* enable interrupt level on INT0 */
  PORTC.INTFLAGS = 0x01;    /* clear INT0 flag */

  /* Bring up TWIC with ASM values. */
  twic_enable_master_baud(0x23);
  g_twi_ready = true;

  /* Apply Si5338 init tables, exactly like ASM step does. */
  bool ok15 = si5338_dd15_apply_init_table();
  bool ok17 = si5338_dd17_apply_init_table();
  g_status  = (ok15 && ok17) ? 0 : 1;

  /* Do not force PC4 level here — ASM lets update_tables_and_io() decide. */
  sample_lines();
  emit_flags();
}

uint8_t twic_master_start_status(void)
{
  return g_status; /* 0=OK, else error from init table hooks */
}

void portc_handshake_twic_kick(void)
{
  /* Sample INTR lines (active low) */
  sample_lines();

  if (g_flags.dd15_intr_active) (void)si5338_clear_intr(SI5338_DD15_ADDR);
  if (g_flags.dd17_intr_active) (void)si5338_clear_intr(SI5338_DD17_ADDR);

  /* If ASM applies additional "kick" after ack, do it inside the hooks above. */
  emit_flags();
}

/* ASM-equivalent selection policy, mirrored literally:
 *  if (LOS0==0) { PC4=0; }
 *  else if (LOS1==0) { PC4=1; }
 *  else { keep PC4 as-is; }
 */
static void selection_policy_step(void)
{
  const bool los0_ok = g_flags.los0_present; /* 1 when present */
  const bool los1_ok = g_flags.los1_present;

  if (los0_ok) {
    set_clk_sel(0);
  } else if (los1_ok) {
    set_clk_sel(1);
  } else {
    /* both lost → keep current, no change */
  }

  /* recompute selected presence in case PC4 changed */
  g_flags.clk_selected_present = g_flags.clk_sel_is_1 ? g_flags.los1_present
                                                      : g_flags.los0_present;
}

void update_tables_and_io(void)
{
  /* Read latest inputs */
  sample_lines();

  /* Apply ASM policy for PC4 */
  selection_policy_step();

  /* If INTR active, run handshake/ack (like original) */
  if (g_flags.dd15_intr_active || g_flags.dd17_intr_active) {
    portc_handshake_twic_kick();
    return; /* portc_handshake_twic_kick() emitted flags */
  }

  emit_flags();
}

bool clock_force_select(uint8_t sel_0_or_1)
{
  set_clk_sel( (sel_0_or_1 ? 1u : 0u) );
  sample_lines();
  emit_flags();
  return true;
}

