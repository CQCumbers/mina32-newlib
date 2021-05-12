OUTPUT_FORMAT(elf32-mina32)

MEMORY
{
  ram (rwx) : ORIGIN = 0x00000000, LENGTH = 0x00010000
}

STACK_SIZE = 0x2000;

/* Section Definitions */
SECTIONS
{
  .text :
  {
    . = ALIGN(4);
    KEEP(*(.reset .reset.*))
    *(.text .text.*)
    *(.rodata .rodata.*)

    /* libc constructors */
    KEEP(*(.init))
    __preinit_array_start = .;
    KEEP (*(.preinit_array))
    __preinit_array_end = .;

    __init_array_start = .;
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array))
    __init_array_end = .;

    /* libc finalizers */
    KEEP(*(.fini))
    __fini_array_start = .;
    KEEP (*(.fini_array))
    KEEP (*(SORT(.fini_array.*)))
    __fini_array_end = .;
  } > ram

  .bss (NOLOAD) :
  {
    __bss_start = .;
    *(.bss*)
    *(COMMON)
    __bss_end = .;
  } > ram

  /* stack section */
  .stack (NOLOAD):
  {
    . = ALIGN(4);
    . = . + STACK_SIZE;
    . = ALIGN(4);
  } > ram

  _end = . ;
}
