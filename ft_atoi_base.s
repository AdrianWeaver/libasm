	global		ft_atoi_base

	extern		ft_strlen
	section		.text

;	int ft_atoi_base(char *str, char *base)

;	implement nb = nb * base + index
ft_atoi_base:
	push		rdi				;saving the src string on stack
	push		rsi				;saving the base on stack
	mov			rdi, rsi		;setting base as arg1 for ft_strlen
	call		ft_strlen
	mov			rdi, rsi		;set base as arg1 for check_base
	mov			rsi, rax		;set base_len as arg2 for check_base
	push		rax				;saving base_len on stack
	sub			rsp, 02H		;16bytes aligning stack
	call		_check_base
	cmp			rax, 0			;checking check_base return code
	jne			_atoi_error		;returning 0 in case of base error
	add			rsp, 02H		;removing stack offset alignment
	pop			r8				;recovering base_len from stack on rdx
	pop			r9	 			;recovering base on from stack on rsi
	pop			r10				;recovering src string from stack on rdi
	xor			rax, rax		;setting number to return to zero
	
_create_int:
	mov		dil, byte [r10]		;passing 'char' to get index
	mov		rsi, r9				;passing base pointer
	mov		rcx, r8				;preparing get_base_index loop
	mul		r8					;nb = (nb * base_index) + base_len
	xor		rdx, rdx			;_get_base_index will return on rdx
	call	_get_base_index
	cmp		rdx, -1				;checking if char is not in base
	je		_end
	add		rax, rdx			;adding base_len
	inc		r10					;iterating to next char
	cmp		byte [r10], 0		;checking for \0
	jne		_create_int			;looping until reaching end of string
	ret							;returning rax

;int _get_base_index(char c, char *base)
_get_base_index:
	cmp		dil, byte [rsi]		;comparing char from string to base
	je		_end
	inc		rdx					;incrementing return value
	inc		rsi					;incrementing index of base
	loop	_get_base_index
	mov		rdx, -1				;no correspondance found, returning -1
	ret							;returning rdx here instead of rax

_atoi_error:
	mov		rax, 0;
	ret

; check_base(char *base, int base_len)
_check_base:
	cmp		rsi, 02H			;checking if base < MIN possible size
	jl		_base_error			;calling erorr if base is too short
	mov		rcx, rsi			;setting base_length as counter	

_check_b_outer_loop:
	mov		dl, byte [rdi]		;storing current char for comparisons
	cmp		dl, 020H			;checks if the value is below printables
	jl		_base_error			;jmp if lower than printable
	cmp		dl, 07FH			;checks if the value is above printables
	jg		_base_error			;jmp if greater than printable
	cmp		dl, 02BH			;checks if the value is a +
	je		_base_error			;jmp if equal to +
	cmp		dl, 02DH			;checks if the value is a -
	je		_base_error			;jmp if equal to -
	mov		r8, rdi				;duplicating rdi pointer for inner-loop
	add		r8,	1				;inner loop starts as outer-loop +1
	cmp		byte [r8], 0		;if inner-loop reached \0 base is valid
	je		_valid_base			;validating base

_check_b_inner_loop:			;this checks for duplicates
	cmp		dl, byte [r8]		;cmp outer/inner loops chars
	je		_base_error			;duplicate found if true
	inc		r8					;go to next char in inner-loop
	cmp		byte [r8], 0		;while not at \0 inner-loop continues
	jne		_check_b_inner_loop
	inc		rdi					;incrementing outer loop
	loop	_check_b_outer_loop	;looping again on outer-loop
			
_valid_base:
	mov		rax, 0				;setting return code to 0
	ret							;returning for a valid base

_base_error:
	mov		rax, -1				;returning -1 if the base is incorrect
	ret							;returning for incorrect base

_end:
	ret
