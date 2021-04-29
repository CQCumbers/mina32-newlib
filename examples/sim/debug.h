#ifndef DEBUG_H
#define DEBUG_H

typedef struct {
  void *ctx;
  unsigned (*read_reg)(void *ctx, unsigned idx);
  unsigned (*read_mem)(unsigned idx);
  void (*set_break)(unsigned addr, int active);
} debug_t;

void debug_init(unsigned port, debug_t conf);
int debug_update(void);

#endif
