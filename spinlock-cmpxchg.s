	.arch armv8-a
	.file	"spinlock-cmpxchg.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.p2align 3,,7
	.global	thread_func
	.type	thread_func, %function
thread_func:
.LFB24:
	.file 1 "spinlock-cmpxchg.c"
	.loc 1 21 0
	.cfi_startproc
.LVL0:
	mov	w4, 38528
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	.loc 1 21 0
	movk	w4, 0x98, lsl 16
.LBB10:
.LBB11:
.LBB12:
	.file 2 "spinlock-cmpxchg.h"
	.loc 2 10 0
	mov	w2, 1
.LVL1:
	.p2align 2
.L3:
	mov	w1, 0
	.loc 2 9 0
	str	wzr, [sp, 12]
	.loc 2 10 0
	ldaxr	w3, [x0]
	cmp	w3, w1
	bne	.L10
	stxr	w5, w2, [x0]
	cmp	w5, 0
.L10:
.LVL2:
	bne	.L3
.LBE12:
.LBE11:
	.loc 1 26 0
	ldr	w1, [x0, 4]
	add	w1, w1, 1
	str	w1, [x0, 4]
.LVL3:
.LBB13:
.LBB14:
	.loc 2 16 0
	stlr	wzr, [x0]
.LVL4:
.LBE14:
.LBE13:
.LBE10:
	.loc 1 23 0
	subs	w4, w4, #1
	bne	.L3
	.loc 1 30 0
	mov	x0, 0
.LVL5:
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE24:
	.size	thread_func, .-thread_func
	.align	2
	.p2align 3,,7
	.global	spin_lock
	.type	spin_lock, %function
spin_lock:
.LFB22:
	.loc 2 5 0
	.cfi_startproc
.LVL6:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	.loc 2 10 0
	mov	w2, 1
	.p2align 2
.L15:
	.loc 2 10 0 is_stmt 0 discriminator 1
	mov	w1, 0
	.loc 2 9 0 is_stmt 1 discriminator 1
	str	wzr, [sp, 12]
	.loc 2 10 0 discriminator 1
	ldaxr	w3, [x0]
	cmp	w3, w1
	bne	.L20
	stxr	w4, w2, [x0]
	cmp	w4, 0
.L20:
	bne	.L15
	.loc 2 11 0
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE22:
	.size	spin_lock, .-spin_lock
	.align	2
	.p2align 3,,7
	.global	spin_unlock
	.type	spin_unlock, %function
spin_unlock:
.LFB23:
	.loc 2 14 0
	.cfi_startproc
.LVL7:
	.loc 2 16 0
	stlr	wzr, [x0]
.LVL8:
	ret
	.cfi_endproc
.LFE23:
	.size	spin_unlock, .-spin_unlock
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 3,,7
	.global	main
	.type	main, %function
main:
.LFB25:
	.loc 1 33 0
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	.loc 1 39 0
	mov	x1, 0
	.loc 1 33 0
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -48
	.cfi_offset 20, -40
	.loc 1 36 0
	add	x20, x29, 64
	.loc 1 39 0
	adrp	x19, thread_func
	add	x19, x19, :lo12:thread_func
	mov	x2, x19
	add	x0, x29, 48
	.loc 1 36 0
	str	xzr, [x20, -24]!
.LVL9:
	.loc 1 39 0
	mov	x3, x20
	bl	pthread_create
.LVL10:
	.loc 1 40 0
	cbnz	w0, .L24
.LVL11:
	.loc 1 39 0
	mov	x3, x20
	mov	x2, x19
	mov	x1, 0
	add	x0, x29, 56
.LVL12:
	bl	pthread_create
.LVL13:
	.loc 1 40 0
	cbnz	w0, .L24
.LVL14:
	.loc 1 44 0 discriminator 2
	ldr	x0, [x29, 48]
.LVL15:
	mov	x1, 0
	bl	pthread_join
.LVL16:
	.loc 1 45 0 discriminator 2
	cbnz	w0, .L26
.LVL17:
	.loc 1 44 0
	ldr	x0, [x29, 56]
.LVL18:
	mov	x1, 0
	bl	pthread_join
.LVL19:
	.loc 1 45 0
	cbnz	w0, .L26
.LVL20:
	.loc 1 48 0
	ldr	w2, [x29, 44]
	mov	w3, 11520
	movk	w3, 0x131, lsl 16
	cmp	w2, w3
	bne	.L32
	.loc 1 53 0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa 31, 0
	ret
.LVL21:
.L24:
	.cfi_restore_state
	.loc 1 40 0 discriminator 1
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
.LVL22:
	add	x3, x3, :lo12:.LANCHOR0
	mov	w2, 40
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	bl	__assert_fail
.LVL23:
.L26:
	.loc 1 45 0
	adrp	x3, .LANCHOR0
	adrp	x1, .LC0
	adrp	x0, .LC1
.LVL24:
	add	x3, x3, :lo12:.LANCHOR0
	mov	w2, 45
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	bl	__assert_fail
.LVL25:
.L32:
	.loc 1 49 0
	adrp	x0, stderr
.LVL26:
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	ldr	x0, [x0, #:lo12:stderr]
	bl	fprintf
.LVL27:
	.loc 1 50 0
	mov	w0, 3
	bl	exit
.LVL28:
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	__PRETTY_FUNCTION__.4637, %object
	.size	__PRETTY_FUNCTION__.4637, 5
__PRETTY_FUNCTION__.4637:
	.string	"main"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"spinlock-cmpxchg.c"
	.zero	5
.LC1:
	.string	"r == 0"
	.zero	1
.LC2:
	.string	"ERROR: x: %d != %d\n"
	.text
.Letext0:
	.file 3 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/lib/gcc/aarch64-linux-gnu/6.2.1/include/stddef.h"
	.file 4 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/types.h"
	.file 5 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/libio.h"
	.file 6 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/stdio.h"
	.file 7 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/sys_errlist.h"
	.file 8 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/time.h"
	.file 9 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/pthreadtypes.h"
	.file 10 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/pthread.h"
	.file 11 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/assert.h"
	.file 12 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/stdlib.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x73d
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF937
	.byte	0xc
	.4byte	.LASF938
	.4byte	.LASF939
	.4byte	.Ldebug_ranges0+0
	.8byte	0
	.4byte	.Ldebug_line0
	.4byte	.Ldebug_macro0
	.uleb128 0x2
	.4byte	.LASF867
	.byte	0x3
	.byte	0xd8
	.4byte	0x38
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF860
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF861
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF862
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF863
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF864
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF865
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF866
	.uleb128 0x2
	.4byte	.LASF868
	.byte	0x4
	.byte	0x83
	.4byte	0x69
	.uleb128 0x2
	.4byte	.LASF869
	.byte	0x4
	.byte	0x84
	.4byte	0x69
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF870
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.4byte	0x95
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF871
	.uleb128 0x7
	.4byte	0x95
	.uleb128 0x8
	.4byte	.LASF901
	.byte	0xd8
	.byte	0x5
	.byte	0xf1
	.4byte	0x21e
	.uleb128 0x9
	.4byte	.LASF872
	.byte	0x5
	.byte	0xf2
	.4byte	0x62
	.byte	0
	.uleb128 0x9
	.4byte	.LASF873
	.byte	0x5
	.byte	0xf7
	.4byte	0x8f
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF874
	.byte	0x5
	.byte	0xf8
	.4byte	0x8f
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF875
	.byte	0x5
	.byte	0xf9
	.4byte	0x8f
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF876
	.byte	0x5
	.byte	0xfa
	.4byte	0x8f
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF877
	.byte	0x5
	.byte	0xfb
	.4byte	0x8f
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF878
	.byte	0x5
	.byte	0xfc
	.4byte	0x8f
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF879
	.byte	0x5
	.byte	0xfd
	.4byte	0x8f
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF880
	.byte	0x5
	.byte	0xfe
	.4byte	0x8f
	.byte	0x40
	.uleb128 0xa
	.4byte	.LASF881
	.byte	0x5
	.2byte	0x100
	.4byte	0x8f
	.byte	0x48
	.uleb128 0xa
	.4byte	.LASF882
	.byte	0x5
	.2byte	0x101
	.4byte	0x8f
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF883
	.byte	0x5
	.2byte	0x102
	.4byte	0x8f
	.byte	0x58
	.uleb128 0xa
	.4byte	.LASF884
	.byte	0x5
	.2byte	0x104
	.4byte	0x256
	.byte	0x60
	.uleb128 0xa
	.4byte	.LASF885
	.byte	0x5
	.2byte	0x106
	.4byte	0x25c
	.byte	0x68
	.uleb128 0xa
	.4byte	.LASF886
	.byte	0x5
	.2byte	0x108
	.4byte	0x62
	.byte	0x70
	.uleb128 0xa
	.4byte	.LASF887
	.byte	0x5
	.2byte	0x10c
	.4byte	0x62
	.byte	0x74
	.uleb128 0xa
	.4byte	.LASF888
	.byte	0x5
	.2byte	0x10e
	.4byte	0x70
	.byte	0x78
	.uleb128 0xa
	.4byte	.LASF889
	.byte	0x5
	.2byte	0x112
	.4byte	0x46
	.byte	0x80
	.uleb128 0xa
	.4byte	.LASF890
	.byte	0x5
	.2byte	0x113
	.4byte	0x54
	.byte	0x82
	.uleb128 0xa
	.4byte	.LASF891
	.byte	0x5
	.2byte	0x114
	.4byte	0x262
	.byte	0x83
	.uleb128 0xa
	.4byte	.LASF892
	.byte	0x5
	.2byte	0x118
	.4byte	0x272
	.byte	0x88
	.uleb128 0xa
	.4byte	.LASF893
	.byte	0x5
	.2byte	0x121
	.4byte	0x7b
	.byte	0x90
	.uleb128 0xa
	.4byte	.LASF894
	.byte	0x5
	.2byte	0x129
	.4byte	0x8d
	.byte	0x98
	.uleb128 0xa
	.4byte	.LASF895
	.byte	0x5
	.2byte	0x12a
	.4byte	0x8d
	.byte	0xa0
	.uleb128 0xa
	.4byte	.LASF896
	.byte	0x5
	.2byte	0x12b
	.4byte	0x8d
	.byte	0xa8
	.uleb128 0xa
	.4byte	.LASF897
	.byte	0x5
	.2byte	0x12c
	.4byte	0x8d
	.byte	0xb0
	.uleb128 0xa
	.4byte	.LASF898
	.byte	0x5
	.2byte	0x12e
	.4byte	0x2d
	.byte	0xb8
	.uleb128 0xa
	.4byte	.LASF899
	.byte	0x5
	.2byte	0x12f
	.4byte	0x62
	.byte	0xc0
	.uleb128 0xa
	.4byte	.LASF900
	.byte	0x5
	.2byte	0x131
	.4byte	0x278
	.byte	0xc4
	.byte	0
	.uleb128 0xb
	.4byte	.LASF940
	.byte	0x5
	.byte	0x96
	.uleb128 0x8
	.4byte	.LASF902
	.byte	0x18
	.byte	0x5
	.byte	0x9c
	.4byte	0x256
	.uleb128 0x9
	.4byte	.LASF903
	.byte	0x5
	.byte	0x9d
	.4byte	0x256
	.byte	0
	.uleb128 0x9
	.4byte	.LASF904
	.byte	0x5
	.byte	0x9e
	.4byte	0x25c
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF905
	.byte	0x5
	.byte	0xa2
	.4byte	0x62
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.4byte	0x225
	.uleb128 0x6
	.byte	0x8
	.4byte	0xa1
	.uleb128 0xc
	.4byte	0x95
	.4byte	0x272
	.uleb128 0xd
	.4byte	0x86
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.4byte	0x21e
	.uleb128 0xc
	.4byte	0x95
	.4byte	0x288
	.uleb128 0xd
	.4byte	0x86
	.byte	0x13
	.byte	0
	.uleb128 0xe
	.4byte	.LASF941
	.uleb128 0xf
	.4byte	.LASF906
	.byte	0x5
	.2byte	0x13b
	.4byte	0x288
	.uleb128 0xf
	.4byte	.LASF907
	.byte	0x5
	.2byte	0x13c
	.4byte	0x288
	.uleb128 0xf
	.4byte	.LASF908
	.byte	0x5
	.2byte	0x13d
	.4byte	0x288
	.uleb128 0x6
	.byte	0x8
	.4byte	0x9c
	.uleb128 0x7
	.4byte	0x2b1
	.uleb128 0x10
	.4byte	.LASF909
	.byte	0x6
	.byte	0xa8
	.4byte	0x25c
	.uleb128 0x10
	.4byte	.LASF910
	.byte	0x6
	.byte	0xa9
	.4byte	0x25c
	.uleb128 0x10
	.4byte	.LASF911
	.byte	0x6
	.byte	0xaa
	.4byte	0x25c
	.uleb128 0x10
	.4byte	.LASF912
	.byte	0x7
	.byte	0x1a
	.4byte	0x62
	.uleb128 0xc
	.4byte	0x2b7
	.4byte	0x2f3
	.uleb128 0x11
	.byte	0
	.uleb128 0x7
	.4byte	0x2e8
	.uleb128 0x10
	.4byte	.LASF913
	.byte	0x7
	.byte	0x1b
	.4byte	0x2f3
	.uleb128 0xc
	.4byte	0x8f
	.4byte	0x313
	.uleb128 0xd
	.4byte	0x86
	.byte	0x1
	.byte	0
	.uleb128 0xf
	.4byte	.LASF914
	.byte	0x8
	.2byte	0x11a
	.4byte	0x303
	.uleb128 0xf
	.4byte	.LASF915
	.byte	0x8
	.2byte	0x11b
	.4byte	0x62
	.uleb128 0xf
	.4byte	.LASF916
	.byte	0x8
	.2byte	0x11c
	.4byte	0x69
	.uleb128 0xf
	.4byte	.LASF917
	.byte	0x8
	.2byte	0x121
	.4byte	0x303
	.uleb128 0xf
	.4byte	.LASF918
	.byte	0x8
	.2byte	0x129
	.4byte	0x62
	.uleb128 0xf
	.4byte	.LASF919
	.byte	0x8
	.2byte	0x12a
	.4byte	0x69
	.uleb128 0x2
	.4byte	.LASF920
	.byte	0x9
	.byte	0x26
	.4byte	0x38
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF921
	.uleb128 0x6
	.byte	0x8
	.4byte	0x62
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF922
	.uleb128 0x12
	.byte	0x4
	.4byte	0x4d
	.byte	0x1
	.byte	0x9
	.4byte	0x394
	.uleb128 0x13
	.string	"N"
	.4byte	0x989680
	.uleb128 0x14
	.4byte	.LASF923
	.byte	0x2
	.byte	0
	.uleb128 0x8
	.4byte	.LASF924
	.byte	0x8
	.byte	0x1
	.byte	0xe
	.4byte	0x3b7
	.uleb128 0x9
	.4byte	.LASF925
	.byte	0x1
	.byte	0xf
	.4byte	0x62
	.byte	0
	.uleb128 0x15
	.string	"x"
	.byte	0x1
	.byte	0x10
	.4byte	0x62
	.byte	0x4
	.byte	0
	.uleb128 0x2
	.4byte	.LASF924
	.byte	0x1
	.byte	0x12
	.4byte	0x394
	.uleb128 0x16
	.4byte	.LASF942
	.byte	0x1
	.byte	0x20
	.4byte	0x62
	.8byte	.LFB25
	.8byte	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x55f
	.uleb128 0x17
	.string	"r"
	.byte	0x1
	.byte	0x22
	.4byte	0x62
	.4byte	.LLST4
	.uleb128 0x17
	.string	"i"
	.byte	0x1
	.byte	0x22
	.4byte	0x62
	.4byte	.LLST5
	.uleb128 0x18
	.4byte	.LASF926
	.byte	0x1
	.byte	0x23
	.4byte	0x55f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x18
	.4byte	.LASF927
	.byte	0x1
	.byte	0x24
	.4byte	0x3b7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF928
	.4byte	0x57f
	.uleb128 0x9
	.byte	0x3
	.8byte	__PRETTY_FUNCTION__.4637
	.uleb128 0x1a
	.8byte	.LVL10
	.4byte	0x707
	.4byte	0x456
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0x8f
	.sleb128 64
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x83
	.sleb128 0
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x84
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.8byte	.LVL13
	.4byte	0x707
	.4byte	0x480
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0x8f
	.sleb128 72
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x83
	.sleb128 0
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x84
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.8byte	.LVL16
	.4byte	0x712
	.4byte	0x497
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x1a
	.8byte	.LVL19
	.4byte	0x712
	.4byte	0x4ae
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x1a
	.8byte	.LVL23
	.4byte	0x71d
	.4byte	0x4ed
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC1
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC0
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x28
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x9
	.byte	0x3
	.8byte	.LANCHOR0
	.byte	0
	.uleb128 0x1a
	.8byte	.LVL25
	.4byte	0x71d
	.4byte	0x52c
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC1
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC0
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x2d
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x9
	.byte	0x3
	.8byte	.LANCHOR0
	.byte	0
	.uleb128 0x1a
	.8byte	.LVL27
	.4byte	0x728
	.4byte	0x54b
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC2
	.byte	0
	.uleb128 0x1c
	.8byte	.LVL28
	.4byte	0x734
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1
	.byte	0x33
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x35b
	.4byte	0x56f
	.uleb128 0xd
	.4byte	0x86
	.byte	0x1
	.byte	0
	.uleb128 0xc
	.4byte	0x9c
	.4byte	0x57f
	.uleb128 0xd
	.4byte	0x86
	.byte	0x4
	.byte	0
	.uleb128 0x7
	.4byte	0x56f
	.uleb128 0x1d
	.4byte	.LASF943
	.byte	0x1
	.byte	0x14
	.4byte	0x8d
	.8byte	.LFB24
	.8byte	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x657
	.uleb128 0x1e
	.4byte	.LASF944
	.byte	0x1
	.byte	0x14
	.4byte	0x8d
	.4byte	.LLST0
	.uleb128 0x17
	.string	"i"
	.byte	0x1
	.byte	0x16
	.4byte	0x62
	.4byte	.LLST1
	.uleb128 0x1f
	.8byte	.LBB10
	.8byte	.LBE10-.LBB10
	.uleb128 0x20
	.4byte	.LASF927
	.byte	0x1
	.byte	0x18
	.4byte	0x657
	.uleb128 0x21
	.4byte	0x67e
	.8byte	.LBB11
	.8byte	.LBE11-.LBB11
	.byte	0x1
	.byte	0x19
	.4byte	0x61d
	.uleb128 0x22
	.4byte	0x68a
	.uleb128 0x1f
	.8byte	.LBB12
	.8byte	.LBE12-.LBB12
	.uleb128 0x23
	.4byte	0x695
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x24
	.4byte	0x6a0
	.byte	0
	.byte	0
	.uleb128 0x25
	.4byte	0x65d
	.8byte	.LBB13
	.8byte	.LBE13-.LBB13
	.byte	0x1
	.byte	0x1b
	.uleb128 0x22
	.4byte	0x669
	.uleb128 0x1f
	.8byte	.LBB14
	.8byte	.LBE14-.LBB14
	.uleb128 0x26
	.4byte	0x674
	.4byte	.LLST2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.4byte	0x3b7
	.uleb128 0x27
	.4byte	.LASF929
	.byte	0x2
	.byte	0xd
	.byte	0x1
	.4byte	0x67e
	.uleb128 0x28
	.4byte	.LASF925
	.byte	0x2
	.byte	0xd
	.4byte	0x36d
	.uleb128 0x29
	.string	"t"
	.byte	0x2
	.byte	0xf
	.4byte	0x62
	.byte	0
	.uleb128 0x27
	.4byte	.LASF930
	.byte	0x2
	.byte	0x4
	.byte	0x1
	.4byte	0x6aa
	.uleb128 0x28
	.4byte	.LASF925
	.byte	0x2
	.byte	0x4
	.4byte	0x36d
	.uleb128 0x20
	.4byte	.LASF931
	.byte	0x2
	.byte	0x6
	.4byte	0x62
	.uleb128 0x29
	.string	"t"
	.byte	0x2
	.byte	0x6
	.4byte	0x62
	.byte	0
	.uleb128 0x2a
	.4byte	0x67e
	.8byte	.LFB22
	.8byte	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x6db
	.uleb128 0x2b
	.4byte	0x68a
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	0x695
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x2c
	.4byte	0x6a0
	.byte	0x1
	.byte	0
	.uleb128 0x2a
	.4byte	0x65d
	.8byte	.LFB23
	.8byte	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x707
	.uleb128 0x2b
	.4byte	0x669
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x26
	.4byte	0x674
	.4byte	.LLST3
	.byte	0
	.uleb128 0x2d
	.4byte	.LASF932
	.4byte	.LASF932
	.byte	0xa
	.byte	0xe9
	.uleb128 0x2d
	.4byte	.LASF933
	.4byte	.LASF933
	.byte	0xa
	.byte	0xfa
	.uleb128 0x2d
	.4byte	.LASF934
	.4byte	.LASF934
	.byte	0xb
	.byte	0x43
	.uleb128 0x2e
	.4byte	.LASF935
	.4byte	.LASF935
	.byte	0x6
	.2byte	0x164
	.uleb128 0x2e
	.4byte	.LASF936
	.4byte	.LASF936
	.byte	0xc
	.2byte	0x21f
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.uleb128 0x2119
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST4:
	.8byte	.LVL10
	.8byte	.LVL12
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL13
	.8byte	.LVL15
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL16
	.8byte	.LVL18
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL19
	.8byte	.LVL22
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL23
	.8byte	.LVL24
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL25
	.8byte	.LVL26
	.2byte	0x1
	.byte	0x50
	.8byte	0
	.8byte	0
.LLST5:
	.8byte	.LVL9
	.8byte	.LVL11
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.8byte	.LVL11
	.8byte	.LVL14
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.8byte	.LVL14
	.8byte	.LVL17
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.8byte	.LVL17
	.8byte	.LVL20
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.8byte	.LVL20
	.8byte	.LVL21
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.8byte	.LVL25
	.8byte	.LFE25
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.8byte	0
	.8byte	0
.LLST0:
	.8byte	.LVL0
	.8byte	.LVL5
	.2byte	0x1
	.byte	0x50
	.8byte	.LVL5
	.8byte	.LFE24
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.8byte	0
	.8byte	0
.LLST1:
	.8byte	.LVL0
	.8byte	.LVL1
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.8byte	0
	.8byte	0
.LLST2:
	.8byte	.LVL3
	.8byte	.LVL4
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.8byte	0
	.8byte	0
.LLST3:
	.8byte	.LVL7
	.8byte	.LVL8
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.8byte	0
	.8byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x3c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	.LFB25
	.8byte	.LFE25-.LFB25
	.8byte	0
	.8byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.8byte	.Ltext0
	.8byte	.Letext0
	.8byte	.LFB25
	.8byte	.LFE25
	.8byte	0
	.8byte	0
	.section	.debug_macro,"",@progbits
.Ldebug_macro0:
	.2byte	0x4
	.byte	0x2
	.4byte	.Ldebug_line0
	.byte	0x7
	.4byte	.Ldebug_macro1
	.byte	0x3
	.uleb128 0
	.uleb128 0x1
	.file 13 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/stdc-predef.h"
	.byte	0x3
	.uleb128 0
	.uleb128 0xd
	.byte	0x7
	.4byte	.Ldebug_macro2
	.byte	0x4
	.byte	0x3
	.uleb128 0x1
	.uleb128 0xb
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF270
	.file 14 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/features.h"
	.byte	0x3
	.uleb128 0x23
	.uleb128 0xe
	.byte	0x7
	.4byte	.Ldebug_macro3
	.file 15 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/sys/cdefs.h"
	.byte	0x3
	.uleb128 0x170
	.uleb128 0xf
	.byte	0x7
	.4byte	.Ldebug_macro4
	.file 16 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/wordsize.h"
	.byte	0x3
	.uleb128 0x19a
	.uleb128 0x10
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF378
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro5
	.byte	0x4
	.byte	0x5
	.uleb128 0x180
	.4byte	.LASF386
	.file 17 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/gnu/stubs.h"
	.byte	0x3
	.uleb128 0x188
	.uleb128 0x11
	.byte	0x3
	.uleb128 0x5
	.uleb128 0x10
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF378
	.byte	0x4
	.file 18 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/gnu/stubs-lp64.h"
	.byte	0x3
	.uleb128 0x8
	.uleb128 0x12
	.byte	0x7
	.4byte	.Ldebug_macro6
	.byte	0x4
	.byte	0x4
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro7
	.byte	0x4
	.byte	0x3
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x7
	.4byte	.Ldebug_macro8
	.byte	0x3
	.uleb128 0x21
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro9
	.byte	0x4
	.byte	0x3
	.uleb128 0x23
	.uleb128 0x4
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF439
	.byte	0x3
	.uleb128 0x1b
	.uleb128 0x10
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF378
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro10
	.file 19 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/typesizes.h"
	.byte	0x3
	.uleb128 0x79
	.uleb128 0x13
	.byte	0x7
	.4byte	.Ldebug_macro11
	.byte	0x4
	.byte	0x6
	.uleb128 0xc0
	.4byte	.LASF493
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro12
	.byte	0x3
	.uleb128 0x4a
	.uleb128 0x5
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF501
	.file 20 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/_G_config.h"
	.byte	0x3
	.uleb128 0x1f
	.uleb128 0x14
	.byte	0x7
	.4byte	.Ldebug_macro13
	.byte	0x3
	.uleb128 0xf
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro14
	.byte	0x4
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF503
	.file 21 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/wchar.h"
	.byte	0x3
	.uleb128 0x14
	.uleb128 0x15
	.byte	0x7
	.4byte	.Ldebug_macro15
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro16
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro17
	.file 22 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/lib/gcc/aarch64-linux-gnu/6.2.1/include/stdarg.h"
	.byte	0x3
	.uleb128 0x31
	.uleb128 0x16
	.byte	0x7
	.4byte	.Ldebug_macro18
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro19
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro20
	.file 23 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/stdio_lim.h"
	.byte	0x3
	.uleb128 0xa4
	.uleb128 0x17
	.byte	0x7
	.4byte	.Ldebug_macro21
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro22
	.byte	0x3
	.uleb128 0x355
	.uleb128 0x7
	.byte	0x4
	.file 24 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/stdio.h"
	.byte	0x3
	.uleb128 0x3a5
	.uleb128 0x18
	.byte	0x7
	.4byte	.Ldebug_macro23
	.byte	0x4
	.byte	0x4
	.byte	0x3
	.uleb128 0x3
	.uleb128 0xa
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF624
	.file 25 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/endian.h"
	.byte	0x3
	.uleb128 0x16
	.uleb128 0x19
	.byte	0x7
	.4byte	.Ldebug_macro24
	.file 26 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/endian.h"
	.byte	0x3
	.uleb128 0x24
	.uleb128 0x1a
	.byte	0x7
	.4byte	.Ldebug_macro25
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro26
	.file 27 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/byteswap.h"
	.byte	0x3
	.uleb128 0x3c
	.uleb128 0x1b
	.byte	0x7
	.4byte	.Ldebug_macro27
	.file 28 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/byteswap-16.h"
	.byte	0x3
	.uleb128 0x22
	.uleb128 0x1c
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF638
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro28
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro29
	.byte	0x4
	.file 29 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/sched.h"
	.byte	0x3
	.uleb128 0x17
	.uleb128 0x1d
	.byte	0x7
	.4byte	.Ldebug_macro30
	.byte	0x3
	.uleb128 0x1c
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro31
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro32
	.byte	0x3
	.uleb128 0x22
	.uleb128 0x8
	.byte	0x7
	.4byte	.Ldebug_macro33
	.byte	0x4
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF663
	.file 30 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/sched.h"
	.byte	0x3
	.uleb128 0x2b
	.uleb128 0x1e
	.byte	0x7
	.4byte	.Ldebug_macro34
	.byte	0x4
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF684
	.byte	0x4
	.byte	0x3
	.uleb128 0x18
	.uleb128 0x8
	.byte	0x7
	.4byte	.Ldebug_macro35
	.byte	0x3
	.uleb128 0x25
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro14
	.byte	0x4
	.file 31 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/time.h"
	.byte	0x3
	.uleb128 0x29
	.uleb128 0x1f
	.byte	0x7
	.4byte	.Ldebug_macro36
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro37
	.file 32 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/xlocale.h"
	.byte	0x3
	.uleb128 0xdd
	.uleb128 0x20
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF705
	.byte	0x4
	.byte	0x5
	.uleb128 0x136
	.4byte	.LASF706
	.byte	0x4
	.byte	0x3
	.uleb128 0x1a
	.uleb128 0x9
	.byte	0x7
	.4byte	.Ldebug_macro38
	.byte	0x4
	.file 33 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/setjmp.h"
	.byte	0x3
	.uleb128 0x1b
	.uleb128 0x21
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF722
	.byte	0x4
	.byte	0x3
	.uleb128 0x1c
	.uleb128 0x10
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF378
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro39
	.byte	0x4
	.byte	0x3
	.uleb128 0x4
	.uleb128 0xc
	.byte	0x7
	.4byte	.Ldebug_macro40
	.byte	0x3
	.uleb128 0x20
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro41
	.byte	0x4
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF763
	.file 34 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/waitflags.h"
	.byte	0x3
	.uleb128 0x29
	.uleb128 0x22
	.byte	0x7
	.4byte	.Ldebug_macro42
	.byte	0x4
	.file 35 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/waitstatus.h"
	.byte	0x3
	.uleb128 0x2a
	.uleb128 0x23
	.byte	0x7
	.4byte	.Ldebug_macro43
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro44
	.file 36 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/sys/types.h"
	.byte	0x3
	.uleb128 0x13a
	.uleb128 0x24
	.byte	0x7
	.4byte	.Ldebug_macro45
	.byte	0x3
	.uleb128 0x92
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro31
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro46
	.file 37 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/sys/select.h"
	.byte	0x3
	.uleb128 0xdb
	.uleb128 0x25
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF823
	.file 38 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/select.h"
	.byte	0x3
	.uleb128 0x1e
	.uleb128 0x26
	.byte	0x7
	.4byte	.Ldebug_macro47
	.byte	0x4
	.file 39 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/sigset.h"
	.byte	0x3
	.uleb128 0x21
	.uleb128 0x27
	.byte	0x7
	.4byte	.Ldebug_macro48
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro49
	.byte	0x3
	.uleb128 0x2d
	.uleb128 0x1f
	.byte	0x7
	.4byte	.Ldebug_macro50
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro51
	.byte	0x4
	.file 40 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/sys/sysmacros.h"
	.byte	0x3
	.uleb128 0xde
	.uleb128 0x28
	.byte	0x7
	.4byte	.Ldebug_macro52
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro53
	.byte	0x4
	.byte	0x5
	.uleb128 0x1cf
	.4byte	.LASF853
	.file 41 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/alloca.h"
	.byte	0x3
	.uleb128 0x1ec
	.uleb128 0x29
	.byte	0x7
	.4byte	.Ldebug_macro54
	.byte	0x3
	.uleb128 0x18
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro31
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro55
	.byte	0x4
	.byte	0x5
	.uleb128 0x2e4
	.4byte	.LASF857
	.file 42 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/stdlib-bsearch.h"
	.byte	0x3
	.uleb128 0x2f7
	.uleb128 0x2a
	.byte	0x4
	.file 43 "/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include/bits/stdlib-float.h"
	.byte	0x3
	.uleb128 0x3ba
	.uleb128 0x2b
	.byte	0x4
	.byte	0x6
	.uleb128 0x3c5
	.4byte	.LASF858
	.byte	0x4
	.byte	0x3
	.uleb128 0x7
	.uleb128 0x2
	.byte	0x5
	.uleb128 0x2
	.4byte	.LASF859
	.byte	0x4
	.byte	0x4
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.0.f0d7e994cbbbba7ee6295a692eb89231,comdat
.Ldebug_macro1:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0
	.4byte	.LASF0
	.byte	0x5
	.uleb128 0
	.4byte	.LASF1
	.byte	0x5
	.uleb128 0
	.4byte	.LASF2
	.byte	0x5
	.uleb128 0
	.4byte	.LASF3
	.byte	0x5
	.uleb128 0
	.4byte	.LASF4
	.byte	0x5
	.uleb128 0
	.4byte	.LASF5
	.byte	0x5
	.uleb128 0
	.4byte	.LASF6
	.byte	0x5
	.uleb128 0
	.4byte	.LASF7
	.byte	0x5
	.uleb128 0
	.4byte	.LASF8
	.byte	0x5
	.uleb128 0
	.4byte	.LASF9
	.byte	0x5
	.uleb128 0
	.4byte	.LASF10
	.byte	0x5
	.uleb128 0
	.4byte	.LASF11
	.byte	0x5
	.uleb128 0
	.4byte	.LASF12
	.byte	0x5
	.uleb128 0
	.4byte	.LASF13
	.byte	0x5
	.uleb128 0
	.4byte	.LASF14
	.byte	0x5
	.uleb128 0
	.4byte	.LASF15
	.byte	0x5
	.uleb128 0
	.4byte	.LASF16
	.byte	0x5
	.uleb128 0
	.4byte	.LASF17
	.byte	0x5
	.uleb128 0
	.4byte	.LASF18
	.byte	0x5
	.uleb128 0
	.4byte	.LASF19
	.byte	0x5
	.uleb128 0
	.4byte	.LASF20
	.byte	0x5
	.uleb128 0
	.4byte	.LASF21
	.byte	0x5
	.uleb128 0
	.4byte	.LASF22
	.byte	0x5
	.uleb128 0
	.4byte	.LASF23
	.byte	0x5
	.uleb128 0
	.4byte	.LASF24
	.byte	0x5
	.uleb128 0
	.4byte	.LASF25
	.byte	0x5
	.uleb128 0
	.4byte	.LASF26
	.byte	0x5
	.uleb128 0
	.4byte	.LASF27
	.byte	0x5
	.uleb128 0
	.4byte	.LASF28
	.byte	0x5
	.uleb128 0
	.4byte	.LASF29
	.byte	0x5
	.uleb128 0
	.4byte	.LASF30
	.byte	0x5
	.uleb128 0
	.4byte	.LASF31
	.byte	0x5
	.uleb128 0
	.4byte	.LASF32
	.byte	0x5
	.uleb128 0
	.4byte	.LASF33
	.byte	0x5
	.uleb128 0
	.4byte	.LASF34
	.byte	0x5
	.uleb128 0
	.4byte	.LASF35
	.byte	0x5
	.uleb128 0
	.4byte	.LASF36
	.byte	0x5
	.uleb128 0
	.4byte	.LASF37
	.byte	0x5
	.uleb128 0
	.4byte	.LASF38
	.byte	0x5
	.uleb128 0
	.4byte	.LASF39
	.byte	0x5
	.uleb128 0
	.4byte	.LASF40
	.byte	0x5
	.uleb128 0
	.4byte	.LASF41
	.byte	0x5
	.uleb128 0
	.4byte	.LASF42
	.byte	0x5
	.uleb128 0
	.4byte	.LASF43
	.byte	0x5
	.uleb128 0
	.4byte	.LASF44
	.byte	0x5
	.uleb128 0
	.4byte	.LASF45
	.byte	0x5
	.uleb128 0
	.4byte	.LASF46
	.byte	0x5
	.uleb128 0
	.4byte	.LASF47
	.byte	0x5
	.uleb128 0
	.4byte	.LASF48
	.byte	0x5
	.uleb128 0
	.4byte	.LASF49
	.byte	0x5
	.uleb128 0
	.4byte	.LASF50
	.byte	0x5
	.uleb128 0
	.4byte	.LASF51
	.byte	0x5
	.uleb128 0
	.4byte	.LASF52
	.byte	0x5
	.uleb128 0
	.4byte	.LASF53
	.byte	0x5
	.uleb128 0
	.4byte	.LASF54
	.byte	0x5
	.uleb128 0
	.4byte	.LASF55
	.byte	0x5
	.uleb128 0
	.4byte	.LASF56
	.byte	0x5
	.uleb128 0
	.4byte	.LASF57
	.byte	0x5
	.uleb128 0
	.4byte	.LASF58
	.byte	0x5
	.uleb128 0
	.4byte	.LASF59
	.byte	0x5
	.uleb128 0
	.4byte	.LASF60
	.byte	0x5
	.uleb128 0
	.4byte	.LASF61
	.byte	0x5
	.uleb128 0
	.4byte	.LASF62
	.byte	0x5
	.uleb128 0
	.4byte	.LASF63
	.byte	0x5
	.uleb128 0
	.4byte	.LASF64
	.byte	0x5
	.uleb128 0
	.4byte	.LASF65
	.byte	0x5
	.uleb128 0
	.4byte	.LASF66
	.byte	0x5
	.uleb128 0
	.4byte	.LASF67
	.byte	0x5
	.uleb128 0
	.4byte	.LASF68
	.byte	0x5
	.uleb128 0
	.4byte	.LASF69
	.byte	0x5
	.uleb128 0
	.4byte	.LASF70
	.byte	0x5
	.uleb128 0
	.4byte	.LASF71
	.byte	0x5
	.uleb128 0
	.4byte	.LASF72
	.byte	0x5
	.uleb128 0
	.4byte	.LASF73
	.byte	0x5
	.uleb128 0
	.4byte	.LASF74
	.byte	0x5
	.uleb128 0
	.4byte	.LASF75
	.byte	0x5
	.uleb128 0
	.4byte	.LASF76
	.byte	0x5
	.uleb128 0
	.4byte	.LASF77
	.byte	0x5
	.uleb128 0
	.4byte	.LASF78
	.byte	0x5
	.uleb128 0
	.4byte	.LASF79
	.byte	0x5
	.uleb128 0
	.4byte	.LASF80
	.byte	0x5
	.uleb128 0
	.4byte	.LASF81
	.byte	0x5
	.uleb128 0
	.4byte	.LASF82
	.byte	0x5
	.uleb128 0
	.4byte	.LASF83
	.byte	0x5
	.uleb128 0
	.4byte	.LASF84
	.byte	0x5
	.uleb128 0
	.4byte	.LASF85
	.byte	0x5
	.uleb128 0
	.4byte	.LASF86
	.byte	0x5
	.uleb128 0
	.4byte	.LASF87
	.byte	0x5
	.uleb128 0
	.4byte	.LASF88
	.byte	0x5
	.uleb128 0
	.4byte	.LASF89
	.byte	0x5
	.uleb128 0
	.4byte	.LASF90
	.byte	0x5
	.uleb128 0
	.4byte	.LASF91
	.byte	0x5
	.uleb128 0
	.4byte	.LASF92
	.byte	0x5
	.uleb128 0
	.4byte	.LASF93
	.byte	0x5
	.uleb128 0
	.4byte	.LASF94
	.byte	0x5
	.uleb128 0
	.4byte	.LASF95
	.byte	0x5
	.uleb128 0
	.4byte	.LASF96
	.byte	0x5
	.uleb128 0
	.4byte	.LASF97
	.byte	0x5
	.uleb128 0
	.4byte	.LASF98
	.byte	0x5
	.uleb128 0
	.4byte	.LASF99
	.byte	0x5
	.uleb128 0
	.4byte	.LASF100
	.byte	0x5
	.uleb128 0
	.4byte	.LASF101
	.byte	0x5
	.uleb128 0
	.4byte	.LASF102
	.byte	0x5
	.uleb128 0
	.4byte	.LASF103
	.byte	0x5
	.uleb128 0
	.4byte	.LASF104
	.byte	0x5
	.uleb128 0
	.4byte	.LASF105
	.byte	0x5
	.uleb128 0
	.4byte	.LASF106
	.byte	0x5
	.uleb128 0
	.4byte	.LASF107
	.byte	0x5
	.uleb128 0
	.4byte	.LASF108
	.byte	0x5
	.uleb128 0
	.4byte	.LASF109
	.byte	0x5
	.uleb128 0
	.4byte	.LASF110
	.byte	0x5
	.uleb128 0
	.4byte	.LASF111
	.byte	0x5
	.uleb128 0
	.4byte	.LASF112
	.byte	0x5
	.uleb128 0
	.4byte	.LASF113
	.byte	0x5
	.uleb128 0
	.4byte	.LASF114
	.byte	0x5
	.uleb128 0
	.4byte	.LASF115
	.byte	0x5
	.uleb128 0
	.4byte	.LASF116
	.byte	0x5
	.uleb128 0
	.4byte	.LASF117
	.byte	0x5
	.uleb128 0
	.4byte	.LASF118
	.byte	0x5
	.uleb128 0
	.4byte	.LASF119
	.byte	0x5
	.uleb128 0
	.4byte	.LASF120
	.byte	0x5
	.uleb128 0
	.4byte	.LASF121
	.byte	0x5
	.uleb128 0
	.4byte	.LASF122
	.byte	0x5
	.uleb128 0
	.4byte	.LASF123
	.byte	0x5
	.uleb128 0
	.4byte	.LASF124
	.byte	0x5
	.uleb128 0
	.4byte	.LASF125
	.byte	0x5
	.uleb128 0
	.4byte	.LASF126
	.byte	0x5
	.uleb128 0
	.4byte	.LASF127
	.byte	0x5
	.uleb128 0
	.4byte	.LASF128
	.byte	0x5
	.uleb128 0
	.4byte	.LASF129
	.byte	0x5
	.uleb128 0
	.4byte	.LASF130
	.byte	0x5
	.uleb128 0
	.4byte	.LASF131
	.byte	0x5
	.uleb128 0
	.4byte	.LASF132
	.byte	0x5
	.uleb128 0
	.4byte	.LASF133
	.byte	0x5
	.uleb128 0
	.4byte	.LASF134
	.byte	0x5
	.uleb128 0
	.4byte	.LASF135
	.byte	0x5
	.uleb128 0
	.4byte	.LASF136
	.byte	0x5
	.uleb128 0
	.4byte	.LASF137
	.byte	0x5
	.uleb128 0
	.4byte	.LASF138
	.byte	0x5
	.uleb128 0
	.4byte	.LASF139
	.byte	0x5
	.uleb128 0
	.4byte	.LASF140
	.byte	0x5
	.uleb128 0
	.4byte	.LASF141
	.byte	0x5
	.uleb128 0
	.4byte	.LASF142
	.byte	0x5
	.uleb128 0
	.4byte	.LASF143
	.byte	0x5
	.uleb128 0
	.4byte	.LASF144
	.byte	0x5
	.uleb128 0
	.4byte	.LASF145
	.byte	0x5
	.uleb128 0
	.4byte	.LASF146
	.byte	0x5
	.uleb128 0
	.4byte	.LASF147
	.byte	0x5
	.uleb128 0
	.4byte	.LASF148
	.byte	0x5
	.uleb128 0
	.4byte	.LASF149
	.byte	0x5
	.uleb128 0
	.4byte	.LASF150
	.byte	0x5
	.uleb128 0
	.4byte	.LASF151
	.byte	0x5
	.uleb128 0
	.4byte	.LASF152
	.byte	0x5
	.uleb128 0
	.4byte	.LASF153
	.byte	0x5
	.uleb128 0
	.4byte	.LASF154
	.byte	0x5
	.uleb128 0
	.4byte	.LASF155
	.byte	0x5
	.uleb128 0
	.4byte	.LASF156
	.byte	0x5
	.uleb128 0
	.4byte	.LASF157
	.byte	0x5
	.uleb128 0
	.4byte	.LASF158
	.byte	0x5
	.uleb128 0
	.4byte	.LASF159
	.byte	0x5
	.uleb128 0
	.4byte	.LASF160
	.byte	0x5
	.uleb128 0
	.4byte	.LASF161
	.byte	0x5
	.uleb128 0
	.4byte	.LASF162
	.byte	0x5
	.uleb128 0
	.4byte	.LASF163
	.byte	0x5
	.uleb128 0
	.4byte	.LASF164
	.byte	0x5
	.uleb128 0
	.4byte	.LASF165
	.byte	0x5
	.uleb128 0
	.4byte	.LASF166
	.byte	0x5
	.uleb128 0
	.4byte	.LASF167
	.byte	0x5
	.uleb128 0
	.4byte	.LASF168
	.byte	0x5
	.uleb128 0
	.4byte	.LASF169
	.byte	0x5
	.uleb128 0
	.4byte	.LASF170
	.byte	0x5
	.uleb128 0
	.4byte	.LASF171
	.byte	0x5
	.uleb128 0
	.4byte	.LASF172
	.byte	0x5
	.uleb128 0
	.4byte	.LASF173
	.byte	0x5
	.uleb128 0
	.4byte	.LASF174
	.byte	0x5
	.uleb128 0
	.4byte	.LASF175
	.byte	0x5
	.uleb128 0
	.4byte	.LASF176
	.byte	0x5
	.uleb128 0
	.4byte	.LASF177
	.byte	0x5
	.uleb128 0
	.4byte	.LASF178
	.byte	0x5
	.uleb128 0
	.4byte	.LASF179
	.byte	0x5
	.uleb128 0
	.4byte	.LASF180
	.byte	0x5
	.uleb128 0
	.4byte	.LASF181
	.byte	0x5
	.uleb128 0
	.4byte	.LASF182
	.byte	0x5
	.uleb128 0
	.4byte	.LASF183
	.byte	0x5
	.uleb128 0
	.4byte	.LASF184
	.byte	0x5
	.uleb128 0
	.4byte	.LASF185
	.byte	0x5
	.uleb128 0
	.4byte	.LASF186
	.byte	0x5
	.uleb128 0
	.4byte	.LASF187
	.byte	0x5
	.uleb128 0
	.4byte	.LASF188
	.byte	0x5
	.uleb128 0
	.4byte	.LASF189
	.byte	0x5
	.uleb128 0
	.4byte	.LASF190
	.byte	0x5
	.uleb128 0
	.4byte	.LASF191
	.byte	0x5
	.uleb128 0
	.4byte	.LASF192
	.byte	0x5
	.uleb128 0
	.4byte	.LASF193
	.byte	0x5
	.uleb128 0
	.4byte	.LASF194
	.byte	0x5
	.uleb128 0
	.4byte	.LASF195
	.byte	0x5
	.uleb128 0
	.4byte	.LASF196
	.byte	0x5
	.uleb128 0
	.4byte	.LASF197
	.byte	0x5
	.uleb128 0
	.4byte	.LASF198
	.byte	0x5
	.uleb128 0
	.4byte	.LASF199
	.byte	0x5
	.uleb128 0
	.4byte	.LASF200
	.byte	0x5
	.uleb128 0
	.4byte	.LASF201
	.byte	0x5
	.uleb128 0
	.4byte	.LASF202
	.byte	0x5
	.uleb128 0
	.4byte	.LASF203
	.byte	0x5
	.uleb128 0
	.4byte	.LASF204
	.byte	0x5
	.uleb128 0
	.4byte	.LASF205
	.byte	0x5
	.uleb128 0
	.4byte	.LASF206
	.byte	0x5
	.uleb128 0
	.4byte	.LASF207
	.byte	0x5
	.uleb128 0
	.4byte	.LASF208
	.byte	0x5
	.uleb128 0
	.4byte	.LASF209
	.byte	0x5
	.uleb128 0
	.4byte	.LASF210
	.byte	0x5
	.uleb128 0
	.4byte	.LASF211
	.byte	0x5
	.uleb128 0
	.4byte	.LASF212
	.byte	0x5
	.uleb128 0
	.4byte	.LASF213
	.byte	0x5
	.uleb128 0
	.4byte	.LASF214
	.byte	0x5
	.uleb128 0
	.4byte	.LASF215
	.byte	0x5
	.uleb128 0
	.4byte	.LASF216
	.byte	0x5
	.uleb128 0
	.4byte	.LASF217
	.byte	0x5
	.uleb128 0
	.4byte	.LASF218
	.byte	0x5
	.uleb128 0
	.4byte	.LASF219
	.byte	0x5
	.uleb128 0
	.4byte	.LASF220
	.byte	0x5
	.uleb128 0
	.4byte	.LASF221
	.byte	0x5
	.uleb128 0
	.4byte	.LASF222
	.byte	0x5
	.uleb128 0
	.4byte	.LASF223
	.byte	0x5
	.uleb128 0
	.4byte	.LASF224
	.byte	0x5
	.uleb128 0
	.4byte	.LASF225
	.byte	0x5
	.uleb128 0
	.4byte	.LASF226
	.byte	0x5
	.uleb128 0
	.4byte	.LASF227
	.byte	0x5
	.uleb128 0
	.4byte	.LASF228
	.byte	0x5
	.uleb128 0
	.4byte	.LASF229
	.byte	0x5
	.uleb128 0
	.4byte	.LASF230
	.byte	0x5
	.uleb128 0
	.4byte	.LASF231
	.byte	0x5
	.uleb128 0
	.4byte	.LASF232
	.byte	0x6
	.uleb128 0
	.4byte	.LASF233
	.byte	0x5
	.uleb128 0
	.4byte	.LASF234
	.byte	0x5
	.uleb128 0
	.4byte	.LASF235
	.byte	0x6
	.uleb128 0
	.4byte	.LASF236
	.byte	0x6
	.uleb128 0
	.4byte	.LASF237
	.byte	0x5
	.uleb128 0
	.4byte	.LASF238
	.byte	0x5
	.uleb128 0
	.4byte	.LASF239
	.byte	0x5
	.uleb128 0
	.4byte	.LASF240
	.byte	0x5
	.uleb128 0
	.4byte	.LASF241
	.byte	0x5
	.uleb128 0
	.4byte	.LASF242
	.byte	0x6
	.uleb128 0
	.4byte	.LASF243
	.byte	0x6
	.uleb128 0
	.4byte	.LASF244
	.byte	0x5
	.uleb128 0
	.4byte	.LASF245
	.byte	0x5
	.uleb128 0
	.4byte	.LASF246
	.byte	0x6
	.uleb128 0
	.4byte	.LASF247
	.byte	0x6
	.uleb128 0
	.4byte	.LASF248
	.byte	0x6
	.uleb128 0
	.4byte	.LASF249
	.byte	0x6
	.uleb128 0
	.4byte	.LASF250
	.byte	0x5
	.uleb128 0
	.4byte	.LASF251
	.byte	0x6
	.uleb128 0
	.4byte	.LASF252
	.byte	0x6
	.uleb128 0
	.4byte	.LASF253
	.byte	0x6
	.uleb128 0
	.4byte	.LASF254
	.byte	0x6
	.uleb128 0
	.4byte	.LASF255
	.byte	0x5
	.uleb128 0
	.4byte	.LASF256
	.byte	0x5
	.uleb128 0
	.4byte	.LASF257
	.byte	0x5
	.uleb128 0
	.4byte	.LASF258
	.byte	0x5
	.uleb128 0
	.4byte	.LASF259
	.byte	0x5
	.uleb128 0
	.4byte	.LASF260
	.byte	0x5
	.uleb128 0
	.4byte	.LASF261
	.byte	0x5
	.uleb128 0
	.4byte	.LASF262
	.byte	0x5
	.uleb128 0
	.4byte	.LASF263
	.byte	0x5
	.uleb128 0
	.4byte	.LASF264
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdcpredef.h.19.bf2bf6c5fb087dfb5ef2d2297c2795de,comdat
.Ldebug_macro2:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF265
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF266
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF267
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF268
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF269
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.features.h.19.eda9734f5a9ce9d015be5799b04ec775,comdat
.Ldebug_macro3:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF271
	.byte	0x6
	.uleb128 0x61
	.4byte	.LASF272
	.byte	0x6
	.uleb128 0x62
	.4byte	.LASF273
	.byte	0x6
	.uleb128 0x63
	.4byte	.LASF274
	.byte	0x6
	.uleb128 0x64
	.4byte	.LASF275
	.byte	0x6
	.uleb128 0x65
	.4byte	.LASF276
	.byte	0x6
	.uleb128 0x66
	.4byte	.LASF277
	.byte	0x6
	.uleb128 0x67
	.4byte	.LASF278
	.byte	0x6
	.uleb128 0x68
	.4byte	.LASF279
	.byte	0x6
	.uleb128 0x69
	.4byte	.LASF280
	.byte	0x6
	.uleb128 0x6a
	.4byte	.LASF281
	.byte	0x6
	.uleb128 0x6b
	.4byte	.LASF282
	.byte	0x6
	.uleb128 0x6c
	.4byte	.LASF283
	.byte	0x6
	.uleb128 0x6d
	.4byte	.LASF284
	.byte	0x6
	.uleb128 0x6e
	.4byte	.LASF285
	.byte	0x6
	.uleb128 0x6f
	.4byte	.LASF286
	.byte	0x6
	.uleb128 0x70
	.4byte	.LASF287
	.byte	0x6
	.uleb128 0x71
	.4byte	.LASF288
	.byte	0x6
	.uleb128 0x72
	.4byte	.LASF289
	.byte	0x6
	.uleb128 0x73
	.4byte	.LASF290
	.byte	0x6
	.uleb128 0x74
	.4byte	.LASF291
	.byte	0x6
	.uleb128 0x75
	.4byte	.LASF292
	.byte	0x6
	.uleb128 0x76
	.4byte	.LASF293
	.byte	0x6
	.uleb128 0x77
	.4byte	.LASF294
	.byte	0x6
	.uleb128 0x78
	.4byte	.LASF295
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF296
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF297
	.byte	0x6
	.uleb128 0xb8
	.4byte	.LASF298
	.byte	0x5
	.uleb128 0xb9
	.4byte	.LASF299
	.byte	0x5
	.uleb128 0xbf
	.4byte	.LASF300
	.byte	0x5
	.uleb128 0xc5
	.4byte	.LASF301
	.byte	0x5
	.uleb128 0xcb
	.4byte	.LASF302
	.byte	0x5
	.uleb128 0xdc
	.4byte	.LASF303
	.byte	0x6
	.uleb128 0xde
	.4byte	.LASF304
	.byte	0x5
	.uleb128 0xdf
	.4byte	.LASF305
	.byte	0x6
	.uleb128 0xe0
	.4byte	.LASF306
	.byte	0x5
	.uleb128 0xe1
	.4byte	.LASF307
	.byte	0x5
	.uleb128 0xf6
	.4byte	.LASF308
	.byte	0x5
	.uleb128 0xfa
	.4byte	.LASF309
	.byte	0x5
	.uleb128 0xfe
	.4byte	.LASF310
	.byte	0x5
	.uleb128 0x102
	.4byte	.LASF311
	.byte	0x5
	.uleb128 0x106
	.4byte	.LASF312
	.byte	0x6
	.uleb128 0x107
	.4byte	.LASF274
	.byte	0x5
	.uleb128 0x108
	.4byte	.LASF302
	.byte	0x6
	.uleb128 0x109
	.4byte	.LASF273
	.byte	0x5
	.uleb128 0x10a
	.4byte	.LASF301
	.byte	0x5
	.uleb128 0x10e
	.4byte	.LASF313
	.byte	0x6
	.uleb128 0x10f
	.4byte	.LASF314
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF315
	.byte	0x5
	.uleb128 0x13a
	.4byte	.LASF316
	.byte	0x5
	.uleb128 0x13e
	.4byte	.LASF317
	.byte	0x5
	.uleb128 0x155
	.4byte	.LASF318
	.byte	0x6
	.uleb128 0x162
	.4byte	.LASF319
	.byte	0x5
	.uleb128 0x163
	.4byte	.LASF320
	.byte	0x5
	.uleb128 0x167
	.4byte	.LASF321
	.byte	0x5
	.uleb128 0x168
	.4byte	.LASF322
	.byte	0x5
	.uleb128 0x16a
	.4byte	.LASF323
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.cdefs.h.19.e107c3371efa9ef36ee8ae09396d7011,comdat
.Ldebug_macro4:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF324
	.byte	0x2
	.uleb128 0x22
	.string	"__P"
	.byte	0x6
	.uleb128 0x23
	.4byte	.LASF325
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF326
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF327
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF328
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF329
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF330
	.byte	0x5
	.uleb128 0x52
	.4byte	.LASF331
	.byte	0x5
	.uleb128 0x53
	.4byte	.LASF332
	.byte	0x5
	.uleb128 0x58
	.4byte	.LASF333
	.byte	0x5
	.uleb128 0x59
	.4byte	.LASF334
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF335
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF336
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF337
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF338
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF339
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF340
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF341
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF342
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF343
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF344
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF345
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF346
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF347
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF348
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF349
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF350
	.byte	0x5
	.uleb128 0xb1
	.4byte	.LASF351
	.byte	0x5
	.uleb128 0xb8
	.4byte	.LASF352
	.byte	0x5
	.uleb128 0xba
	.4byte	.LASF353
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF354
	.byte	0x5
	.uleb128 0xbe
	.4byte	.LASF355
	.byte	0x5
	.uleb128 0xd3
	.4byte	.LASF356
	.byte	0x5
	.uleb128 0xdb
	.4byte	.LASF357
	.byte	0x5
	.uleb128 0xe5
	.4byte	.LASF358
	.byte	0x5
	.uleb128 0xec
	.4byte	.LASF359
	.byte	0x5
	.uleb128 0xf5
	.4byte	.LASF360
	.byte	0x5
	.uleb128 0xf6
	.4byte	.LASF361
	.byte	0x5
	.uleb128 0xfe
	.4byte	.LASF362
	.byte	0x5
	.uleb128 0x10a
	.4byte	.LASF363
	.byte	0x5
	.uleb128 0x114
	.4byte	.LASF364
	.byte	0x5
	.uleb128 0x11d
	.4byte	.LASF365
	.byte	0x5
	.uleb128 0x125
	.4byte	.LASF366
	.byte	0x5
	.uleb128 0x12e
	.4byte	.LASF367
	.byte	0x5
	.uleb128 0x133
	.4byte	.LASF368
	.byte	0x5
	.uleb128 0x13b
	.4byte	.LASF369
	.byte	0x5
	.uleb128 0x14d
	.4byte	.LASF370
	.byte	0x5
	.uleb128 0x14e
	.4byte	.LASF371
	.byte	0x5
	.uleb128 0x157
	.4byte	.LASF372
	.byte	0x5
	.uleb128 0x15d
	.4byte	.LASF373
	.byte	0x5
	.uleb128 0x15e
	.4byte	.LASF374
	.byte	0x5
	.uleb128 0x172
	.4byte	.LASF375
	.byte	0x5
	.uleb128 0x181
	.4byte	.LASF376
	.byte	0x5
	.uleb128 0x182
	.4byte	.LASF377
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.cdefs.h.432.619afd0aac7c4b439843706c1b28ddea,comdat
.Ldebug_macro5:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1b0
	.4byte	.LASF379
	.byte	0x5
	.uleb128 0x1b1
	.4byte	.LASF380
	.byte	0x5
	.uleb128 0x1b2
	.4byte	.LASF381
	.byte	0x5
	.uleb128 0x1b3
	.4byte	.LASF382
	.byte	0x5
	.uleb128 0x1b4
	.4byte	.LASF383
	.byte	0x5
	.uleb128 0x1b6
	.4byte	.LASF384
	.byte	0x5
	.uleb128 0x1b7
	.4byte	.LASF385
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stubslp64.h.10.e28b410b4614beb932e7700b15e424c7,comdat
.Ldebug_macro6:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xa
	.4byte	.LASF387
	.byte	0x5
	.uleb128 0xb
	.4byte	.LASF388
	.byte	0x5
	.uleb128 0xc
	.4byte	.LASF389
	.byte	0x5
	.uleb128 0xd
	.4byte	.LASF390
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF391
	.byte	0x5
	.uleb128 0xf
	.4byte	.LASF392
	.byte	0x5
	.uleb128 0x10
	.4byte	.LASF393
	.byte	0x5
	.uleb128 0x11
	.4byte	.LASF394
	.byte	0x5
	.uleb128 0x12
	.4byte	.LASF395
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF396
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF397
	.byte	0x5
	.uleb128 0x15
	.4byte	.LASF398
	.byte	0x5
	.uleb128 0x16
	.4byte	.LASF399
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF400
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF401
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF402
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF403
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF404
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF405
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF406
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF407
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF408
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF409
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.assert.h.40.93a95bbb7a3c3b66e999d68d8edb6960,comdat
.Ldebug_macro7:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF410
	.byte	0x5
	.uleb128 0x55
	.4byte	.LASF411
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF412
	.byte	0x6
	.uleb128 0x74
	.4byte	.LASF413
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF414
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdio.h.26.4719156f1aea2bb9662fd6c582dc9a4c,comdat
.Ldebug_macro8:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF415
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF416
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF417
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stddef.h.187.2ff233552538c6ff9b8575ca8ea52cb3,comdat
.Ldebug_macro9:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xbb
	.4byte	.LASF418
	.byte	0x5
	.uleb128 0xbc
	.4byte	.LASF419
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF420
	.byte	0x5
	.uleb128 0xbe
	.4byte	.LASF421
	.byte	0x5
	.uleb128 0xbf
	.4byte	.LASF422
	.byte	0x5
	.uleb128 0xc0
	.4byte	.LASF423
	.byte	0x5
	.uleb128 0xc1
	.4byte	.LASF424
	.byte	0x5
	.uleb128 0xc2
	.4byte	.LASF425
	.byte	0x5
	.uleb128 0xc3
	.4byte	.LASF426
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF427
	.byte	0x5
	.uleb128 0xc5
	.4byte	.LASF428
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF429
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF430
	.byte	0x5
	.uleb128 0xc8
	.4byte	.LASF431
	.byte	0x5
	.uleb128 0xc9
	.4byte	.LASF432
	.byte	0x5
	.uleb128 0xca
	.4byte	.LASF433
	.byte	0x5
	.uleb128 0xd2
	.4byte	.LASF434
	.byte	0x6
	.uleb128 0xee
	.4byte	.LASF435
	.byte	0x6
	.uleb128 0x191
	.4byte	.LASF436
	.byte	0x5
	.uleb128 0x196
	.4byte	.LASF437
	.byte	0x6
	.uleb128 0x19c
	.4byte	.LASF438
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.types.h.89.468e2451361e3b92f048f6cad51690ff,comdat
.Ldebug_macro10:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x59
	.4byte	.LASF440
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF441
	.byte	0x5
	.uleb128 0x5b
	.4byte	.LASF442
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF443
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF444
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF445
	.byte	0x5
	.uleb128 0x6c
	.4byte	.LASF446
	.byte	0x5
	.uleb128 0x6d
	.4byte	.LASF447
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF448
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF449
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF450
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF451
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF452
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF453
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF454
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.typesizes.h.25.c8cb054800ee73b4344f0c304f3aee56,comdat
.Ldebug_macro11:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF455
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF456
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF457
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF458
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF459
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF460
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF461
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF462
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF463
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF464
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF465
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF466
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF467
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF468
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF469
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF470
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF471
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF472
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF473
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF474
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF475
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF476
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF477
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF478
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF479
	.byte	0x5
	.uleb128 0x36
	.4byte	.LASF480
	.byte	0x5
	.uleb128 0x37
	.4byte	.LASF481
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF482
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF483
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF484
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF485
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF486
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF487
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF488
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF489
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF490
	.byte	0x5
	.uleb128 0x48
	.4byte	.LASF491
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF492
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdio.h.36.2dd12c1fd035242ad5cfd0152a01be5a,comdat
.Ldebug_macro12:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF494
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF495
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF496
	.byte	0x6
	.uleb128 0x3a
	.4byte	.LASF497
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF498
	.byte	0x6
	.uleb128 0x44
	.4byte	.LASF499
	.byte	0x5
	.uleb128 0x48
	.4byte	.LASF500
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4._G_config.h.5.b0f37d9e474454cf6e459063458db32f,comdat
.Ldebug_macro13:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x5
	.4byte	.LASF502
	.byte	0x5
	.uleb128 0xa
	.4byte	.LASF416
	.byte	0x5
	.uleb128 0xe
	.4byte	.LASF417
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stddef.h.238.04cc7214bceba497b20d15c10fd97511,comdat
.Ldebug_macro14:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0xee
	.4byte	.LASF435
	.byte	0x6
	.uleb128 0x191
	.4byte	.LASF436
	.byte	0x5
	.uleb128 0x196
	.4byte	.LASF437
	.byte	0x6
	.uleb128 0x19c
	.4byte	.LASF438
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.wchar.h.80.eea3eba2d2a17aace9470a8e0d8218dc,comdat
.Ldebug_macro15:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x50
	.4byte	.LASF504
	.byte	0x6
	.uleb128 0x60
	.4byte	.LASF505
	.byte	0x6
	.uleb128 0x386
	.4byte	.LASF505
	.byte	0x6
	.uleb128 0x387
	.4byte	.LASF506
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4._G_config.h.46.5187c97b14fd664662cb32e6b94fc49e,comdat
.Ldebug_macro16:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF507
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF508
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF509
	.byte	0x5
	.uleb128 0x33
	.4byte	.LASF510
	.byte	0x5
	.uleb128 0x36
	.4byte	.LASF511
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF512
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.libio.h.33.a775b9ecae273f33bc59931e9891e4ca,comdat
.Ldebug_macro17:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF513
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF514
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF515
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF516
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF517
	.byte	0x5
	.uleb128 0x26
	.4byte	.LASF518
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF519
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF520
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF521
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF522
	.byte	0x5
	.uleb128 0x2b
	.4byte	.LASF523
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF524
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF525
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF526
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdarg.h.34.3a23a216c0c293b3d2ea2e89281481e6,comdat
.Ldebug_macro18:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0x22
	.4byte	.LASF527
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF528
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.libio.h.51.dab170798ec1df48c625aea7c30e1b63,comdat
.Ldebug_macro19:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0x33
	.4byte	.LASF529
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF530
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF531
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF532
	.byte	0x5
	.uleb128 0x4d
	.4byte	.LASF533
	.byte	0x5
	.uleb128 0x4e
	.4byte	.LASF534
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF535
	.byte	0x5
	.uleb128 0x50
	.4byte	.LASF536
	.byte	0x5
	.uleb128 0x51
	.4byte	.LASF537
	.byte	0x5
	.uleb128 0x52
	.4byte	.LASF538
	.byte	0x5
	.uleb128 0x53
	.4byte	.LASF539
	.byte	0x5
	.uleb128 0x54
	.4byte	.LASF540
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF541
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF542
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF543
	.byte	0x5
	.uleb128 0x5f
	.4byte	.LASF544
	.byte	0x5
	.uleb128 0x60
	.4byte	.LASF545
	.byte	0x5
	.uleb128 0x61
	.4byte	.LASF546
	.byte	0x5
	.uleb128 0x62
	.4byte	.LASF547
	.byte	0x5
	.uleb128 0x63
	.4byte	.LASF548
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF549
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF550
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF551
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF552
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF553
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF554
	.byte	0x5
	.uleb128 0x6a
	.4byte	.LASF555
	.byte	0x5
	.uleb128 0x6b
	.4byte	.LASF556
	.byte	0x5
	.uleb128 0x6c
	.4byte	.LASF557
	.byte	0x5
	.uleb128 0x6d
	.4byte	.LASF558
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF559
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF560
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF561
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF562
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF563
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF564
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF565
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF566
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF567
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF568
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF569
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF570
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF571
	.byte	0x5
	.uleb128 0x86
	.4byte	.LASF572
	.byte	0x5
	.uleb128 0x87
	.4byte	.LASF573
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF574
	.byte	0x5
	.uleb128 0x89
	.4byte	.LASF575
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF576
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF577
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF578
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF579
	.byte	0x5
	.uleb128 0xf3
	.4byte	.LASF580
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF581
	.byte	0x5
	.uleb128 0x13f
	.4byte	.LASF582
	.byte	0x5
	.uleb128 0x140
	.4byte	.LASF583
	.byte	0x5
	.uleb128 0x141
	.4byte	.LASF584
	.byte	0x5
	.uleb128 0x18b
	.4byte	.LASF585
	.byte	0x5
	.uleb128 0x190
	.4byte	.LASF586
	.byte	0x5
	.uleb128 0x193
	.4byte	.LASF587
	.byte	0x5
	.uleb128 0x197
	.4byte	.LASF588
	.byte	0x5
	.uleb128 0x1aa
	.4byte	.LASF589
	.byte	0x5
	.uleb128 0x1ab
	.4byte	.LASF590
	.byte	0x5
	.uleb128 0x1b5
	.4byte	.LASF591
	.byte	0x5
	.uleb128 0x1c3
	.4byte	.LASF592
	.byte	0x5
	.uleb128 0x1c4
	.4byte	.LASF593
	.byte	0x5
	.uleb128 0x1c5
	.4byte	.LASF594
	.byte	0x5
	.uleb128 0x1c6
	.4byte	.LASF595
	.byte	0x5
	.uleb128 0x1c7
	.4byte	.LASF596
	.byte	0x5
	.uleb128 0x1c8
	.4byte	.LASF597
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdio.h.80.2c0b67e94eb93fd8dd1cc22c150ce71c,comdat
.Ldebug_macro20:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x50
	.4byte	.LASF598
	.byte	0x5
	.uleb128 0x5e
	.4byte	.LASF599
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF600
	.byte	0x5
	.uleb128 0x78
	.4byte	.LASF601
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF602
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF603
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF604
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF605
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF606
	.byte	0x5
	.uleb128 0x8e
	.4byte	.LASF607
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF608
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdio_lim.h.23.557290a6cddeba0587f574f29e3a5fb9,comdat
.Ldebug_macro21:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF609
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF610
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF611
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF612
	.byte	0x6
	.uleb128 0x24
	.4byte	.LASF613
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF614
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdio.h.172.df21df34a7396d7da2e08f9b617d582f,comdat
.Ldebug_macro22:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xac
	.4byte	.LASF615
	.byte	0x5
	.uleb128 0xad
	.4byte	.LASF616
	.byte	0x5
	.uleb128 0xae
	.4byte	.LASF617
	.byte	0x5
	.uleb128 0x21f
	.4byte	.LASF618
	.byte	0x5
	.uleb128 0x249
	.4byte	.LASF619
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdio.h.26.cae64f7ada9bb8327a89dba6a5e93655,comdat
.Ldebug_macro23:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF620
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF621
	.byte	0x5
	.uleb128 0xa8
	.4byte	.LASF622
	.byte	0x6
	.uleb128 0xbe
	.4byte	.LASF623
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.endian.h.19.ff00c9c0f5e9f9a9719c5de76ace57b4,comdat
.Ldebug_macro24:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF625
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF626
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF627
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF628
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.endian.h.27.038e1c3e879b082debfc22babf6e9631,comdat
.Ldebug_macro25:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF629
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF630
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.endian.h.45.79342a936cd8243ce44880e5a2fd6b7a,comdat
.Ldebug_macro26:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF631
	.byte	0x5
	.uleb128 0x2e
	.4byte	.LASF632
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF633
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF634
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF635
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.byteswap.h.24.6de22b9768c31ef70ef7a1f4de56b5c7,comdat
.Ldebug_macro27:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF636
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF637
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.byteswap.h.37.1c4149605040ec9122a34b040ff7383d,comdat
.Ldebug_macro28:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF639
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF640
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.endian.h.63.97272d7c64d5db8020003b32e9289502,comdat
.Ldebug_macro29:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF641
	.byte	0x5
	.uleb128 0x40
	.4byte	.LASF642
	.byte	0x5
	.uleb128 0x41
	.4byte	.LASF643
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF644
	.byte	0x5
	.uleb128 0x44
	.4byte	.LASF645
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF646
	.byte	0x5
	.uleb128 0x46
	.4byte	.LASF647
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF648
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF649
	.byte	0x5
	.uleb128 0x4a
	.4byte	.LASF650
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF651
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF652
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.sched.h.20.03e66e3b847677c1e781b90f4b73f77e,comdat
.Ldebug_macro30:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF653
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF416
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stddef.h.238.847b6907dabda77be90a9ab7ad789e2e,comdat
.Ldebug_macro31:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0xee
	.4byte	.LASF435
	.byte	0x6
	.uleb128 0x19c
	.4byte	.LASF438
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.sched.h.31.f838e85546a76474a8c4ae9ddad27ef3,comdat
.Ldebug_macro32:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF654
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF655
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.time.h.66.d0d9f365f84dd1293e1385c36750685d,comdat
.Ldebug_macro33:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0x42
	.4byte	.LASF656
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF657
	.byte	0x6
	.uleb128 0x52
	.4byte	.LASF658
	.byte	0x6
	.uleb128 0x5e
	.4byte	.LASF659
	.byte	0x6
	.uleb128 0x6a
	.4byte	.LASF660
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF661
	.byte	0x6
	.uleb128 0x7f
	.4byte	.LASF662
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.sched.h.28.25eb17a9847efe42b26af9ba02dfcd4f,comdat
.Ldebug_macro34:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF664
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF665
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF666
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF667
	.byte	0x6
	.uleb128 0x6b
	.4byte	.LASF668
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF669
	.byte	0x5
	.uleb128 0x72
	.4byte	.LASF670
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF671
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF672
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF673
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF674
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF675
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF676
	.byte	0x5
	.uleb128 0x9e
	.4byte	.LASF677
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF678
	.byte	0x5
	.uleb128 0xaa
	.4byte	.LASF679
	.byte	0x5
	.uleb128 0xb9
	.4byte	.LASF680
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF681
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF682
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF683
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.time.h.26.6a3cabd4f228e226db6723a3b0c81ba6,comdat
.Ldebug_macro35:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF685
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF416
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF417
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.time.h.40.ef4cac57544640468516e1691b64cd57,comdat
.Ldebug_macro36:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF686
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF687
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF688
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF689
	.byte	0x5
	.uleb128 0x41
	.4byte	.LASF690
	.byte	0x5
	.uleb128 0x43
	.4byte	.LASF691
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF692
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF693
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF694
	.byte	0x5
	.uleb128 0x4b
	.4byte	.LASF695
	.byte	0x5
	.uleb128 0x4d
	.4byte	.LASF696
	.byte	0x5
	.uleb128 0x4f
	.4byte	.LASF697
	.byte	0x5
	.uleb128 0x51
	.4byte	.LASF698
	.byte	0x5
	.uleb128 0x54
	.4byte	.LASF699
	.byte	0x6
	.uleb128 0x65
	.4byte	.LASF700
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.time.h.53.bd1843bcf6509dad2997aea252718ac0,comdat
.Ldebug_macro37:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF701
	.byte	0x6
	.uleb128 0x42
	.4byte	.LASF656
	.byte	0x6
	.uleb128 0x52
	.4byte	.LASF658
	.byte	0x5
	.uleb128 0x56
	.4byte	.LASF702
	.byte	0x6
	.uleb128 0x5e
	.4byte	.LASF659
	.byte	0x5
	.uleb128 0x62
	.4byte	.LASF703
	.byte	0x6
	.uleb128 0x6a
	.4byte	.LASF660
	.byte	0x6
	.uleb128 0x7f
	.4byte	.LASF662
	.byte	0x5
	.uleb128 0xb6
	.4byte	.LASF704
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.pthreadtypes.h.20.09c3df20351f07fae554819f2c40df08,comdat
.Ldebug_macro38:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF707
	.byte	0x5
	.uleb128 0x18
	.4byte	.LASF708
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF709
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF710
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF711
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF712
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF713
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF714
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF715
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF716
	.byte	0x5
	.uleb128 0x21
	.4byte	.LASF717
	.byte	0x5
	.uleb128 0x30
	.4byte	.LASF718
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF719
	.byte	0x5
	.uleb128 0x4e
	.4byte	.LASF720
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF721
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.pthread.h.35.f22d4e3365fde53960f13483fab50ab9,comdat
.Ldebug_macro39:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF723
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF724
	.byte	0x5
	.uleb128 0x56
	.4byte	.LASF725
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF726
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF727
	.byte	0x5
	.uleb128 0x9e
	.4byte	.LASF728
	.byte	0x5
	.uleb128 0xa0
	.4byte	.LASF729
	.byte	0x5
	.uleb128 0xa8
	.4byte	.LASF730
	.byte	0x5
	.uleb128 0xaa
	.4byte	.LASF731
	.byte	0x5
	.uleb128 0xb2
	.4byte	.LASF732
	.byte	0x5
	.uleb128 0xb4
	.4byte	.LASF733
	.byte	0x5
	.uleb128 0xba
	.4byte	.LASF734
	.byte	0x5
	.uleb128 0xca
	.4byte	.LASF735
	.byte	0x5
	.uleb128 0xcc
	.4byte	.LASF736
	.byte	0x5
	.uleb128 0xd1
	.4byte	.LASF737
	.byte	0x5
	.uleb128 0xd3
	.4byte	.LASF738
	.byte	0x5
	.uleb128 0xd5
	.4byte	.LASF739
	.byte	0x5
	.uleb128 0xd9
	.4byte	.LASF740
	.byte	0x5
	.uleb128 0xe0
	.4byte	.LASF741
	.byte	0x5
	.uleb128 0x217
	.4byte	.LASF742
	.byte	0x5
	.uleb128 0x298
	.4byte	.LASF743
	.byte	0x5
	.uleb128 0x2ad
	.4byte	.LASF744
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdlib.h.27.59e2586c75bdbcb991b248ad7257b993,comdat
.Ldebug_macro40:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1b
	.4byte	.LASF416
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF745
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF417
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stddef.h.238.5c3398669aab31a6fd426ff45ca6ab2c,comdat
.Ldebug_macro41:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0xee
	.4byte	.LASF435
	.byte	0x5
	.uleb128 0x10b
	.4byte	.LASF746
	.byte	0x5
	.uleb128 0x10c
	.4byte	.LASF747
	.byte	0x5
	.uleb128 0x10d
	.4byte	.LASF748
	.byte	0x5
	.uleb128 0x10e
	.4byte	.LASF749
	.byte	0x5
	.uleb128 0x10f
	.4byte	.LASF750
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF751
	.byte	0x5
	.uleb128 0x111
	.4byte	.LASF752
	.byte	0x5
	.uleb128 0x112
	.4byte	.LASF753
	.byte	0x5
	.uleb128 0x113
	.4byte	.LASF754
	.byte	0x5
	.uleb128 0x114
	.4byte	.LASF755
	.byte	0x5
	.uleb128 0x115
	.4byte	.LASF756
	.byte	0x5
	.uleb128 0x116
	.4byte	.LASF757
	.byte	0x5
	.uleb128 0x117
	.4byte	.LASF758
	.byte	0x5
	.uleb128 0x118
	.4byte	.LASF759
	.byte	0x5
	.uleb128 0x119
	.4byte	.LASF760
	.byte	0x6
	.uleb128 0x126
	.4byte	.LASF761
	.byte	0x6
	.uleb128 0x15b
	.4byte	.LASF762
	.byte	0x6
	.uleb128 0x191
	.4byte	.LASF436
	.byte	0x5
	.uleb128 0x196
	.4byte	.LASF437
	.byte	0x6
	.uleb128 0x19c
	.4byte	.LASF438
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.waitflags.h.25.f56331828b5cc76f944a22c96459a9b6,comdat
.Ldebug_macro42:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF764
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF765
	.byte	0x5
	.uleb128 0x1d
	.4byte	.LASF766
	.byte	0x5
	.uleb128 0x1e
	.4byte	.LASF767
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF768
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF769
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF770
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF771
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF772
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.waitstatus.h.28.75da223233ea088d05b70fad69e90c9e,comdat
.Ldebug_macro43:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x1c
	.4byte	.LASF773
	.byte	0x5
	.uleb128 0x1f
	.4byte	.LASF774
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF775
	.byte	0x5
	.uleb128 0x25
	.4byte	.LASF776
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF777
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF778
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF779
	.byte	0x5
	.uleb128 0x35
	.4byte	.LASF780
	.byte	0x5
	.uleb128 0x38
	.4byte	.LASF781
	.byte	0x5
	.uleb128 0x39
	.4byte	.LASF782
	.byte	0x5
	.uleb128 0x3a
	.4byte	.LASF783
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF784
	.byte	0x5
	.uleb128 0x63
	.4byte	.LASF785
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF786
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF787
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF788
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF789
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.stdlib.h.50.84aeca2ac6f37d40e1e9b3cef757ba2d,comdat
.Ldebug_macro44:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x32
	.4byte	.LASF790
	.byte	0x5
	.uleb128 0x48
	.4byte	.LASF791
	.byte	0x5
	.uleb128 0x54
	.4byte	.LASF792
	.byte	0x5
	.uleb128 0x55
	.4byte	.LASF793
	.byte	0x5
	.uleb128 0x56
	.4byte	.LASF794
	.byte	0x5
	.uleb128 0x57
	.4byte	.LASF795
	.byte	0x5
	.uleb128 0x58
	.4byte	.LASF796
	.byte	0x5
	.uleb128 0x59
	.4byte	.LASF797
	.byte	0x5
	.uleb128 0x5b
	.4byte	.LASF798
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF799
	.byte	0x5
	.uleb128 0x7a
	.4byte	.LASF800
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF801
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF802
	.byte	0x5
	.uleb128 0x86
	.4byte	.LASF803
	.byte	0x5
	.uleb128 0x8a
	.4byte	.LASF804
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.types.h.23.f5ee130e433d66431be7850b0cc3662c,comdat
.Ldebug_macro45:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF805
	.byte	0x5
	.uleb128 0x28
	.4byte	.LASF806
	.byte	0x5
	.uleb128 0x34
	.4byte	.LASF807
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF808
	.byte	0x5
	.uleb128 0x42
	.4byte	.LASF809
	.byte	0x5
	.uleb128 0x47
	.4byte	.LASF810
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF811
	.byte	0x5
	.uleb128 0x51
	.4byte	.LASF812
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF813
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF814
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF815
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF816
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF654
	.byte	0x5
	.uleb128 0x82
	.4byte	.LASF817
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF818
	.byte	0x5
	.uleb128 0x91
	.4byte	.LASF416
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.types.h.187.bd5a05039b505b3620e6973f1b2ffeb1,comdat
.Ldebug_macro46:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xbb
	.4byte	.LASF819
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF820
	.byte	0x5
	.uleb128 0xc1
	.4byte	.LASF821
	.byte	0x5
	.uleb128 0xd3
	.4byte	.LASF822
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.select.h.25.df647f04fce2d846f134ede6a14ddf91,comdat
.Ldebug_macro47:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF824
	.byte	0x5
	.uleb128 0x20
	.4byte	.LASF825
	.byte	0x5
	.uleb128 0x22
	.4byte	.LASF826
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF827
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.sigset.h.20.f36413b6d2364ad847d3db53fb03e683,comdat
.Ldebug_macro48:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF828
	.byte	0x5
	.uleb128 0x1a
	.4byte	.LASF829
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.select.h.36.069f1abf1d1f07e580ff8682c1bbb856,comdat
.Ldebug_macro49:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x24
	.4byte	.LASF830
	.byte	0x5
	.uleb128 0x29
	.4byte	.LASF654
	.byte	0x5
	.uleb128 0x2a
	.4byte	.LASF655
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF831
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.time.h.25.ae5284cdff565e87a9198d819340325d,comdat
.Ldebug_macro50:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x19
	.4byte	.LASF832
	.byte	0x6
	.uleb128 0x65
	.4byte	.LASF700
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.select.h.49.e9d2041e5035cc68ebd1a20f7dbc8514,comdat
.Ldebug_macro51:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x31
	.4byte	.LASF833
	.byte	0x6
	.uleb128 0x39
	.4byte	.LASF834
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF835
	.byte	0x5
	.uleb128 0x3c
	.4byte	.LASF836
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF837
	.byte	0x5
	.uleb128 0x49
	.4byte	.LASF838
	.byte	0x5
	.uleb128 0x4e
	.4byte	.LASF839
	.byte	0x5
	.uleb128 0x55
	.4byte	.LASF840
	.byte	0x5
	.uleb128 0x5a
	.4byte	.LASF841
	.byte	0x5
	.uleb128 0x5b
	.4byte	.LASF842
	.byte	0x5
	.uleb128 0x5c
	.4byte	.LASF843
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF844
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.sysmacros.h.20.8a0c33ff175cd9b434a86c0aaa36f0a2,comdat
.Ldebug_macro52:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x14
	.4byte	.LASF845
	.byte	0x5
	.uleb128 0x3d
	.4byte	.LASF846
	.byte	0x5
	.uleb128 0x3e
	.4byte	.LASF847
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF848
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.types.h.229.67b3f66bd74b06b451caec392a72a945,comdat
.Ldebug_macro53:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0xe5
	.4byte	.LASF849
	.byte	0x5
	.uleb128 0xec
	.4byte	.LASF850
	.byte	0x5
	.uleb128 0xf0
	.4byte	.LASF851
	.byte	0x5
	.uleb128 0xf4
	.4byte	.LASF852
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.alloca.h.19.edefa922a76c1cbaaf1e416903ba2d1c,comdat
.Ldebug_macro54:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF854
	.byte	0x5
	.uleb128 0x17
	.4byte	.LASF416
	.byte	0
	.section	.debug_macro,"G",@progbits,wm4.alloca.h.29.156e12058824cc23d961c4d3b13031f6,comdat
.Ldebug_macro55:
	.2byte	0x4
	.byte	0
	.byte	0x6
	.uleb128 0x1d
	.4byte	.LASF855
	.byte	0x5
	.uleb128 0x23
	.4byte	.LASF856
	.byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF258:
	.string	"__linux__ 1"
.LASF852:
	.string	"__fsfilcnt_t_defined "
.LASF539:
	.string	"_IOS_NOREPLACE 64"
.LASF194:
	.string	"__DEC128_EPSILON__ 1E-33DL"
.LASF537:
	.string	"_IOS_TRUNC 16"
.LASF512:
	.string	"_G_BUFSIZ 8192"
.LASF52:
	.string	"__UINT32_TYPE__ unsigned int"
.LASF208:
	.string	"__GCC_ATOMIC_WCHAR_T_LOCK_FREE 2"
.LASF98:
	.string	"__UINT32_MAX__ 0xffffffffU"
.LASF199:
	.string	"__CHAR_UNSIGNED__ 1"
.LASF867:
	.string	"size_t"
.LASF61:
	.string	"__UINT_LEAST64_TYPE__ long unsigned int"
.LASF870:
	.string	"sizetype"
.LASF615:
	.string	"stdin stdin"
.LASF227:
	.string	"__ARM_ARCH_PROFILE 65"
.LASF609:
	.string	"L_tmpnam 20"
.LASF858:
	.string	"__need_malloc_and_calloc"
.LASF193:
	.string	"__DEC128_MAX__ 9.999999999999999999999999999999999E6144DL"
.LASF848:
	.string	"makedev(maj,min) gnu_dev_makedev (maj, min)"
.LASF239:
	.string	"__ARM_FEATURE_FMA 1"
.LASF20:
	.string	"__LP64__ 1"
.LASF245:
	.string	"__ARM_FEATURE_NUMERIC_MAXMIN 1"
.LASF596:
	.string	"_IO_cleanup_region_start(_fct,_fp) "
.LASF405:
	.string	"__stub_sigreturn "
.LASF286:
	.string	"__USE_XOPEN2K8XSI"
.LASF605:
	.string	"SEEK_SET 0"
.LASF225:
	.string	"__ARM_ALIGN_MAX_STACK_PWR 16"
.LASF16:
	.string	"__ATOMIC_CONSUME 1"
.LASF80:
	.string	"__WCHAR_MAX__ 0xffffffffU"
.LASF379:
	.string	"__LDBL_REDIR1(name,proto,alias) name proto"
.LASF702:
	.string	"__clockid_t_defined 1"
.LASF350:
	.string	"__flexarr []"
.LASF908:
	.string	"_IO_2_1_stderr_"
.LASF730:
	.string	"PTHREAD_SCOPE_SYSTEM PTHREAD_SCOPE_SYSTEM"
.LASF484:
	.string	"__BLKSIZE_T_TYPE __S32_TYPE"
.LASF319:
	.string	"__GNU_LIBRARY__"
.LASF121:
	.string	"__UINT_FAST16_MAX__ 0xffffffffffffffffUL"
.LASF151:
	.string	"__DBL_MAX_10_EXP__ 308"
.LASF223:
	.string	"__ARM_ARCH_ISA_A64 1"
.LASF530:
	.string	"_IO_va_list __gnuc_va_list"
.LASF517:
	.string	"_IO_off_t __off_t"
.LASF741:
	.string	"PTHREAD_BARRIER_SERIAL_THREAD -1"
.LASF358:
	.string	"__attribute_pure__ __attribute__ ((__pure__))"
.LASF883:
	.string	"_IO_save_end"
.LASF119:
	.string	"__INT_FAST64_MAX__ 0x7fffffffffffffffL"
.LASF569:
	.string	"_IO_HEX 0100"
.LASF33:
	.string	"__ORDER_PDP_ENDIAN__ 3412"
.LASF184:
	.string	"__DEC64_MAX_EXP__ 385"
.LASF160:
	.string	"__FP_FAST_FMA 1"
.LASF595:
	.string	"_IO_ftrylockfile(_fp) "
.LASF46:
	.string	"__INT8_TYPE__ signed char"
.LASF678:
	.string	"__CPU_COUNT_S(setsize,cpusetp) __sched_cpucount (setsize, cpusetp)"
.LASF474:
	.string	"__FSWORD_T_TYPE __SWORD_TYPE"
.LASF766:
	.string	"WSTOPPED 2"
.LASF2:
	.string	"__STDC_UTF_16__ 1"
.LASF37:
	.string	"__SIZE_TYPE__ long unsigned int"
.LASF109:
	.string	"__UINT8_C(c) c"
.LASF47:
	.string	"__INT16_TYPE__ short int"
.LASF259:
	.string	"linux 1"
.LASF57:
	.string	"__INT_LEAST64_TYPE__ long int"
.LASF546:
	.string	"_IO_NO_READS 4"
.LASF412:
	.string	"__ASSERT_FUNCTION __PRETTY_FUNCTION__"
.LASF738:
	.string	"PTHREAD_CANCEL_ASYNCHRONOUS PTHREAD_CANCEL_ASYNCHRONOUS"
.LASF876:
	.string	"_IO_write_base"
.LASF361:
	.string	"__attribute_noinline__ __attribute__ ((__noinline__))"
.LASF200:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1"
.LASF167:
	.string	"__DECIMAL_DIG__ 36"
.LASF813:
	.string	"__id_t_defined "
.LASF875:
	.string	"_IO_read_base"
.LASF4:
	.string	"__STDC_HOSTED__ 1"
.LASF493:
	.string	"__STD_TYPE"
.LASF824:
	.string	"__FD_ZERO(s) do { unsigned int __i; fd_set *__arr = (s); for (__i = 0; __i < sizeof (fd_set) / sizeof (__fd_mask); ++__i) __FDS_BITS (__arr)[__i] = 0; } while (0)"
.LASF602:
	.string	"_IOLBF 1"
.LASF85:
	.string	"__SIZE_MAX__ 0xffffffffffffffffUL"
.LASF927:
	.string	"state"
.LASF915:
	.string	"__daylight"
.LASF331:
	.string	"__P(args) args"
.LASF740:
	.string	"PTHREAD_ONCE_INIT 0"
.LASF822:
	.string	"__BIT_TYPES_DEFINED__ 1"
.LASF758:
	.string	"__INT_WCHAR_T_H "
.LASF892:
	.string	"_lock"
.LASF419:
	.string	"__SIZE_T__ "
.LASF23:
	.string	"__SIZEOF_LONG_LONG__ 8"
.LASF526:
	.string	"__need___va_list "
.LASF95:
	.string	"__INT64_MAX__ 0x7fffffffffffffffL"
.LASF464:
	.string	"__OFF64_T_TYPE __SQUAD_TYPE"
.LASF814:
	.string	"__daddr_t_defined "
.LASF594:
	.string	"_IO_funlockfile(_fp) "
.LASF762:
	.string	"__need_wchar_t"
.LASF705:
	.string	"_XLOCALE_H 1"
.LASF96:
	.string	"__UINT8_MAX__ 0xff"
.LASF932:
	.string	"pthread_create"
.LASF675:
	.string	"__CPU_SET_S(cpu,setsize,cpusetp) (__extension__ ({ size_t __cpu = (cpu); __cpu / 8 < (setsize) ? (((__cpu_mask *) ((cpusetp)->__bits))[__CPUELT (__cpu)] |= __CPUMASK (__cpu)) : 0; }))"
.LASF624:
	.string	"_PTHREAD_H 1"
.LASF590:
	.string	"_IO_ferror_unlocked(__fp) (((__fp)->_flags & _IO_ERR_SEEN) != 0)"
.LASF729:
	.string	"PTHREAD_EXPLICIT_SCHED PTHREAD_EXPLICIT_SCHED"
.LASF737:
	.string	"PTHREAD_CANCEL_DEFERRED PTHREAD_CANCEL_DEFERRED"
.LASF881:
	.string	"_IO_save_base"
.LASF797:
	.string	"WIFSTOPPED(status) __WIFSTOPPED (__WAIT_INT (status))"
.LASF536:
	.string	"_IOS_APPEND 8"
.LASF444:
	.string	"__SLONGWORD_TYPE long int"
.LASF434:
	.string	"__size_t "
.LASF451:
	.string	"__ULONG32_TYPE unsigned int"
.LASF323:
	.string	"__GLIBC_PREREQ(maj,min) ((__GLIBC__ << 16) + __GLIBC_MINOR__ >= ((maj) << 16) + (min))"
.LASF667:
	.string	"__defined_schedparam 1"
.LASF351:
	.string	"__REDIRECT(name,proto,alias) name proto __asm__ (__ASMNAME (#alias))"
.LASF423:
	.string	"_T_SIZE "
.LASF513:
	.string	"_IO_fpos_t _G_fpos_t"
.LASF32:
	.string	"__ORDER_BIG_ENDIAN__ 4321"
.LASF192:
	.string	"__DEC128_MIN__ 1E-6143DL"
.LASF593:
	.string	"_IO_flockfile(_fp) "
.LASF632:
	.string	"BIG_ENDIAN __BIG_ENDIAN"
.LASF885:
	.string	"_chain"
.LASF289:
	.string	"__USE_FILE_OFFSET64"
.LASF889:
	.string	"_cur_column"
.LASF912:
	.string	"sys_nerr"
.LASF276:
	.string	"__USE_POSIX"
.LASF180:
	.string	"__DEC32_EPSILON__ 1E-6DF"
.LASF436:
	.string	"NULL"
.LASF828:
	.string	"_SIGSET_H_types 1"
.LASF557:
	.string	"_IO_IS_FILEBUF 0x2000"
.LASF853:
	.string	"__malloc_and_calloc_defined "
.LASF395:
	.string	"__stub_fchflags "
.LASF251:
	.string	"__AARCH64_CMODEL_SMALL__ 1"
.LASF41:
	.string	"__INTMAX_TYPE__ long int"
.LASF473:
	.string	"__FSFILCNT64_T_TYPE __UQUAD_TYPE"
.LASF742:
	.string	"__cleanup_fct_attribute "
.LASF680:
	.ascii	"__CPU_OP_S(setsize,destset,srcset1,srcset2,op) (__extension_"
	.ascii	"_ ({ cpu_set_t *__dest = (destset); const __cp"
	.string	"u_mask *__arr1 = (srcset1)->__bits; const __cpu_mask *__arr2 = (srcset2)->__bits; size_t __imax = (setsize) / sizeof (__cpu_mask); size_t __i; for (__i = 0; __i < __imax; ++__i) ((__cpu_mask *) __dest->__bits)[__i] = __arr1[__i] op __arr2[__i]; __dest; }))"
.LASF786:
	.string	"w_coredump __wait_terminated.__w_coredump"
.LASF642:
	.string	"htole16(x) (x)"
.LASF297:
	.string	"__GNUC_PREREQ(maj,min) ((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))"
.LASF280:
	.string	"__USE_XOPEN"
.LASF120:
	.string	"__UINT_FAST8_MAX__ 0xff"
.LASF285:
	.string	"__USE_XOPEN2K8"
.LASF421:
	.string	"_SYS_SIZE_T_H "
.LASF58:
	.string	"__UINT_LEAST8_TYPE__ unsigned char"
.LASF321:
	.string	"__GLIBC__ 2"
.LASF866:
	.string	"long int"
.LASF644:
	.string	"le16toh(x) (x)"
.LASF718:
	.string	"__have_pthread_attr_t1 "
.LASF641:
	.string	"htobe16(x) __bswap_16 (x)"
.LASF923:
	.string	"N_THREADS"
.LASF830:
	.string	"__sigset_t_defined "
.LASF313:
	.string	"__USE_XOPEN2K8 1"
.LASF482:
	.string	"__CLOCKID_T_TYPE __S32_TYPE"
.LASF544:
	.string	"_IO_USER_BUF 1"
.LASF190:
	.string	"__DEC128_MIN_EXP__ (-6142)"
.LASF692:
	.string	"CLOCK_MONOTONIC_RAW 4"
.LASF655:
	.string	"__need_timespec "
.LASF418:
	.string	"__size_t__ "
.LASF69:
	.string	"__UINT_FAST64_TYPE__ long unsigned int"
.LASF841:
	.string	"FD_SET(fd,fdsetp) __FD_SET (fd, fdsetp)"
.LASF54:
	.string	"__INT_LEAST8_TYPE__ signed char"
.LASF36:
	.string	"__SIZEOF_POINTER__ 8"
.LASF204:
	.string	"__GCC_ATOMIC_BOOL_LOCK_FREE 2"
.LASF492:
	.string	"__FD_SETSIZE 1024"
.LASF902:
	.string	"_IO_marker"
.LASF628:
	.string	"__PDP_ENDIAN 3412"
.LASF651:
	.string	"be64toh(x) __bswap_64 (x)"
.LASF942:
	.string	"main"
.LASF821:
	.string	"__int8_t_defined "
.LASF614:
	.string	"FOPEN_MAX 16"
.LASF582:
	.string	"_IO_stdin ((_IO_FILE*)(&_IO_2_1_stdin_))"
.LASF68:
	.string	"__UINT_FAST32_TYPE__ long unsigned int"
.LASF171:
	.string	"__LDBL_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966L"
.LASF466:
	.string	"__RLIM_T_TYPE __ULONGWORD_TYPE"
.LASF471:
	.string	"__FSBLKCNT64_T_TYPE __UQUAD_TYPE"
.LASF430:
	.string	"_SIZE_T_DECLARED "
.LASF333:
	.string	"__CONCAT(x,y) x ## y"
.LASF778:
	.string	"__WIFSTOPPED(status) (((status) & 0xff) == 0x7f)"
.LASF708:
	.string	"__SIZEOF_PTHREAD_ATTR_T 64"
.LASF244:
	.string	"__ARM_FEATURE_FP16_VECTOR_ARITHMETIC"
.LASF123:
	.string	"__UINT_FAST64_MAX__ 0xffffffffffffffffUL"
.LASF135:
	.string	"__FLT_MAX_EXP__ 128"
.LASF470:
	.string	"__FSBLKCNT_T_TYPE __ULONGWORD_TYPE"
.LASF266:
	.string	"__STDC_IEC_559__ 1"
.LASF22:
	.string	"__SIZEOF_LONG__ 8"
.LASF725:
	.string	"PTHREAD_MUTEX_INITIALIZER { { 0, 0, 0, 0, 0, __PTHREAD_SPINS, { 0, 0 } } }"
.LASF606:
	.string	"SEEK_CUR 1"
.LASF381:
	.string	"__LDBL_REDIR1_NTH(name,proto,alias) name proto __THROW"
.LASF26:
	.string	"__SIZEOF_DOUBLE__ 8"
.LASF712:
	.string	"__SIZEOF_PTHREAD_COND_COMPAT_T 48"
.LASF589:
	.string	"_IO_feof_unlocked(__fp) (((__fp)->_flags & _IO_EOF_SEEN) != 0)"
.LASF410:
	.string	"__ASSERT_VOID_CAST (void)"
.LASF265:
	.string	"_STDC_PREDEF_H 1"
.LASF686:
	.string	"_BITS_TIME_H 1"
.LASF3:
	.string	"__STDC_UTF_32__ 1"
.LASF186:
	.string	"__DEC64_MAX__ 9.999999999999999E384DD"
.LASF352:
	.string	"__REDIRECT_NTH(name,proto,alias) name proto __asm__ (__ASMNAME (#alias)) __THROW"
.LASF503:
	.string	"__need_mbstate_t "
.LASF803:
	.string	"EXIT_SUCCESS 0"
.LASF134:
	.string	"__FLT_MIN_10_EXP__ (-37)"
.LASF934:
	.string	"__assert_fail"
.LASF836:
	.string	"__FD_ELT(d) ((d) / __NFDBITS)"
.LASF137:
	.string	"__FLT_DECIMAL_DIG__ 9"
.LASF622:
	.ascii	"fwrite_unlocked(ptr,size,n,stream) (__extension__ ((__builti"
	.ascii	"n_constant_p (size) && __builtin_constant_p (n) && (size_t) "
	.ascii	"(size) * (size_t) (n) <= 8 && (size_t) (size) != 0) ? ({ con"
	.ascii	"st char *__ptr = (const char *) (ptr); FILE *__stream = (str"
	.ascii	"eam); size_t __cnt; for (__cnt = (size_t) (size) * (size_t) "
	.ascii	"(n); __cnt > 0; --__cnt) if (_IO_putc_unlocked (*__ptr++, __"
	.ascii	"stream) == EOF) break; ((size_t) (size) * (size_t) (n) -"
	.string	" __cnt) / (size_t) (size); }) : (((__builtin_constant_p (size) && (size_t) (size) == 0) || (__builtin_constant_p (n) && (size_t) (n) == 0)) ? ((void) (ptr), (void) (stream), (void) (size), (void) (n), (size_t) 0) : fwrite_unlocked (ptr, size, n, stream))))"
.LASF864:
	.string	"signed char"
.LASF833:
	.string	"__suseconds_t_defined "
.LASF798:
	.string	"WIFCONTINUED(status) __WIFCONTINUED (__WAIT_INT (status))"
.LASF236:
	.string	"__AARCH64EB__"
.LASF441:
	.string	"__U16_TYPE unsigned short int"
.LASF901:
	.string	"_IO_FILE"
.LASF930:
	.string	"spin_lock"
.LASF916:
	.string	"__timezone"
.LASF242:
	.string	"__ARM_FP16_ARGS 1"
.LASF610:
	.string	"TMP_MAX 238328"
.LASF144:
	.string	"__FLT_HAS_QUIET_NAN__ 1"
.LASF487:
	.string	"__SYSCALL_SLONG_TYPE __SLONGWORD_TYPE"
.LASF264:
	.string	"SPINLOCK_IMPL_HEADER \"spinlock-cmpxchg.h\""
.LASF110:
	.string	"__UINT_LEAST16_MAX__ 0xffff"
.LASF819:
	.string	"__intN_t(N,MODE) typedef int int ##N ##_t __attribute__ ((__mode__ (MODE)))"
.LASF928:
	.string	"__PRETTY_FUNCTION__"
.LASF469:
	.string	"__BLKCNT64_T_TYPE __SQUAD_TYPE"
.LASF529:
	.string	"_IO_va_list"
.LASF578:
	.string	"_IO_DONT_CLOSE 0100000"
.LASF806:
	.string	"__u_char_defined "
.LASF107:
	.string	"__INT64_C(c) c ## L"
.LASF429:
	.string	"_BSD_SIZE_T_DEFINED_ "
.LASF431:
	.string	"___int_size_t_h "
.LASF568:
	.string	"_IO_OCT 040"
.LASF301:
	.string	"__USE_ISOC99 1"
.LASF136:
	.string	"__FLT_MAX_10_EXP__ 38"
.LASF332:
	.string	"__PMT(args) args"
.LASF191:
	.string	"__DEC128_MAX_EXP__ 6145"
.LASF552:
	.string	"_IO_IN_BACKUP 0x100"
.LASF839:
	.string	"FD_SETSIZE __FD_SETSIZE"
.LASF12:
	.string	"__ATOMIC_SEQ_CST 5"
.LASF706:
	.string	"__isleap(year) ((year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0))"
.LASF633:
	.string	"PDP_ENDIAN __PDP_ENDIAN"
.LASF462:
	.string	"__NLINK_T_TYPE __U32_TYPE"
.LASF506:
	.string	"__need_wint_t"
.LASF775:
	.string	"__WSTOPSIG(status) __WEXITSTATUS(status)"
.LASF842:
	.string	"FD_CLR(fd,fdsetp) __FD_CLR (fd, fdsetp)"
.LASF150:
	.string	"__DBL_MAX_EXP__ 1024"
.LASF113:
	.string	"__UINT32_C(c) c ## U"
.LASF8:
	.string	"__VERSION__ \"6.2.1 20161016\""
.LASF663:
	.string	"__pid_t_defined "
.LASF87:
	.string	"__INTMAX_C(c) c ## L"
.LASF165:
	.string	"__LDBL_MAX_EXP__ 16384"
.LASF24:
	.string	"__SIZEOF_SHORT__ 2"
.LASF914:
	.string	"__tzname"
.LASF659:
	.string	"__clockid_time_t"
.LASF941:
	.string	"_IO_FILE_plus"
.LASF369:
	.string	"__attribute_artificial__ __attribute__ ((__artificial__))"
.LASF387:
	.string	"__stub___compat_bdflush "
.LASF427:
	.string	"_SIZE_T_DEFINED_ "
.LASF938:
	.string	"spinlock-cmpxchg.c"
.LASF859:
	.string	"SPINLOCK_CMPXCHG_H "
.LASF89:
	.string	"__UINTMAX_C(c) c ## UL"
.LASF480:
	.string	"__DADDR_T_TYPE __S32_TYPE"
.LASF292:
	.string	"__USE_GNU"
.LASF509:
	.string	"_G_HAVE_MREMAP 1"
.LASF39:
	.string	"__WCHAR_TYPE__ unsigned int"
.LASF871:
	.string	"char"
.LASF249:
	.string	"__AARCH64_CMODEL_SMALL__"
.LASF201:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1"
.LASF268:
	.string	"__STDC_ISO_10646__ 201505L"
.LASF745:
	.string	"__need_wchar_t "
.LASF65:
	.string	"__INT_FAST64_TYPE__ long int"
.LASF679:
	.string	"__CPU_EQUAL_S(setsize,cpusetp1,cpusetp2) (__builtin_memcmp (cpusetp1, cpusetp2, setsize) == 0)"
.LASF21:
	.string	"__SIZEOF_INT__ 4"
.LASF416:
	.string	"__need_size_t "
.LASF295:
	.string	"__KERNEL_STRICT_NAMES"
.LASF30:
	.string	"__BIGGEST_ALIGNMENT__ 16"
.LASF372:
	.string	"__fortify_function __extern_always_inline __attribute_artificial__"
.LASF303:
	.string	"__USE_POSIX_IMPLICITLY 1"
.LASF548:
	.string	"_IO_EOF_SEEN 0x10"
.LASF260:
	.string	"__unix 1"
.LASF940:
	.string	"_IO_lock_t"
.LASF925:
	.string	"lock"
.LASF322:
	.string	"__GLIBC_MINOR__ 23"
.LASF283:
	.string	"__USE_XOPEN2K"
.LASF770:
	.string	"__WNOTHREAD 0x20000000"
.LASF284:
	.string	"__USE_XOPEN2KXSI"
.LASF563:
	.string	"_IO_SKIPWS 01"
.LASF572:
	.string	"_IO_UPPERCASE 01000"
.LASF140:
	.string	"__FLT_EPSILON__ 1.19209289550781250000000000000000000e-7F"
.LASF370:
	.string	"__extern_inline extern __inline __attribute__ ((__gnu_inline__))"
.LASF693:
	.string	"CLOCK_REALTIME_COARSE 5"
.LASF157:
	.string	"__DBL_HAS_DENORM__ 1"
.LASF604:
	.string	"BUFSIZ _IO_BUFSIZ"
.LASF919:
	.string	"timezone"
.LASF672:
	.string	"__CPUELT(cpu) ((cpu) / __NCPUBITS)"
.LASF561:
	.string	"_IO_FLAGS2_NOTCANCEL 2"
.LASF74:
	.string	"__GXX_ABI_VERSION 1010"
.LASF102:
	.string	"__INT_LEAST16_MAX__ 0x7fff"
.LASF873:
	.string	"_IO_read_ptr"
.LASF278:
	.string	"__USE_POSIX199309"
.LASF73:
	.string	"__has_include_next(STR) __has_include_next__(STR)"
.LASF701:
	.string	"__clock_t_defined 1"
.LASF496:
	.string	"__FILE_defined 1"
.LASF807:
	.string	"__ino_t_defined "
.LASF905:
	.string	"_pos"
.LASF909:
	.string	"stdin"
.LASF754:
	.string	"_WCHAR_T_DEFINED_ "
.LASF282:
	.string	"__USE_UNIX98"
.LASF62:
	.string	"__INT_FAST8_TYPE__ signed char"
.LASF296:
	.string	"__KERNEL_STRICT_NAMES "
.LASF838:
	.string	"__FDS_BITS(set) ((set)->__fds_bits)"
.LASF913:
	.string	"sys_errlist"
.LASF458:
	.string	"__GID_T_TYPE __U32_TYPE"
.LASF559:
	.string	"_IO_USER_LOCK 0x8000"
.LASF209:
	.string	"__GCC_ATOMIC_SHORT_LOCK_FREE 2"
.LASF653:
	.string	"_SCHED_H 1"
.LASF743:
	.ascii	"pthread_cleanup_push(routine,arg) do { __pthread_unwind_buf_"
	.ascii	"t __cancel_buf; void (*__cancel_routine) (void *) = (routine"
	.ascii	"); void *__cancel_arg = (arg); int __not_fir"
	.string	"st_call = __sigsetjmp ((struct __jmp_buf_tag *) (void *) __cancel_buf.__cancel_jmp_buf, 0); if (__glibc_unlikely (__not_first_call)) { __cancel_routine (__cancel_arg); __pthread_unwind_next (&__cancel_buf); } __pthread_register_cancel (&__cancel_buf); do {"
.LASF445:
	.string	"__ULONGWORD_TYPE unsigned long int"
.LASF213:
	.string	"__GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1"
.LASF884:
	.string	"_markers"
.LASF263:
	.string	"__ELF__ 1"
.LASF598:
	.string	"_VA_LIST_DEFINED "
.LASF670:
	.string	"__CPU_SETSIZE 1024"
.LASF549:
	.string	"_IO_ERR_SEEN 0x20"
.LASF623:
	.string	"__STDIO_INLINE"
.LASF654:
	.string	"__need_time_t "
.LASF611:
	.string	"FILENAME_MAX 4096"
.LASF173:
	.string	"__LDBL_HAS_INFINITY__ 1"
.LASF404:
	.string	"__stub_setlogin "
.LASF179:
	.string	"__DEC32_MAX__ 9.999999E96DF"
.LASF491:
	.string	"__INO_T_MATCHES_INO64_T 1"
.LASF510:
	.string	"_G_IO_IO_FILE_VERSION 0x20001"
.LASF528:
	.string	"__GNUC_VA_LIST "
.LASF685:
	.string	"_TIME_H 1"
.LASF787:
	.string	"w_retcode __wait_terminated.__w_retcode"
.LASF91:
	.string	"__SIG_ATOMIC_MIN__ (-__SIG_ATOMIC_MAX__ - 1)"
.LASF108:
	.string	"__UINT_LEAST8_MAX__ 0xff"
.LASF753:
	.string	"_BSD_WCHAR_T_ "
.LASF518:
	.string	"_IO_off64_t __off64_t"
.LASF801:
	.string	"RAND_MAX 2147483647"
.LASF145:
	.string	"__FP_FAST_FMAF 1"
.LASF216:
	.string	"__PRAGMA_REDEFINE_EXTNAME 1"
.LASF704:
	.string	"TIME_UTC 1"
.LASF153:
	.string	"__DBL_MAX__ ((double)1.79769313486231570814527423731704357e+308L)"
.LASF500:
	.string	"_STDIO_USES_IOSTREAM "
.LASF924:
	.string	"algo_state"
.LASF495:
	.string	"__need___FILE "
.LASF523:
	.string	"_IO_BUFSIZ _G_BUFSIZ"
.LASF504:
	.string	"____mbstate_t_defined 1"
.LASF449:
	.string	"__UWORD_TYPE unsigned long int"
.LASF129:
	.string	"__DEC_EVAL_METHOD__ 2"
.LASF388:
	.string	"__stub___compat_create_module "
.LASF645:
	.string	"htobe32(x) __bswap_32 (x)"
.LASF640:
	.ascii	"__bswap_constant_64(x) (__extension__ ((((x) & 0xff000000000"
	.ascii	"00000ull) >> 56) | (((x) & 0x00ff0000000"
	.string	"00000ull) >> 40) | (((x) & 0x0000ff0000000000ull) >> 24) | (((x) & 0x000000ff00000000ull) >> 8) | (((x) & 0x00000000ff000000ull) << 8) | (((x) & 0x0000000000ff0000ull) << 24) | (((x) & 0x000000000000ff00ull) << 40) | (((x) & 0x00000000000000ffull) << 56)))"
.LASF188:
	.string	"__DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD"
.LASF437:
	.string	"NULL ((void *)0)"
.LASF783:
	.string	"__W_CONTINUED 0xffff"
.LASF397:
	.string	"__stub_getmsg "
.LASF893:
	.string	"_offset"
.LASF917:
	.string	"tzname"
.LASF197:
	.string	"__USER_LABEL_PREFIX__ "
.LASF494:
	.string	"__need_FILE "
.LASF314:
	.string	"_ATFILE_SOURCE"
.LASF1:
	.string	"__STDC_VERSION__ 201112L"
.LASF520:
	.string	"_IO_uid_t __uid_t"
.LASF643:
	.string	"be16toh(x) __bswap_16 (x)"
.LASF100:
	.string	"__INT_LEAST8_MAX__ 0x7f"
.LASF564:
	.string	"_IO_LEFT 02"
.LASF214:
	.string	"__GCC_ATOMIC_POINTER_LOCK_FREE 2"
.LASF228:
	.string	"__ARM_FEATURE_CLZ 1"
.LASF13:
	.string	"__ATOMIC_ACQUIRE 2"
.LASF710:
	.string	"__SIZEOF_PTHREAD_MUTEXATTR_T 8"
.LASF237:
	.string	"__ARM_BIG_ENDIAN"
.LASF547:
	.string	"_IO_NO_WRITES 8"
.LASF587:
	.string	"_IO_peekc_unlocked(_fp) (_IO_BE ((_fp)->_IO_read_ptr >= (_fp)->_IO_read_end, 0) && __underflow (_fp) == EOF ? EOF : *(unsigned char *) (_fp)->_IO_read_ptr)"
.LASF834:
	.string	"__NFDBITS"
.LASF232:
	.string	"__ARM_SIZEOF_WCHAR_T 4"
.LASF800:
	.string	"__lldiv_t_defined 1"
.LASF72:
	.string	"__has_include(STR) __has_include__(STR)"
.LASF840:
	.string	"NFDBITS __NFDBITS"
.LASF937:
	.string	"GNU C11 6.2.1 20161016 -march=armv8-a -mlittle-endian -mabi=lp64 -g3 -O3"
.LASF502:
	.string	"_G_config_h 1"
.LASF565:
	.string	"_IO_RIGHT 04"
.LASF843:
	.string	"FD_ISSET(fd,fdsetp) __FD_ISSET (fd, fdsetp)"
.LASF744:
	.string	"pthread_cleanup_pop(execute) do { } while (0); } while (0); __pthread_unregister_cancel (&__cancel_buf); if (execute) __cancel_routine (__cancel_arg); } while (0)"
.LASF143:
	.string	"__FLT_HAS_INFINITY__ 1"
.LASF765:
	.string	"WUNTRACED 2"
.LASF267:
	.string	"__STDC_IEC_559_COMPLEX__ 1"
.LASF535:
	.string	"_IOS_ATEND 4"
.LASF92:
	.string	"__INT8_MAX__ 0x7f"
.LASF215:
	.string	"__GCC_HAVE_DWARF2_CFI_ASM 1"
.LASF247:
	.string	"__ARM_FEATURE_CRC32"
.LASF638:
	.string	"__bswap_16(x) (__extension__ ({ unsigned short int __bsx = (unsigned short int) (x); __bswap_constant_16 (__bsx); }))"
.LASF439:
	.string	"_BITS_TYPES_H 1"
.LASF637:
	.string	"__bswap_constant_16(x) ((unsigned short int)((((x) >> 8) & 0xffu) | (((x) & 0xffu) << 8)))"
.LASF697:
	.string	"CLOCK_BOOTTIME_ALARM 9"
.LASF5:
	.string	"__GNUC__ 6"
.LASF51:
	.string	"__UINT16_TYPE__ short unsigned int"
.LASF304:
	.string	"_POSIX_SOURCE"
.LASF389:
	.string	"__stub___compat_get_kernel_syms "
.LASF920:
	.string	"pthread_t"
.LASF403:
	.string	"__stub_revoke "
.LASF177:
	.string	"__DEC32_MAX_EXP__ 97"
.LASF422:
	.string	"_T_SIZE_ "
.LASF639:
	.string	"__bswap_constant_32(x) ((((x) & 0xff000000u) >> 24) | (((x) & 0x00ff0000u) >> 8) | (((x) & 0x0000ff00u) << 8) | (((x) & 0x000000ffu) << 24))"
.LASF221:
	.string	"__aarch64__ 1"
.LASF170:
	.string	"__LDBL_EPSILON__ 1.92592994438723585305597794258492732e-34L"
.LASF707:
	.string	"_BITS_PTHREADTYPES_H 1"
.LASF519:
	.string	"_IO_pid_t __pid_t"
.LASF507:
	.string	"_G_va_list __gnuc_va_list"
.LASF341:
	.string	"__USING_NAMESPACE_STD(name) "
.LASF375:
	.string	"__restrict_arr __restrict"
.LASF736:
	.string	"PTHREAD_CANCEL_DISABLE PTHREAD_CANCEL_DISABLE"
.LASF19:
	.string	"_LP64 1"
.LASF817:
	.string	"__need_timer_t "
.LASF45:
	.string	"__SIG_ATOMIC_TYPE__ int"
.LASF328:
	.string	"__THROW __attribute__ ((__nothrow__ __LEAF))"
.LASF417:
	.string	"__need_NULL "
.LASF271:
	.string	"_FEATURES_H 1"
.LASF299:
	.string	"_DEFAULT_SOURCE 1"
.LASF900:
	.string	"_unused2"
.LASF767:
	.string	"WEXITED 4"
.LASF931:
	.string	"expected"
.LASF326:
	.string	"__LEAF , __leaf__"
.LASF360:
	.string	"__attribute_used__ __attribute__ ((__used__))"
.LASF648:
	.string	"le32toh(x) (x)"
.LASF231:
	.string	"__ARM_PCS_AAPCS64 1"
.LASF696:
	.string	"CLOCK_REALTIME_ALARM 8"
.LASF206:
	.string	"__GCC_ATOMIC_CHAR16_T_LOCK_FREE 2"
.LASF805:
	.string	"_SYS_TYPES_H 1"
.LASF455:
	.string	"_BITS_TYPESIZES_H 1"
.LASF14:
	.string	"__ATOMIC_RELEASE 3"
.LASF691:
	.string	"CLOCK_THREAD_CPUTIME_ID 3"
.LASF131:
	.string	"__FLT_MANT_DIG__ 24"
.LASF305:
	.string	"_POSIX_SOURCE 1"
.LASF649:
	.string	"htobe64(x) __bswap_64 (x)"
.LASF816:
	.string	"__need_clock_t "
.LASF573:
	.string	"_IO_SHOWPOS 02000"
.LASF17:
	.string	"__OPTIMIZE__ 1"
.LASF580:
	.string	"_IO_file_flags _flags"
.LASF577:
	.string	"_IO_STDIO 040000"
.LASF86:
	.string	"__INTMAX_MAX__ 0x7fffffffffffffffL"
.LASF728:
	.string	"PTHREAD_INHERIT_SCHED PTHREAD_INHERIT_SCHED"
.LASF396:
	.string	"__stub_fdetach "
.LASF525:
	.string	"_IO_wint_t wint_t"
.LASF618:
	.string	"getc(_fp) _IO_getc (_fp)"
.LASF888:
	.string	"_old_offset"
.LASF665:
	.string	"SCHED_FIFO 1"
.LASF291:
	.string	"__USE_ATFILE"
.LASF88:
	.string	"__UINTMAX_MAX__ 0xffffffffffffffffUL"
.LASF689:
	.string	"CLOCK_MONOTONIC 1"
.LASF515:
	.string	"_IO_size_t size_t"
.LASF203:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1"
.LASF490:
	.string	"__OFF_T_MATCHES_OFF64_T 1"
.LASF823:
	.string	"_SYS_SELECT_H 1"
.LASF749:
	.string	"_T_WCHAR_ "
.LASF104:
	.string	"__INT_LEAST32_MAX__ 0x7fffffff"
.LASF527:
	.string	"__need___va_list"
.LASF81:
	.string	"__WCHAR_MIN__ 0U"
.LASF699:
	.string	"TIMER_ABSTIME 1"
.LASF277:
	.string	"__USE_POSIX2"
.LASF142:
	.string	"__FLT_HAS_DENORM__ 1"
.LASF211:
	.string	"__GCC_ATOMIC_LONG_LOCK_FREE 2"
.LASF717:
	.string	"__SIZEOF_PTHREAD_BARRIERATTR_T 8"
.LASF435:
	.string	"__need_size_t"
.LASF788:
	.string	"w_stopsig __wait_stopped.__w_stopsig"
.LASF234:
	.string	"__ARM_ARCH 8"
.LASF425:
	.string	"_SIZE_T_ "
.LASF601:
	.string	"_IOFBF 0"
.LASF553:
	.string	"_IO_LINE_BUF 0x200"
.LASF815:
	.string	"__key_t_defined "
.LASF922:
	.string	"long long int"
.LASF735:
	.string	"PTHREAD_CANCEL_ENABLE PTHREAD_CANCEL_ENABLE"
.LASF252:
	.string	"_ILP32"
.LASF44:
	.string	"__CHAR32_TYPE__ unsigned int"
.LASF746:
	.string	"__wchar_t__ "
.LASF721:
	.string	"__PTHREAD_RWLOCK_ELISION_EXTRA 0"
.LASF174:
	.string	"__LDBL_HAS_QUIET_NAN__ 1"
.LASF438:
	.string	"__need_NULL"
.LASF10:
	.string	"__LINARO_SPIN__ 0"
.LASF608:
	.string	"P_tmpdir \"/tmp\""
.LASF764:
	.string	"WNOHANG 1"
.LASF246:
	.string	"__ARM_NEON 1"
.LASF212:
	.string	"__GCC_ATOMIC_LLONG_LOCK_FREE 2"
.LASF562:
	.string	"_IO_FLAGS2_USER_WBUF 8"
.LASF365:
	.string	"__nonnull(params) __attribute__ ((__nonnull__ params))"
.LASF661:
	.string	"__timespec_defined 1"
.LASF751:
	.string	"__WCHAR_T "
.LASF118:
	.string	"__INT_FAST32_MAX__ 0x7fffffffffffffffL"
.LASF832:
	.string	"_STRUCT_TIMEVAL 1"
.LASF168:
	.string	"__LDBL_MAX__ 1.18973149535723176508575932662800702e+4932L"
.LASF42:
	.string	"__UINTMAX_TYPE__ long unsigned int"
.LASF133:
	.string	"__FLT_MIN_EXP__ (-125)"
.LASF878:
	.string	"_IO_write_end"
.LASF660:
	.string	"__need_timer_t"
.LASF363:
	.string	"__attribute_format_arg__(x) __attribute__ ((__format_arg__ (x)))"
.LASF218:
	.string	"__SIZEOF_WCHAR_T__ 4"
.LASF116:
	.string	"__INT_FAST8_MAX__ 0x7f"
.LASF739:
	.string	"PTHREAD_CANCELED ((void *) -1)"
.LASF631:
	.string	"LITTLE_ENDIAN __LITTLE_ENDIAN"
.LASF325:
	.string	"__PMT"
.LASF130:
	.string	"__FLT_RADIX__ 2"
.LASF556:
	.string	"_IO_IS_APPENDING 0x1000"
.LASF789:
	.string	"w_stopval __wait_stopped.__w_stopval"
.LASF719:
	.string	"__PTHREAD_MUTEX_HAVE_PREV 1"
.LASF472:
	.string	"__FSFILCNT_T_TYPE __ULONGWORD_TYPE"
.LASF311:
	.string	"__USE_POSIX199506 1"
.LASF122:
	.string	"__UINT_FAST32_MAX__ 0xffffffffffffffffUL"
.LASF400:
	.string	"__stub_lchmod "
.LASF475:
	.string	"__ID_T_TYPE __U32_TYPE"
.LASF315:
	.string	"_ATFILE_SOURCE 1"
.LASF446:
	.string	"__SQUAD_TYPE long int"
.LASF612:
	.string	"L_ctermid 9"
.LASF34:
	.string	"__BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__"
.LASF105:
	.string	"__INT32_C(c) c"
.LASF538:
	.string	"_IOS_NOCREATE 32"
.LASF71:
	.string	"__UINTPTR_TYPE__ long unsigned int"
.LASF804:
	.string	"MB_CUR_MAX (__ctype_get_mb_cur_max ())"
.LASF248:
	.string	"__AARCH64_CMODEL_TINY__"
.LASF532:
	.string	"EOF (-1)"
.LASF335:
	.string	"__ptr_t void *"
.LASF40:
	.string	"__WINT_TYPE__ unsigned int"
.LASF620:
	.string	"__STDIO_INLINE __extern_inline"
.LASF727:
	.string	"PTHREAD_RWLOCK_INITIALIZER { { 0, 0, 0, 0, 0, 0, 0, 0, __PTHREAD_RWLOCK_ELISION_EXTRA, 0, 0 } }"
.LASF879:
	.string	"_IO_buf_base"
.LASF207:
	.string	"__GCC_ATOMIC_CHAR32_T_LOCK_FREE 2"
.LASF887:
	.string	"_flags2"
.LASF541:
	.string	"_IO_MAGIC 0xFBAD0000"
.LASF780:
	.string	"__WCOREDUMP(status) ((status) & __WCOREFLAG)"
.LASF60:
	.string	"__UINT_LEAST32_TYPE__ unsigned int"
.LASF863:
	.string	"unsigned int"
.LASF722:
	.string	"_BITS_SETJMP_H 1"
.LASF64:
	.string	"__INT_FAST32_TYPE__ long int"
.LASF401:
	.string	"__stub_putmsg "
.LASF433:
	.string	"_SIZET_ "
.LASF478:
	.string	"__USECONDS_T_TYPE __U32_TYPE"
.LASF674:
	.string	"__CPU_ZERO_S(setsize,cpusetp) do __builtin_memset (cpusetp, '\\0', setsize); while (0)"
.LASF453:
	.string	"__U64_TYPE unsigned long int"
.LASF287:
	.string	"__USE_LARGEFILE"
.LASF132:
	.string	"__FLT_DIG__ 6"
.LASF760:
	.string	"_WCHAR_T_DECLARED "
.LASF29:
	.string	"__CHAR_BIT__ 8"
.LASF312:
	.string	"__USE_XOPEN2K 1"
.LASF128:
	.string	"__FLT_EVAL_METHOD__ 0"
.LASF619:
	.string	"putc(_ch,_fp) _IO_putc (_ch, _fp)"
.LASF481:
	.string	"__KEY_T_TYPE __S32_TYPE"
.LASF138:
	.string	"__FLT_MAX__ 3.40282346638528859811704183484516925e+38F"
.LASF75:
	.string	"__SCHAR_MAX__ 0x7f"
.LASF895:
	.string	"__pad2"
.LASF896:
	.string	"__pad3"
.LASF588:
	.string	"_IO_putc_unlocked(_ch,_fp) (_IO_BE ((_fp)->_IO_write_ptr >= (_fp)->_IO_write_end, 0) ? __overflow (_fp, (unsigned char) (_ch)) : (unsigned char) (*(_fp)->_IO_write_ptr++ = (_ch)))"
.LASF898:
	.string	"__pad5"
.LASF443:
	.string	"__U32_TYPE unsigned int"
.LASF904:
	.string	"_sbuf"
.LASF357:
	.string	"__attribute_alloc_size__(params) __attribute__ ((__alloc_size__ params))"
.LASF183:
	.string	"__DEC64_MIN_EXP__ (-382)"
.LASF126:
	.string	"__GCC_IEC_559 2"
.LASF585:
	.string	"_IO_BE(expr,res) __builtin_expect ((expr), res)"
.LASF855:
	.string	"alloca"
.LASF377:
	.string	"__glibc_likely(cond) __builtin_expect ((cond), 1)"
.LASF399:
	.string	"__stub_gtty "
.LASF0:
	.string	"__STDC__ 1"
.LASF220:
	.string	"__SIZEOF_PTRDIFF_T__ 8"
.LASF229:
	.string	"__ARM_FEATURE_IDIV 1"
.LASF35:
	.string	"__FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__"
.LASF669:
	.string	"__cpu_set_t_defined "
.LASF50:
	.string	"__UINT8_TYPE__ unsigned char"
.LASF488:
	.string	"__SYSCALL_ULONG_TYPE __ULONGWORD_TYPE"
.LASF367:
	.string	"__wur "
.LASF413:
	.string	"static_assert"
.LASF414:
	.string	"static_assert _Static_assert"
.LASF700:
	.string	"__need_timeval"
.LASF827:
	.string	"__FD_ISSET(d,s) ((__FDS_BITS (s)[__FD_ELT (d)] & __FD_MASK (d)) != 0)"
.LASF189:
	.string	"__DEC128_MANT_DIG__ 34"
.LASF872:
	.string	"_flags"
.LASF724:
	.string	"PTHREAD_CREATE_DETACHED PTHREAD_CREATE_DETACHED"
.LASF811:
	.string	"__nlink_t_defined "
.LASF617:
	.string	"stderr stderr"
.LASF320:
	.string	"__GNU_LIBRARY__ 6"
.LASF457:
	.string	"__UID_T_TYPE __U32_TYPE"
.LASF205:
	.string	"__GCC_ATOMIC_CHAR_LOCK_FREE 2"
.LASF899:
	.string	"_mode"
.LASF465:
	.string	"__PID_T_TYPE __S32_TYPE"
.LASF774:
	.string	"__WTERMSIG(status) ((status) & 0x7f)"
.LASF329:
	.string	"__THROWNL __attribute__ ((__nothrow__))"
.LASF380:
	.string	"__LDBL_REDIR(name,proto) name proto"
.LASF94:
	.string	"__INT32_MAX__ 0x7fffffff"
.LASF773:
	.string	"__WEXITSTATUS(status) (((status) & 0xff00) >> 8)"
.LASF334:
	.string	"__STRING(x) #x"
.LASF861:
	.string	"unsigned char"
.LASF235:
	.string	"__ARM_SIZEOF_MINIMAL_ENUM 4"
.LASF826:
	.string	"__FD_CLR(d,s) ((void) (__FDS_BITS (s)[__FD_ELT(d)] &= ~__FD_MASK(d)))"
.LASF626:
	.string	"__LITTLE_ENDIAN 1234"
.LASF676:
	.string	"__CPU_CLR_S(cpu,setsize,cpusetp) (__extension__ ({ size_t __cpu = (cpu); __cpu / 8 < (setsize) ? (((__cpu_mask *) ((cpusetp)->__bits))[__CPUELT (__cpu)] &= ~__CPUMASK (__cpu)) : 0; }))"
.LASF748:
	.string	"_WCHAR_T "
.LASF141:
	.string	"__FLT_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F"
.LASF175:
	.string	"__DEC32_MANT_DIG__ 7"
.LASF734:
	.string	"PTHREAD_COND_INITIALIZER { { 0, 0, 0, 0, 0, (void *) 0, 0, 0 } }"
.LASF652:
	.string	"le64toh(x) (x)"
.LASF392:
	.string	"__stub___kernel_rem_pio2l "
.LASF339:
	.string	"__BEGIN_NAMESPACE_STD "
.LASF161:
	.string	"__LDBL_MANT_DIG__ 113"
.LASF668:
	.string	"__need_schedparam"
.LASF270:
	.string	"_ASSERT_H 1"
.LASF383:
	.string	"__LDBL_REDIR_DECL(name) "
.LASF716:
	.string	"__SIZEOF_PTHREAD_BARRIER_T 32"
.LASF330:
	.string	"__NTH(fct) __attribute__ ((__nothrow__ __LEAF)) fct"
.LASF385:
	.string	"__REDIRECT_NTH_LDBL(name,proto,alias) __REDIRECT_NTH (name, proto, alias)"
.LASF420:
	.string	"_SIZE_T "
.LASF756:
	.string	"_WCHAR_T_H "
.LASF255:
	.string	"__ARM_FEATURE_QRDMX"
.LASF846:
	.string	"major(dev) gnu_dev_major (dev)"
.LASF726:
	.string	"__PTHREAD_RWLOCK_INT_FLAGS_SHARED 1"
.LASF498:
	.string	"____FILE_defined 1"
.LASF79:
	.string	"__LONG_LONG_MAX__ 0x7fffffffffffffffLL"
.LASF354:
	.string	"__ASMNAME(cname) __ASMNAME2 (__USER_LABEL_PREFIX__, cname)"
.LASF650:
	.string	"htole64(x) (x)"
.LASF545:
	.string	"_IO_UNBUFFERED 2"
.LASF521:
	.string	"_IO_iconv_t _G_iconv_t"
.LASF522:
	.string	"_IO_HAVE_ST_BLKSIZE _G_HAVE_ST_BLKSIZE"
.LASF720:
	.string	"__PTHREAD_SPINS 0"
.LASF390:
	.string	"__stub___compat_query_module "
.LASF166:
	.string	"__LDBL_MAX_10_EXP__ 4932"
.LASF101:
	.string	"__INT8_C(c) c"
.LASF531:
	.string	"_IO_UNIFIED_JUMPTABLES 1"
.LASF148:
	.string	"__DBL_MIN_EXP__ (-1021)"
.LASF424:
	.string	"__SIZE_T "
.LASF625:
	.string	"_ENDIAN_H 1"
.LASF48:
	.string	"__INT32_TYPE__ int"
.LASF182:
	.string	"__DEC64_MANT_DIG__ 16"
.LASF943:
	.string	"thread_func"
.LASF274:
	.string	"__USE_ISOC95"
.LASF566:
	.string	"_IO_INTERNAL 010"
.LASF273:
	.string	"__USE_ISOC99"
.LASF344:
	.string	"__USING_NAMESPACE_C99(name) "
.LASF281:
	.string	"__USE_XOPEN_EXTENDED"
.LASF555:
	.string	"_IO_CURRENTLY_PUTTING 0x800"
.LASF172:
	.string	"__LDBL_HAS_DENORM__ 1"
.LASF368:
	.string	"__always_inline __inline __attribute__ ((__always_inline__))"
.LASF202:
	.string	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1"
.LASF337:
	.string	"__BEGIN_DECLS "
.LASF658:
	.string	"__need_time_t"
.LASF254:
	.string	"__ARM_FEATURE_CRYPTO"
.LASF415:
	.string	"_STDIO_H 1"
.LASF683:
	.string	"__CPU_FREE(cpuset) __sched_cpufree (cpuset)"
.LASF768:
	.string	"WCONTINUED 8"
.LASF793:
	.string	"WTERMSIG(status) __WTERMSIG (__WAIT_INT (status))"
.LASF713:
	.string	"__SIZEOF_PTHREAD_CONDATTR_T 8"
.LASF829:
	.string	"_SIGSET_NWORDS (1024 / (8 * sizeof (unsigned long int)))"
.LASF49:
	.string	"__INT64_TYPE__ long int"
.LASF31:
	.string	"__ORDER_LITTLE_ENDIAN__ 1234"
.LASF411:
	.string	"assert(expr) ((expr) ? __ASSERT_VOID_CAST (0) : __assert_fail (#expr, __FILE__, __LINE__, __ASSERT_FUNCTION))"
.LASF921:
	.string	"long long unsigned int"
.LASF516:
	.string	"_IO_ssize_t __ssize_t"
.LASF784:
	.string	"__WCOREFLAG 0x80"
.LASF76:
	.string	"__SHRT_MAX__ 0x7fff"
.LASF489:
	.string	"__CPU_MASK_TYPE __ULONGWORD_TYPE"
.LASF275:
	.string	"__USE_ISOCXX11"
.LASF428:
	.string	"_SIZE_T_DEFINED "
.LASF82:
	.string	"__WINT_MAX__ 0xffffffffU"
.LASF874:
	.string	"_IO_read_end"
.LASF600:
	.string	"__ssize_t_defined "
.LASF845:
	.string	"_SYS_SYSMACROS_H 1"
.LASF195:
	.string	"__DEC128_SUBNORMAL_MIN__ 0.000000000000000000000000000000001E-6143DL"
.LASF868:
	.string	"__off_t"
.LASF70:
	.string	"__INTPTR_TYPE__ long int"
.LASF860:
	.string	"long unsigned int"
.LASF825:
	.string	"__FD_SET(d,s) ((void) (__FDS_BITS (s)[__FD_ELT(d)] |= __FD_MASK(d)))"
.LASF703:
	.string	"__timer_t_defined 1"
.LASF307:
	.string	"_POSIX_C_SOURCE 200809L"
.LASF505:
	.string	"__need_mbstate_t"
.LASF733:
	.string	"PTHREAD_PROCESS_SHARED PTHREAD_PROCESS_SHARED"
.LASF59:
	.string	"__UINT_LEAST16_TYPE__ short unsigned int"
.LASF779:
	.string	"__WIFCONTINUED(status) ((status) == __W_CONTINUED)"
.LASF808:
	.string	"__dev_t_defined "
.LASF43:
	.string	"__CHAR16_TYPE__ short unsigned int"
.LASF592:
	.string	"_IO_peekc(_fp) _IO_peekc_unlocked (_fp)"
.LASF646:
	.string	"htole32(x) (x)"
.LASF279:
	.string	"__USE_POSIX199506"
.LASF627:
	.string	"__BIG_ENDIAN 4321"
.LASF124:
	.string	"__INTPTR_MAX__ 0x7fffffffffffffffL"
.LASF18:
	.string	"__FINITE_MATH_ONLY__ 0"
.LASF607:
	.string	"SEEK_END 2"
.LASF763:
	.string	"_STDLIB_H 1"
.LASF514:
	.string	"_IO_fpos64_t _G_fpos64_t"
.LASF550:
	.string	"_IO_DELETE_DONT_CLOSE 0x40"
.LASF378:
	.string	"__WORDSIZE 64"
.LASF348:
	.string	"__warnattr(msg) __attribute__((__warning__ (msg)))"
.LASF597:
	.string	"_IO_cleanup_region_end(_Doit) "
.LASF755:
	.string	"_WCHAR_T_DEFINED "
.LASF226:
	.string	"__ARM_ARCH_8A 1"
.LASF217:
	.string	"__SIZEOF_INT128__ 16"
.LASF407:
	.string	"__stub_stty "
.LASF402:
	.string	"__stub_putpmsg "
.LASF38:
	.string	"__PTRDIFF_TYPE__ long int"
.LASF723:
	.string	"PTHREAD_CREATE_JOINABLE PTHREAD_CREATE_JOINABLE"
.LASF869:
	.string	"__off64_t"
.LASF181:
	.string	"__DEC32_SUBNORMAL_MIN__ 0.000001E-95DF"
.LASF256:
	.string	"__gnu_linux__ 1"
.LASF771:
	.string	"__WALL 0x40000000"
.LASF106:
	.string	"__INT_LEAST64_MAX__ 0x7fffffffffffffffL"
.LASF452:
	.string	"__S64_TYPE long int"
.LASF426:
	.string	"_BSD_SIZE_T_ "
.LASF346:
	.string	"__bos0(ptr) __builtin_object_size (ptr, 0)"
.LASF534:
	.string	"_IOS_OUTPUT 2"
.LASF752:
	.string	"_WCHAR_T_ "
.LASF560:
	.string	"_IO_FLAGS2_MMAP 1"
.LASF579:
	.string	"_IO_BOOLALPHA 0200000"
.LASF750:
	.string	"_T_WCHAR "
.LASF342:
	.string	"__BEGIN_NAMESPACE_C99 "
.LASF442:
	.string	"__S32_TYPE int"
.LASF796:
	.string	"WIFSIGNALED(status) __WIFSIGNALED (__WAIT_INT (status))"
.LASF732:
	.string	"PTHREAD_PROCESS_PRIVATE PTHREAD_PROCESS_PRIVATE"
.LASF240:
	.string	"__ARM_FP 14"
.LASF906:
	.string	"_IO_2_1_stdin_"
.LASF882:
	.string	"_IO_backup_base"
.LASF891:
	.string	"_shortbuf"
.LASF575:
	.string	"_IO_FIXED 010000"
.LASF115:
	.string	"__UINT64_C(c) c ## UL"
.LASF459:
	.string	"__INO_T_TYPE __ULONGWORD_TYPE"
.LASF687:
	.string	"CLOCKS_PER_SEC ((clock_t) 1000000)"
.LASF907:
	.string	"_IO_2_1_stdout_"
.LASF926:
	.string	"thread"
.LASF671:
	.string	"__NCPUBITS (8 * sizeof (__cpu_mask))"
.LASF759:
	.string	"_GCC_WCHAR_T "
.LASF844:
	.string	"FD_ZERO(fdsetp) __FD_ZERO (fdsetp)"
.LASF317:
	.string	"__USE_ATFILE 1"
.LASF272:
	.string	"__USE_ISOC11"
.LASF154:
	.string	"__DBL_MIN__ ((double)2.22507385850720138309023271733240406e-308L)"
.LASF603:
	.string	"_IONBF 2"
.LASF599:
	.string	"__off_t_defined "
.LASF558:
	.string	"_IO_BAD_SEEN 0x4000"
.LASF542:
	.string	"_OLD_STDIO_MAGIC 0xFABC0000"
.LASF903:
	.string	"_next"
.LASF936:
	.string	"exit"
.LASF56:
	.string	"__INT_LEAST32_TYPE__ int"
.LASF409:
	.string	"__stub_ustat "
.LASF682:
	.string	"__CPU_ALLOC(count) __sched_cpualloc (count)"
.LASF6:
	.string	"__GNUC_MINOR__ 2"
.LASF222:
	.string	"__ARM_64BIT_STATE 1"
.LASF164:
	.string	"__LDBL_MIN_10_EXP__ (-4931)"
.LASF524:
	.string	"_IO_va_list _G_va_list"
.LASF673:
	.string	"__CPUMASK(cpu) ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))"
.LASF210:
	.string	"__GCC_ATOMIC_INT_LOCK_FREE 2"
.LASF393:
	.string	"__stub_chflags "
.LASF835:
	.string	"__NFDBITS (8 * (int) sizeof (__fd_mask))"
.LASF243:
	.string	"__ARM_FEATURE_FP16_SCALAR_ARITHMETIC"
.LASF847:
	.string	"minor(dev) gnu_dev_minor (dev)"
.LASF483:
	.string	"__TIMER_T_TYPE void *"
.LASF159:
	.string	"__DBL_HAS_QUIET_NAN__ 1"
.LASF253:
	.string	"__ILP32__"
.LASF812:
	.string	"__uid_t_defined "
.LASF785:
	.string	"w_termsig __wait_terminated.__w_termsig"
.LASF634:
	.string	"BYTE_ORDER __BYTE_ORDER"
.LASF656:
	.string	"__need_clock_t"
.LASF880:
	.string	"_IO_buf_end"
.LASF384:
	.string	"__REDIRECT_LDBL(name,proto,alias) __REDIRECT (name, proto, alias)"
.LASF371:
	.string	"__extern_always_inline extern __always_inline __attribute__ ((__gnu_inline__))"
.LASF196:
	.string	"__REGISTER_PREFIX__ "
.LASF551:
	.string	"_IO_LINKED 0x80"
.LASF147:
	.string	"__DBL_DIG__ 15"
.LASF929:
	.string	"spin_unlock"
.LASF476:
	.string	"__CLOCK_T_TYPE __SLONGWORD_TYPE"
.LASF364:
	.string	"__attribute_format_strfmon__(a,b) __attribute__ ((__format__ (__strfmon__, a, b)))"
.LASF782:
	.string	"__W_STOPCODE(sig) ((sig) << 8 | 0x7f)"
.LASF28:
	.string	"__SIZEOF_SIZE_T__ 8"
.LASF238:
	.string	"__AARCH64EL__ 1"
.LASF935:
	.string	"fprintf"
.LASF338:
	.string	"__END_DECLS "
.LASF769:
	.string	"WNOWAIT 0x01000000"
.LASF99:
	.string	"__UINT64_MAX__ 0xffffffffffffffffUL"
.LASF613:
	.string	"FOPEN_MAX"
.LASF66:
	.string	"__UINT_FAST8_TYPE__ unsigned char"
.LASF664:
	.string	"SCHED_OTHER 0"
.LASF790:
	.string	"__WAIT_INT(status) (__extension__ (((union { __typeof(status) __in; int __i; }) { .__in = (status) }).__i))"
.LASF343:
	.string	"__END_NAMESPACE_C99 "
.LASF911:
	.string	"stderr"
.LASF831:
	.string	"__need_timeval "
.LASF865:
	.string	"short int"
.LASF324:
	.string	"_SYS_CDEFS_H 1"
.LASF792:
	.string	"WEXITSTATUS(status) __WEXITSTATUS (__WAIT_INT (status))"
.LASF698:
	.string	"CLOCK_TAI 11"
.LASF111:
	.string	"__UINT16_C(c) c"
.LASF374:
	.string	"__va_arg_pack_len() __builtin_va_arg_pack_len ()"
.LASF850:
	.string	"__blkcnt_t_defined "
.LASF818:
	.string	"__need_clockid_t "
.LASF11:
	.string	"__ATOMIC_RELAXED 0"
.LASF355:
	.string	"__ASMNAME2(prefix,cname) __STRING (prefix) cname"
.LASF849:
	.string	"__blksize_t_defined "
.LASF837:
	.string	"__FD_MASK(d) ((__fd_mask) (1UL << ((d) % __NFDBITS)))"
.LASF158:
	.string	"__DBL_HAS_INFINITY__ 1"
.LASF90:
	.string	"__SIG_ATOMIC_MAX__ 0x7fffffff"
.LASF67:
	.string	"__UINT_FAST16_TYPE__ long unsigned int"
.LASF63:
	.string	"__INT_FAST16_TYPE__ long int"
.LASF7:
	.string	"__GNUC_PATCHLEVEL__ 1"
.LASF711:
	.string	"__SIZEOF_PTHREAD_COND_T 48"
.LASF447:
	.string	"__UQUAD_TYPE unsigned long int"
.LASF25:
	.string	"__SIZEOF_FLOAT__ 4"
.LASF185:
	.string	"__DEC64_MIN__ 1E-383DD"
.LASF890:
	.string	"_vtable_offset"
.LASF688:
	.string	"CLOCK_REALTIME 0"
.LASF152:
	.string	"__DBL_DECIMAL_DIG__ 17"
.LASF570:
	.string	"_IO_SHOWBASE 0200"
.LASF772:
	.string	"__WCLONE 0x80000000"
.LASF353:
	.string	"__REDIRECT_NTHNL(name,proto,alias) name proto __asm__ (__ASMNAME (#alias)) __THROWNL"
.LASF533:
	.string	"_IOS_INPUT 1"
.LASF394:
	.string	"__stub_fattach "
.LASF540:
	.string	"_IOS_BIN 128"
.LASF233:
	.string	"__ARM_FP_FAST"
.LASF93:
	.string	"__INT16_MAX__ 0x7fff"
.LASF356:
	.string	"__attribute_malloc__ __attribute__ ((__malloc__))"
.LASF448:
	.string	"__SWORD_TYPE long int"
.LASF359:
	.string	"__attribute_const__ __attribute__ ((__const__))"
.LASF747:
	.string	"__WCHAR_T__ "
.LASF616:
	.string	"stdout stdout"
.LASF362:
	.string	"__attribute_deprecated__ __attribute__ ((__deprecated__))"
.LASF290:
	.string	"__USE_MISC"
.LASF308:
	.string	"__USE_POSIX 1"
.LASF127:
	.string	"__GCC_IEC_559_COMPLEX 2"
.LASF621:
	.ascii	"fread_unlocked(ptr,size,n,stream) (__extension__ ((__builtin"
	.ascii	"_constant_p (size) && __builtin_constant_p (n) && (size_t) ("
	.ascii	"size) * (size_t) (n) <= 8 && (size_t) (size) != 0) ? ({ char"
	.ascii	" *__ptr = (char *) (ptr); FILE *__stream = (stream); size_t "
	.ascii	"__cnt; for (__cnt = (size_t) (size) * (size_t) (n); __cnt > "
	.ascii	"0; --__cnt) { int __c = _IO_getc_unlocked (__stream); if (__"
	.ascii	"c == EOF) break; *__ptr++ = __c; } ((size_t) (size) * (size_"
	.ascii	"t) (n) "
	.string	"- __cnt) / (size_t) (size); }) : (((__builtin_constant_p (size) && (size_t) (size) == 0) || (__builtin_constant_p (n) && (size_t) (n) == 0)) ? ((void) (ptr), (void) (stream), (void) (size), (void) (n), (size_t) 0) : fread_unlocked (ptr, size, n, stream))))"
.LASF567:
	.string	"_IO_DEC 020"
.LASF694:
	.string	"CLOCK_MONOTONIC_COARSE 6"
.LASF178:
	.string	"__DEC32_MIN__ 1E-95DF"
.LASF511:
	.string	"_G_HAVE_ST_BLKSIZE defined (_STATBUF_ST_BLKSIZE)"
.LASF440:
	.string	"__S16_TYPE short int"
.LASF576:
	.string	"_IO_UNITBUF 020000"
.LASF219:
	.string	"__SIZEOF_WINT_T__ 4"
.LASF657:
	.string	"__time_t_defined 1"
.LASF230:
	.string	"__ARM_FEATURE_UNALIGNED 1"
.LASF636:
	.string	"_BITS_BYTESWAP_H 1"
.LASF715:
	.string	"__SIZEOF_PTHREAD_RWLOCKATTR_T 8"
.LASF366:
	.string	"__attribute_warn_unused_result__ __attribute__ ((__warn_unused_result__))"
.LASF574:
	.string	"_IO_SCIENTIFIC 04000"
.LASF302:
	.string	"__USE_ISOC95 1"
.LASF543:
	.string	"_IO_MAGIC_MASK 0xFFFF0000"
.LASF176:
	.string	"__DEC32_MIN_EXP__ (-94)"
.LASF53:
	.string	"__UINT64_TYPE__ long unsigned int"
.LASF586:
	.string	"_IO_getc_unlocked(_fp) (_IO_BE ((_fp)->_IO_read_ptr >= (_fp)->_IO_read_end, 0) ? __uflow (_fp) : *(unsigned char *) (_fp)->_IO_read_ptr++)"
.LASF757:
	.string	"___int_wchar_t_h "
.LASF501:
	.string	"_IO_STDIO_H "
.LASF933:
	.string	"pthread_join"
.LASF27:
	.string	"__SIZEOF_LONG_DOUBLE__ 16"
.LASF117:
	.string	"__INT_FAST16_MAX__ 0x7fffffffffffffffL"
.LASF463:
	.string	"__OFF_T_TYPE __SLONGWORD_TYPE"
.LASF583:
	.string	"_IO_stdout ((_IO_FILE*)(&_IO_2_1_stdout_))"
.LASF477:
	.string	"__TIME_T_TYPE __SLONGWORD_TYPE"
.LASF382:
	.string	"__LDBL_REDIR_NTH(name,proto) name proto __THROW"
.LASF373:
	.string	"__va_arg_pack() __builtin_va_arg_pack ()"
.LASF479:
	.string	"__SUSECONDS_T_TYPE __SLONGWORD_TYPE"
.LASF294:
	.string	"__USE_FORTIFY_LEVEL"
.LASF584:
	.string	"_IO_stderr ((_IO_FILE*)(&_IO_2_1_stderr_))"
.LASF300:
	.string	"__USE_ISOC11 1"
.LASF684:
	.string	"sched_priority __sched_priority"
.LASF508:
	.string	"_G_HAVE_MMAP 1"
.LASF799:
	.string	"__ldiv_t_defined 1"
.LASF298:
	.string	"_DEFAULT_SOURCE"
.LASF571:
	.string	"_IO_SHOWPOINT 0400"
.LASF432:
	.string	"_GCC_SIZE_T "
.LASF681:
	.string	"__CPU_ALLOC_SIZE(count) ((((count) + __NCPUBITS - 1) / __NCPUBITS) * sizeof (__cpu_mask))"
.LASF241:
	.string	"__ARM_FP16_FORMAT_IEEE 1"
.LASF78:
	.string	"__LONG_MAX__ 0x7fffffffffffffffL"
.LASF820:
	.string	"__u_intN_t(N,MODE) typedef unsigned int u_int ##N ##_t __attribute__ ((__mode__ (MODE)))"
.LASF224:
	.string	"__ARM_ALIGN_MAX_PWR 28"
.LASF761:
	.string	"_BSD_WCHAR_T_"
.LASF709:
	.string	"__SIZEOF_PTHREAD_MUTEX_T 48"
.LASF629:
	.string	"__BYTE_ORDER __LITTLE_ENDIAN"
.LASF499:
	.string	"__need___FILE"
.LASF456:
	.string	"__DEV_T_TYPE __UQUAD_TYPE"
.LASF777:
	.string	"__WIFSIGNALED(status) (((signed char) (((status) & 0x7f) + 1) >> 1) > 0)"
.LASF84:
	.string	"__PTRDIFF_MAX__ 0x7fffffffffffffffL"
.LASF125:
	.string	"__UINTPTR_MAX__ 0xffffffffffffffffUL"
.LASF886:
	.string	"_fileno"
.LASF345:
	.string	"__bos(ptr) __builtin_object_size (ptr, __USE_FORTIFY_LEVEL > 1)"
.LASF635:
	.string	"__LONG_LONG_PAIR(HI,LO) LO, HI"
.LASF647:
	.string	"be32toh(x) __bswap_32 (x)"
.LASF169:
	.string	"__LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L"
.LASF309:
	.string	"__USE_POSIX2 1"
.LASF261:
	.string	"__unix__ 1"
.LASF467:
	.string	"__RLIM64_T_TYPE __UQUAD_TYPE"
.LASF781:
	.string	"__W_EXITCODE(ret,sig) ((ret) << 8 | (sig))"
.LASF198:
	.string	"__GNUC_STDC_INLINE__ 1"
.LASF347:
	.string	"__warndecl(name,msg) extern void name (void) __attribute__((__warning__ (msg)))"
.LASF662:
	.string	"__need_timespec"
.LASF460:
	.string	"__INO64_T_TYPE __UQUAD_TYPE"
.LASF497:
	.string	"__need_FILE"
.LASF468:
	.string	"__BLKCNT_T_TYPE __SLONGWORD_TYPE"
.LASF83:
	.string	"__WINT_MIN__ 0U"
.LASF461:
	.string	"__MODE_T_TYPE __U32_TYPE"
.LASF554:
	.string	"_IO_TIED_PUT_GET 0x400"
.LASF187:
	.string	"__DEC64_EPSILON__ 1E-15DD"
.LASF139:
	.string	"__FLT_MIN__ 1.17549435082228750796873653722224568e-38F"
.LASF810:
	.string	"__mode_t_defined "
.LASF336:
	.string	"__long_double_t long double"
.LASF55:
	.string	"__INT_LEAST16_TYPE__ short int"
.LASF857:
	.string	"__COMPAR_FN_T "
.LASF262:
	.string	"unix 1"
.LASF454:
	.string	"__STD_TYPE typedef"
.LASF862:
	.string	"short unsigned int"
.LASF910:
	.string	"stdout"
.LASF398:
	.string	"__stub_getpmsg "
.LASF854:
	.string	"_ALLOCA_H 1"
.LASF450:
	.string	"__SLONG32_TYPE int"
.LASF591:
	.string	"_IO_PENDING_OUTPUT_COUNT(_fp) ((_fp)->_IO_write_ptr - (_fp)->_IO_write_base)"
.LASF318:
	.string	"__USE_FORTIFY_LEVEL 0"
.LASF163:
	.string	"__LDBL_MIN_EXP__ (-16381)"
.LASF316:
	.string	"__USE_MISC 1"
.LASF486:
	.string	"__SSIZE_T_TYPE __SWORD_TYPE"
.LASF155:
	.string	"__DBL_EPSILON__ ((double)2.22044604925031308084726333618164062e-16L)"
.LASF340:
	.string	"__END_NAMESPACE_STD "
.LASF877:
	.string	"_IO_write_ptr"
.LASF776:
	.string	"__WIFEXITED(status) (__WTERMSIG(status) == 0)"
.LASF112:
	.string	"__UINT_LEAST32_MAX__ 0xffffffffU"
.LASF406:
	.string	"__stub_sstk "
.LASF293:
	.string	"__USE_REENTRANT"
.LASF809:
	.string	"__gid_t_defined "
.LASF731:
	.string	"PTHREAD_SCOPE_PROCESS PTHREAD_SCOPE_PROCESS"
.LASF349:
	.string	"__errordecl(name,msg) extern void name (void) __attribute__((__error__ (msg)))"
.LASF250:
	.string	"__AARCH64_CMODEL_LARGE__"
.LASF386:
	.string	"__USE_EXTERN_INLINES 1"
.LASF802:
	.string	"EXIT_FAILURE 1"
.LASF327:
	.string	"__LEAF_ATTR __attribute__ ((__leaf__))"
.LASF939:
	.string	"/home/scottt/Dropbox/shared-memory-concurrency/memory-model-examples"
.LASF918:
	.string	"daylight"
.LASF690:
	.string	"CLOCK_PROCESS_CPUTIME_ID 2"
.LASF666:
	.string	"SCHED_RR 2"
.LASF310:
	.string	"__USE_POSIX199309 1"
.LASF288:
	.string	"__USE_LARGEFILE64"
.LASF103:
	.string	"__INT16_C(c) c"
.LASF408:
	.string	"__stub_sysctl "
.LASF269:
	.string	"__STDC_NO_THREADS__ 1"
.LASF795:
	.string	"WIFEXITED(status) __WIFEXITED (__WAIT_INT (status))"
.LASF677:
	.string	"__CPU_ISSET_S(cpu,setsize,cpusetp) (__extension__ ({ size_t __cpu = (cpu); __cpu / 8 < (setsize) ? ((((const __cpu_mask *) ((cpusetp)->__bits))[__CPUELT (__cpu)] & __CPUMASK (__cpu))) != 0 : 0; }))"
.LASF15:
	.string	"__ATOMIC_ACQ_REL 4"
.LASF630:
	.string	"__FLOAT_WORD_ORDER __BYTE_ORDER"
.LASF257:
	.string	"__linux 1"
.LASF149:
	.string	"__DBL_MIN_10_EXP__ (-307)"
.LASF944:
	.string	"data"
.LASF695:
	.string	"CLOCK_BOOTTIME 7"
.LASF156:
	.string	"__DBL_DENORM_MIN__ ((double)4.94065645841246544176568792868221372e-324L)"
.LASF162:
	.string	"__LDBL_DIG__ 33"
.LASF894:
	.string	"__pad1"
.LASF856:
	.string	"alloca(size) __builtin_alloca (size)"
.LASF897:
	.string	"__pad4"
.LASF791:
	.string	"__WAIT_STATUS_DEFN int *"
.LASF714:
	.string	"__SIZEOF_PTHREAD_RWLOCK_T 56"
.LASF306:
	.string	"_POSIX_C_SOURCE"
.LASF146:
	.string	"__DBL_MANT_DIG__ 53"
.LASF485:
	.string	"__FSID_T_TYPE struct { int __val[2]; }"
.LASF9:
	.string	"__LINARO_RELEASE__ 201611"
.LASF376:
	.string	"__glibc_unlikely(cond) __builtin_expect ((cond), 0)"
.LASF77:
	.string	"__INT_MAX__ 0x7fffffff"
.LASF114:
	.string	"__UINT_LEAST64_MAX__ 0xffffffffffffffffUL"
.LASF97:
	.string	"__UINT16_MAX__ 0xffff"
.LASF581:
	.string	"__HAVE_COLUMN "
.LASF794:
	.string	"WSTOPSIG(status) __WSTOPSIG (__WAIT_INT (status))"
.LASF851:
	.string	"__fsblkcnt_t_defined "
.LASF391:
	.string	"__stub___compat_uselib "
	.ident	"GCC: (Linaro GCC 6.2-2016.11) 6.2.1 20161016"
	.section	.note.GNU-stack,"",@progbits
