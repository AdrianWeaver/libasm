
		extern		free

		section		.data
		section		.text
		global		ft_list_remove_if

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
	;cmp function - int	(list_ptr->data, data_ref);
	;free function - void (list_ptr->data);
ft_list_remove_if:
	cmp		rdi, 0				;check if first arg is NULL
	je		_error
	cmp		qword [rdi], 0		;check if first arg points on NULL
	je		_error
	cmp		rsi, 0				;check if second arg is NULL
	je		_error
	cmp		rdx, 0				;check if third arg is NULL
	je		_error
	cmp		rcx, 0				;check if fourth arg is NULL
	je		_error
	enter	64, 0				;preparing stack for register saves needs to be 16bytes aligned
	mov		[rsp], rbx			;saving registers about to be used -- begin list
	mov		[rsp + 8], r12		;r12 - first node
	mov		[rsp + 16], r13		;r13 - previous node
	mov		[rsp + 24], r14		;r14 - current node
	mov		[rsp + 32], r15		;r15 - second arg (data_ref)
	mov		[rsp + 40], rdx		;saving comp function on stack	
	mov		[rsp + 48], rcx		;saving free function on stack
	mov		r15, rsi			;saving data_ref in r15
	mov		rbx, rdi			;saving return pointer
	mov		r12, [rdi]			;saving first node
	mov		rdi, [rdi]			;dereferencing **list to get *list

_loop:
	cmp		rdi, 0			;quitting if end of list
	je		_end
	mov		r14, rdi		;saving current node
	mov		rdi, [rdi]		;preparing arg for comparison function, node->data
	mov		rsi, r15		;preparing arg2 for comparison function
	call	[rsp + 40]		;calling comparison function
	cmp		rax, 0			
	je		_remove			;if cmp returned 0 deleting node
	mov		r13, r14		;save current node as "previous" node for next iteration
	mov		rdi, [r14 + 8]	;iterating to next node
	jmp		_loop

_error:
	ret

_end:
	mov		[rbx], r12		;returning head of list
	mov		rbx, [rsp]		;restoring rbx
	mov		r12, [rsp + 8]	;restoring r12
	mov		r13, [rsp + 16]	;restoring r13
	mov		r14, [rsp + 24]	;restoring r14
	mov		r15, [rsp + 32]	;restoring r15
	leave
	ret

_remove:
	call	[rsp + 48]		;clearing data using free function
	mov		rdi, r14		;get current node
	cmp		rdi, r10		;check if node to remove is first of list
	je		_remove_head
	mov		r14, [rdi + 8]	;iterating to next address using a buffer
	mov		[r13 + 8], r14	;links previous-next with current-next
	call	free			;freeing current node
	mov		rdi, r14		;copying next node in rdi for next loop
	jmp		_loop

_remove_head:
	mov		r12, [rdi + 8]		;replacing the saved head with next
	call	free				;freeing current node
	mov		rdi, r12			;replacing the current head with next
	cmp		rdi, 0				;checking if end of list reached
	je		_end
	jmp		_loop
