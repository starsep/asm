CPROGRAMS=hello maks

all: $(CPROGRAMS)

.SECONDARY:

$(CPROGRAMS): %: %.cpp %.o
	g++ -o $@ $^

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<
	
clean:
	rm -f *.o $(CPROGRAMS)
