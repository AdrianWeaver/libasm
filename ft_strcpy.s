	global		ft_strcpy

	section		.text

ft_strcpy:
	mov		rax, rdi ;storing the dest adress to return

	_loop:
		mov		rcx, [rsi]			;copying the character of the source in a buffer
		mov		[rdi], rcx			;copying the saved character in the dest
		cmp		byte [rsi], 0	;checking if \0 reached
		jz		_finish

		inc		rsi					;accessing next index in src string
		inc		rdi					;accessing next index in dest string
		jmp		_loop

	_finish:
		ret
