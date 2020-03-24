
# Makefile for a "hello world" program on qemu -M ppce500

# The gnu toolchain is assumed to be in your path.
# Modify $(QEMU) to where your qemu is located

PROC=powerpc
TYPE=eabi
PREFIX=/opt/cross/powerpc-linux-musl-cross/bin/powerpc-linux-musl-
#PATH:=/usr/local/bin:$(PATH)
CCFLAGS=-mbig-endian -g -gstabs+ -nostdlib

CC=$(PREFIX)gcc
AS=$(PREFIX)as
AR=$(PREFIX)ar
LD=$(PREFIX)ld
NM=$(PREFIX)nm
OBJDUMP=$(PREFIX)objdump
OBJCOPY=$(PREFIX)objcopy

QEMU=~/workspace/build-qemu/native/debug/ppc-softmmu/qemu-system-ppc

.PHONY: all

all : bios.bin os.elf

bios.elf : bios.S bios.ld
	$(CC) $(CCFLAGS) -T bios.ld bios.S -o $@

bios.bin : bios.elf
	 $(OBJCOPY) -O binary  $< $@


os.elf : startup.S utils.S exceptions.S main.c os.ld
	$(CC) $(CCFLAGS) -T os.ld -o $@ startup.S utils.S exceptions.S main.c

dis_os : os.elf
	$(OBJDUMP) --disassemble os.elf

clean :
	rm -f -v *.o *.elf *.bin *.lst

run : bios.bin
	$(QEMU) -cpu 405 -d guest_errors,unimp -M ref405ep -nographic -bios bios.bin -device loader,file=os.elf -s

debug : bios.bin
	$(QEMU) -cpu 405 -d guest_errors,unimp -M ref405ep -nographic -bios bios.bin  -monitor telnet:127.0.0.1:5555,server; -s
