#pragma once

#include <stdint.h>
#include <stdbool.h>

#include "timer.h"

struct system_eeprom
{
  uint8_t ip_addr[4];
  uint8_t mac_addr[6];
  int16_t a_side_phase;
  int16_t c_side_phase;
  int16_t laser_phase;
  uint16_t attenuator_config;
  uint8_t attenuator_portb_config;
  uint8_t _res0;
  int16_t vertex_time_low_th;
  int16_t vertex_time_high_th;
  uint16_t semicentral_lvl_a;
  uint16_t semicentral_lvl_c;
  uint16_t central_lvl_a;
  uint16_t central_lvl_c;
  uint16_t trigger_mode;
  uint16_t board_sn;
  uint8_t _res1;
};

struct system_status
{
  bool b_sys_fail;
  bool b_si5338_fail;
  bool b_pwr_in_ok;
  bool b_pwr_ldo_ok;
  bool b_fpga_done_ok;
  bool b_clk_err;
  uint8_t porte_status;
};

struct system_timers
{
    struct timer_state ts_fpga;
    struct timer_state ts_attenuator;
    struct timer_state ts_si5338;
};

void system_clock_init(void);
void system_init(void);
void system_deinit(void);
void system_restart(void);

struct system_eeprom *system_eeprom_get(void);
struct system_status *system_status_get(void);
struct system_timers *system_timers_get(void);
