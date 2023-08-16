typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef uint32_t size_t;

extern char __bss[], __bss_end[], __stack_top[];

void *memset(void *buf, char c, size_t n) {
  uint8_t *p = (uint8_t *)buf;
  while (n--) {
    *p++ = c;
  }
  return buf;
}

void kernel_main(void) {
  memset(__bss, 0, (size_t)__bss_end - (size_t)__bss);
  for (;;) {
  }
}

__attribute__((section(".text.boot")))  // set entry point using ld
__attribute__((naked))  // avoid generating unneeded code

void boot(void) {
  __asm__ __volatile__("mv sp, %[stack_top]\n" // set sp to stack_top
                       "j kernel_main\n"       // jump to kernel_main func
                       :
                       : [stack_top] "r"(__stack_top));
}
