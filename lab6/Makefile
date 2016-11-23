CPROGRAMS=unsplice

all: $(CPROGRAMS)

.SECONDARY:

$(CPROGRAMS): %: %.c %.o
	gcc -o $@ $^

%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

clean:
	rm -f *.o $(CPROGRAMS)
