ENTRY(os_entry)
SECTIONS
{
    . = 0xfff00000;
    os_entry = .;
    .text .  : { *(.text) }
    .data    : { *(.data) }
    .bss     : { *(.bss) }
    . = 0x07000000;
    .stack . : {
        . += 0x00fffff8;
        stack_top = .;
    }
}