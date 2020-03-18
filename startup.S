/*
 * crt0.S -- startup file for PowerPC systems.
 *
 * Copyright (c) 1995 Cygnus Support
 *
 * The authors hereby grant permission to use, copy, modify, distribute,
 * and license this software and its documentation for any purpose, provided
 * that existing copyright notices are retained in all copies and that this
 * notice is included verbatim in any distributions. No written agreement,
 * license, or royalty fee is required for any of the authorized uses.
 * Modifications to this software may be copyrighted by their authors
 * and need not follow the licensing terms described here, provided that
 * the new terms are clearly indicated on the first page of each file where
 * they apply.
 */

.file	"startup.S"
.text
.global os_entry
os_entry:

	/* make memory unguarded */
	li %r1, 0
	mtsgr %r1

	/* invalidate icache */
	iccci
	isync

	/* invalidate dcache */
	/* line */
	li %r1, 0
	/* address */
	li %r2, 0

invalidate_dcache_line:
	dccci %r2
	addi %r1, %r1, 1
	addi %r2, %r2, 32
	cmpwi %r1, 256
	blt invalidate_dcache_line

	isync
	
	/* load the stack */
	lis %r1, stack_top@h
	ori %r1, %r1, stack_top@l

	bl	c_entry

eloop:
	b eloop

	trap