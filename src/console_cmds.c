/**
 * @file    console_cmds.c
 * @brief   ALICE FIT XMEGA firmware – Trigger & Controller Module (TCM)
 *
 * @project ALICE Fast Interaction Trigger (FIT)
 * @module  Trigger & Controller Module (TCM)
 * @target  ATxmega128A3 @ 32 MHz
 *
 * @details
 * Implements the complete set of commands available via the text console.
 * Handles system configuration, EEPROM parameter read/write operations, and
 * diagnostic commands.
 */

/*
 * console_cmds.c — full UART F0 command handler
 *
 * This version implements all placeholder commands (no __attribute__((weak))).
 * Runtime configuration is stored in RAM and can be written/read from EEPROM (XMEGA NVM).
 * Sections that need exact byte-level sequences from ASM are marked with // TODO(ASM).
 */

#include <avr/io.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>

#include "console_cmds.h"
#include "clock_mgmt.h"
#include "fpga_spic.h"
#include "power_supervision.h"
#include "led_status.h"

/* -------------------------------------------------------------------------- */
/* Basic UART TX helpers                                                      */
/* -------------------------------------------------------------------------- */
static void rj_puts(const char* s){
  while(*s){
    while(!(USARTF0.STATUS & USART_DREIF_bm)){}
    USARTF0.DATA = *s++;
  }
}
void rj_print_ok(void){ rj_puts("OK\r\n"); }
void rj_print_err(const char* code){ rj_puts("ERR "); rj_puts(code); rj_puts("\r\n"); }
void rj_println(const char* s){ rj_puts(s); rj_puts("\r\n"); }

/* -------------------------------------------------------------------------- */
/* Parser/console integration                                                 */
/* -------------------------------------------------------------------------- */
extern void console_enter_pass_thru_to_d0_until_esc(void);
extern void uartd0_write_byte(uint8_t b);

/* -------------------------------------------------------------------------- */
/* String parsing helpers                                                     */
/* -------------------------------------------------------------------------- */
static void trim_leading(const char** p){ while(**p==' '||**p=='\t') (*p)++; }
static void strtoupper_inplace(char* s){ for(;*s;++s) *s=(char)toupper((unsigned char)*s); }

static bool parse_u16_dec(const char* s, uint16_t* out){
  if (!s || !*s) return false;
  char* end = NULL;
  unsigned long v = strtoul(s, &end, 10);
  if (end == s || v > 0xFFFFUL) return false;
  *out = (uint16_t)v;
  return true;
}
static bool parse_ip(const char* s, uint8_t ip[4]){
  if (!s) return false;
  int a,b,c,d;
  if (sscanf(s,"%d.%d.%d.%d",&a,&b,&c,&d)!=4) return false;
  if (a<0||a>255||b<0||b>255||c<0||c>255||d<0||d>255) return false;
  ip[0]=a; ip[1]=b; ip[2]=c; ip[3]=d;
  return true;
}
static bool parse_mac(const char* s, uint8_t mac[6]){
  if (!s) return false;
  unsigned v[6];
  if (sscanf(s,"%2x:%2x:%2x:%2x:%2x:%2x",&v[0],&v[1],&v[2],&v[3],&v[4],&v[5])!=6) return false;
  for (int i=0;i<6;i++){ if(v[i]>0xFF) return false; mac[i]=(uint8_t)v[i]; }
  return true;
}

/* -------------------------------------------------------------------------- */
/* Runtime configuration + EEPROM storage                                    */
/* -------------------------------------------------------------------------- */
typedef struct {
  uint8_t  ip[4];
  uint8_t  mac[6];
  uint16_t phase_A;
  uint16_t phase_C;
  uint16_t phase_L;
  uint16_t vtx_thr_hi;
  uint16_t vtx_thr_lo;
  uint16_t trig_mode;
  uint16_t cent_A;
  uint16_t cent_C;
  uint16_t semic_A;
  uint16_t semic_C;
  uint8_t  att_steps;
  char     serial[24];
} RuntimeCfg;

static RuntimeCfg g_cfg;

/* Simple EEPROM interface (XMEGA NVM) */
#ifndef EE_BASE
#define EE_BASE       0x000
#endif
#define EE_MAGIC      0x55
#define EE_OFS_MAGIC  (EE_BASE + 0)
#define EE_OFS_DATA   (EE_BASE + 1)

static void nvm_wait(void){ while (NVM.STATUS & NVM_NVMBUSY_bm) {} }
static inline void nvm_cmd(uint8_t cmd){ NVM.CMD = cmd; }

static uint8_t eeprom_read_byte(uint16_t addr){
  nvm_wait();
  NVM.ADDR0 = (uint8_t)(addr & 0xFF);
  NVM.ADDR1 = (uint8_t)(addr >> 8);
  NVM.ADDR2 = 0;
  nvm_cmd(NVM_CMD_READ_EEPROM_gc);
  CCP = CCP_IOREG_gc; NVM.CTRLA = NVM_CMDEX_bm;
  nvm_wait();
  return NVM.DATA0;
}
static void eeprom_write_byte(uint16_t addr, uint8_t val){
  nvm_wait();
  NVM.ADDR0 = (uint8_t)(addr & 0xFF);
  NVM.ADDR1 = (uint8_t)(addr >> 8);
  NVM.ADDR2 = 0;
  NVM.DATA0 = val;
  nvm_cmd(NVM_CMD_ERASE_WRITE_EEPROM_PAGE_gc);
  CCP = CCP_IOREG_gc; NVM.CTRLA = NVM_CMDEX_bm;
  nvm_wait();
}
static void eeprom_read_block(uint16_t ofs, void* dst, uint16_t len){
  uint8_t* p = (uint8_t*)dst;
  for (uint16_t i=0;i<len;i++) p[i] = eeprom_read_byte(EE_OFS_DATA + ofs + i);
}
static void eeprom_write_block(uint16_t ofs, const void* src, uint16_t len){
  const uint8_t* p = (const uint8_t*)src;
  for (uint16_t i=0;i<len;i++) eeprom_write_byte(EE_OFS_DATA + ofs + i, p[i]);
}

static void cfg_defaults(void){
  memset(&g_cfg,0,sizeof(g_cfg));
  g_cfg.ip[0]=192; g_cfg.ip[1]=168; g_cfg.ip[2]=0; g_cfg.ip[3]=100;
  uint8_t defmac[6]={0x02,0x00,0x00,0x00,0x00,0x01};
  memcpy(g_cfg.mac,defmac,6);
  strncpy(g_cfg.serial,"UNSET",sizeof(g_cfg.serial)-1);
}
void cfg_load_from_eeprom(void){
  if (eeprom_read_byte(EE_OFS_MAGIC)!=EE_MAGIC){ cfg_defaults(); return; }
  eeprom_read_block(0,&g_cfg,(uint16_t)sizeof(g_cfg));
}
static void cfg_store_to_eeprom(void){
  eeprom_write_byte(EE_OFS_MAGIC,EE_MAGIC);
  eeprom_write_block(0,&g_cfg,(uint16_t)sizeof(g_cfg));
}

/* Public init for this module (declared in header) */
void console_cmds_init(void){
  cfg_load_from_eeprom();
}

/* -------------------------------------------------------------------------- */
/* Hardware stubs to be replaced by ASM sequences                            */
/* -------------------------------------------------------------------------- */
static bool si5338_set_phase_A(uint16_t v){ (void)v; /* TODO(ASM) */ return true; }
static bool si5338_set_phase_C(uint16_t v){ (void)v; /* TODO(ASM) */ return true; }
static bool si5338_set_phase_L(uint16_t v){ (void)v; /* TODO(ASM) */ return true; }
static bool thresholds_apply_hw(void){ /* TODO(ASM) */ return true; }
static bool levels_apply_hw(void){ /* TODO(ASM) */ return true; }
static bool attenuator_apply_hw(uint8_t steps){ (void)steps; /* TODO(ASM) */ return true; }
static bool emit_pma_status_hw(void){
  /* TODO(ASM): read PMA0..7 via SPI/FPGA and print actual bits */
  rj_println("PMA: 00000000");
  return true;
}

/* -------------------------------------------------------------------------- */
/* Command implementations (previously weak hooks)                           */
/* -------------------------------------------------------------------------- */
bool cmd_CP_emit_pma_status(void){ return emit_pma_status_hw(); }

bool cmd_ON_erase_eeprom(void){
  for (uint16_t a=0;a<sizeof(g_cfg)+1;++a) eeprom_write_byte(EE_OFS_DATA+a,0xFF);
  eeprom_write_byte(EE_OFS_MAGIC,0xFF);
  cfg_defaults();
  return true;
}
bool cmd_OF_something(void){ return cmd_ON_erase_eeprom(); }

bool cmd_PA_flash_atxmega(void){
  /* Intentionally unsupported until the bootloader/flash flow is confirmed from ASM. */
  return false;
}

bool cmd_RP_emit_params(void){
  char line[96];
  snprintf(line,sizeof(line),
    "IP=%u.%u.%u.%u MAC=%02X:%02X:%02X:%02X:%02X:%02X SN=%s",
    g_cfg.ip[0],g_cfg.ip[1],g_cfg.ip[2],g_cfg.ip[3],
    g_cfg.mac[0],g_cfg.mac[1],g_cfg.mac[2],g_cfg.mac[3],g_cfg.mac[4],g_cfg.mac[5],
    g_cfg.serial);
  rj_println(line);
  return true;
}

bool cmd_SA_set_phase_u16(uint16_t v){ g_cfg.phase_A=v; return si5338_set_phase_A(v); }
bool cmd_SC_set_phase_u16(uint16_t v){ g_cfg.phase_C=v; return si5338_set_phase_C(v); }
bool cmd_SL_set_phase_u16(uint16_t v){ g_cfg.phase_L=v; return si5338_set_phase_L(v); }

bool cmd_SI_set_ip(uint8_t a,uint8_t b,uint8_t c,uint8_t d){
  g_cfg.ip[0]=a; g_cfg.ip[1]=b; g_cfg.ip[2]=c; g_cfg.ip[3]=d;
  return true;
}
bool cmd_SM_set_mac(const uint8_t mac[6]){ memcpy(g_cfg.mac,mac,6); return true; }
bool cmd_SS_set_portb(uint8_t v){ PORTB.OUT=v; return true; }
bool cmd_STH_set_u16(uint16_t v){ g_cfg.vtx_thr_hi=v; return thresholds_apply_hw(); }
bool cmd_STL_set_u16(uint16_t v){ g_cfg.vtx_thr_lo=v; return thresholds_apply_hw(); }
bool cmd_STM_set_u16(uint16_t v){ g_cfg.trig_mode=v;  return thresholds_apply_hw(); }
bool cmd_SV_set_serial(const char* s){
  if(!s) return false;
  size_t n=strnlen(s,sizeof(g_cfg.serial)-1);
  memcpy(g_cfg.serial,s,n); g_cfg.serial[n]=0;
  return true;
}
bool cmd_SW_set_steps(uint8_t v){ g_cfg.att_steps=v; return attenuator_apply_hw(v); }
bool cmd_THA_set_u16(uint16_t v){ g_cfg.cent_A=v;  return levels_apply_hw(); }
bool cmd_THC_set_u16(uint16_t v){ g_cfg.cent_C=v;  return levels_apply_hw(); }
bool cmd_TMA_set_u16(uint16_t v){ g_cfg.semic_A=v; return levels_apply_hw(); }
bool cmd_TMC_set_u16(uint16_t v){ g_cfg.semic_C=v; return levels_apply_hw(); }
bool cmd_WR_commit_to_eeprom(void){ cfg_store_to_eeprom(); return true; }

/* -------------------------------------------------------------------------- */
/* Existing functional commands (AC, CA, CL, PF, RS)                         */
/* -------------------------------------------------------------------------- */
static bool do_RS(void){
  clock_flags_t cf = clock_get_flags();
  fpga_status_t fs = fpga_get_status();
  bool pwr = power_input_in_ok() && power_input_pgood();
  char line[128];
  snprintf(line,sizeof(line),
    "PWR=%u INIT=%u DONE=%u CLKSEL=%u LOS0=%u LOS1=%u CLKOK=%u",
    (unsigned)pwr,(unsigned)fs.fpga_init_inactive,(unsigned)fs.fpga_done,
    (unsigned)(cf.clk_sel_is_1?1:0),
    (unsigned)(!cf.los0_present),(unsigned)(!cf.los1_present),
    (unsigned)(cf.clk_selected_present?1:0));
  rj_println(line); rj_print_ok(); return true;
}
static bool do_CL(const char* args){
  if(!args){ rj_print_err("BADARG"); return true; }
  while(*args==' '||*args=='\t') args++;
  if(*args!='0'&&*args!='1'){ rj_print_err("BADARG"); return true; }
  uint8_t sel = (*args=='1');
  clock_force_select(sel);
  return do_RS();
}
static bool do_CA(void){ led_status_apply_from_flags(); rj_print_ok(); return true; }
static bool do_AC(void){ console_enter_pass_thru_to_d0_until_esc(); return true; }
static bool do_PF(void){
  spic_upload_table_from_2B7C();
  fpga_trigger_reconfig_pulse();
  unsigned max_iter=50000;
  while(max_iter--){ if(fpga_get_status().fpga_done){ rj_print_ok(); return true; } }
  rj_print_err("TIMEOUT"); return true;
}

/* -------------------------------------------------------------------------- */
/* Command dispatchers                                                       */
/* -------------------------------------------------------------------------- */
static bool do_CP(void){ if(cmd_CP_emit_pma_status()) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_ON(void){ if(cmd_ON_erase_eeprom()) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_OF(void){ if(cmd_OF_something()) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_PA(void){ if(cmd_PA_flash_atxmega()) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_RP(void){ if(cmd_RP_emit_params()) rj_print_ok(); else rj_print_err("UNSUP"); return true; }

static bool do_S_any(const char* which,const char* args){
  uint16_t v; if(!parse_u16_dec(args,&v)){ rj_print_err("BADARG"); return true; }
  bool ok=false;
  if(strcmp(which,"SA")==0) ok=cmd_SA_set_phase_u16(v);
  else if(strcmp(which,"SC")==0) ok=cmd_SC_set_phase_u16(v);
  else if(strcmp(which,"SL")==0) ok=cmd_SL_set_phase_u16(v);
  else if(strcmp(which,"SS")==0){ if(v>0xFF){ rj_print_err("BADARG"); return true; } ok=cmd_SS_set_portb((uint8_t)v); }
  else if(strcmp(which,"STH")==0) ok=cmd_STH_set_u16(v);
  else if(strcmp(which,"STL")==0) ok=cmd_STL_set_u16(v);
  else if(strcmp(which,"STM")==0) ok=cmd_STM_set_u16(v);
  if(ok) rj_print_ok(); else rj_print_err("UNSUP"); return true;
}

static bool do_SI(const char* args){ uint8_t ip[4]; if(!parse_ip(args,ip)){ rj_print_err("BADARG"); return true; } if(cmd_SI_set_ip(ip[0],ip[1],ip[2],ip[3])) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_SM(const char* args){ uint8_t mac[6]; if(!parse_mac(args,mac)){ rj_print_err("BADARG"); return true; } if(cmd_SM_set_mac(mac)) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_SV(const char* args){ if(!args||!*args){ rj_print_err("BADARG"); return true; } if(cmd_SV_set_serial(args)) rj_print_ok(); else rj_print_err("UNSUP"); return true; }
static bool do_SW(const char* args){ uint16_t v; if(!parse_u16_dec(args,&v)||v>255){ rj_print_err("BADARG"); return true; } if(cmd_SW_set_steps((uint8_t)v)) rj_print_ok(); else rj_print_err("UNSUP"); return true; }

static bool do_THx(const char* which,const char* args){
  uint16_t v; if(!parse_u16_dec(args,&v)){ rj_print_err("BADARG"); return true; }
  bool ok=false;
  if(strcmp(which,"THA")==0) ok=cmd_THA_set_u16(v);
  else if(strcmp(which,"THC")==0) ok=cmd_THC_set_u16(v);
  if(ok) rj_print_ok(); else rj_print_err("UNSUP"); return true;
}
static bool do_TMx(const char* which,const char* args){
  uint16_t v; if(!parse_u16_dec(args,&v)){ rj_print_err("BADARG"); return true; }
  bool ok=false;
  if(strcmp(which,"TMA")==0) ok=cmd_TMA_set_u16(v);
  else if(strcmp(which,"TMC")==0) ok=cmd_TMC_set_u16(v);
  if(ok) rj_print_ok(); else rj_print_err("UNSUP"); return true;
}

static bool do_WR(void){ if(cmd_WR_commit_to_eeprom()) rj_print_ok(); else rj_print_err("UNSUP"); return true; }

/* -------------------------------------------------------------------------- */
/* Main line dispatcher                                                      */
/* -------------------------------------------------------------------------- */
bool console_cmds_handle_line(const char* line){
  if(!line||!*line) return false;
  char buf[192]; strncpy(buf,line,sizeof(buf)-1); buf[sizeof(buf)-1]=0; strtoupper_inplace(buf);
  const char* p=buf; trim_leading(&p);

  char tok[4]={0,0,0,0}; int ti=0;
  while(*p && isalpha((unsigned char)*p) && ti<3){ tok[ti++]=*p++; }
  while(*p==' '||*p=='\t') p++;

  if(strcmp(tok,"RS")==0) return do_RS();
  if(strcmp(tok,"CL")==0) return do_CL(p);
  if(strcmp(tok,"CA")==0) return do_CA();
  if(strcmp(tok,"AC")==0) return do_AC();
  if(strcmp(tok,"PF")==0) return do_PF();
  if(strcmp(tok,"CP")==0) return do_CP();
  if(strcmp(tok,"ON")==0) return do_ON();
  if(strcmp(tok,"OF")==0) return do_OF();
  if(strcmp(tok,"PA")==0) return do_PA();
  if(strcmp(tok,"RP")==0) return do_RP();

  if(strcmp(tok,"SA")==0) return do_S_any("SA",p);
  if(strcmp(tok,"SC")==0) return do_S_any("SC",p);
  if(strcmp(tok,"SL")==0) return do_S_any("SL",p);
  if(strcmp(tok,"SS")==0) return do_S_any("SS",p);
  if(strcmp(tok,"STH")==0) return do_S_any("STH",p);
  if(strcmp(tok,"STL")==0) return do_S_any("STL",p);
  if(strcmp(tok,"STM")==0) return do_S_any("STM",p);

  if(strcmp(tok,"SI")==0) return do_SI(p);
  if(strcmp(tok,"SM")==0) return do_SM(p);
  if(strcmp(tok,"SV")==0) return do_SV(p);
  if(strcmp(tok,"SW")==0) return do_SW(p);

  if(strcmp(tok,"THA")==0) return do_THx("THA",p);
  if(strcmp(tok,"THC")==0) return do_THx("THC",p);
  if(strcmp(tok,"TMA")==0) return do_TMx("TMA",p);
  if(strcmp(tok,"TMC")==0) return do_TMx("TMC",p);

  if(strcmp(tok,"WR")==0) return do_WR();

  rj_print_err("UNSUP");
  return true;
}

