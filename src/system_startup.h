/**
 * @file    system_startup.h
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
 * system_startup.h
 * System Startup & Top-Level Wiring (AVR XMEGA)
 *
 * Responsibilities:
 *  - Configure pin sensing / pull-ups for key inputs (as in all.c/ASM).
 *  - Initialize subsystems in the intended order:
 *      LED → POWER → CLOCK(TWIC) → FPGA(SPIC) → CONSOLES
 *  - Register callbacks to keep modules decoupled (LED flags updated by producers).
 *  - Perform initial handshakes (Si5338/Si53301) and enable PSU when safe.
 *  - Render LEDs at the same callpoints as the original code.
 *
 * This module does not implement business logic; it only wires and starts blocks.
 */

#ifndef SYSTEM_STARTUP_H
#define SYSTEM_STARTUP_H

#include <stdbool.h>
#include <stdint.h>

/* Bring-up the whole platform (one-time). */
void peripherals_bringup(void);

/* Configure pin sense / pull-ups / basic IRQ masks for top-level ports.
 * Mirrors the role of ctrl_irq_flag_setup() in all.c.
 */
void ctrl_irq_flag_setup(void);

#endif /* SYSTEM_STARTUP_H */

