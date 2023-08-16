/* kernel entry point is 'boot' */
ENTRY(boot)

SECTIONS {

  /* base address */
  . = 0x80200000;

  /* .text.boot section is the first */
  /* then, .text, .rodata, .data, .bss */
  
  /* code area */
  .text :{
    KEEP(*(.text.boot));
    *(.text .text.*);
  }
  
  /* const data area*/
  .rodata : ALIGN(4) {
    *(.rodata .rodata.*);
  }

  /* read/writable data area */
  .data : ALIGN(4) {
    *(.data .data.*);
  }

  /* read/writable data area (init value = 0) */
  .bss : ALIGN(4) {
    __bss = .;
    *(.bss .bss.* .sbss .sbss.*);
    __bss_end = .;
  }

  /* attach stack area to the tail of bss section */
  . = ALIGN(4);
  . += 128 * 1024;
  __stack_top = .;
}
