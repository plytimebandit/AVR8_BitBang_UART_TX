# --
# The source code is based on the source code of:
# Copyright (c) 2017, Lukasz Marcin Podkalicki <lukasz@podkalicki.com>
#
# https://github.com/lpodkalicki/attiny13-software-uart-library/blob/master/example/Makefile
# --

MCU=attiny13
FUSE_L=0x7A
FUSE_H=0xFF
F_CPU=9600000
CC=avr-gcc
LD=avr-ld
OBJCOPY=avr-objcopy
SIZE=avr-size
AVRDUDE=avrdude
CFLAGS=-std=c99 -Wall -g -Os -mmcu=${MCU} -DF_CPU=${F_CPU} -I.
TARGET=main

SRCS=main.c

all:
	${CC} ${CFLAGS} -o ${TARGET}.o ${SRCS}
	${LD} -o ${TARGET}.elf ${TARGET}.o
	${OBJCOPY} -j .text -j .data -O ihex ${TARGET}.o ${TARGET}.hex
	${SIZE} -C --mcu=${MCU} ${TARGET}.elf

flash:
	${AVRDUDE} -p ${MCU} -c stk500v1 -C avrdude.conf -U flash:w:${TARGET}.hex:i -F -P /dev/ttyACM0 -b 19200

fuse:
	$(AVRDUDE) -p ${MCU} -c stk500v1 -C avrdude.conf -U hfuse:w:${FUSE_H}:m -U lfuse:w:${FUSE_L}:m -P /dev/ttyACM0 -b 19200

clean:
	rm -f *.c~ *.o *.elf *.hex
