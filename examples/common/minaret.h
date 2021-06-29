#ifndef MINARET_H
#define MINARET_H

#include <inttypes.h>
#define IO_REG32 (volatile uint32_t*)

// mmio register map
#define MINA_HDMI_PAL  ((uint32_t*) 0x80000000)
#define MINA_HDMI_PIX  ((uint32_t*) 0x80000100)
#define MINA_UART_CTRL (*(IO_REG32 0xffffff00))
#define MINA_UART_DATA (*(IO_REG32 0xffffff04))
#define MINA_TIMER     (*(IO_REG32 0xffffff10))
#define MINA_KEYS      (*(IO_REG32 0xffffff20))

void mina_uart_putc(char c);
char mina_uart_getc(void);
void mina_uart_puts(const char *s);
void mina_uart_gets(char *s, int n);
void mina_time_wait(uint32_t ms);

#endif //MINARET_H
