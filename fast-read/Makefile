GET_CHARACTER_PROGRAMS=fgetc_unlocked assembly
INT_PROGRAMS=scanf cin cin_without_sync
PROGRAMS=$(GET_CHARACTER_PROGRAMS) $(INT_PROGRAMS)
FLAGS=-O3
COMPILER=g++

all: $(PROGRAMS)

.SECONDARY:

clean:
	rm -f *.o $(PROGRAMS)

assembly.o: assembly.asm
	nasm -f elf64 -F dwarf -g $<

%.o: %.cpp
	g++ -c $<

1kk.in:
	seq 1000000 > 1kk.in

$(GET_CHARACTER_PROGRAMS): %: main.cpp fast_read.cpp %.o
	$(COMPILER) $(FLAGS) -o $@ main.cpp fast_read.cpp $@.o

$(INT_PROGRAMS): %: main.cpp %.o
	$(COMPILER) $(FLAGS) -o $@ main.cpp $@.o

test: 1kk.in
