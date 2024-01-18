
	section		.data
	section		.text

	global		ft_list_size

;int	ft_list_size(t_list *list);
ft_list_size:
	xor		rax, rax
	cmp		rdi, 0			;if list == NULL return 0
	je		_end

_loop:
	inc		rax
	cmp		qword [rdi + 8], 0
	je		_end
	mov		rdi, [rdi + 8]
	jmp		_loop

_end:
	ret


