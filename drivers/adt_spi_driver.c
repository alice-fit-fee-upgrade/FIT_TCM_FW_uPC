#include "adt_spi_driver.h"
#include "port_driver.h"

void adt_spi_write_and_read(struct adt_spi_desc *p_spi_desc, uint8_t *p_data_buf, uint8_t data_len)
{
    PORT_ClearPins(p_spi_desc->cs_port, p_spi_desc->cs_pin);
    for(uint8_t data_cnt = 0; data_cnt < data_len; data_cnt++)
    {
        uint8_t data_cur = p_data_buf[data_cnt];
        uint8_t bit_cnt = 8;
        uint8_t data_in = 0;
        do
        {
            if ((data_cur & 0x80) != 0)
            {
                PORT_SetPins(p_spi_desc->spi_port, p_spi_desc->mosi_pin);
            }
            else
            {
                PORT_ClearPins(p_spi_desc->spi_port, p_spi_desc->mosi_pin);
            }
            PORT_ClearPins(p_spi_desc->spi_port, p_spi_desc->clk_pin);
            PORT_SetPins(p_spi_desc->spi_port, p_spi_desc->clk_pin);
            data_in = PORT_GetPinValue(p_spi_desc->spi_port, p_spi_desc->miso_pin);
            data_cur = ((data_cur << 1) | data_in);
        }
        while (--bit_cnt != 0);
        p_data_buf[data_cnt] = data_cur;
    }
    PORT_SetPins(p_spi_desc->cs_port, p_spi_desc->cs_pin);

    return;
}