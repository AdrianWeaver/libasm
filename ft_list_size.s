	;file:		ft_list_remove_if.s
	;output:	part of libasm.a
	;created:	18/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this function is used to return the size of a linked-list
		;the type of the list is as such
		;8bytes - address of the data
		;8bytes - address of the next node

	section		.data
	section		.bss
	section		.text

	global		ft_list_size

;int	ft_list_size(t_list *list);
ft_list_size:
	xor		rax, rax		;setting register rax to null, used for returned value
	cmp		rdi, 0			;if list == NULL return 0
	je		_end

_loop:
	inc		rax						;increment counter
	cmp		qword [rdi + 8], 0		;check if next node is null
	je		_end
	mov		rdi, [rdi + 8]			;going to next node
	jmp		_loop					;looping back

_end:
	ret

