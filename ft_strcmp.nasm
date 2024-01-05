	global		ft_strcmp

	section 	.text

ft_strcmp:
	_loop:
		movzx	rax, byte [rsi]
		xor		al, byte [rdi]
		jnz		finish
		cmp		byte [rsi], 0
		je		finish
		inc		qword rsi
		inc		qword rdi
		jmp		_loop

	finish:
		ret
