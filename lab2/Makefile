CPROGRAMS=capitalize locate remove_spaces sum_of_digits to_hex

all: $(CPROGRAMS)

.SECONDARY:

$(CPROGRAMS): %: %.cpp %.o
	g++ -o $@ $^

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

clean:
	rm -f *.o $(CPROGRAMS)
