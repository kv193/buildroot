
CCF:= bfin-uclinux-gcc
CC:= bfin-linux-uclibc-gcc
CPPC:= bfin-linux-uclibc-g++
CFLAGS:= -fno-jump-tables -mfdpic
LDFLAGS:= -Wl,-elf2flt

test_simple: 
	$(CC)  -o $@ $@.c $(CFLAGS)

clean:
	rm -rf *.o *.so *.gdb test_simple 
