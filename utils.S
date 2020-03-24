.file "utils.S"
.text
.global strcat
strcat:
    // we need to save the original string in order to return it
    mr %r5, %r3

    addi %r5, %r5, -1

find_dest_null_byte:
    lbzu %r6, 1(%r5)
    cmpwi %r6, 0
    bne find_dest_null_byte

    addi %r4, %r4, -1
    addi %r5, %r5, -1

    // oh no, what is this?
    .long 0x00112233


write_src_byte:
    lbzu %r6, 1(%r4)
    stbu %r6, 1(%r5)

    // again??? what is going on
    .long 0x00223344

    cmpwi %r6, 0
    bne write_src_byte

    blr

