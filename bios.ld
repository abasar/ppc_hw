ENTRY(boot)
SECTIONS
{
    . = 0xffff0000;
    .text . : {
        _text_start = .;
        *(.text)
        _text_end = .;
        . +=  0xfffc - (_text_end - _text_start);
        *(.boot)
    }
    os_entry = 0xfff00000;
}