	section	.data
	section	.text

	global	sandbox

_start:
	call	sandbox
	mov		rax, 60		;syscall for exit
	mov		rdi, 0		;returning 0
	syscall				;exiting

sandbox:
	nop					;for debugger purpose only

	mov		cx, 10
	mov		rax, -1		;setting all bits of rax to 1
	movzx	eax, cx		;trying that heh

	nop					;for debugger purpose only
	ret					

	section .bss
