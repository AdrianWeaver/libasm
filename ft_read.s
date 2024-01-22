	;file:		ft_read.s
	;output:	part of libasm.a
	;created:	12/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this is an implementation of read from libc
		;this function is used to read from a fd and store in a buffer
		;see man 2 read for details
		;it sets errno in case of errors

	extern	__errno_location

	section		.data
	section		.bss
	section		.text
	global ft_read;

;int	ft_read(unsigned int fd, char *str, size_t	buff_size);
ft_read:
	xor			rax, rax		;setting rax to read syscall value
	syscall						;calling read with rdi, rsi, rdx
	cmp			rax, 0			;checking for error during read
	js			_read_error		;if read returned -1 manage errors
	ret							;otherwise return

_read_error:
	neg			rax					;getting real error code
	mov			rcx, rax			;storing error code before overwritting it
	call		__errno_location	;getting errno address
	mov			[eax], ecx			;storing error code in errno using 32bits registers because errno is 32bits
	mov			rax, -1				;returning -1 in case of error
	ret

