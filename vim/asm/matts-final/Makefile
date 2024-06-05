SIMPLELINK_MSP432_SDK_INSTALL_DIR := $(MSP432_HEADERS)

CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc  # Use GCC for assembling to maintain option compatibility
LNK = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
NAME = eset350_final_matt

SRC_DIR = src
LIB_DIR = lib

OPENOCD = openocd
OPENOCD_CFG = /usr/share/openocd/scripts/board/ti_msp432_launchpad.cfg
GDB = arm-none-eabi-gdb
QEMU = qemu-system-arm

DEBUG ?= 0
ifeq ($(DEBUG), 1)
		DEBUG_FLAGS = -g -O0
else
		DEBUG_FLAGS =
endif

CFLAGS = -I"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source" \
		-I"$(SIMPLELINK_MSP432_SDK_INSTALL_DIR)/source/third_party/CMSIS/Include" \
		-D__MSP432P401R__ \
		-DDeviceFamily_MSP432P401x \
		-mcpu=cortex-m4 \
		-mthumb \
		-mfloat-abi=hard \
		-mfpu=fpv4-sp-d16 $(DEBUG_FLAGS)

ASFLAGS = $(CFLAGS)

LFLAGS = -T msp432p401r.lds --specs=nosys.specs \
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

C_SOURCES = $(wildcard $(SRC_DIR)/*.c) $(wildcard $(LIB_DIR)/*.c)
ASM_SOURCES = $(wildcard $(SRC_DIR)/*.s)

C_OBJECTS = $(C_SOURCES:.c=.o)
ASM_OBJECTS = $(ASM_SOURCES:.s=.o)
OBJECTS = $(C_OBJECTS) $(ASM_OBJECTS)

all: $(NAME).elf

%.o: %.c
		@echo "Compiling $<"
		$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
		@echo "Assembling $<"
		$(AS) $(ASFLAGS) -c $< -o $@

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
		@$(OPENOCD) -f $(OPENOCD_CFG) -c "program $< verify reset exit"

simulate: $(NAME).elf
		@echo "Simulating..."
		@$(QEMU) -machine mps2-an385 -cpu cortex-m3 -kernel $(NAME).elf -nographic -s -S &
		@$(GDB) $(NAME).elf -ex "target remote localhost:1234"

debug: $(NAME).elf
		@echo "Starting debugger..."
		@$(OPENOCD) -f $(OPENOCD_CFG) & \
		arm-none-eabi-gdb $(NAME).elf \
		-ex "target remote localhost:3333" \
		-ex "monitor reset halt"


.PHONY: all clean flash debug simulate

