CC := /Users/alexanderzhang/Documents/llvm-project/build/bin/clang
CFLAGS := -nostdlib -fno-builtin -nostdlibinc -target mina32-elf -g -static
CFLAGS += -L ~/Documents/mina32-newlib/build/mina32-elf/lib
CFLAGS += -I ~/Documents/mina32-newlib/build/mina32-elf/include
CFLAGS += -L ~/Documents/llvm-project/rt-build/lib/generic
LDLIBS := -lc -lclang_rt.builtins-mina32

.PHONY: clean

hello: crt0.s hello.c
	$(CC) $(CFLAGS) crt0.s hello.c $(LDLIBS) -o $@

clean:
	rm hello
