
	section		.data
	section 	.text
	global		ft_strcmp

; int ft_strcmp(char *s1, char *s2);
ft_strcmp:
	xor		rax, rax
	cmp		qword rsi, 0 ;checking for NULL on first arg
	je		finish
	cmp		qword rdi, 0 ;checking for NULL on second arg
	je		finish

_loop:
	mov		al, [rdi] 	;storing char from dest string in buffer
	sub		al, [rsi]	;comparing char from dest and src
	jnz		finish		;quitting loop if chars do not match
	cmp		byte [rsi], 0
	je		finish		;quitting loop if end of source string reached
	inc		qword rsi	;iterating on src string
	inc		qword rdi	;iterating on dest string
	jmp		_loop

finish:
	movsx	eax, al		;adjusting the sign bit for an int
	ret

	section		.bss
