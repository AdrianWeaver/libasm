	global		ft_strcmp

	section 	.text

ft_strcmp:
	_loop:
		mov		al, [rdi]
		sub		al, [rsi]
		jnz		finish
		cmp		byte [rsi], 0
		je		finish
		inc		qword rsi
		inc		qword rdi
		jmp		_loop

	finish:
		movsx	rax, al
		ret
