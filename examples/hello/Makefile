CC := /Users/alexanderzhang/Documents/llvm-project/build/bin/clang
SYSROOT := /Users/alexanderzhang/Documents/mina32-newlib/examples/sysroot
CFLAGS := -target mina32-elf -g -Os --sysroot=$(SYSROOT)
LDFLAGS := -Wl,-Tmemory_map.ld

.PHONY: clean

hello: hello.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@

crt0.o: crt0.s
	$(CC) -c $(CFLAGS) $^ -o $@

clean:
	rm hello crt0.o
