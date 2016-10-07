PROGRAMS=zero jeden dwa trzy

all: $(PROGRAMS)

.SECONDARY:

trzy: trzymain.c trzy.o
	gcc -o trzy trzymain.c trzy.o

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<


%: %.o
	ld $< -o $@ -lc --dynamic-linker=/lib64/ld-linux-x86-64.so.2


clean:
	rm -f *.o $(PROGRAMS)

