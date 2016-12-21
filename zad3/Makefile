COMPILER=gcc
CFLAGS=-O2 -std=c11 -Wall -Wextra -Wshadow -pedantic -g
all: grayscale

grayscale: main.c grayscale.o
	$(COMPILER) $(CFLAGS) -o grayscale $^

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

clean:
	rm -rf *.o grayscale gen_* fc359081-zad3

pack: main.c grayscale.asm Makefile images
	make clean
	mkdir -p fc359081-zad3
	cp $^ fc359081-zad3
	tar -czvf fc359081-zad3.tar.gz fc359081-zad3
