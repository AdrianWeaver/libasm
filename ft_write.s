	extern	__errno_location

	section		.data
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

	section		.bss
