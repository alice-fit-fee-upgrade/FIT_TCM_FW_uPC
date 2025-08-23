# MCU settings
MCU   = atxmega128a3u

# Tools
CC = avr-gcc
OBJCOPY = avr-objcopy
SIZE = avr-size

# Project files
TARGET = fit_tcm
SRC = main.S
OBJ = $(SRC:.asm=.o)
INCDIR = .

# Flags
CFLAGS = -mmcu=$(MCU) -x assembler-with-cpp -I$(INCDIR)
LDFLAGS = -mmcu=$(MCU) -nostartfiles
HEXFLAGS = -O ihex --gap-fill=0xFF -R .eeprom 

# Outputs
ELF = $(TARGET).elf
HEX = $(TARGET).hex

# Build
all: $(HEX)

# Assemble .s files into .o
%.o: %.S
	$(CC) $(CFLAGS) -c -o $@ $<

# Link objects into ELF
$(ELF): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

# Convert to HEX
$(HEX): $(ELF)
	$(OBJCOPY) $(HEXFLAGS) $< $@
	$(SIZE) $<

# Cleanup
clean:
	rm -f *.o *.elf *.hex

.PHONY: all clean
