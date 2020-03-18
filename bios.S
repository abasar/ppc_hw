.file   "bios.S"

.text
startup:
    // enable SDRAM
    li %r2, 0x20
    mtdcr 0x10, %r2

    lis %r2, 0x8000
    ori %r2, %r2, 0x0000
    mtdcr 0x11, %r2

    // jump to OS
    lis %r9, os_entry@h
    ori %r9, %r9, os_entry@l
    mtctr %r9
    bctr

.global boot
.section .boot
boot:
    b startup
