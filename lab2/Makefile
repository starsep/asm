CPROGRAMS=hello maks sum sum_loop

all: $(CPROGRAMS)

.SECONDARY:

$(CPROGRAMS): %: %.cpp %.o
	g++ -o $@ $^

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

clean:
	rm -f *.o $(CPROGRAMS)
