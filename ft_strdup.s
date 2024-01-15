	global	ft_strdup

	extern	malloc
	extern	ft_strlen
	extern	ft_strcpy
	extern	__errno_location

	section	.text

;char *ft_strdup(char *src)

ft_strdup:
	push	rdi			;storing the src pointer to keep it safe
	sub		rsp, 01H	;aligning the stack to 16bytes
	call	ft_strlen	;calculating the length of the src string
	add		rax, 1		;adding one to length of src string to account for \0
	mov		rdi, rax	;preparing the call for malloc with the length of src string
	call	malloc		;calling malloc with the length of string +1 for \0
	cmp		rax, 0		;checking for errors during malloc
	jz		_dup_err	;error management if malloc returned NULL
	mov		rdi, rax	;setting dest address for ft_strcpy
	add		rsp, 01H	;aligning the stack to 16bytes
	pop		rsi			;recovering the src pointer
	call	ft_strcpy	;copying strings
	ret

_dup_err:
	neg		rax					;getting the correct error code for errno
	mov		ecx, eax			;storing the error code before overwritting rax
	call	__errno_location	;getting errno address
	mov		[rax], ecx			;storing the error code in errno
	mov		rax, -1				;setting the return to -1
	ret
