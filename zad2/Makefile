COMPILER=gcc
CFLAGS=-O2 -std=c11 -Wall -Wextra -Wshadow -pedantic -g

all: simulation

simulation: simulation.c simulation.o debug.o
	$(COMPILER) $(CFLAGS) -o simulation simulation.c simulation.o debug.o

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

clean:
	rm -rf *.o simulation gen_* fc359081-zad2*

pack: simulation.c simulation.asm debug.asm Makefile example.in example2.in
	make clean
	mkdir -p fc359081-zad2
	cp $^ fc359081-zad2
	tar -czvf fc359081-zad2.tar.gz fc359081-zad2
