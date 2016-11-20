all: cpuid cpuid2

cpuid: cpuid.asm
	nasm -f elf64 cpuid.asm
	ld -o cpuid cpuid.o

cpuid2: cpuid2.asm
	nasm -f elf64 cpuid2.asm
	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o cpuid2 -lc cpuid2.o

clean:
	rm *.o cpuid cpuid2

##EOF
