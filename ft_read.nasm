	global ft_read;

	extern	__errno_location

	section	.text

ft_read:
	xor		rax, rax
	syscall
	cmp		rax, 0
	js		_read_error
	ret


_read_error:
	neg		rax					;getting real error code
	mov		rcx, rax			;storing error code before overwritting it
	call	__errno_location	;getting errno address
	mov		[eax], ecx			;storing error code in errno using 32bits registers because errno is 32bits
	mov		rax, -1
	ret
