	global		ft_strcpy

	section		.text

ft_strcpy:
	mov		rax, rdi

	_loop:
		mov		rcx, [rsi]
		mov		[rdi], rcx
		cmp		byte [rsi], 0
		jz		finish

		inc		qword rsi
		jmp		_loop

	finish:
		ret
