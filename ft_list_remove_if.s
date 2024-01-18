
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
	cmp		rcx, 0		;check if fourth arg is NULL
	je		_end
	mov		r10, rdi	;saving first node

_loop:
	cmp		[rdi], 0		;quitting if end of list
	je		_end
	mov		r9,	rdi			;saving rdi
	mov		rdi, [rdi]		;preparing arg for comparison fuction
	call	rdx				;calling comparison function
	cmp		rax, 0			
	mov		rdi, r9			;replacing saved node
	je		_free			;if cmp returned free is called
	cmp		qword [rdi], 0	;if current node is NULL quit
	je		_end
	mov		r8,	rdi			;save "previous" node
	mov		rdi, [rdi + 8]	;going to next address
	jmp		_loop

_end:
	mov		rdi, r10	;returning head of list
	ret

_free:
	cmp		rdi, r10		;check if node to remove is first of list
	je		_remove_head
	mov		r9,	[rdi + 8]	;save next address
	mov		[r8 + 8], r9	;links previous-next with current-next
	call	rcx				;delete current node using free function

_remove_head:
	mov		r10, [rdi + 8]		;replacing the saved head with next
	call	rcx					;deleting node using free function
	mov		rdi, r10			;replacing the current head with next
	cmp		rdi, 0				;checking if end of list reached
	je		_end
	jmp		_loop





	;A lot of errors in this file.
	;free function is not a remove node function
	;now need to remove the node.
	;a lot of things need fixing here.
	;#dontcodewhentired
