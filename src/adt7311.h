/**
 * @file    adt7311.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the interface of the ADT7311 temperature sensor driver, including
 * GPIO line mapping and basic SPI communication functions.
 */

/*
 * adt7311.h
 * Bit-banged SPI driver for ADT7311 temperature sensor (AVR XMEGA, Port A)
 *
 * Default pin mapping:
 *   PA1 = SCLK
 *   PA2 = DOUT (MISO)
 *   PA3 = DIN  (MOSI)
 *   PA4 = CS   (active low)
 *
 * SPI mode: 3 (CPOL=1, CPHA=1)
 *   - SCLK idle high
 *   - Data valid on rising edge
 */

#ifndef ADT7311_H
#define ADT7311_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

/* -------- Default hardware mapping (override before including if needed) --- */
#ifndef ADT_PORT
#  define ADT_PORT        PORTA
#endif
#ifndef ADT_SCLK_bm
#  define ADT_SCLK_bm     PIN1_bm
#endif
#ifndef ADT_DOUT_bm
#  define ADT_DOUT_bm     PIN2_bm
#endif
#ifndef ADT_DIN_bm
#  define ADT_DIN_bm      PIN3_bm
#endif
#ifndef ADT_CS_bm
#  define ADT_CS_bm       PIN4_bm
#endif

/* -------- Bit-bang timing constants (symbolic spin counts) ---------------- */
#ifndef ADT_TSU_NS
#  define ADT_TSU_NS      200  /* setup */
#endif
#ifndef ADT_TH_NS
#  define ADT_TH_NS       200  /* hold  */
#endif

/* -------- ADT7311 register map -------------------------------------------- */
enum {
  ADT_REG_TEMPERATURE  = 0x00, /* 16-bit */
  ADT_REG_CONFIG       = 0x01, /* 8-bit  (bit7=RES) */
  ADT_REG_STATUS       = 0x02, /* 8-bit */
  ADT_REG_ID           = 0x03, /* 8-bit */
  ADT_REG_TCRIT_HI     = 0x04, /* 16-bit */
  ADT_REG_TCRIT_LO     = 0x05, /* 16-bit */
  ADT_REG_THIGH        = 0x06, /* 16-bit */
  ADT_REG_TLOW         = 0x07  /* 16-bit */
};

/* -------- Command helpers (R/W + 3-bit address) --------------------------- */
#define ADT_CMD_READ(addr)   ( (uint8_t)(0x40 | ((addr & 0x07) << 3)) )
#define ADT_CMD_WRITE(addr)  ( (uint8_t)(0x00 | ((addr & 0x07) << 3)) )

/* -------- Public API ------------------------------------------------------ */
void    adt7311_init(void);
/* Weak hook called by init. Implemented to match ASM (writes CONFIG/TCRIT_HI/THIGH). */
void    adt7311_post_init_sequence(void);

/* Core bit-bang SPI (Mode 3) + CS helpers */
uint8_t adt7311_shift_byte(uint8_t tx);
void    adt7311_cs_low(void);
void    adt7311_cs_high(void);

/* Register access */
bool    adt7311_read_reg8(uint8_t reg, uint8_t* out);
bool    adt7311_write_reg8(uint8_t reg, uint8_t val);
bool    adt7311_read_reg16(uint8_t reg, uint16_t* out);
bool    adt7311_write_reg16(uint8_t reg, uint16_t val);

/* Temperature helpers */
bool    adt7311_read_temp_raw(uint16_t* out_raw);
bool    adt7311_read_temp_centiC(int16_t* out_cC);

/* Convenience helpers (match legacy behavior) */
uint8_t adt7311_send2(uint8_t b0, uint8_t b1);
uint8_t adt7311_send3(uint8_t b0, uint8_t b1, uint8_t b2);
/* EXACT ASM: clock four 0xFF bytes under one CS pulse, no return value. */
void    adt7311_clock_4x_ff(void);
/* Generic N-byte transfer (CS wrapped). If rx!=NULL, fills received bytes. */
void    adt7311_transfer_n(const uint8_t* tx, uint8_t* rx, size_t len);

/* Optional resolution setters (not called by default; ASM uses CONFIG=0x50) */
bool    adt7311_set_resolution_13bit(void);
bool    adt7311_set_resolution_16bit(void);

#endif /* ADT7311_H */

