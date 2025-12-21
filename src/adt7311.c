/**
 * @file    adt7311.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements a software (bit-banging) SPI driver for the ADT7311 temperature
 * sensor. Responsible for sensor initialization and reading temperature data
 * used to monitor TCM operating conditions.
 */

/*
 * adt7311.c
 * Bit-banged SPI driver for ADT7311 (SPI Mode 3) — AVR XMEGA Port A
 *
 * This implementation mirrors the ASM behavior:
 *  - Post-init writes:
 *      CONFIG    = 0x50 (RES=0 → 13-bit)
 *      TCRIT_HI  = 0x0023
 *      THIGH     = 0x001E
 *  - pa_bb_send_4x_ff equivalent is void: adt7311_clock_4x_ff()
 */

#include <avr/io.h>
#include "adt7311.h"

/* ----------------- Tiny spin delay (cycle-based) -------------------------- */
static inline void spin_delay(unsigned n)
{
  while (n--) { __asm__ __volatile__("nop"); }
}

/* ----------------- GPIO helpers ------------------------------------------ */
static inline void sclk_high(void) { ADT_PORT.OUTSET = ADT_SCLK_bm; }
static inline void sclk_low(void)  { ADT_PORT.OUTCLR = ADT_SCLK_bm; }
static inline void din_high(void)  { ADT_PORT.OUTSET = ADT_DIN_bm; }
static inline void din_low(void)   { ADT_PORT.OUTCLR = ADT_DIN_bm; }
static inline uint8_t dout_sample(void)
{
  return (ADT_PORT.IN & ADT_DOUT_bm) ? 1u : 0u;
}

void adt7311_cs_low(void)  { ADT_PORT.OUTCLR = ADT_CS_bm; }
void adt7311_cs_high(void) { ADT_PORT.OUTSET = ADT_CS_bm; }

/* ----------------- Initialization ---------------------------------------- */
void adt7311_init(void)
{
  /* Directions: SCLK/DIN/CS outputs, DOUT input */
  ADT_PORT.DIRSET = ADT_SCLK_bm | ADT_DIN_bm | ADT_CS_bm;
  ADT_PORT.DIRCLR = ADT_DOUT_bm;

  /* SPI Mode 3 idle levels */
  sclk_high();
  din_low();
  adt7311_cs_high();

  /* Power-up settle */
  spin_delay(2000);

  /* ASM-equivalent post-init sequence */
  adt7311_post_init_sequence();
}

/* Weak hook: implemented here to match ASM defaults exactly. */
__attribute__((weak)) void adt7311_post_init_sequence(void)
{
  /* CONFIG = 0x50 (RES=0 → 13-bit; other bits per ASM snapshot) */
  (void)adt7311_write_reg8(ADT_REG_CONFIG, 0x50);

  /* TCRIT_HI = 0x0023 */
  (void)adt7311_write_reg16(ADT_REG_TCRIT_HI, 0x0023);

  /* THIGH = 0x001E */
  (void)adt7311_write_reg16(ADT_REG_THIGH, 0x001E);
}

/* ----------------- Bit-banged SPI (Mode 3) --------------------------------
 * Per bit:
 *   - Idle: SCLK=HIGH
 *   - Drive MOSI, small setup delay
 *   - Falling edge (HIGH→LOW), short hold
 *   - Rising edge (LOW→HIGH) and sample MISO
 */
uint8_t adt7311_shift_byte(uint8_t tx)
{
  uint8_t rx = 0;

  for (uint8_t i = 0; i < 8; i++) {
    if (tx & 0x80) din_high(); else din_low();
    tx <<= 1;
    spin_delay(ADT_TSU_NS);

    sclk_low();
    spin_delay(ADT_TH_NS);

    sclk_high();
    rx <<= 1;
    if (dout_sample()) rx |= 1u;

    spin_delay(ADT_TSU_NS);
  }

  return rx;
}

/* ----------------- Register access --------------------------------------- */
bool adt7311_read_reg8(uint8_t reg, uint8_t* out)
{
  if (!out) return false;

  adt7311_cs_low();
  (void)adt7311_shift_byte(ADT_CMD_READ(reg));
  *out = adt7311_shift_byte(0xFF);
  adt7311_cs_high();
  return true;
}

bool adt7311_write_reg8(uint8_t reg, uint8_t val)
{
  adt7311_cs_low();
  (void)adt7311_shift_byte(ADT_CMD_WRITE(reg));
  (void)adt7311_shift_byte(val);
  adt7311_cs_high();
  return true;
}

bool adt7311_read_reg16(uint8_t reg, uint16_t* out)
{
  if (!out) return false;
  uint8_t msb, lsb;

  adt7311_cs_low();
  (void)adt7311_shift_byte(ADT_CMD_READ(reg));
  msb = adt7311_shift_byte(0xFF);
  lsb = adt7311_shift_byte(0xFF);
  adt7311_cs_high();

  *out = ((uint16_t)msb << 8) | lsb;
  return true;
}

bool adt7311_write_reg16(uint8_t reg, uint16_t val)
{
  adt7311_cs_low();
  (void)adt7311_shift_byte(ADT_CMD_WRITE(reg));
  (void)adt7311_shift_byte((uint8_t)(val >> 8));
  (void)adt7311_shift_byte((uint8_t)(val & 0xFF));
  adt7311_cs_high();
  return true;
}

/* ----------------- Temperature helpers ----------------------------------- */
bool adt7311_read_temp_raw(uint16_t* out_raw)
{
  return adt7311_read_reg16(ADT_REG_TEMPERATURE, out_raw);
}

/* Convert raw to 0.01°C:
 *  - If CONFIG.RES=1 (16-bit): 0.0078125°C/LSB → (raw * 25)/32 centiC
 *  - If CONFIG.RES=0 (13-bit): raw is top-justified → shift >>3 first,
 *    0.0625°C/LSB → (raw13 * 25)/4 centiC
 */
bool adt7311_read_temp_centiC(int16_t* out_cC)
{
  if (!out_cC) return false;

  uint8_t cfg;
  if (!adt7311_read_reg8(ADT_REG_CONFIG, &cfg)) return false;

  uint16_t raw;
  if (!adt7311_read_temp_raw(&raw)) return false;

  if (cfg & (1u << 7)) {
    int32_t cc = ((int32_t)(int16_t)raw * 25) / 32;
    *out_cC = (int16_t)cc;
  } else {
    int16_t s = (int16_t)raw;
    s >>= 3;
    int32_t cc = ((int32_t)s * 25) / 4;
    *out_cC = (int16_t)cc;
  }
  return true;
}

/* ----------------- Convenience helpers (legacy-equivalents) -------------- */

uint8_t adt7311_send2(uint8_t b0, uint8_t b1)
{
  uint8_t rx = 0;
  adt7311_cs_low();
  (void)adt7311_shift_byte(b0);
  rx = adt7311_shift_byte(b1);
  adt7311_cs_high();
  return rx;
}

uint8_t adt7311_send3(uint8_t b0, uint8_t b1, uint8_t b2)
{
  uint8_t rx = 0;
  adt7311_cs_low();
  (void)adt7311_shift_byte(b0);
  (void)adt7311_shift_byte(b1);
  rx = adt7311_shift_byte(b2);
  adt7311_cs_high();
  return rx;
}

/* EXACT ASM counterpart of pa_bb_send_4x_ff: no return value */
void adt7311_clock_4x_ff(void)
{
  adt7311_cs_low();
  (void)adt7311_shift_byte(0xFF);
  (void)adt7311_shift_byte(0xFF);
  (void)adt7311_shift_byte(0xFF);
  (void)adt7311_shift_byte(0xFF);
  adt7311_cs_high();
}

/* Generic N-byte transfer with CS wrapped */
void adt7311_transfer_n(const uint8_t* tx, uint8_t* rx, size_t len)
{
  adt7311_cs_low();
  for (size_t i = 0; i < len; i++) {
    uint8_t r = adt7311_shift_byte(tx ? tx[i] : 0xFF);
    if (rx) rx[i] = r;
  }
  adt7311_cs_high();
}

/* -------- Optional resolution setters (not used in ASM by default) -------- */
static bool adt7311_update_res_bit(bool res16)
{
  uint8_t cfg;
  if (!adt7311_read_reg8(ADT_REG_CONFIG, &cfg)) return false;
  if (res16) cfg |=  (1u << 7);
  else       cfg &= ~(1u << 7);
  return adt7311_write_reg8(ADT_REG_CONFIG, cfg);
}

bool adt7311_set_resolution_13bit(void) { return adt7311_update_res_bit(false); }
bool adt7311_set_resolution_16bit(void) { return adt7311_update_res_bit(true);  }

