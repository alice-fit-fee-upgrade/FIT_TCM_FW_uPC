#include "adt7311.h"

#include <util/delay.h>

#include "drivers/port_driver.h"
#include "drivers/adt_spi_driver.h"

struct adt7311_dev adt7311_dev;

/** 
 * @brief Reads the value of a register SPI interface device.
 *
 * @param reg_addr - Address of the register.
 * @param data - Pointer to the register value
 *
 * @return register_value  - Value of the register.
 */
static int adt7311_reg_read(uint16_t reg_addr, uint16_t *p_data)
{
	uint8_t data_buf[3] = { 0, 0, 0 };
	uint8_t data_len = ((reg_addr & ADT7311_REG_LEN_bm) >> ADT7311_REG_LEN_bp);

	data_buf[0] = (ADT7311_CMD_READ | (reg_addr & ADT7311_ADDR_MSK) << 3);
	adt_spi_write_and_read(adt7311_dev.p_spi_desc, data_buf, data_len);

	if (data_len == 2)
    {
		*p_data = data_buf[1];
    }
	else
    {
		*p_data = (data_buf[1] << 8 | data_buf[2]);
    }

	return 0;
}

/**
 * @brief Write a value of a register via SPI
 * 
 * @param reg_addr - Address of the register.
 * @param data - Pointer to the register value
 * 
 * @return 0 in case of success, -1 otherwise.
 */
int adt7311_reg_write(uint16_t reg_addr, uint32_t data)
{
	uint8_t data_buf[3] = { 0, 0, 0 };
	uint8_t data_len = ((reg_addr & ADT7311_REG_LEN_bm) >> ADT7311_REG_LEN_bp);

    data_buf[0] = (ADT7311_CMD_WRITE_MSK & (reg_addr & ADT7311_ADDR_MSK) << 3);

    if (3 == data_len)
    {
        data_buf[1] = (data >> 8);
        data_buf[2] = (data & 0xFF);
    }
    else
    {
		data_buf[1] = (data & 0xFF);
	}
    adt_spi_write_and_read(adt7311_dev.p_spi_desc, data_buf, data_len);
    

	return 0;
}

/**
 * @brief Sets the value of a register
 *
 * @param reg_addr - Address of the register.
 * @param mask		   - Bit Mask of the bit to be written
 * @param value		   - Value of the bit
 *
 * @return 0 in case of success, -1 otherwise.
 */

static int adt7311_reg_update(uint16_t reg_addr, uint8_t mask, uint8_t value)
{
	uint16_t reg_val;

	if (adt7311_reg_read(reg_addr, &reg_val))
    {
		return -1;
    }

	reg_val &= ~mask;
	reg_val |= value;

	return adt7311_reg_write(reg_addr, reg_val);
}

/***
 * @brief Reads the temperature data and converts it to Celsius degrees.
 *
 * @return temperature - Temperature in degrees Celsius.
 */
float adt7311_temperature_get(uint8_t *p_flags)
{
	uint16_t temp_reg = 0;
	float temp_c = 0;
    *p_flags = 0;

	adt7311_reg_read(ADT7311_REG_TEMP, &temp_reg);

    switch (adt7311_dev.resolution)
    {
        case ADT7311_RES_13BIT:
        {
            *p_flags = (ADT7311_TEMP_FLAG_bm & temp_reg);
            temp_reg >>= 3;
		    if (temp_reg & ADT7311_13BIT_SIGN)
			{
			    temp_c = (float)((int32_t)temp_reg - ADT7311_13BIT_NEG) / ADT7311_13BIT_DIV;
            }
		    else
			{
			    temp_c = (float)temp_reg / ADT7311_13BIT_DIV;
            }
            break;
        }
        case ADT7311_RES_16BIT:
        {
            if (temp_reg & ADT7311_16BIT_SIGN)
            {
			    temp_c = (float)((int32_t)temp_reg - ADT7311_16BIT_NEG) / ADT7311_16BIT_DIV;
            }
		    else
			{
			    temp_c = (float)temp_reg / ADT7311_16BIT_DIV;
            }
            break;
        }
        default:
        {
            /* This cannot happen :) */
            break;
        }
    }

	return temp_c;
}

/**
 * @brief Sets the operational mode for ADT7311.
 *
 * @param mode - Operation mode.
 *               Example: ADT7420_OP_MODE_CONT_CONV - continuous conversion;
 *                        ADT7420_OP_MODE_ONE_SHOT  - one shot;
 *                        ADT7420_OP_MODE_1_SPS     - 1 SPS mode;
 *                        ADT7420_OP_MODE_SHUTDOWN  - shutdown.
 */
int adt7311_operation_mode_set(uint8_t mode)
{
    int status;
    status = adt7311_reg_update(
        ADT7311_REG_CONFIG, 
        ADT7311_CF_REG_OPMODE_bm, 
        mode << ADT7311_CF_REG_OPMODE_bp);

    return status;
}

/**
 * @brief Sets the resolution for ADT7311.
 *
 * @param resolution - Resolution.
 *                     Example: 0 - 13-bit resolution;
 *                              1 - 16-bit resolution.
 */
int adt7311_set_resolution(uint8_t resolution)
{
    int status;

    status = adt7311_reg_update(
        ADT7311_REG_CONFIG,
        ADT7311_CF_REG_RES_bm, 
        resolution << ADT7311_CF_REG_RES_bp);

    adt7311_dev.resolution = resolution;

return status;
}

/**
 * @brief Resets the SPI inteface for the ADT7311
 *
 * @return 0 in case of Success, -1 otherwise.
 */
int32_t adt7311_reset(void)
{
	uint8_t data_buffer[] = { 0xFF, 0xFF, 0xFF, 0xFF };
    adt_spi_write_and_read(adt7311_dev.p_spi_desc, data_buffer, sizeof(data_buffer));
	
    _delay_ms(ADT7311_RST_DELAY_MS);
	
	adt7311_dev.resolution = ADT7311_RES_13BIT;

	return 0;
}

/**
 * @brief Initializes the communication peripheral and checks if the device is
 *        present.
 *
 * @param device     - The device structure.
 * @param init_param - The structure that contains the device initial
 * 		       parameters.
 *
 * @return status - The result of the initialization procedure.
 *                  Example: -1 - peripheral was not initialized or the
 *                                device is not present.
 *                            0 - peripheral was initialized and the
 *                                device is present.
 */
int32_t adt7311_init(struct adt_spi_desc *p_spi_desc, uint8_t config_reg)
{
    int32_t status = 0;
    uint16_t dev_id = 0;

    adt7311_dev.p_spi_desc = p_spi_desc;
    adt7311_dev.config_reg = config_reg;
    adt7311_dev.resolution = (config_reg & ADT7311_CF_REG_RES_bm);

    /* Reset and get device ID just to be sure it works */
    adt7311_reset();
    adt7311_reg_read(ADT7311_REG_ID, &dev_id);

    if (dev_id != ADT7311_REV_MAN_ID)
    {
        status = -1;
    }

    /* Configure device */
    adt7311_reg_write(ADT7311_REG_CONFIG, config_reg);

    return status;
}

