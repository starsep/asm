# Makefile
TARGETS=array branch compare factorial first hello1 hello2 load loop printf1 printf2 store sum1 sum2
all: $(TARGETS)

%: %.o
	gcc -o $@ $+

%.o : %.s
	as -o $@ $<

clean:
	rm -vf $(TARGETS) *.o

