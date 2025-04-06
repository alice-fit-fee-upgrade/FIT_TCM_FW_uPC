#pragma once

#include <stdint.h>

#include <avr/io.h>
#include "drivers/adt_spi_driver.h"


/* ADT7311 command byte */
#define ADT7311_CMD_WRITE_MSK	(0b00111000)            // SPI write command mask
#define ADT7311_CMD_READ		(0b01000000)            // SPI read command
#define ADT7311_ADDR_MSK		(0x07)

/* ADT7311 registers */
#define ADT7311_REG_LEN_8		(0x80)      // 8-bit register indicator
#define ADT7311_REG_LEN_16		(0xC0)      // 16-bit register indicator
#define ADT7311_REG_LEN_bm	    (0xC0)      // register indicator bitmask
#define ADT7311_REG_LEN_bp      (6)         // register indicator bits position

#define ADT7311_REG_STATUS		(ADT7311_REG_LEN_8  | 0x00) // Status info
#define ADT7311_REG_CONFIG		(ADT7311_REG_LEN_8  | 0x01) // Configuration
#define ADT7311_REG_TEMP    	(ADT7311_REG_LEN_16 | 0x02) // Temperature value
#define ADT7311_REG_ID			(ADT7311_REG_LEN_8  | 0x03) // ID value
#define ADT7311_REG_T_CRIT		(ADT7311_REG_LEN_16 | 0x04) // Temperature CRIT setpoint
#define ADT7311_REG_HIST		(ADT7311_REG_LEN_8  | 0x05) // Temperature HYST setpoint
#define ADT7311_REG_T_HIGH      (ADT7311_REG_LEN_16 | 0x06) // Temperature HIGH setpoint
#define ADT7311_REG_T_LOW    	(ADT7311_REG_LEN_16 | 0x07) // Temperature LOW setpoint

/* ADT7311 status register */
#define ADT7311_STATUS_T_LOW    (0b00010000)
#define ADT7311_STATUS_T_HIGH   (0b00100000)
#define ADT7311_STATUS_T_CRIT   (0b01000000)
#define ADT7311_STATUS_RDY      (0b10000000)

/* ADT7311 configuration register */
#define ADT7311_CF_REG_FLTQ_bp      (0)
#define ADT7311_CF_REG_FLTQ_bm      (3 << ADT7311_CF_REG_FLTQ_bp)
#define ADT7311_CF_REG_CTPP_bp      (2)
#define ADT7311_CF_REG_CTPP_bm      (1 << ADT7311_CF_REG_CTPP_bp)
#define ADT7311_CF_REG_INTPP_bp     (3)
#define ADT7311_CF_REG_INTPP_bm     (1 << ADT7311_CF_REG_INTPP_bp)
#define ADT7311_CF_REG_ICMODE_bp    (4)
#define ADT7311_CF_REG_ICMODE_bm    (1 << ADT7311_CF_REG_ICMODE_bp)
#define ADT7311_CF_REG_OPMODE_bp    (5)
#define ADT7311_CF_REG_OPMODE_bm    (3 << ADT7311_CF_REG_OPMODE_bp)
#define ADT7311_CF_REG_RES_bp       (7)
#define ADT7311_CF_REG_RES_bm       (1 << ADT7311_CF_REG_RES_bp)

/* ADT7311 fault queue options */
#define ADT7311_FLTQ_1_FAULT        (0)
#define ADT7311_FLTQ_2_FAULTS       (1)
#define ADT7311_FLTQ_3_FAULTS       (2)
#define ADT7311_FLTQ_4_FAULTS       (3)

/* ADT7311 CT pin polarity options */
#define ADT7311_CTPP_LO             (0)
#define ADT7311_CTPP_HI             (1)

/* ADT7311 INT pin polarity options */
#define ADT7311_INTPP_LO            (0)
#define ADT7311_INTPP_HI            (1)

/* ADT7311 INT/CT mode options */
#define ADT7311_ICMODE_INTR         (0)
#define ADT7311_ICMODE_COMP         (1)

/* ADT7311 operation mode options */
#define ADT7311_OP_MODE_CONT_CONV	(0)
#define ADT7311_OP_MODE_ONE_SHOT	(1)
#define ADT7311_OP_MODE_1_SPS		(2)
#define ADT7311_OP_MODE_SHUTDOWN	(3)

/* ADT7311 resolution options */
#define ADT7311_RES_13BIT           (0)
#define ADT7311_RES_16BIT           (1)

/* ADT7311 temperature definitions */
#define ADT7311_16BIT_NEG			(1UL << 16)
#define ADT7311_16BIT_SIGN			(0x8000)
#define ADT7311_16BIT_DIV			(128)
#define ADT7311_13BIT_NEG			(1 << 13)
#define ADT7311_13BIT_SIGN			(0x1000)
#define ADT7311_13BIT_DIV			(16)

#define ADT7311_TEMP_FLAG_LO        (0x01)
#define ADT7311_TEMP_FLAG_HI        (0x02)
#define ADT7311_TEMP_FLAG_CR        (0x04)
#define ADT7311_TEMP_FLAG_bm        (0x07)

/* ADT7311 reset delay is recommended to be more than 500us */
#define ADT7311_RST_DELAY_MS 		(1)

/* ADT7311 devuce ID */
#define ADT7311_REV_MAN_ID			 (0x3C)

struct adt7311_dev 
{
	struct adt_spi_desc *p_spi_desc;
    uint8_t config_reg;
	uint8_t	resolution;
};

float adt7311_temperature_get(uint8_t *p_flags);
int32_t adt7311_init(struct adt_spi_desc *p_spi_desc, uint8_t config_reg);