COMPILER=gcc
CFLAGS=-O2 -std=c11 -Wall -Wextra -Wshadow -pedantic -g

all: enlight tests

enlight: enlight.c enlight.o
	$(COMPILER) $(CFLAGS) -o enlight enlight.c enlight.o

enlight.o: enlight.asm
	nasm -f elf64 -F dwarf -g enlight.asm

clean:
	rm -f *.o enlight gen_*

tests: gen_mini gen_duck

gen_mini: gen_no_red_mini.ppm gen_red_mini.ppm gen_no_green_mini.ppm \
	gen_green_mini.ppm gen_no_blue_mini.ppm gen_blue_mini.ppm

gen_duck: gen_no_red_duck.ppm gen_red_duck.ppm gen_no_green_duck.ppm \
	gen_green_duck.ppm gen_no_blue_duck.ppm gen_blue_duck.ppm

gen_no_red_mini.ppm:
	./enlight 1 -128 < mini.ppm > $@

gen_red_mini.ppm:
	./enlight 1 127 < mini.ppm > $@

gen_no_green_mini.ppm:
	./enlight 2 -128 < mini.ppm > $@

gen_green_mini.ppm:
	./enlight 2 127 < mini.ppm > $@

gen_no_blue_mini.ppm:
	./enlight 3 -128 < mini.ppm > $@

gen_blue_mini.ppm:
	./enlight 3 127 < mini.ppm > $@

gen_no_red_duck.ppm:
	./enlight 1 -128 < duck.ppm > $@

gen_red_duck.ppm:
	./enlight 1 127 < duck.ppm > $@

gen_no_green_duck.ppm:
	./enlight 2 -128 < duck.ppm > $@

gen_green_duck.ppm:
	./enlight 2 127 < duck.ppm > $@

gen_no_blue_duck.ppm:
	./enlight 3 -128 < duck.ppm > $@

gen_blue_duck.ppm:
	./enlight 3 127 < duck.ppm > $@
