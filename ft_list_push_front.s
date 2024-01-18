
	section		.data
	section		.text
	global		ft_list_push_front


;void	ft_list_push_front(t_list **begin, t_list *data)
ft_list_push_front:
	cmp		rdi, 0				;securing NULL for first arg
	je		_end
	cmp		rsi, 0				;securing NULL for second arg
	je		_end
	mov		rcx, [rdi]			;buffering *begin
	mov		[rdi], rsi			;*begin = data
	mov		qword [rsi + 8], rcx	;data->next = old begin

_end:
	ret


