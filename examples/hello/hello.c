#include <stdio.h>
#include <sys/stat.h>
#include <inttypes.h>

// minaret BSP

#define IO_REG32 (volatile uint32_t*)
#define MINA_UART_CTRL (*(IO_REG32 0xffffff00))
#define MINA_UART_DATA (*(IO_REG32 0xffffff04))

void mina_uart_putc(char c) {
  // wait for write fifo space
  // see altera jtag uart docs
  while (MINA_UART_CTRL >> 16 == 0);
  MINA_UART_DATA = (uint32_t)c;
}

char mina_uart_getc(void) {
  // wait for valid read
  uint32_t data = 0;
  while (~(data = MINA_UART_DATA) & 0x8000);
  return (char)data;
}

// newlib stubs

void *_sbrk(int incr) {
  extern int _end;
  static unsigned char *heap;
  unsigned char *prev_heap;

  if (heap == NULL)
    heap = (unsigned char *)&_end;
  prev_heap = heap, heap += incr;

  return prev_heap;
}

int _close(int file) {
  return -1;
}

int _fstat(int file, struct stat *st) {
  st->st_mode = S_IFCHR;

  return 0;
}

int _isatty(int file) {
  return 1;
}

int _lseek(int file, int ptr, int dir) {
  return 0;
}

void _exit(int status) {
  while (1);
}

void _kill(int pid, int sig) {
  return;
}

int _getpid(void) {
  return -1;
}

int _write (int file, char * ptr, int len) {
  int written = 0;

  if ((file != 1) && (file != 2) && (file != 3)) {
    return -1;
  }

  for (; len != 0; --len) {
    mina_uart_putc(*ptr++);
    ++written;
  }
  return written;
}

int _read (int file, char * ptr, int len) {
  int read = 0;

  if (file != 0) {
    return -1;
  }

  for (; len > 0; --len) {
    *ptr++ = mina_uart_getc();
    read++;
  }
  return read;
}

// demo program

int main() {
  puts("Hello, World!");
  return 0;
}
