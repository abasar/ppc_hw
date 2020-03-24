#include <string.h>

volatile unsigned char * const UART0DR = (unsigned char *)0xEF600300;

int putc_uart0(const char *s) {
    for (; *s != '\0'; ++s) {
        *UART0DR = (unsigned char)(*s);
    }
    return 0;
}

int c_entry() 
{
    putc_uart0("Test Hello world!\n");

    char suc[10] = "suc";
    char cess[] = "cess!\n";
    putc_uart0(strcat(suc, cess));

    return 0;
}
