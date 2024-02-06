SIMPLELINK_MSP432_SDK_INSTALL_DIR := $(MSP432P4111_HEADERS)

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LNK = arm-none-eabi-gcc # Use GCC for linking to leverage the linker script and specs
OBJCOPY = arm-none-eabi-objcopy
NAME = blinky-red-led

SRC_DIR = src
LIB_DIR = lib

# Flags for C compilation, adjust for the SDK path
CFLAGS = -I"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source" \
	-I"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source/third_party/CMSIS/Include" \
	-D__MSP432P4111__ \
	-DDeviceFamily_MSP432P4x1xI \
	-mcpu=cortex-m4 \
	-mthumb \
	-mfloat-abi=hard \
	-mfpu=fpv4-sp-d16

# Assembler flags, ensure they're appropriate for your assembler
ASFLAGS = -mcpu=cortex-m4 -mthumb

# Linker flags
LFLAGS = -T msp432p4111.lds --specs=nosys.specs \
	-L"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source" \
	-static \
	-Wl,--gc-sections \
	-lgcc \
	-lc \
	-lm \
	-lnosys \
	--specs=nano.specs \
	-mcpu=cortex-m4 \
	-mthumb \
	-mfloat-abi=hard \
	-mfpu=fpv4-sp-d16


ASM_SOURCES = $(wildcard $(SRC_DIR)/*.s)
C_SOURCES = $(wildcard $(LIB_DIR)/*.c)

ASM_OBJECTS = $(ASM_SOURCES:$(SRC_DIR)/%.s=%.o)
C_OBJECTS = $(C_SOURCES:$(LIB_DIR)/%.c=%.o)

OBJECTS = $(ASM_OBJECTS) $(C_OBJECTS)

all: $(NAME).elf

# Assemble ASM files
%.o: $(SRC_DIR)/%.s
	@echo "Assembling $<"
	$(AS) $(ASFLAGS) $< -o $@

# Compile C files
%.o: $(LIB_DIR)/%.c
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

# Link to produce the final ELF
$(NAME).elf: $(OBJECTS)
	@echo "Linking $@"
	$(LNK) $(LFLAGS) $(OBJECTS) -o $@
	@echo "-----"
	@echo "Built $@ successfully"

clean:
	@echo "Cleaning..."
	@rm -f $(OBJECTS) $(NAME).elf $(NAME).map

flash: $(NAME).elf
	@echo Flashing
	@openocd -f board/ti_msp432_launchpad.cfg -c "program $< verify reset exit"

.PHONY: all clean flash

