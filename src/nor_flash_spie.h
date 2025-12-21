/**
 * @file    nor_flash_spie.h
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Declares the interface of the NOR Flash memory driver and basic memory
 * operations.
 */

/*
 * nor_flash_spie.h
 * Reconstructed low-level NOR Flash (S25FL064) driver over SPIE (XMEGA, Port E)
 * Minimal deps: <avr/io.h>, <stdint.h>, <stdbool.h>, <stddef.h>
 *
 * You may override pin/peripheral macros BEFORE including this header.
 */
#ifndef NOR_FLASH_SPIE_H
#define NOR_FLASH_SPIE_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

/* -------------------- Hardware mapping (override as needed) ---------------- */
#ifndef NORF_SPI
#  define NORF_SPI            SPIE
#endif

#ifndef NORF_PORT
#  define NORF_PORT           PORTE
#endif

#ifndef NORF_CS_bm
#  define NORF_CS_bm          PIN4_bm   /* PE4: CFG_FCS (active low) */
#endif
#ifndef NORF_SCK_bm
#  define NORF_SCK_bm         PIN7_bm   /* PE7: CFG_CCLK */
#endif
#ifndef NORF_MOSI_bm
#  define NORF_MOSI_bm        PIN5_bm   /* PE5: CFG_MOSI_DQ0 */
#endif
#ifndef NORF_MISO_bm
#  define NORF_MISO_bm        PIN6_bm   /* PE6: CFG_DIN_DQ1 */
#endif

/* -------------------- JEDEC opcodes & status bits ------------------------- */
enum {
  NORF_OP_WREN          = 0x06,
  NORF_OP_WRDI          = 0x04,
  NORF_OP_RDSR          = 0x05,
  NORF_OP_WRSR          = 0x01,
  NORF_OP_RDID          = 0x9F,
  NORF_OP_READ          = 0x03,
  NORF_OP_FAST_READ     = 0x0B,
  NORF_OP_PP            = 0x02,
  NORF_OP_ERASE_4K      = 0x20, /* if supported */
  NORF_OP_ERASE_64K     = 0xD8,
  NORF_OP_CHIP_ERASE    = 0xC7
};

enum {
  NORF_SR_WIP_bm        = 1u << 0, /* Write-In-Progress */
  NORF_SR_WEL_bm        = 1u << 1  /* Write Enable Latch */
};

/* -------------------- Device info / timeouts ------------------------------ */
typedef struct {
  uint8_t manufacturer;
  uint8_t memory_type;
  uint8_t capacity_code;
} NorfJedecId;

typedef struct {
  uint32_t poll_status_timeout;  /* default: 100000 */
  uint32_t erase_timeout;        /* default: 5000000 */
  uint32_t program_timeout;      /* default: 200000 */
} NorfTimeouts;

#ifndef NORF_DEFAULT_POLL
#  define NORF_DEFAULT_POLL     (100000u)
#endif
#ifndef NORF_DEFAULT_ERASE
#  define NORF_DEFAULT_ERASE    (5000000u)
#endif
#ifndef NORF_DEFAULT_PROGRAM
#  define NORF_DEFAULT_PROGRAM  (200000u)
#endif

#ifndef NORF_PAGE_SIZE
#  define NORF_PAGE_SIZE        (256u) /* typical page size */
#endif

/* -------------------- Public API (stable) --------------------------------- */
/* Configure SPIE and pins; call once on startup. */
void norf_init(void);

/* JEDEC ID (0x9F). */
bool norf_read_jedec_id(NorfJedecId* out_id);

/* Read Status Register (0x05). */
uint8_t norf_read_status(void);

/* Wait for WIP=0. Timeout is loop-based. Returns true if cleared before timeout. */
bool norf_wait_wip_clear(uint32_t timeout_iter);

/* Write Enable (0x06) + optional WEL verify. */
bool norf_write_enable(void);

/* Erase by 24-bit address: opcode usually NORF_OP_ERASE_64K or NORF_OP_ERASE_4K. */
bool norf_erase(uint8_t erase_opcode, uint32_t addr24, uint32_t timeout_iter);

/* Page Program (0x02). 'len' should not cross the page boundary (caller responsibility). */
bool norf_page_program(uint32_t addr24, const uint8_t* data, size_t len, uint32_t timeout_iter);

/* Blocking reads. */
bool norf_read(uint32_t addr24, uint8_t* out, size_t len);
bool norf_fast_read(uint32_t addr24, uint8_t* out, size_t len);

/* -------------------- ASM-compat shims (names seen in asm) ---------------- */
void  spie_release_cs(void);
bool  spie_send_cmd_06(void);                                 /* WREN */
bool  spie_wait_wip_clear(uint32_t timeout_iter);              /* alias to norf_wait_wip_clear */
bool  spie_send_cmd_param16(uint8_t opcode, uint16_t param);   /* short-form helper */
bool  spie_erase_block(uint32_t addr24, uint8_t opcode, uint32_t timeout_iter);
bool  spie_read_id(NorfJedecId* out_id);

/* Optional table/sequencer hooks (weak; can be overridden) */
bool  spie_send_from_table_21AE(const uint8_t* table, size_t len);
bool  spie_send_from_table_2(const uint8_t* table, size_t len);
bool  spie_gf2_block_process(const uint8_t* src, size_t len, uint32_t base_addr);

#endif /* NOR_FLASH_SPIE_H */

