#include <stdio.h>
#include <sys/stat.h>

extern int _end;
const int outChar = 0xffffff04;
const int inChar = 0xffffff05;

void *_sbrk(int incr) {
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
    *(uint8_t*)outChar = (uint8_t)*ptr++;
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
    *(uint8_t*)inChar = (uint8_t)*ptr++;
    read++;
  }
  return read;
}

int main() {
  puts("Hello, World!");
  return 0;
}
