COMPILER=gcc
CFLAGS=-O2 -std=c99 -Wall -Wextra -Wshadow -pedantic -g
PROJECT_FILES=main.c grayscale.asm Makefile images c_grayscale.c

all: grayscale

grayscale: main.c grayscale.o
	$(COMPILER) $(CFLAGS) -o $@ $^

c_grayscale: main.c c_grayscale.o
	$(COMPILER) $(CFLAGS) -o $@ $^

grayscale.o: grayscale.asm
	as -g -o $@ $<

c_grayscale.o: c_grayscale.c
	$(COMPILER) $(CFLAGS) -c $^

clean:
	rm -rf *.o grayscale c_grayscale gen_* fc359081-zad3*

pack: $(PROJECT_FILES)
	make clean
	mkdir -p fc359081-zad3
	cp -r $^ fc359081-zad3
	tar -czvf fc359081-zad3.tar.gz fc359081-zad3

deploy: pack
	scp -P 5555 fc359081-zad3.tar.gz root@localhost:~
	ssh -p 5555 root@localhost -t "tar -xvf fc359081-zad3.tar.gz"
