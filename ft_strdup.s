
	extern	malloc
	extern	ft_strlen
	extern	ft_strcpy
	extern	__errno_location

	section		.data
	section		.text
	global		ft_strdup

;char *ft_strdup(char *src)
ft_strdup:
	enter	16, 0			;reservation for 16bytes in stack
	mov		[rbp - 8], rdi	;saving src pointer on stack
	call	ft_strlen		;get length of src string
	add		rax, 1			;adding to length for \0
	mov		rdi, rax		;arg for malloc
	call	malloc			;calling malloc
	cmp		rax, 0			;checking for errors during malloc
	jz		_dup_err		;error management if malloc returned NULL
	mov		rdi, rax		;setting dest address for ft_strcpy
	mov		rsi, [rbp - 8]	;recovering the src pointer
	call	ft_strcpy		;copying src to malloced address
	leave					;releasing stack reservation
	ret

_dup_err:
	neg		rax					;getting the correct error code for errno
	mov		ecx, eax			;saving error code
	call	__errno_location	;getting errno address
	mov		[rax], ecx			;storing the error code in errno
	mov		rax, -1				;setting the return to -1
	leave						;releasing stack reservation
	ret

	section		.bss
