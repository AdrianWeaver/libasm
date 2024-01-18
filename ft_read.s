	extern	__errno_location

	section		.data
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
	mov			rax, -1
	ret

	section		.bss
