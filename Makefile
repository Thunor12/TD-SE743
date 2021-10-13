PREFIX=arm-none-eabi-
GDB = $(PREFIX)gdb
CC = $(PREFIX)gcc
CFLAGS = -g -O1
TARGET_ARCH = -mthumb -mcpu=cortex-m4
TARGET_MACH = TARGET_ARCH
LDFLAGS = -nostdlib -g -T ld_ram.lds
OBJS = test.o
EXE = test.elf

all: $(EXE)

$(EXE): $(OBJS)
	$(CC) $(LDFLAGS) $< -o $@

.PHONY: connect debug clean all objdump

objdump:
	$(PREFIX)objdump -d $(OBJS)

connect:
	JLinkGDBServer -device STM32L475VG -endian little -if SWD -speed auto -ir -LocalhostOnly

debug:
	$(GDB) -x gdbcmd

clean:
	del *.o
	del *.elf