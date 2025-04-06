#pragma once

#include "port_driver.h"

struct adt_spi_desc
{
    PORT_t *cs_port;
    uint8_t cs_pin;
    PORT_t *spi_port;
    uint8_t clk_pin;
    uint8_t mosi_pin;
    uint8_t miso_pin;
};

void adt_spi_write_and_read(
    struct adt_spi_desc *p_spi_desc, 
    uint8_t *p_data_buf, 
    uint8_t data_len
);