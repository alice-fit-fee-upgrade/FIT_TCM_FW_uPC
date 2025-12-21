/**
 * @file    clock_mgmt.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the API of the clock management module. Provides functions for TWI
 * interface initialization, interrupt handling, and updating clock status and
 * clock source selection lines.
 */

/*
 * clock_mgmt.h
 * CLOCK MANAGEMENT for Si5338A/B + Si53301 (AVR XMEGA, TWIC on Port C)
 *
 * Pins:
 *   PC0 = TWI SDA (TWIC)
 *   PC1 = TWI SCL (TWIC)
 *   PC2 = DD17_INTR (input, active low)
 *   PC3 = DD15_INTR (input, active low)
 *   PC4 = CLK_SEL   (output: 0=CLK0, 1=CLK1 → SI53301 input select)
 *
 *   PF5 = LOS0 (input, 0 = CLK0 present)
 *   PF4 = LOS1 (input, 0 = CLK1 present)
 *
 * Exported callpoints (match all.c):
 *   void    twic_master_start(void);
 *   uint8_t twic_master_start_status(void);
 *   void    portc_handshake_twic_kick(void);
 *   void    update_tables_and_io(void);
 *
 * No LED dependency inside: use callbacks or getters to feed your LED module.
 */

#ifndef CLOCK_MGMT_H
#define CLOCK_MGMT_H

#include <stdint.h>
#include <stdbool.h>

#ifndef CLK_PORTC
#  define CLK_PORTC            PORTC
#endif
#ifndef CLK_PORTF
#  define CLK_PORTF            PORTF
#endif

#ifndef CLK_SEL_bm
#  define CLK_SEL_bm           PIN4_bm   /* PC4 */
#endif
#ifndef DD17_INTR_bm
#  define DD17_INTR_bm         PIN2_bm   /* PC2, active low */
#endif
#ifndef DD15_INTR_bm
#  define DD15_INTR_bm         PIN3_bm   /* PC3, active low */
#endif
#ifndef LOS1_bm
#  define LOS1_bm              PIN4_bm   /* PF4: 0=present, 1=loss */
#endif
#ifndef LOS0_bm
#  define LOS0_bm              PIN5_bm   /* PF5: 0=present, 1=loss */
#endif

#ifndef TWIC_IF
#  define TWIC_IF              TWIC
#endif

/* I2C 7-bit addresses deduced from ASM (0xE0/0xE2 writes) */
#ifndef SI5338_DD15_ADDR
#  define SI5338_DD15_ADDR     0x70
#endif
#ifndef SI5338_DD17_ADDR
#  define SI5338_DD17_ADDR     0x71
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  bool clk_sel_is_1;          /* current PC4 state: 0=CLK0, 1=CLK1 */
  bool los0_present;          /* !LOS0 (PF5==0) */
  bool los1_present;          /* !LOS1 (PF4==0) */
  bool clk_selected_present;  /* presence for the selected input */
  bool dd15_intr_active;      /* PC3==0 */
  bool dd17_intr_active;      /* PC2==0 */
} clock_flags_t;

typedef struct {
  void (*on_clock_flags)(const clock_flags_t* flags);
} clock_callbacks_t;

/* Bring up TWIC + GPIOs; apply Si5338 init tables via weak hooks (if provided). */
void    twic_master_start(void);

/* 0 = OK after bring-up; non-zero if init hooks failed. */
uint8_t twic_master_start_status(void);

/* Handle device interrupts (active-low on PC2/PC3): clear/ack on Si5338 if needed. */
void    portc_handshake_twic_kick(void);

/* Periodic service:
 * - sample LOS/INTR
 * - apply ASM-equivalent selection policy on PC4
 * - emit flags via callback (if registered)
 */
void    update_tables_and_io(void);

/* Manual force of CLK_SEL (0=CLK0, 1=CLK1). */
bool    clock_force_select(uint8_t sel_0_or_1);

/* Snapshot of current flags (no side effects). */
clock_flags_t clock_get_flags(void);

/* Register (or remove with NULL) the flags callback. */
void    clock_register_callbacks(const clock_callbacks_t* cbs);

/* --- Weak hooks to inject exact ASM init/ack sequences (optional) --------- */
bool    si5338_dd15_apply_init_table(void) __attribute__((weak));
bool    si5338_dd17_apply_init_table(void) __attribute__((weak));

#ifdef __cplusplus
}
#endif

#endif /* CLOCK_MGMT_H */

