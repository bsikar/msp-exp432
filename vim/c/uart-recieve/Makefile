SIMPLELINK_MSP432_SDK_INSTALL_DIR := $(MSP432_HEADERS)

CC = arm-none-eabi-gcc
LNK = arm-none-eabi-gcc
NAME = blinky-leds

CFLAGS = -I"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source" \
	-I"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source/third_party/CMSIS/Include" \
	-D__MSP432P401R__ \
	-DDeviceFamily_MSP432P401x \
	-mcpu=cortex-m4 \
	-march=armv7e-m \
	-mthumb \
	-std=c17 \
	-mfloat-abi=hard \
	-mfpu=fpv4-sp-d16 \
	-ffunction-sections \
	-fdata-sections \
	-g \
	-gstrict-dwarf \
	-Wall

LFLAGS = -Wl,-T,msp432p401r.lds \
	-Wl,-Map,"$(NAME).map" \
	-L"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source" \
	-l:ti/display/lib/display.am4fg \
	-l:ti/grlib/lib/gcc/m4f/grlib.a \
	-l:third_party/spiffs/lib/gcc/m4f/spiffs.a \
	-l:ti/drivers/lib/drivers_msp432p4x1xi.am4fg \
	-l:third_party/fatfs/lib/gcc/m4f/fatfs.a \
	-l:ti/devices/msp432p4xx/driverlib/gcc/msp432p4xx_driverlib.a \
	-march=armv7e-m \
	-mthumb \
	-mfloat-abi=hard \
	-mfpu=fpv4-sp-d16 \
	-static \
	-Wl,--gc-sections \
	-lgcc \
	-lc \
	-lm \
	-lnosys \
	--specs=nano.specs

# Source files
SOURCES = $(wildcard src/*.c lib/*.c)

# Object files
OBJECTS = $(SOURCES:.c=.o)

# Default target
all: $(NAME).elf

# Compile
%.o: %.c
	@echo "Building $@"
	@$(CC) $(CFLAGS) -c $< -o $@

# Link
$(NAME).elf: $(OBJECTS)
	@echo "Linking $@"
	@$(LNK) $(OBJECTS) $(LFLAGS) -o $@
	@echo "-----"
	@echo "Built $@ successfully"

# Clean
clean:
	@echo "Cleaning..."
	@rm -f $(OBJECTS) $(NAME).elf $(NAME).map

# OpenOCD configurations
OPENOCD=openocd
OPENOCD_CFG=/usr/share/openocd/scripts/board/ti_msp432_launchpad.cfg

# Flash the binary to the MSP432P4111
flash: $(NAME).elf
	@echo Flashing
	$(OPENOCD) -f $(OPENOCD_CFG) -c "program $< verify reset exit"

asm: $(SOURCES)
	@echo "Converting to assembly..."
	@$(foreach src,$(SOURCES),$(CC) -O3 $(CFLAGS) -S $(src) -o $(src:.c=.s);)

.PHONY: all clean flash asm

