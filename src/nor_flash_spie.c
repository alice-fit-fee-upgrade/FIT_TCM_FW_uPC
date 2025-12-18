/**
 * @file    nor_flash_spie.c
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
 * nor_flash_spie.c
 * Low-level NOR Flash (S25FL064) driver over SPIE (XMEGA)
 */

#include <avr/io.h>
#include <string.h>
#include "nor_flash_spie.h"

/* --------- SPI CTRL defaults (XMEGA) ---------------------------------------
 * SPIx.CTRL bits (datasheet): ENABLE, MASTER, MODE[1:0], PRESCALER[1:0], DORD
 * We'll pick: Master, Mode0, MSB first, fper/4. Adjust if needed.
 */
#ifndef NORF_SPI_CTRL_VALUE
#  define NORF_SPI_CTRL_VALUE   (SPI_ENABLE_bm | SPI_MASTER_bm /* MODE0 default, prescaler /4 */)
#endif

/* -------------------- Private helpers ------------------------------------- */
static inline void cs_low(void)  { NORF_PORT.OUTCLR = NORF_CS_bm; }
static inline void cs_high(void) { NORF_PORT.OUTSET = NORF_CS_bm; }

static inline uint8_t spie_xfer(uint8_t v)
{
  NORF_SPI.DATA = v;
  /* wait for IF (transfer complete) */
  while ((NORF_SPI.STATUS & SPI_IF_bm) == 0) { /* spin */ }
  return NORF_SPI.DATA;
}

static inline void send_addr24(uint32_t a)
{
  spie_xfer((uint8_t)(a >> 16));
  spie_xfer((uint8_t)(a >> 8));
  spie_xfer((uint8_t)(a >> 0));
}

/* -------------------- Public API ------------------------------------------ */
void norf_init(void)
{
  /* Pins: CS, SCK, MOSI as outputs; MISO as input */
  NORF_PORT.DIRSET = NORF_CS_bm | NORF_SCK_bm | NORF_MOSI_bm;
  NORF_PORT.DIRCLR = NORF_MISO_bm;
  cs_high();

  /* SPI: Master, Mode0, MSB first, prescaler /4 */
  NORF_SPI.CTRL    = NORF_SPI_CTRL_VALUE;
  NORF_SPI.INTCTRL = 0; /* no interrupts */
}

uint8_t norf_read_status(void)
{
  uint8_t s;
  cs_low();
  spie_xfer(NORF_OP_RDSR);
  s = spie_xfer(0xFF);
  cs_high();
  return s;
}

bool norf_wait_wip_clear(uint32_t timeout_iter)
{
  if (timeout_iter == 0) timeout_iter = NORF_DEFAULT_POLL;
  while (timeout_iter--) {
    if ((norf_read_status() & NORF_SR_WIP_bm) == 0) return true;
  }
  return false;
}

bool norf_write_enable(void)
{
  if (!spie_send_cmd_06()) return false;
  /* Optional check */
  return (norf_read_status() & NORF_SR_WEL_bm) != 0;
}

bool norf_read_jedec_id(NorfJedecId* out_id)
{
  if (!out_id) return false;
  NorfJedecId id = {0};

  cs_low();
  spie_xfer(NORF_OP_RDID);
  id.manufacturer  = spie_xfer(0xFF);
  id.memory_type   = spie_xfer(0xFF);
  id.capacity_code = spie_xfer(0xFF);
  cs_high();

  *out_id = id;
  return true;
}

bool norf_read(uint32_t addr24, uint8_t* out, size_t len)
{
  if (!out || len == 0) return false;
  cs_low();
  spie_xfer(NORF_OP_READ);
  send_addr24(addr24);
  for (size_t i = 0; i < len; i++) out[i] = spie_xfer(0xFF);
  cs_high();
  return true;
}

bool norf_fast_read(uint32_t addr24, uint8_t* out, size_t len)
{
  if (!out || len == 0) return false;
  cs_low();
  spie_xfer(NORF_OP_FAST_READ);
  send_addr24(addr24);
  (void)spie_xfer(0x00); /* dummy */
  for (size_t i = 0; i < len; i++) out[i] = spie_xfer(0xFF);
  cs_high();
  return true;
}

bool norf_page_program(uint32_t addr24, const uint8_t* data, size_t len, uint32_t timeout_iter)
{
  if (!data || len == 0) return false;
  /* Caller ensures we don't cross page boundary. */
  if (!norf_write_enable()) return false;

  cs_low();
  spie_xfer(NORF_OP_PP);
  send_addr24(addr24);
  for (size_t i = 0; i < len; i++) spie_xfer(data[i]);
  cs_high();

  if (timeout_iter == 0) timeout_iter = NORF_DEFAULT_PROGRAM;
  return norf_wait_wip_clear(timeout_iter);
}

bool norf_erase(uint8_t erase_opcode, uint32_t addr24, uint32_t timeout_iter)
{
  if (!norf_write_enable()) return false;

  cs_low();
  spie_xfer(erase_opcode);   /* NORF_OP_ERASE_64K (0xD8) or NORF_OP_ERASE_4K (0x20) */
  send_addr24(addr24);
  cs_high();

  if (timeout_iter == 0) timeout_iter = NORF_DEFAULT_ERASE;
  return norf_wait_wip_clear(timeout_iter);
}

/* -------------------- ASM-compat shims ------------------------------------ */
void spie_release_cs(void) { cs_high(); }

bool spie_send_cmd_06(void)
{
  cs_low();
  spie_xfer(NORF_OP_WREN);
  cs_high();
  return true;
}

bool spie_wait_wip_clear(uint32_t timeout_iter)
{
  return norf_wait_wip_clear(timeout_iter);
}

/* Short helper with 16-bit parameter (seen in asm). */
bool spie_send_cmd_param16(uint8_t opcode, uint16_t param)
{
  cs_low();
  spie_xfer(opcode);
  spie_xfer((uint8_t)(param >> 8));
  spie_xfer((uint8_t)(param & 0xFF));
  cs_high();
  return true;
}

/* Erase helper mirroring asm behavior; default 24-bit addressing. */
bool spie_erase_block(uint32_t addr24, uint8_t opcode, uint32_t timeout_iter)
{
  return norf_erase(opcode, addr24, timeout_iter);
}

bool spie_read_id(NorfJedecId* out_id)
{
  return norf_read_jedec_id(out_id);
}

/* -------------------- Optional sequencer stubs (weak) --------------------- */
__attribute__((weak))
bool spie_send_from_table_21AE(const uint8_t* table, size_t len)
{
  if (!table || !len) return false;
  cs_low();
  for (size_t i = 0; i < len; i++) (void)spie_xfer(table[i]);
  cs_high();
  return true;
}

__attribute__((weak))
bool spie_send_from_table_2(const uint8_t* table, size_t len)
{
  return spie_send_from_table_21AE(table, len);
}

__attribute__((weak))
bool spie_gf2_block_process(const uint8_t* src, size_t len, uint32_t base_addr)
{
  (void)src; (void)len; (void)base_addr;
  /* Implement if/when you reconstruct exact GF2/table process from asm */
  return false;
}

