ENTRY(os_entry)
SECTIONS
{
    . = 0xfff00000;
    os_entry = .;
    .text .  : { *(.text)
                 g_exception_vector = .;
                 . += 0x700;
                 *(.program_exception_interrupt_handler) }
    .data    : { *(.data) }
    .bss     : { *(.bss) }
    . = 0x07000000;
    .stack . : {
        . += 0x00fffff8;
        stack_top = .;
    }
}