	global		ft_strcmp

	section 	.text

ft_strcmp:
	xor		rax, rax
	cmp		qword rsi, 0 ;checking for NULL on first arg
	je		finish
	cmp		qword rdi, 0 ;checking for NULL on second arg
	je		finish

	_loop:
		mov		al, [rdi] 	
		sub		al, [rsi]
		jnz		finish		;quitting loop if values of rdi and rsi are different
		cmp		byte [rsi], 0
		je		finish		;quitting loop if end of source string reached
		inc		qword rsi
		inc		qword rdi
		jmp		_loop

	finish:
		movsx	rax, al		;appropriately setting the sign bit on rax
		ret
