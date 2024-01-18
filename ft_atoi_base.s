
	extern		ft_strlen
	section		.data
	section		.text
	global		ft_atoi_base

;	int ft_atoi_base(char *str, char *base)

;	implement nb = nb * base + index
	;stack is as follow
	;	rbp	=	previous rbp 
	;	rbp - 8 = rdi (src pointer)
	;	rbp - 16 = rsi (base pointer)
	;	rbp - 24 = base_len
	;	rbp	- 28 = neg_flag
ft_atoi_base:
	cmp			rdi, 0			;checking if str is NULL
	je			_end
	cmp			rsi, 0			;checking if base is NULL
	je			_end
	enter		32, 0			;making space on stack for 32 bytes
	mov			[rbp - 16], rsi	;saving the base pointer on stack
	call		_skip_ws		;skipping whitespaces and zeros
	mov			[rbp - 8], rax	;save src without trailing whitespaces
	mov			rdi, rax		;arg1 of _check_neg is str
	mov			eax, 1			;preparing sign value for _check_neg
	call		_check_neg		;checking for neg sign
	mov			[rbp - 8], rdi	;save src without trailing +/-
	mov			[rbp - 28], eax	;set neg/pos flag
	mov			rdi, [rbp - 16]	;set base as arg1 for ft_strlen
	call		ft_strlen
	mov			rdi, [rbp - 16]	;set base as arg1 for check_base
	mov			rsi, rax		;set base_len as arg2 for check_base
	mov			[rsp - 24], rax	;saving base_len on stack
	call		_check_base
	cmp			rax, 0			;checking check_base return code
	jne			_atoi_error		;returning 0 in case of base error
	mov			r8d, dword [rbp - 24]	;recovering base_len from stack
	mov			r9, qword [rbp - 16] ;recovering pointer from stack
	mov			r10, qword [rbp - 8];using r10 to iterate on src pointer
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
	mul		dword [rbp - 28]	;multiplying by 1 or -1 depending on sign
	leave
	ret							;returning rax

;int check_neg(char **str)
	;skips leading +/- changing the start of the string
	;returns -1 if neg 1 if pos
_check_neg:
	cmp		byte [rdi], 0		;check for \0
	je		_end
	cmp		byte [rdi], '-'		;check for '-' sign
	je		_swap_neg			;if '-' swap neg sign and increment
	cmp		byte [rdi], '+'		;check for '+'
	jne		_end				;end checking if not + or -
	inc		rdi					;check next char
	jmp		_check_neg

_swap_neg:
	neg		eax					;swapping flag for neg value
	inc		rdi					;check next char
	jmp		_check_neg
	
_skip_ws:
	;skipping \t \n \v \f \r and space
	cmp		byte [rdi], 09H		;if tab skip
	je		_skip
	cmp		byte [rdi], 0AH		;if newline return
	je		_skip
	cmp		byte [rdi], 0BH		;if vertical tab return
	je		_skip
	cmp		byte [rdi], 0CH		;if form feed return
	je		_skip
	cmp		byte [rdi], 0DH		;if carriage return... return
	je		_skip
	cmp		byte [rdi], 020H	;if space return
	je		_skip
	mov		rax, rdi			;return new beginning of string
	ret

_skip:
	inc		rdi
	jmp		_skip_ws

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
	leave
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

	section		.bss
