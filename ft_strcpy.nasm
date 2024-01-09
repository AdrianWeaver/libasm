	global		ft_strcpy

	section		.text

ft_strcpy:
	mov		rax, rdi ;storing the dest adress to return

	_loop:
		mov		rcx, [rsi] ;copying rsi's value in rdi using rcx as buffer
		mov		[rdi], rcx
		cmp		byte [rsi], 0 ;checking if \0 reached
		jz		finish

		inc		qword rsi
		jmp		_loop

	finish:
		ret
