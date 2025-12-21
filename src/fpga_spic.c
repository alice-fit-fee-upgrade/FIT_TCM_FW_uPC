/**
 * @file    fpga_spic.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements FPGA configuration and status readout via the SPI interface.
 * Responsible for the configuration sequence, data transfer, and monitoring of
 * INIT and DONE signals.
 */

/*
 * fpga_spic.c
 * FPGA CONFIG & STATUS over SPIC (AVR XMEGA)
 *
 * Control logic matches all.c/ASM:
 *  - SPIC master enable, mode 0
 *  - PD0 (CS), PD1 (RECONFIG active low), PD4 (INIT low), PD5 (DONE high), PE0 (IRQ)
 *  - Entry points and CS handling identical to original calls
 * Data sequences are injected via weak hooks to allow 1:1 byte-for-byte inclusion.
 */

#include <avr/io.h>
#include <util/delay.h>
#include <util/delay_basic.h>
#include <string.h>
#include "fpga_spic.h"

static fpga_callbacks_t g_cb = (fpga_callbacks_t){ 0 };

static inline void out_set(volatile PORT_t* p, uint8_t bm) { p->OUTSET = bm; }
static inline void out_clr(volatile PORT_t* p, uint8_t bm) { p->OUTCLR = bm; }
static inline int  in_bit(volatile PORT_t* p, uint8_t bm)  { return (p->IN & bm) ? 1 : 0; }

static inline fpga_status_t sample_status(void)
{
  fpga_status_t s;
  s.fpga_init_inactive = in_bit(&FPGA_PORTD, FPGA_INIT_bm);
  s.fpga_done          = in_bit(&FPGA_PORTD, FPGA_DONE_bm);
  s.irq_active         = in_bit(&FPGA_PORTE, FPGA_IRQ_bm);
  s.cs_active          = !in_bit(&FPGA_PORTD, FPGA_CS_bm);
  return s;
}

static inline void emit_status(void)
{
  if (g_cb.on_fpga_status) {
    fpga_status_t st = sample_status();
    g_cb.on_fpga_status(&st);
  }
}

/* ---- SPIC low-level ---- */

static inline void spic_wait_tx_ready(void)
{
  while (!(SPIC_IF.STATUS & SPI_IF_bm)) { /* spin */ }
}

static inline uint8_t spic_txrx(uint8_t v)
{
  SPIC_IF.DATA = v;
  spic_wait_tx_ready();
  return SPIC_IF.DATA;
}

/* ---- Public API ---- */

void fpga_spic_init(const fpga_callbacks_t* cbs)
{
  if (cbs) g_cb = *cbs; else memset(&g_cb, 0, sizeof(g_cb));

  /* Control pins */
  FPGA_PORTD.DIRSET = (FPGA_CS_bm | FPGA_RECONF_bm);
  FPGA_PORTD.DIRCLR = (FPGA_INIT_bm | FPGA_DONE_bm);
  FPGA_PORTE.DIRCLR = FPGA_IRQ_bm;

  FPGA_PORTB.DIRSET = FPGA_RST_bm;
  out_set(&FPGA_PORTB, FPGA_RST_bm);     /* RST inactive */

  out_set(&FPGA_PORTD, FPGA_CS_bm);      /* CS high (inactive) */
  out_set(&FPGA_PORTD, FPGA_RECONF_bm);  /* RECONF inactive */

  /* SPIC: master, mode 0, prescaler /4 (tune if ASM shows different) */
  SPIC_IF.CTRL = SPI_ENABLE_bm | SPI_MASTER_bm | SPI_MODE_0_gc | SPI_PRESCALER_DIV4_gc;
  (void)SPIC_IF.STATUS; /* clear IF */

  emit_status();
}

void fpga_cs_low(void)  { out_clr(&FPGA_PORTD, FPGA_CS_bm); }
void fpga_cs_high(void) { out_set(&FPGA_PORTD, FPGA_CS_bm); }

void spic_write_header_u16(uint16_t hdr)
{
  fpga_cs_low();
  (void)spic_txrx((uint8_t)(hdr >> 8));
  (void)spic_txrx((uint8_t)(hdr & 0xFF));
  fpga_cs_high();
}

void spic_packed_write(const uint8_t* data, uint16_t len)
{
  if (!data || !len) return;
  fpga_cs_low();
  for (uint16_t i = 0; i < len; i++)
    (void)spic_txrx(data[i]);
  fpga_cs_high();
}

/* Weak hooks — tbl2189 left empty until we confirm its exact location/length */
__attribute__((weak)) const uint8_t* fpga_tbl2189_data(uint16_t* out_len)
{
  if (out_len) *out_len = 0;
  return NULL;
}

/* Filled from dump/flash.hex @ 0x2B7C — first 4 non-0xFF bytes. */
__attribute__((weak)) const uint8_t* fpga_table_2B7C_data(uint16_t* out_len)
{
  /* Bytes extracted from flash at 0x2B7C:
     0x5E, 0x26, 0xAB, 0x7A
     Following bytes are 0xFF padding; table length interpreted as 4. */
  static const uint8_t k_table_2B7C[] = { 0x5E, 0x26, 0xAB, 0x7A };
  if (out_len) *out_len = (uint16_t)sizeof(k_table_2B7C);
  return k_table_2B7C;
}

void spic_send_cmd_3c_then_tbl2189(void)
{
  uint16_t n = 0;
  const uint8_t* p = fpga_tbl2189_data(&n);

  fpga_cs_low();
  (void)spic_txrx(0x3C);
  for (uint16_t i = 0; i < n; i++)
    (void)spic_txrx(p[i]);
  fpga_cs_high();

  spic_post_write_update();
}

void spic_upload_table_from_2B7C(void)
{
  uint16_t n = 0;
  const uint8_t* p = fpga_table_2B7C_data(&n);
  if (p && n) {
    fpga_cs_low();
    for (uint16_t i = 0; i < n; i++)
      (void)spic_txrx(p[i]);
    fpga_cs_high();
  }
  spic_post_write_update();
}

void spic_post_write_update(void)
{
  /* _delay_us(20) @ F_CPU=32 MHz -> 32e6 * 20e-6 = 640 cykli -> loop2: 640/4 = 160 */
  _delay_loop_2(160);

  fpga_poll_irq();
  emit_status();
}

void fpga_trigger_reconfig_pulse(void)
{
  out_clr(&FPGA_PORTD, FPGA_RECONF_bm);
  /* _delay_ms(1) @ 32 MHz -> 32,000 cykli -> loop2: 32,000/4 = 8,000 */
  _delay_loop_2(8000);
  out_set(&FPGA_PORTD, FPGA_RECONF_bm);
}

void fpga_reset_assert(bool assert_line)
{
  if (assert_line) out_clr(&FPGA_PORTB, FPGA_RST_bm);
  else             out_set(&FPGA_PORTB, FPGA_RST_bm);
}

fpga_status_t fpga_get_status(void)
{
  return sample_status();
}

void fpga_poll_irq(void)
{
  /* If your fabric requires SPI readback to clear IRQ, add it here or expose a hook. */
  emit_status();
}

