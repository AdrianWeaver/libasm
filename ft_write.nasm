	global	ft_write

	section	.text

ft_write:
	mov		rax, 1	;set rax register to value of write
	syscall
	ret
	
