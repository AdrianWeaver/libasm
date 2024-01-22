	;file:		ft_write.s
	;output:	part of libasm.a
	;created:	09/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this is a simple write implementation 
		;this function calls write and sets errno if something went wrong
		;see man 2 write

	extern	__errno_location

	section		.data
	section		.bss
	section		.text
	global	ft_write

;int	ft_write(int fd, void *str, size_t len)
ft_write:
	mov		rax, 1			;set rax register to value of write
	syscall					;calling write
	cmp		rax, 0			;check for write error
	js		_write_error	;calling error handler
	ret						;otherwise returning

_write_error:
	neg		rax, 				;getting correct error code
	mov		ecx, eax			;saving write error code to ecx
	call	__errno_location	;get address of errno
	mov		[rax], ecx			;updating errno with 32bits error code
	mov		rax, -1				;on error write needs to return -1
	ret
