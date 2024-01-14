	global	ft_write
	extern	__errno_location

	section	.text

ft_write:
	mov		rax, 1	;set rax register to value of write
	syscall
	cmp		rax, 0	;check for errors on rax
	js		_write_error		;if return or write is < 0
	ret

	_write_error:
		neg		rax, 				;negating rax to recover error code
		mov		ecx, eax			;saving write error code to ecx
		call	__errno_location	;get address of errno
		mov		[rax], ecx			;updating errno with 31bits error code
		mov		rax, -1				;on error write needs to return -1
		ret
