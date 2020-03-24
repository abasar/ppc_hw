#include <stdint.h>
#include <stdbool.h>
#include <string.h>

volatile unsigned char * const UART0DR = (unsigned char *)0xEF600300;

int putc_uart0(const char *s);

void set_evpr(uint32_t val)
{
    asm volatile("mtevpr %0" : : "r"(val));
}

uint32_t set_srr0(uint32_t val)
{
    asm volatile("mtsrr0 %0" : : "r"(val));
}

uint32_t get_srr0(void)
{
    uint32_t srr0;
    asm volatile("mfsrr0 %0" : "=r"(srr0));
    return srr0;
}

void handle_program_exception(void)
{
    putc_uart0("program exception handled\n");

    // return to the next instruction
    uint32_t srr0 = get_srr0();
    set_srr0(srr0 + 4);
}

int putc_uart0(const char *s) {
    for (; *s != '\0'; ++s) {
        *UART0DR = (unsigned char)(*s);
    }
    return 0;
}

extern uint8_t g_exception_vector;

int c_entry() 
{
    putc_uart0("Test Hello world!\n");

    set_evpr((uint32_t)&g_exception_vector);

    char suc[10] = "suc";
    char cess[] = "cess!\n";
    putc_uart0(strcat(suc, cess));

    return 0;
}
