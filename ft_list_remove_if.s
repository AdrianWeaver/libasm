

		section		.data
		section		.text
		global		ft_remove_if

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
	;cmp function - int	(list_ptr->data, data_ref);
	;free function - void (list_ptr->data);
ft_remove_if:
	cmp		rdi, 0		;check if first arg is NULL
	je		_end
	cmp		rsi, 0		;check if second arg is NULL
	je		_end
	cmp		rdx, 0		;check if third arg is NULL
	je		_end
	mov		rcx, [rdi]	;saving first node

_loop:
	call	[rsi]			;calling comparison function
	cmp		rax, 0			
	je		_remove			;if cmp returned remove is called
	cmp		qword [rdi], 0		;if current node is NULL quit
	je		_end
	mov		r8,	rdi			;save "previous" node
	mov		rdi, [rdi + 8]	;going to next address
	jmp		_loop

_end:
	mov		[rdi], rdx	;returning head of list
	ret

_remove:
	cmp		rdi, rdx
	je		_remove_head
	mov		r9,	[rdi + 8]	;save next address
	mov		[r8 + 8], r9	;links previous-next with current-next
	call	[rdx]				;delete current node using free function

_remove_head:
	mov		rdx, [rdx + 8]		;replacing the saved head with next
	call	[rdx]					;deleting node using free function
	mov		rdi, [rdx + 8]		;replacing the current head with next
	cmp		rdi, 0				;checking if end of list reached
	je		_end
	jmp		_loop
