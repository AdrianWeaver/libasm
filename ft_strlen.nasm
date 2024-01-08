	global	ft_strlen;

	section	.text

ft_strlen:
	xor		rax, rax

	_loop:
		cmp		byte [rdi], 0
		je		_end
		inc		rax
		inc		rdi
		jmp		_loop
	_end:
		ret
