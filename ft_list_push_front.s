	;file:		ft_list_push_front.s
	;output:	part of libasm.a
	;created:	18/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this function is used to add a node in a linked list and put it
		;in front of the existing list
		;the type of the list is as such
		;8bytes - address of the data
		;8bytes - address of the next node

	section		.data
	section		.bss
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

