cmake_minimum_required(VERSION 3.16)

# --- Target toolchain (before project()) -----------------------------------
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR avr)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Optional prefix with AVR tools (can be empty if tools are in PATH)
set(AVR_PREFIX "" CACHE PATH "Path prefix to AVR toolchain bin dir (leave empty if in PATH)")

# Try to locate tools
find_program(AVR_GCC   NAMES avr-gcc   HINTS ${AVR_PREFIX})
find_program(AVR_OBJCOPY NAMES avr-objcopy HINTS ${AVR_PREFIX})
find_program(AVR_SIZE    NAMES avr-size    HINTS ${AVR_PREFIX})
find_program(AVR_OBJDUMP NAMES avr-objdump HINTS ${AVR_PREFIX})

if(NOT AVR_GCC)
  message(FATAL_ERROR "avr-gcc not found. Add it to PATH or set AVR_PREFIX to its bin directory.")
endif()

# Force compiler (important for cross build)
set(CMAKE_C_COMPILER "${AVR_GCC}")

project(TCM_FW_uPC C)

# --- Configurable MCU / clock ----------------------------------------------
set(MCU  "atxmega128a3" CACHE STRING "AVR MCU type, e.g. atxmega128a3")
set(F_CPU "32000000UL"   CACHE STRING "CPU frequency as UL literal")

# --- Compile / link flags ---------------------------------------------------
set(MCU_FLAG     "-mmcu=${MCU}")
set(F_CPU_DEF    "-DF_CPU=${F_CPU}")
set(OPT_FLAGS    "-Os")
set(WARN_FLAGS   "-Wall -Wextra")
set(SECT_FLAGS   "-ffunction-sections -fdata-sections")
set(STD_FLAGS    "-std=gnu11 -fno-builtin")

set(CMAKE_C_FLAGS "${MCU_FLAG} ${F_CPU_DEF} ${OPT_FLAGS} ${WARN_FLAGS} ${SECT_FLAGS} ${STD_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAG} -Wl,--gc-sections")

# --- Sources ----------------------------------------------------------------
set(SRC
    main.c
    system_startup.c
    led_status.c
    power_supervision.c
    clock_mgmt.c
    fpga_spic.c
    console.c
  rj45_parser.c
  x36_parser.c
    console_cmds.c
    adt7311.c
    nor_flash_spie.c
)

add_executable(${PROJECT_NAME}.elf ${SRC})

# --- Includes ---------------------------------------------------------------
target_include_directories(${PROJECT_NAME}.elf PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# --- Artifacts: HEX / EEP / LSS + size -------------------------------------
if(NOT AVR_OBJCOPY)
  message(FATAL_ERROR "avr-objcopy not found.")
endif()

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${AVR_OBJCOPY} -O ihex -R .eeprom $<TARGET_FILE:${PROJECT_NAME}.elf> ${PROJECT_NAME}.hex
    COMMAND ${AVR_OBJCOPY} -O ihex -j .eeprom --change-section-lma .eeprom=0 $<TARGET_FILE:${PROJECT_NAME}.elf> ${PROJECT_NAME}.eep
    BYPRODUCTS ${PROJECT_NAME}.hex ${PROJECT_NAME}.eep
    COMMENT "Generating ${PROJECT_NAME}.hex and ${PROJECT_NAME}.eep"
    VERBATIM
)

if(AVR_OBJDUMP)
  add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
      COMMAND ${AVR_OBJDUMP} -h -S $<TARGET_FILE:${PROJECT_NAME}.elf> > ${PROJECT_NAME}.lss
      BYPRODUCTS ${PROJECT_NAME}.lss
      COMMENT "Generating ${PROJECT_NAME}.lss (disassembly)"
      VERBATIM
  )
endif()

if(AVR_SIZE)
  add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
      COMMAND ${AVR_SIZE} --mcu=${MCU} --format=avr $<TARGET_FILE:${PROJECT_NAME}.elf>
      COMMENT "Program size"
      VERBATIM
  )
endif()

# --- Optional convenience target: 'flash' (avrdude) -------------------------
# Uncomment and set your programmer/port if you want a flash target.
# set(AVRDUDE avrdude)
# set(AVRDUDE_MCU ${MCU})
# set(AVRDUDE_PROG "atmelice")        # example
# set(AVRDUDE_PORT "")                # e.g. /dev/ttyUSB0 (for UART bootloaders)
# add_custom_target(flash
#   COMMAND ${AVRDUDE} -p ${AVRDUDE_MCU} -c ${AVRDUDE_PROG} $<$<BOOL:${AVRDUDE_PORT}>:-P ${AVRDUDE_PORT}> -U flash:w:${PROJECT_NAME}.hex
#   DEPENDS ${PROJECT_NAME}.hex
#   COMMENT "Flashing ${PROJECT_NAME}.hex"
# )

