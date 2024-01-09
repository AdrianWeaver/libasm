	global	ft_strlen;

	section	.text

ft_strlen:
	xor		rax, rax	;setting the counter to 0

	_loop:
		cmp		byte [rdi], 0 ;checking for end of string
		je		_end
		inc		rax				;incrementing counter
		inc		rdi				;interating on string
		jmp		_loop
	_end:
		ret
