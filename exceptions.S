.file "exceptions.S"
.section .program_exception_interrupt_handler
.global program_exception_interrupt_handler
program_exception_interrupt_handler:
    stwu %r1, -142(%r1)
    stmw %r0, 4(%r1)

    mflr %r14
    mfctr %r15

    bl handle_program_exception

    mtlr %r14
    mtctr %r15

    lmw %r2, 12(%r1)
    lwz %r0, 4(%r1)
    lwz %r1, 0(%r1)

    rfi