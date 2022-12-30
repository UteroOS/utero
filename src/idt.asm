isr_0:
	cli
	push 0
	jmp isr_basic

isr_1:
	cli
	push 1
	jmp isr_basic

isr_2:
	cli
	push 2
	jmp isr_basic

isr_3:
	cli
	push 3
	jmp isr_basic

isr_4:
	cli
	push 4
	jmp isr_basic

isr_5:
	cli
	push 5
	jmp isr_basic

isr_6:
	cli
	push 6
	jmp isr_basic

isr_7:
	cli
	push 7
	jmp isr_basic

isr_8:
	cli
	push 8
	jmp isr_basic

isr_9:
	cli
	push 9
	jmp isr_basic

isr_10:
	cli
	push 10
	jmp isr_basic

isr_11:
	cli
	push 11
	jmp isr_basic

isr_12:
	cli
	push 12
	jmp isr_basic

isr_13:
	cli
	push 13
	jmp isr_basic

isr_14:
	cli
	push 14
	jmp isr_basic

isr_15:
	cli
	push 15
	jmp isr_basic

isr_16:
	cli
	push 16
	jmp isr_basic

isr_17:
	cli
	push 17
	jmp isr_basic

isr_18:
	cli
	push 18
	jmp isr_basic

isr_19:
	cli
	push 19
	jmp isr_basic

isr_20:
	cli
	push 20
	jmp isr_basic

isr_21:
	cli
	push 21
	jmp isr_basic

isr_22:
	cli
	push 22
	jmp isr_basic

isr_23:
	cli
	push 23
	jmp isr_basic

isr_24:
	cli
	push 24
	jmp isr_basic

isr_25:
	cli
	push 25
	jmp isr_basic

isr_26:
	cli
	push 26
	jmp isr_basic

isr_27:
	cli
	push 27
	jmp isr_basic

isr_28:
	cli
	push 28
	jmp isr_basic

isr_29:
	cli
	push 29
	jmp isr_basic

isr_30:
	cli
	push 30
	jmp isr_basic

isr_31:
	cli
	push 31
	jmp isr_basic

isr_32:
	; Part 1

	; Step 1: When we are handling an interrupt, it is better to not receive any other interrupt
	cli

	; Step 2: pushe the current values of all general purpose registers into the stack
	pusha

	; Step 3: to obtain the value of process A's return address, we can do that simply by reading the value in esp + 32
	; we first read this value and then push it into the stack so the function scheduler can receive it as the first parameter
	mov eax, [esp + 32]
	push eax

	call scheduler ; Step 4

	; Part 2

	; Step 5: after the function scheduler returns, we need to tell PIC that we finished the handling of an IRQ by sending end of interrupt command to the PIC
	mov al, 0x20
	out 0x20, al

	; Step 6: The final thing to do after choosing the next process and performing the context switching is to give a CPU time for the code of the next process
	; First we remove all values that we have pushed on the stack while running isr_32, this is performed by just adding 40 to the current value of ESP
	; the total size of pushed items in isr_32 is 32 + 4 = 36
	; 36 + 4 = 40 bytes should be removed from the stack to ensure that we remove all pushed values with the return address or process
	add esp, 40d
	; the code of the function run_next_process will be called which enables the interrupts again and jumps to the resume point of the next process
	push run_next_process

	iret ; Step 7

isr_33:
	cli
	push 33
	jmp isr_basic

isr_34:
	cli
	push 34
	jmp isr_basic

isr_35:
	cli
	push 35
	jmp isr_basic

isr_36:
	cli
	push 36
	jmp isr_basic

isr_37:
	cli
	push 37
	jmp isr_basic

isr_38:
	cli
	push 38
	jmp isr_basic

isr_39:
	cli
	push 39
	jmp isr_basic

isr_40:
	cli
	push 40
	jmp isr_basic

isr_41:
	cli
	push 41
	jmp isr_basic

isr_42:
	cli
	push 42
	jmp isr_basic

isr_43:
	cli
	push 43
	jmp isr_basic
isr_44:
	cli
	push 44
	jmp isr_basic

isr_45:
	cli
	push 45
	jmp isr_basic

isr_46:
	cli
	push 46
	jmp isr_basic

isr_47:
	cli
	push 47
	jmp isr_basic

isr_48:
	cli
	push 48
	jmp isr_basic

isr_basic:
	call interrupt_handler

	pop eax

	sti
	iret

irq_basic:
	call interrupt_handler

	mov al, 0x20
	out 0x20, al

	cmp byte [esp], 40d
	jnge irq_basic_end

	mov al, 0xa0
	out 0x20, al

	irq_basic_end:
		pop eax

		sti
		iret

idt:
	dw isr_0, 8, 0x8e00, 0x0000
	dw isr_1, 8, 0x8e00, 0x0000
	dw isr_2, 8, 0x8e00, 0x0000
	dw isr_3, 8, 0x8e00, 0x0000
	dw isr_4, 8, 0x8e00, 0x0000
	dw isr_5, 8, 0x8e00, 0x0000
	dw isr_6, 8, 0x8e00, 0x0000
	dw isr_7, 8, 0x8e00, 0x0000
	dw isr_8, 8, 0x8e00, 0x0000
	dw isr_9, 8, 0x8e00, 0x0000
	dw isr_10, 8, 0x8e00, 0x0000
	dw isr_11, 8, 0x8e00, 0x0000
	dw isr_12, 8, 0x8e00, 0x0000
	dw isr_13, 8, 0x8e00, 0x0000
	dw isr_14, 8, 0x8e00, 0x0000
	dw isr_15, 8, 0x8e00, 0x0000
	dw isr_16, 8, 0x8e00, 0x0000
	dw isr_17, 8, 0x8e00, 0x0000
	dw isr_18, 8, 0x8e00, 0x0000
	dw isr_19, 8, 0x8e00, 0x0000
	dw isr_20, 8, 0x8e00, 0x0000
	dw isr_21, 8, 0x8e00, 0x0000
	dw isr_22, 8, 0x8e00, 0x0000
	dw isr_23, 8, 0x8e00, 0x0000
	dw isr_24, 8, 0x8e00, 0x0000
	dw isr_25, 8, 0x8e00, 0x0000
	dw isr_26, 8, 0x8e00, 0x0000
	dw isr_27, 8, 0x8e00, 0x0000
	dw isr_28, 8, 0x8e00, 0x0000
	dw isr_29, 8, 0x8e00, 0x0000
	dw isr_30, 8, 0x8e00, 0x0000
	dw isr_31, 8, 0x8e00, 0x0000
	dw isr_32, 8, 0x8e00, 0x0000
	dw isr_33, 8, 0x8e00, 0x0000
	dw isr_34, 8, 0x8e00, 0x0000
	dw isr_35, 8, 0x8e00, 0x0000
	dw isr_36, 8, 0x8e00, 0x0000
	dw isr_37, 8, 0x8e00, 0x0000
	dw isr_38, 8, 0x8e00, 0x0000
	dw isr_39, 8, 0x8e00, 0x0000
	dw isr_40, 8, 0x8e00, 0x0000
	dw isr_41, 8, 0x8e00, 0x0000
	dw isr_42, 8, 0x8e00, 0x0000
	dw isr_43, 8, 0x8e00, 0x0000
	dw isr_44, 8, 0x8e00, 0x0000
	dw isr_45, 8, 0x8e00, 0x0000
	dw isr_46, 8, 0x8e00, 0x0000
	dw isr_47, 8, 0x8e00, 0x0000
	dw isr_48, 8, 0x8e00, 0x0000

idtr:
	idt_size_in_bytes	:	dw idtr - idt
	idt_base_address	:	dd idt
