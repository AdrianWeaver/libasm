
	section		.data
	section		.text
	global		ft_strcpy

; char *strcpy(char *dest, char *src);
ft_strcpy:
	mov		rax, rdi		;storing the dest adress to return
_loop:
	mov		rcx, [rsi]		;buffering src char.
	mov		[rdi], rcx		;copying buffered char to dest
	cmp		byte [rsi], 0	;checking if end of string reached
	jz		_finish
	inc		rsi				;iterating on src string
	inc		rdi				;iterating on dest string
	jmp		_loop

_finish:
	ret

	section		.bss
