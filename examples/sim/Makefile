CC := gcc
CFLAGS := -Wall -std=c11 -g -O3

.PHONY: clean

simulator: simulator.c debug.c debug.h elf.h
	$(CC) $(CFLAGS) simulator.c debug.c -o $@

clean:
	rm simulator
