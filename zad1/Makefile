COMPILER=gcc
CFLAGS=-O2 -std=c11 -Wall -Wextra -Wshadow -pedantic -g

all: enlight

enlight: enlight.c enlight.o
	$(COMPILER) $(CFLAGS) -o enlight enlight.c enlight.o

enlight.o: enlight.asm
	nasm -f elf64 -F dwarf -g enlight.asm

clean:
	rm -f *.o enlight
