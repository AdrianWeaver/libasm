	section	.data
	section	.text

	global	ft_list_sort

;void ft_list_sort(t_list **begin_list, int (*cmp)())
	;(*cmp)(list_ptr->data, other_list_ptr->data);
ft_list_sort:
	cmp		rdi, 0			;checking for NULL list
	je		_end
	cmp		qword [rdi], 0		;checking for NULL first node
	je		_end
	cmp		rsi, 0			;checking for NULL as evaluation function
	je		_end
	mov		rdx, rdi		;saving begin_list pointer in rdx
	mov		r8, [rdi]		;accessing first node with r8

_outer_loop:
	mov		r9, [rdi + 8]	;accessing next node
	cmp		r9, 0			;if next node is NULL end

	cmp		qword [rcx], 0


_inner_loop:
	mov		r9, [r8 + 8]	;


	cmp		qword [r9 + 8], 0		;checking if end of list reached
	je		_outer_loop		;list is sorted
	mov		r8, [r9 + 8]	;current = next;

_end:
	ret
