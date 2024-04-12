	.cpu cortex-m4
	.arch armv7e-m
	.fpu fpv4-sp-d16
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"startup_msp432p4111_gcc.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 1 "lib/startup_msp432p4111_gcc.c"
	.section	.text.Default_Handler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	Default_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	Default_Handler, %function
Default_Handler:
.LFB1:
	.loc 1 257 28
	.cfi_startproc
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
.L2:
	.loc 1 259 3
	.loc 1 259 14
	.loc 1 259 9
	b	.L2
	.cfi_endproc
.LFE1:
	.size	Default_Handler, .-Default_Handler
	.weak	LCD_F_IRQHandler
	.thumb_set LCD_F_IRQHandler,Default_Handler
	.weak	PORT6_IRQHandler
	.thumb_set PORT6_IRQHandler,Default_Handler
	.weak	PORT5_IRQHandler
	.thumb_set PORT5_IRQHandler,Default_Handler
	.weak	PORT4_IRQHandler
	.thumb_set PORT4_IRQHandler,Default_Handler
	.weak	PORT3_IRQHandler
	.thumb_set PORT3_IRQHandler,Default_Handler
	.weak	PORT2_IRQHandler
	.thumb_set PORT2_IRQHandler,Default_Handler
	.weak	PORT1_IRQHandler
	.thumb_set PORT1_IRQHandler,Default_Handler
	.weak	DMA_INT0_IRQHandler
	.thumb_set DMA_INT0_IRQHandler,Default_Handler
	.weak	DMA_INT1_IRQHandler
	.thumb_set DMA_INT1_IRQHandler,Default_Handler
	.weak	DMA_INT2_IRQHandler
	.thumb_set DMA_INT2_IRQHandler,Default_Handler
	.weak	DMA_INT3_IRQHandler
	.thumb_set DMA_INT3_IRQHandler,Default_Handler
	.weak	DMA_ERR_IRQHandler
	.thumb_set DMA_ERR_IRQHandler,Default_Handler
	.weak	RTC_C_IRQHandler
	.thumb_set RTC_C_IRQHandler,Default_Handler
	.weak	AES256_IRQHandler
	.thumb_set AES256_IRQHandler,Default_Handler
	.weak	T32_INTC_IRQHandler
	.thumb_set T32_INTC_IRQHandler,Default_Handler
	.weak	T32_INT2_IRQHandler
	.thumb_set T32_INT2_IRQHandler,Default_Handler
	.weak	T32_INT1_IRQHandler
	.thumb_set T32_INT1_IRQHandler,Default_Handler
	.weak	ADC14_IRQHandler
	.thumb_set ADC14_IRQHandler,Default_Handler
	.weak	EUSCIB3_IRQHandler
	.thumb_set EUSCIB3_IRQHandler,Default_Handler
	.weak	EUSCIB2_IRQHandler
	.thumb_set EUSCIB2_IRQHandler,Default_Handler
	.weak	EUSCIB1_IRQHandler
	.thumb_set EUSCIB1_IRQHandler,Default_Handler
	.weak	EUSCIB0_IRQHandler
	.thumb_set EUSCIB0_IRQHandler,Default_Handler
	.weak	EUSCIA3_IRQHandler
	.thumb_set EUSCIA3_IRQHandler,Default_Handler
	.weak	EUSCIA2_IRQHandler
	.thumb_set EUSCIA2_IRQHandler,Default_Handler
	.weak	EUSCIA1_IRQHandler
	.thumb_set EUSCIA1_IRQHandler,Default_Handler
	.weak	EUSCIA0_IRQHandler
	.thumb_set EUSCIA0_IRQHandler,Default_Handler
	.weak	TA3_N_IRQHandler
	.thumb_set TA3_N_IRQHandler,Default_Handler
	.weak	TA3_0_IRQHandler
	.thumb_set TA3_0_IRQHandler,Default_Handler
	.weak	TA2_N_IRQHandler
	.thumb_set TA2_N_IRQHandler,Default_Handler
	.weak	TA2_0_IRQHandler
	.thumb_set TA2_0_IRQHandler,Default_Handler
	.weak	TA1_N_IRQHandler
	.thumb_set TA1_N_IRQHandler,Default_Handler
	.weak	TA1_0_IRQHandler
	.thumb_set TA1_0_IRQHandler,Default_Handler
	.weak	TA0_N_IRQHandler
	.thumb_set TA0_N_IRQHandler,Default_Handler
	.weak	TA0_0_IRQHandler
	.thumb_set TA0_0_IRQHandler,Default_Handler
	.weak	COMP_E1_IRQHandler
	.thumb_set COMP_E1_IRQHandler,Default_Handler
	.weak	COMP_E0_IRQHandler
	.thumb_set COMP_E0_IRQHandler,Default_Handler
	.weak	FLCTL_A_IRQHandler
	.thumb_set FLCTL_A_IRQHandler,Default_Handler
	.weak	FPU_IRQHandler
	.thumb_set FPU_IRQHandler,Default_Handler
	.weak	WDT_A_IRQHandler
	.thumb_set WDT_A_IRQHandler,Default_Handler
	.weak	PCM_IRQHandler
	.thumb_set PCM_IRQHandler,Default_Handler
	.weak	CS_IRQHandler
	.thumb_set CS_IRQHandler,Default_Handler
	.weak	PSS_IRQHandler
	.thumb_set PSS_IRQHandler,Default_Handler
	.weak	SysTick_Handler
	.thumb_set SysTick_Handler,Default_Handler
	.weak	PendSV_Handler
	.thumb_set PendSV_Handler,Default_Handler
	.weak	DebugMon_Handler
	.thumb_set DebugMon_Handler,Default_Handler
	.weak	SVC_Handler
	.thumb_set SVC_Handler,Default_Handler
	.weak	UsageFault_Handler
	.thumb_set UsageFault_Handler,Default_Handler
	.weak	BusFault_Handler
	.thumb_set BusFault_Handler,Default_Handler
	.weak	MemManage_Handler
	.thumb_set MemManage_Handler,Default_Handler
	.weak	HardFault_Handler
	.thumb_set HardFault_Handler,Default_Handler
	.weak	NMI_Handler
	.thumb_set NMI_Handler,Default_Handler
	.section	.text.Reset_Handler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.weak	Reset_Handler
	.syntax unified
	.thumb
	.thumb_func
	.type	Reset_Handler, %function
Reset_Handler:
.LFB0:
	.loc 1 234 26
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 235 3
	.loc 1 240 3
.LVL0:
	.loc 1 241 3
	.loc 1 241 47 discriminator 1
	ldr	r0, .L7
	ldr	r2, .L7+4
	cmp	r0, r2
	.loc 1 234 26 is_stmt 0
	push	{r3, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	.cfi_offset 14, -4
	.loc 1 241 47 discriminator 1
	bcs	.L5
	.loc 1 242 18
	subs	r2, r2, #1
	subs	r2, r2, r0
	bic	r2, r2, #3
	ldr	r1, .L7+8
	adds	r2, r2, #4
	bl	memcpy
.LVL1:
.L5:
	.loc 1 246 3 is_stmt 1
	bl	SystemInit
.LVL2:
	.loc 1 249 3
	.loc 1 250 1 is_stmt 0
	pop	{r3, lr}
	.cfi_restore 14
	.cfi_restore 3
	.cfi_def_cfa_offset 0
	.loc 1 249 3
	b	_mainCRTStartup
.LVL3:
.L8:
	.align	2
.L7:
	.word	__data_start__
	.word	__data_end__
	.word	__data_load__
	.cfi_endproc
.LFE0:
	.size	Reset_Handler, .-Reset_Handler
	.global	interruptVectors
	.section	.intvecs,"a"
	.align	2
	.type	interruptVectors, %object
	.size	interruptVectors, 232
interruptVectors:
	.word	__StackTop
	.word	Reset_Handler
	.word	NMI_Handler
	.word	HardFault_Handler
	.word	MemManage_Handler
	.word	BusFault_Handler
	.word	UsageFault_Handler
	.word	0
	.word	0
	.word	0
	.word	0
	.word	SVC_Handler
	.word	DebugMon_Handler
	.word	0
	.word	PendSV_Handler
	.word	SysTick_Handler
	.word	PSS_IRQHandler
	.word	CS_IRQHandler
	.word	PCM_IRQHandler
	.word	WDT_A_IRQHandler
	.word	FPU_IRQHandler
	.word	FLCTL_A_IRQHandler
	.word	COMP_E0_IRQHandler
	.word	COMP_E1_IRQHandler
	.word	TA0_0_IRQHandler
	.word	TA0_N_IRQHandler
	.word	TA1_0_IRQHandler
	.word	TA1_N_IRQHandler
	.word	TA2_0_IRQHandler
	.word	TA2_N_IRQHandler
	.word	TA3_0_IRQHandler
	.word	TA3_N_IRQHandler
	.word	EUSCIA0_IRQHandler
	.word	EUSCIA1_IRQHandler
	.word	EUSCIA2_IRQHandler
	.word	EUSCIA3_IRQHandler
	.word	EUSCIB0_IRQHandler
	.word	EUSCIB1_IRQHandler
	.word	EUSCIB2_IRQHandler
	.word	EUSCIB3_IRQHandler
	.word	ADC14_IRQHandler
	.word	T32_INT1_IRQHandler
	.word	T32_INT2_IRQHandler
	.word	T32_INTC_IRQHandler
	.word	AES256_IRQHandler
	.word	RTC_C_IRQHandler
	.word	DMA_ERR_IRQHandler
	.word	DMA_INT3_IRQHandler
	.word	DMA_INT2_IRQHandler
	.word	DMA_INT1_IRQHandler
	.word	DMA_INT0_IRQHandler
	.word	PORT1_IRQHandler
	.word	PORT2_IRQHandler
	.word	PORT3_IRQHandler
	.word	PORT4_IRQHandler
	.word	PORT5_IRQHandler
	.word	PORT6_IRQHandler
	.word	LCD_F_IRQHandler
	.text
.Letext0:
	.file 2 "/usr/arm-none-eabi/include/machine/_default_types.h"
	.file 3 "/usr/arm-none-eabi/include/sys/_stdint.h"
	.file 4 "<built-in>"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x16c
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x8
	.4byte	.LASF19
	.byte	0x1d
	.4byte	.LASF20
	.4byte	.LASF21
	.4byte	.LLRL0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.4byte	.LASF4
	.uleb128 0x3
	.4byte	.LASF9
	.byte	0x2
	.byte	0x4f
	.byte	0x19
	.4byte	0x55
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x9
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x3
	.4byte	.LASF10
	.byte	0x3
	.byte	0x30
	.byte	0x14
	.4byte	0x49
	.uleb128 0x2
	.4byte	.LASF11
	.byte	0x2e
	.4byte	0x78
	.uleb128 0x2
	.4byte	.LASF12
	.byte	0x2f
	.4byte	0x78
	.uleb128 0x2
	.4byte	.LASF13
	.byte	0x30
	.4byte	0x78
	.uleb128 0x2
	.4byte	.LASF14
	.byte	0x31
	.4byte	0x78
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x1
	.byte	0x33
	.byte	0x10
	.4byte	0xb8
	.uleb128 0x4
	.4byte	0xc2
	.uleb128 0x5
	.4byte	0xb8
	.uleb128 0xa
	.uleb128 0xb
	.4byte	0xbd
	.4byte	0xd3
	.uleb128 0xc
	.4byte	0x71
	.byte	0x39
	.byte	0
	.uleb128 0x5
	.4byte	0xc3
	.uleb128 0xd
	.4byte	.LASF16
	.byte	0x1
	.byte	0xa4
	.byte	0xe
	.4byte	0xd3
	.uleb128 0x5
	.byte	0x3
	.4byte	interruptVectors
	.uleb128 0xe
	.4byte	.LASF22
	.byte	0x1
	.byte	0x29
	.byte	0xc
	.4byte	0x6a
	.4byte	0xfc
	.uleb128 0xf
	.byte	0
	.uleb128 0x10
	.4byte	.LASF23
	.byte	0x1
	.byte	0x2c
	.byte	0xd
	.uleb128 0x11
	.4byte	.LASF24
	.byte	0x1
	.2byte	0x101
	.byte	0x6
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x12
	.4byte	.LASF25
	.byte	0x1
	.byte	0xea
	.byte	0x6
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x15f
	.uleb128 0x6
	.4byte	.LASF17
	.byte	0xeb
	.byte	0xd
	.4byte	0x15f
	.uleb128 0x6
	.4byte	.LASF18
	.byte	0xeb
	.byte	0x18
	.4byte	0x15f
	.uleb128 0x7
	.4byte	.LVL1
	.4byte	0x164
	.uleb128 0x7
	.4byte	.LVL2
	.4byte	0xfc
	.uleb128 0x13
	.4byte	.LVL3
	.4byte	0xea
	.byte	0
	.uleb128 0x4
	.4byte	0x78
	.uleb128 0x14
	.4byte	.LASF26
	.4byte	.LASF27
	.byte	0x4
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
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
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 17
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.byte	0
	.byte	0
	.uleb128 0x9
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
	.uleb128 0xa
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xe
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
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x82
	.uleb128 0x19
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
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
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	0
	.4byte	0
	.section	.debug_rnglists,"",%progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL0:
	.byte	0x7
	.4byte	.LFB1
	.uleb128 .LFE1-.LFB1
	.byte	0x7
	.4byte	.LFB0
	.uleb128 .LFE0-.LFB0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF21:
	.ascii	"/home/brighton/Documents/GitHub/msp432/vim/c/blinky"
	.ascii	"-leds\000"
.LASF22:
	.ascii	"_mainCRTStartup\000"
.LASF25:
	.ascii	"Reset_Handler\000"
.LASF11:
	.ascii	"__data_load__\000"
.LASF18:
	.ascii	"pui32Dest\000"
.LASF16:
	.ascii	"interruptVectors\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF5:
	.ascii	"long unsigned int\000"
.LASF3:
	.ascii	"short unsigned int\000"
.LASF15:
	.ascii	"pFunc\000"
.LASF20:
	.ascii	"lib/startup_msp432p4111_gcc.c\000"
.LASF9:
	.ascii	"__uint32_t\000"
.LASF8:
	.ascii	"unsigned int\000"
.LASF17:
	.ascii	"pui32Src\000"
.LASF7:
	.ascii	"long long unsigned int\000"
.LASF14:
	.ascii	"__StackTop\000"
.LASF27:
	.ascii	"__builtin_memcpy\000"
.LASF23:
	.ascii	"SystemInit\000"
.LASF19:
	.ascii	"GNU C17 13.2.0 -mcpu=cortex-m4 -mthumb -mfloat-abi="
	.ascii	"hard -mfpu=fpv4-sp-d16 -march=armv7e-m+fp -g -gstri"
	.ascii	"ct-dwarf -O3 -std=c17 -ffunction-sections -fdata-se"
	.ascii	"ctions\000"
.LASF6:
	.ascii	"long long int\000"
.LASF24:
	.ascii	"Default_Handler\000"
.LASF26:
	.ascii	"memcpy\000"
.LASF2:
	.ascii	"short int\000"
.LASF10:
	.ascii	"uint32_t\000"
.LASF4:
	.ascii	"long int\000"
.LASF0:
	.ascii	"signed char\000"
.LASF12:
	.ascii	"__data_start__\000"
.LASF13:
	.ascii	"__data_end__\000"
	.ident	"GCC: (Arch Repository) 13.2.0"
