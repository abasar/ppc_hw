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

    return 0;
}
