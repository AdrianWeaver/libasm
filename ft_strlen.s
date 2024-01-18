	section		.data
	section		.text
	global		ft_strlen;

;size_t	ft_strlen(char *str)
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

	section		.bss
