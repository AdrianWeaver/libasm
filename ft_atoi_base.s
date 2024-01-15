	global		ft_atoi_base

	extern		ft_strlen
	section		.text

;	int ft_atoi_base(char *str, char *base)

;	implement nb = nb * base + index
ft_atoi_base:
	push		rdi				;saving the src string on stack
	push		rsi				;saving the base on stack
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
	mov		rdi, [r10]			;passing 'char' to get index
	mov		rsi, r9				;passing base pointer
	mov		rcx, r8				;preparing get_base_index loop
	call	_get_base_index
	cmp		rdx, -1
	je		_atoi_error
	mul		rax, rdx			;nb = (nb * base_index) + base_len
	add		rax, r8				;adding base_len
	inc		r10					;iterating to next char
	cmp		r10, 0				;checking for \0
	jne		_create_int			;looping until reaching end of string
	ret

;						rdi,	rsi,
;int _get_base_index(char c, char *base)
_get_base_index:
	xor		rdx, rdx			;setting return value to 0 using 2nd return reg
	cmp		rdi, [rsi]			;comparing char from string to base
	ret
	inc		rdx
	inc		rsi
	loop	_get_base_index
	mov		rdx, -1
	ret

_atoi_error:
	mov		rax, 0;
	ret

; check_base(char *base, int base_len)
_check_base:
	mov		rcx, rsi			;setting base_length as counter	
	cmp		rsi, 02H			;checking if base < MIN possible size
	jl		_base_error			;calling erorr if base is too short

_outer_loop:
	cmp		rdi, 020H			;checks if the value is below printables
	jl		_base_error			;jmp if lower than comparison value
	cmp		rdi, 07FH			;checks if the value is above printables
	jg		_base_error			;jmp if greater than comparison value
	cmp		rdi, 02BH			;checks if the value is a +
	je		_base_error			;jmp if equal
	cmp		rdi, 02DH			;checks if the value is a -
	je		_base_error			;jmp if equal
	mov		rdx, [rdi]			;storing current char for comparison
	mov		r8, rdi + 1			;setting deeper loop value using r8
	cmp		[r8], 0				;checking for \0
	je		_valid_base			;validating base

_inner_loop:					;this checks for duplicates
	cmp		[r8], rdi			;comparison loop1 values to all other indexes
	je		_base_error
	inc		r8					;go to next char
	cmp		[r8], 0				;check for \0 to quit the inner loop
	jne		_inner_loop
	inc		rdi					;checking next index
	loop	_outer_loop				;going back to the beginning of the loop
			
_valid_base:
	mov		rax, 0				;setting return code to 0
	ret							;returning for a valid base

_base_error:
	mov		rax, -1				;returning -1 if the base is incorrect
	ret
